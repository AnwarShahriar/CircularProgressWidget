import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressWidget extends StatelessWidget {
  final double width;
  final double height;
  final double progressLineWidth;
  final double max;
  final double progress;
  final Color color;

  CircularProgressWidget(
      {Key key,
      this.width = 300,
      this.height = 300,
      this.max = 100,
      this.progress = 0,
      this.progressLineWidth = 10,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressInDegree = max == 0 ? 0 : (360 / max) * progress;
    return Container(
      width: this.width,
      height: this.height,
      child: CustomPaint(
        foregroundPainter: CirclePainter(
          degree: progressInDegree,
          color: color,
          width: progressLineWidth,
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  Paint border, solid;
  double start;
  double degree;
  double width;

  CirclePainter({this.degree, this.width = 5.0, Color color}) {
    border = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;
    solid = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    start = -0.5 * pi;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 2, size.height / 2);
    double radius = min(offset.dx, offset.dy);
    //canvas.drawCircle(offset, radius, solid);
    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius), start,
        (degree / 180) * pi, false, border);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}