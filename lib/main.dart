import 'package:flutter/material.dart';

void main() => runApp(
      new MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double top = 50;
  double left = 50;
  int count = 0;
  Color kutu = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Container(
                child: DragTarget(
                  builder: (context, List<int> candidateData, rejectedData) {
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: kutu, borderRadius: BorderRadius.circular(10)),
                    );
                  },
                  onWillAccept: (data) {
                    if (data == 1) return true;
                    return false;
                  },
                  onAccept: (data) {
                    setState(() {
                      count++;
                      kutu = Colors.amberAccent;
                    });
                  },
                  onLeave: (data) {
                    setState(() {
                      kutu = Colors.amber;
                    });
                  },
                ),
              ),
            ),
            Draggable(
              data: 1,
              child: Container(
                padding: EdgeInsets.only(top: top, left: left),
                child: dragItem(40),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: top, left: left),
                child: dragItem(35),
              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: top, left: left),
                child: null,
              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  top = top + drag.offset.dy < 0 ? 0 : top + drag.offset.dy;

                  left = left + drag.offset.dx < 0 ? 0 : left + drag.offset.dx;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '$count times entered',
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget dragItem(double size) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}
