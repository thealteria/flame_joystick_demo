import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import 'joystick_player.dart';

class JoystickExample extends FlameGame with HasDraggables, HasCollidables {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = JoystickPlayer(joystick);

    // add(ScreenCollidable());
    add(player);
    add(joystick);
  }
}
