import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_joystick_demo/joystick_example.dart';
import 'package:flutter/material.dart';

class JoystickPlayer extends SpriteComponent
    with HasGameRef<JoystickExample>, HasHitboxes, Collidable {
  /// Pixels/s
  static const double maxSpeed = 700.0;

  bool _isWallHit = false;

  final JoystickComponent joystick;

  JoystickPlayer(this.joystick)
      : super(
          size: Vector2.all(100.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;

    // final shape = HitboxPolygon([
    //   Vector2(0, 1),
    //   Vector2(1, 0),
    //   Vector2(0, -1),
    //   Vector2(-1, 0),
    // ]);

    // addHitbox(shape);

    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    debugPrint(
      'isWallHit return: $_isWallHit '
      'position: ${position.toString()}',
    );

    if (!joystick.delta.isZero()) {

      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    _isWallHit = other is ScreenCollidable;

    debugPrint('other: $other');
  }
}
