import 'package:flutter/material.dart';
import 'package:naive_bayes/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naive Bayes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen()
    );
  }
}

