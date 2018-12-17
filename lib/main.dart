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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: CustomPaint(
                foregroundPainter: MyPainter(
                  degree: 300,
                  color: Colors.red[400],
                  width: 10,
                ),
                child: Center(
                  child: Text(
                    "Awesome",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyPainter extends CustomPainter {
  Paint line;
  double start;
  double degree;
  double width;

  MyPainter({this.degree, this.width = 5.0, Color color}) {
    line = Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..strokeWidth = width
    ..style = PaintingStyle.stroke;

    start = -0.5 * pi;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width/2, size.height/2);
    double radius = min(offset.dx, offset.dy);
    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius), start, (degree / 180) * pi, false, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}