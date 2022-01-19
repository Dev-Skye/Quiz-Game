import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'widgets/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(fontFamily: 'productsans', primaryColor: Color(0xFF2D046E)),
      home: HomePage(),
      routes: {
        ResultScreen.routeName: (ctx) => ResultScreen(),
        QuizScreen.routeName: (ctx) => QuizScreen()
      },
    );
  }
}
