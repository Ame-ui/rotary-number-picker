import 'package:flutter/material.dart';
import 'package:rotary_number_picker/rotary_number_picker.dart';
import 'dart:math' as math;

class RotaryNumberPicker extends StatefulWidget {
  const RotaryNumberPicker({
    super.key,
    required this.circleDiameter,
    required this.onGetNumber,
    this.wheelBgColor = const Color(0xff313131),
    this.wheelInnerCircleColor = const Color(0xff101010),
    this.numberCircleColor = Colors.orange,
    this.numberTextStyle = const TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
    this.selectedNumberCircleColor = Colors.white,
    this.selectedNumberTextStyle = const TextStyle(
        color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
    this.dropAreaColor = const Color(0x33ffffff), //white with 0.2 opacity
    this.dropAreaBorderColor = Colors.white,
  });
  final double circleDiameter;
  final Function({String number}) onGetNumber;
  final Color wheelBgColor;
  final Color wheelInnerCircleColor;
  final Color numberCircleColor;
  final TextStyle numberTextStyle;
  final Color selectedNumberCircleColor;
  final TextStyle selectedNumberTextStyle;
  final Color dropAreaColor;
  final Color dropAreaBorderColor;

  @override
  State<RotaryNumberPicker> createState() => _RotaryNumberPickerState();
}

class _RotaryNumberPickerState extends State<RotaryNumberPicker>
    with SingleTickerProviderStateMixin {
  // const data
  final List<String> dialNum = [
    '',
    '',
    // '#',
    // '*',
    '0',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2',
    '1',
    '',
  ];

  //state management variable
  bool xForcedPulling = false;
  double angle = 0;
  double oldAngle = 0;
  double tapAngle = 0;
  int clickedIndex = -1;

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.circleDiameter,
      height: widget.circleDiameter,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {},
              onPanUpdate: (details) async {
                if (!xForcedPulling) {
                  final Offset center = Offset(
                      widget.circleDiameter / 2, widget.circleDiameter / 2);
                  final endAngle = RotaryNumberPickerUtil.calculateAngle(
                      Offset(
                          details.localPosition.dx, details.localPosition.dy),
                      center);
                  double additionalAngle = (oldAngle - endAngle);

                  // check to stop rotation from going backward
                  if (additionalAngle >= 0 && additionalAngle < 50) {
                    angle = math.max(
                        0,
                        math.min(((angle + additionalAngle) % 360),
                            (360 * (dialNum.length - 1 / 2) / dialNum.length)));

                    // detect how many degree left to rotate to get the nubmer
                    tapAngle -= additionalAngle;

                    // if rotate angle is near Drop area, we will pull with force
                    if (tapAngle < (360 / dialNum.length)) {
                      xForcedPulling = true;

                      // for forced pull animation
                      final List<double> mids =
                          RotaryNumberPickerUtil.generateNumbersBetween(angle,
                              360 - (clickedIndex * 360 / dialNum.length), 7);
                      for (var element in mids) {
                        angle = element;
                        setState(() {});
                        await Future.delayed(const Duration(milliseconds: 17));
                      }
                    }
                    oldAngle = endAngle;
                  }
                }
              },
              onPanEnd: (details) {
                xForcedPulling = false;
                if (tapAngle <= (360 / dialNum.length)) {
                  widget.onGetNumber(number: dialNum[clickedIndex]);
                }
                double maxAngle =
                    (360 * (dialNum.length - 1 / 2) / dialNum.length);
                double total = angle;
                animationController.value = 1;
                animationController.duration =
                    Duration(milliseconds: (500 * (total / maxAngle)).toInt());
                // resettin the wheel
                animationController
                  ..addListener(() {
                    setState(() {
                      angle = total * (animationController.value);
                    });
                  })
                  ..reverse().then((value) {
                    oldAngle = 0;
                    angle = 0;
                    clickedIndex = -1;
                    setState(() {});
                  });
              },
              onPanDown: (details) {
                final Offset center = Offset(
                    widget.circleDiameter / 2, widget.circleDiameter / 2);
                oldAngle = RotaryNumberPickerUtil.calculateAngle(
                    Offset(details.localPosition.dx, details.localPosition.dy),
                    center);
                tapAngle = oldAngle;

                // to mark the tapped number
                clickedIndex = dialNum.length -
                    (oldAngle / (360 / dialNum.length)).round();
                setState(() {});
              },
              child: Stack(
                children: [
                  Transform.rotate(
                    angle: RotaryNumberPickerUtil.degreeToRadian(angle),
                    child: Container(
                      width: widget.circleDiameter,
                      height: widget.circleDiameter,
                      decoration: BoxDecoration(
                          color: widget.wheelBgColor, shape: BoxShape.circle),
                      child: Stack(
                        alignment: Alignment.center,
                        children: List.generate(
                          dialNum.length,
                          // rotate the number board
                          (index) => Transform.rotate(
                            angle: RotaryNumberPickerUtil.degreeToRadian(
                                ((360 / dialNum.length) * index)),
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  EdgeInsets.all(widget.circleDiameter * 0.05),
                              child: Transform.rotate(
                                // to make the numbers appear right
                                angle: RotaryNumberPickerUtil.degreeToRadian(
                                    (-(360 / dialNum.length) * index) - angle),
                                child: dialNum[index].isEmpty
                                    ? const SizedBox.shrink()
                                    : Container(
                                        width: widget.circleDiameter * 0.15,
                                        height: widget.circleDiameter * 0.15,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: clickedIndex == index
                                                ? widget
                                                    .selectedNumberCircleColor
                                                : widget.numberCircleColor),
                                        child: Text(dialNum[index],
                                            style: clickedIndex == index
                                                ? widget.selectedNumberTextStyle
                                                : widget.numberTextStyle),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: widget.circleDiameter / 2,
              height: widget.circleDiameter / 2,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black, width: 3),
                  shape: BoxShape.circle,
                  color: widget.wheelInnerCircleColor),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100000),
                child: Container(
                  margin:
                      EdgeInsets.only(right: widget.circleDiameter * 0.05 / 2),
                  width: widget.circleDiameter * 0.2,
                  height: widget.circleDiameter * 0.2,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.dropAreaBorderColor),
                      color: widget.dropAreaColor),
                ),
              ))
        ],
      ),
    );
  }
}
