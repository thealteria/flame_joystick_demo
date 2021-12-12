import 'package:flame/components.dart';
import 'package:flame_joystick_demo/joystick_example.dart';

class JoystickPlayer extends SpriteComponent with HasGameRef<JoystickExample>
// , HasHitboxes, Collidable
{
  /// Pixels/s
  static const double maxSpeed = 700.0;

  // bool _isWallHit = false;

  final JoystickComponent joystick;
  final screenCollidable = ScreenCollidable();

  JoystickPlayer(this.joystick)
      : super(
          size: Vector2.all(100.0),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(screenCollidable);
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;

    // final shape = HitboxPolygon([
    //   Vector2(0, 1),
    //   Vector2(1, 0),
    //   Vector2(0, -1),
    //   Vector2(-1, 0),
    // ]);

    // addHitbox(shape);

    // addHitbox(HitboxRectangle());
    //for out of screen bound
  }

  @override
  void update(double dt) {
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }

    // Takes rotation into consideration (which topLeftPosition doesn't)
    final topLeft = absoluteCenter - (scaledSize / 2);
    if (topLeft.x + scaledSize.x < 0 ||
        topLeft.y + scaledSize.y < 0 ||
        topLeft.x > screenCollidable.scaledSize.x ||
        topLeft.y > screenCollidable.scaledSize.y) {
      debugMode = true;

      final moduloSize = screenCollidable.scaledSize + scaledSize;

      topLeftPosition = topLeftPosition % moduloSize;
    }
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  //   _isWallHit = other is ScreenCollidable;

  //   debugPrint('other: $other');
  // }
}
