import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/widgets/quizhelper.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz-screen';
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Uri apiURL = Uri.parse(
      'https://opentdb.com/api.php?amount=10&category=18&type=multiple');

  QuizHelper quizHelper;
  int currentQuestion = 0;
  int totalSeconds = 30;
  int elapsedSeconds = 0;
  int score = 0;
  Timer timer;

  @override
  void initState() {
    fetchAllQuiz();
    super.initState();
  }

  fetchAllQuiz() async {
    var response = await http.get(apiURL);
    var body = response.body;
    var json = jsonDecode(body);

    print(body);
    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer);
      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
    });
  }

  initTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == totalSeconds) {
        print('Time out');
        t.cancel();
      } else {
        setState(() {
          elapsedSeconds = t.tick;
        });
      }
    });
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      score += 1;
    } else {
      print('Wrong');
    }
    changeQuestion();
  }

  changeQuestion() {
    timer.cancel();
    if (currentQuestion == quizHelper.results.length - 1) {
      print('Quiz Completed');
      print('Score: $score');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    score: score,
                  )));
    } else {
      setState(() {
        currentQuestion += 1;
      });
      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer);
      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/images/icon-circle.png'),
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        '$elapsedSeconds S',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Q: ${quizHelper.results[currentQuestion].question}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                      children: quizHelper
                          .results[currentQuestion].incorrectAnswers
                          .map((option) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 7.0),
                      child: ElevatedButton(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF511AAB),
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                            )),
                        onPressed: () {
                          checkAnswer(option);
                        },
                      ),
                    );
                  }).toList()),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF511AAB),
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
