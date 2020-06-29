import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  Box({Key key, this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 70,
      height: 70,
    );
  }
}
