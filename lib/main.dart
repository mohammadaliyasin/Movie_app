import 'package:flutter/material.dart';

import 'splashScreen.dart';


void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.dark().copyWith(
          secondary: Colors.red,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
