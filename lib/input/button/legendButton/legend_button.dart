import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/styles/typography/widgets/legend_text.dart';
import 'package:legend_design_core/widgets/elevation/elevation_box.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_utils/legend_utils.dart';

class LegendButton extends HookWidget {
  final Widget text;
  final Color background;
  final Color selBackground;
  final double elevation;
  final double selElevation;
  final Color? shadowColor;
  final BorderRadiusGeometry borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Duration duration;
  final Curve curve;
  final void Function()? onTap;

  const LegendButton({
    super.key,
    required this.background,
    required this.text,
    this.onTap,
    this.shadowColor,
    this.height,
    this.width,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 200),
    this.elevation = 0,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    Color? selBackground,
    double? selElevation,
  })  : selBackground = selBackground ?? background,
        selElevation = selElevation ?? elevation;

  //Create a factory constructor to create a button with a default style
  factory LegendButton.text({
    required String? text,
    required Color background,
    void Function()? onTap,
    TextStyle? style,
    Color? selBackground,
    Color? shadowColor,
    double? selElevation,
    double? width,
    double? height,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    double elevation = 0,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 24,
    ),
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(12),
    ),
  }) {
    selBackground ??= background.darken(0.1);
    return LegendButton(
      text: LegendText(
        text,
        style: style,
        selectable: false,
      ),
      background: background,
      selBackground: selBackground,
      shadowColor: shadowColor,
      onTap: onTap,
      elevation: elevation,
      selElevation: selElevation,
      borderRadius: borderRadius,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      curve: curve,
      duration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = useState(false);
    final controller = useAnimationController(duration: duration);
    final _parentAnimation = CurvedAnimation(parent: controller, curve: curve);
    final _background = ColorTween(begin: background, end: selBackground)
        .animate(_parentAnimation);
    final _elevation =
        Tween(begin: elevation, end: selElevation).animate(_parentAnimation);

    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedBuilder(
          animation: controller,
          child: Padding(
            padding: padding,
            child: Center(
              child: text,
            ),
          ),
          builder: (context, child) {
            return ElevatedBox(
              elevation: _elevation.value,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              shadowColor: shadowColor,
              child: LegendDetector(
                background: _background.value,
                onTap: onTap,
                onHover: (value) {
                  if (value) {
                    controller.forward();
                    isSelected.value = true;
                  } else {
                    controller.reverse();
                    isSelected.value = false;
                  }
                },
                borderRadius: borderRadius,
                child: child!,
              ),
            );
          },
        ),
      ),
    );
  }
}