import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _progress = 0.0;
  final double max = 100.0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressWidget(
                  max: max,
                  progress: _progress,
                  progressLineWidth: 30.0,
                  color: Colors.red[400],
                ),
              ),
              Text(
                "${_progress.toInt()}",
                style: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
                ),
              ),
            ],
          ),
          Slider(
            max: max,
            min: 0.0,
            value: _progress,
            onChanged: (value) {
              setState(() => _progress = value);
            },
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
