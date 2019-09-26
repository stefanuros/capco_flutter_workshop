import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Capco Flutter Workshop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _offsets = <Offset>[];
  var lineColour = Colors.blue;

  var colours = <Color>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: GestureDetector(
        onPanStart: (details) {
          RenderBox getBox = context.findRenderObject();
          var local = getBox.globalToLocal(details.globalPosition);

          setState(() {
            _offsets.add(local);
            colours.add(lineColour);
          });
        },
        onPanUpdate: (details) {
          RenderBox getBox = context.findRenderObject();
          var local = getBox.globalToLocal(details.globalPosition);
          setState(() {
            _offsets.add(local);
            colours.add(lineColour);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _offsets.add(null);
            colours.add(null);
            // _offsets.add(details.globalPosition);
          });
        },
        child: Center(
          child: CustomPaint(
            painter: FlipBookPainter(_offsets, colours),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0.9, 0.95),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _offsets.clear();
                  colours.clear();
                });
              },
              tooltip: 'Increment',
              child: Icon(Icons.clear),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.95),
            child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    lineColour = Colors.red;
                  });
                },
                tooltip: 'Increment',
                // child: Icon(Icons.add),
                backgroundColor: Colors.red),
          ),
          Align(
            alignment: Alignment(-0.2, 0.95),
            child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    lineColour = Colors.yellow;
                  });
                },
                tooltip: 'Increment',
                // child: Icon(Icons.add),
                backgroundColor: Colors.yellow),
          ),
          Align(
            alignment: Alignment(-0.5, 0.95),
            child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    lineColour = Colors.green;
                  });
                },
                tooltip: 'Increment',
                // child: Icon(Icons.add),
                backgroundColor: Colors.green),
          ),
          Align(
            alignment: Alignment(-0.8, 0.95),
            child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    lineColour = Colors.blue;
                  });
                },
                tooltip: 'Increment',
                // child: Icon(Icons.add),
                backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class FlipBookPainter extends CustomPainter {
  final offsets;
  final colours;

  FlipBookPainter(this.offsets, this.colours) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ..color = colour
      ..isAntiAlias = true
      ..strokeWidth = 3.0;

    for (var i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != null && offsets[i + 1] != null) {
        paint.color = colours[i];
        canvas.drawLine(offsets[i], offsets[i + 1], paint);
      }

      if (i > 0 && offsets[i - 1] == null && offsets[i + 1] == null) {
        paint.color = colours[i];
        canvas.drawPoints(PointMode.points, [offsets[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
