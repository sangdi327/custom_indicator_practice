import 'package:custom_indicator_practice3/model/indicator_option.dart';
import 'package:flutter/material.dart';

class IndicatorWidget extends StatefulWidget {
  const IndicatorWidget({
    super.key,
    required this.indicatorOption,
    required this.pageController,
  });
  final IndicatorOption indicatorOption;
  final PageController pageController;

  @override
  State<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  late Size indicatorBoxSize;
  double level = 0;

  @override
  void initState() {
    super.initState();
    makeBoxSize();
    widget.pageController.addListener(pageEvent);
  }

  void pageEvent() {
    setState(() {
      level = widget.pageController.page ?? 0.0;
    });
    print(level);
  }

  void makeBoxSize() {
    var size = widget.indicatorOption.size;
    var gap = widget.indicatorOption.gap;
    var counts = widget.indicatorOption.counts;

    indicatorBoxSize =
        Size(size.width * counts + gap * (counts - 1), size.height);
    print(indicatorBoxSize);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: indicatorBoxSize.width,
          height: indicatorBoxSize.height,
          child: CustomPaint(
            painter: IndicatorPainter(
              indicatorOption: widget.indicatorOption,
              level: level,
            ),
          ),
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final IndicatorOption indicatorOption;
  final double level;
  IndicatorPainter({
    required this.indicatorOption,
    required this.level,
  });
  @override
  void paint(Canvas canvas, Size size) {
    blankIndicator(canvas);
    activeIndicator(canvas);
  }

  void blankIndicator(Canvas canvas) {
    Paint paint = Paint()..color = indicatorOption.inActiveColor;

    // indicatorOption.points.forEach((point) {
    //   var bounds = Rect.fromLTRB(
    //     point.x1,
    //     0,
    //     point.x2,
    //     indicatorOption.size.height,
    //   );
    //   var rrect = RRect.fromRectAndRadius(bounds, const Radius.circular(20));
    //   canvas.drawRRect(rrect, paint);
    // });

    for (var point in indicatorOption.points) {
      var bounds = Rect.fromLTRB(
        point.x1,
        0,
        point.x2,
        indicatorOption.size.height,
      );
      var rrect = RRect.fromRectAndRadius(bounds, const Radius.circular(20));
      canvas.drawRRect(rrect, paint);
    }
  }

  void activeIndicator(Canvas canvas) {
    Paint paint = Paint()..color = indicatorOption.activeColor;

    var progress = level % 1 * 2;
    var forwardProgress = progress.clamp(0, 1);
    var backwardProgress = (progress - 1).clamp(0, 1);
    int index = progress.floor();
    int nextIndex = (index + 1).clamp(0, indicatorOption.counts - 1);

    final xPos = indicatorOption.points[index];
    final txPos = indicatorOption.points[nextIndex];
    final nextPoint = forwardProgress == 0 ? xPos.x2 : txPos.x2;

    var bounds = Rect.fromLTRB(
      xPos.x1 + (nextPoint - xPos.x2) * backwardProgress,
      0,
      xPos.x2 + (nextPoint - xPos.x2) * forwardProgress,
      indicatorOption.size.height,
    );

    var rrect = RRect.fromRectAndRadius(bounds, const Radius.circular(20));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
