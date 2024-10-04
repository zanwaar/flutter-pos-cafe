import 'package:flutter/material.dart';

import '../constants/colors.dart';

enum ButtonStyle { filled, outlined }

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyle.filled,
    this.color = const Color.fromARGB(255, 31, 26, 8),
    this.textColor = const Color.fromARGB(255, 190, 152, 94),
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 8.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 18.0,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.label,
    this.style = ButtonStyle.outlined,
    this.color = const Color.fromARGB(0, 255, 255, 255),
    this.textColor = const Color.fromARGB(255, 2, 11, 23),
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 8.0,
    this.icon,
    this.disabled = false,
    this.fontSize = 15.0,
  });

  final Function() onPressed;
  final String label;
  final ButtonStyle style;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final bool disabled;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyle.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: color,
                side: const BorderSide(
                    color: Color.fromARGB(255, 12, 29, 67), width: 3.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
