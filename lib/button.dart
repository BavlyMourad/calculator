import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final Function buttonTapped;
  final Function clear;

  CalButton({this.color, this.textColor, this.buttonText, this.buttonTapped, this.clear});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      onLongPress: clear,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            alignment: Alignment.center,
            color: color,
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 24.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
