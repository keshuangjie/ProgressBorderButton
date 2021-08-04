import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_border_button/progress_border_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 10;
  late GlobalKey _progressButtonKey;

  @override
  void initState() {
    _progressButtonKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgressBorderButton(
              key: _progressButtonKey,
              duration: _duration,
              size: Size(200, 100),
              hasRadius: true,
              borderColor: const Color(0xFFFEDBFD),
              onTimeEnd: () {
                print('on time end');
              },
              childBuild: (context, double progress) {
                int remainTime = _duration - (_duration * progress).toInt();
                return Container(
                  width: 104,
                  height: 48,
                  alignment: AlignmentDirectional.center,
                  child: GestureDetector(
                    onTap: () {
                      print('tap button');
                    },
                    child: Container(
                      width: 94,
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/btn_action.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFEDBFD), width: 3),
                        color: const Color(0xFFEEBAFF),
                      ),
                      child: Text('${max(remainTime, 0)}',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _start,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _start() {
    ProgressBorderButtonState progressBorderButtonState = _progressButtonKey.currentState as ProgressBorderButtonState;
    progressBorderButtonState.start();
  }
}
