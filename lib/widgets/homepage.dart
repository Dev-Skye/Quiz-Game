import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                'Quiz',
                style: TextStyle(color: Color(0xFFA20CBE), fontSize: 50),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                child: ElevatedButton(
                  child: Text(
                    'PLAY',
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      primary: Color(0xFFFFBA00),
                      textStyle: TextStyle(color: Colors.white, fontSize: 25)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(QuizScreen.routeName);
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
