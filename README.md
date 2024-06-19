# Rotary Number Picker

`rotary_number_picker` is a creative and customizable number picker widget for Flutter. It provides a unique way to pick numbers, such as phone numbers, and allows extensive customization of its appearance, making it perfect for a variety of use cases.

## Features

- **Customizable Appearance:** Change the colors and styles of selected and unselected numbers, the wheel background, drop area, and more.
- **Flexible Number Selection:** Suitable for picking any kind of number, including phone numbers.
- **Creative UI:** Offers a visually appealing and interactive way to pick numbers.

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
import 'package:flutter/material.dart';
import 'package:rotary_number_picker/rotary_number_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Rotary Number Picker Example')),
        body: Center(
          child: RotaryNumberPicker(
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
        ),
      ),
    );
  }
}
```

## Parameters
- circleDiameter: Diameter of the number picker wheel.
- numberCircleColor: Color of the number circles.
- selectedNumberCircleColor: Color of the selected number circle.
- numberTextStyle: Text style of the unselected numbers.
- selectedNumberTextStyle: Text style of the selected number.
- wheelBgColor: Background color of the wheel.
- wheelInnerCircleColor: Inner circle color of the wheel.
- dropAreaBorderColor: Border color of the drop area.
- dropAreaColor: Color of the drop area.
- onGetNumber: Callback function that returns the selected number.



## Contribution
```markdown
Contributions are welcome! If you have any issues or feature requests, please create an issue on the [GitHub repository](https://github.com/Ame-ui/rotary-number-picker).
```
