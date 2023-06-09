import 'package:flutter/material.dart';
import 'package:tictaktoe/splash_screen.dart';
import 'game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // routes: ['landing' ],
        debugShowCheckedModeBanner: false,
        // home: GamePlay(),
        home: GameSplashScreen());
  }
}
