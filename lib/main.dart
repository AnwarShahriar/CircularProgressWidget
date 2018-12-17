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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Center(
              child: CircularProgressWidget(),
            ),
            Center(
              child: Text(
                "awesome",
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
            )
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CircularProgressWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CircularProgressState();
  }
}

class CircularProgressState extends State<CircularProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: CustomPaint(
        foregroundPainter: CirclePainter(
          degree: 300,
          color: Colors.red[400],
          width: 10,
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
