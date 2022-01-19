import 'quiz_screen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result - screen';
  final int score;

  ResultScreen({this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/icon-circle.png',
                  ),
                  height: 300,
                  width: 200,
                ),
              ),
              Text(
                'Result',
                style: TextStyle(color: Color(0xFFFFBA00), fontSize: 25),
              ),
              Text(
                '$score/10',
                style: TextStyle(color: Color(0xFFA20CBE), fontSize: 45),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: ElevatedButton(
                  child: Text(
                    'RESTART',
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      primary: Color(0xFFFFBA00),
                      textStyle: TextStyle(color: Colors.white, fontSize: 25)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      QuizScreen.routeName,
                    );
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                child: ElevatedButton(
                  child: Text(
                    'QUIT',
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      primary: Color(0xFFA20CBE),
                      textStyle: TextStyle(color: Colors.white, fontSize: 25)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
