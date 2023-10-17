import 'package:flutter/material.dart';

class IndicatorOption {
  final Size size;
  final double gap;
  final int counts;
  final Color inActiveColor;
  final Color activeColor;
  final List<Points> points = [];

  IndicatorOption({
    required this.size,
    this.gap = 10,
    this.counts = 4,
    this.inActiveColor = Colors.grey,
    this.activeColor = Colors.deepOrange,
  }) {
    makeStartPoint();
  }
  void makeStartPoint() {
    points.clear();
    for (int i = 0; i < counts; i++) {
      var startPoint = size.width * i + gap * i;
      points.add(Points(startPoint, startPoint + size.width));
    }
  }
}

class Points {
  final x1;
  final x2;
  Points(this.x1, this.x2);
}
