import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'joystick_example.dart';

void main() {
  runApp(
    GameWidget(
      game: JoystickExample(),
    ),
  );
}
