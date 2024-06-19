# Rotary Number Picker

`rotary_number_picker` is a creative(may be unusual) and customizable number picker widget for Flutter. It provides a unique way to pick numbers, such as phone numbers, and allows extensive customization of its appearance, making it perfect for a variety of use cases.

## Features

- **Customizable Appearance:** Change the colors and styles of both selected and unselected numbers, the wheel background, drop area, and more.
- **Flexible Number Selection:** Suitable for picking any kind of number, eg. phone number, passcode and etc.
- **Creative UI:** Offers a visually appealing and rotary telephone way to pick numbers. If you tired of using normal number picker just try this.

![Demo Video]("https://raw.githubusercontent.com/Ame-ui/rotary-number-picker/main/picker_demo.gif")

## Installation

Add `rotary_number_picker` to your `pubspec.yaml` file:

```yaml
dependencies:
  rotary_number_picker: latest_version
```

## Usage
```yaml
import 'package:rotary_number_picker/rotary_number_picker.dart';
```

## Example
```dart
import 'package:rotary_number_picker/rotary_number_picker.dart';

RotaryNumberPicker(
    circleDiameter: MediaQuery.of(context).size.width,
    numberCircleColor: Colors.grey.withOpacity(0.2),
    selectedNumberCircleColor: Colors.orange,
    numberTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
    selectedNumberTextStyle: const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
    wheelBgColor: Colors.white,
    wheelInnerCircleColor: Colors.grey.withOpacity(0.2),
    dropAreaBorderColor: Colors.orange,
    dropAreaColor: Colors.orange.withOpacity(0.2),
    onGetNumber: (number) {
        print('Selected number: $number');
    },
),
```

## Parameters
- circleDiameter: Diameter of the picker wheel.
- numberCircleColor: Color of the circles of each number.
- selectedNumberCircleColor: Color of the circle of the selected number.
- numberTextStyle: Text style of the normal numbers text.
- selectedNumberTextStyle: Text style of the selected number text.
- wheelBgColor: Background color of the wheel.
- wheelInnerCircleColor: Inner circle color of the wheel.
- dropAreaBorderColor: Border color of the drop area.
- dropAreaColor: Color of the drop area (prefer color with opacity).
- onGetNumber: Callback function that returns the selected number.



## Contribution
```markdown
Contributions are welcome! If you have any issues or feature requests, please create an issue on the [GitHub repository](https://github.com/Ame-ui/rotary-number-picker).
```
