import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotaryNumberPickerUtil {
  /// generate [count] numbers of double between [start] and [end]
  static List<double> generateNumbersBetween(
      double start, double end, int count) {
    if (count < 2) {
      throw ArgumentError('Count must be at least 2');
    }

    List<double> numbers = [];
    double step = (end - start) / (count - 1);

    for (int i = 0; i < count; i++) {
      numbers.add(start + i * step);
    }
    return numbers;
  }

  /// calculate the angle on given points [newP],[center]
  static double calculateAngle(Offset newP, Offset center) {
    double h = disBetween(center, newP);
    double a = disBetween(center, findAdj(center, newP));
    double tempAngle = radianToDegree(math.acos(a / h));
    if (newP.dx < center.dx && newP.dy < center.dy) {
      //sin -- TL
      tempAngle = 180 - tempAngle;
    } else if (newP.dx < center.dx && newP.dy > center.dy) {
      //tan -- BL
      tempAngle = 180 + tempAngle;
    } else if (newP.dx > center.dx && newP.dy > center.dy) {
      //cos -- BR
      tempAngle = 360 - tempAngle;
    } else if (newP.dx > center.dx && newP.dy < center.dy) {
      //all -- TR
      tempAngle = tempAngle;
    }
    return tempAngle;
  }

  /// covert radian value to degree
  static double radianToDegree(double radian) {
    return radian * 180 / math.pi;
  }

  /// covert degree value to radian
  static double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  /// find
  static Offset findAdj(Offset center, Offset p1) {
    return Offset(p1.dx, center.dy);
  }

  static double disBetween(Offset p1, Offset p2) {
    return math.sqrt(square((p2.dx - p1.dx)) + square((p2.dy - p1.dy)));
  }

  static double square(double num) {
    return num * num;
  }
}
