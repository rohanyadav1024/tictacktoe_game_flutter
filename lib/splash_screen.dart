import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tictaktoe/game_screen.dart';

class GameSplashScreen extends StatefulWidget {
  const GameSplashScreen({super.key});

  @override
  State<GameSplashScreen> createState() => _GameSplashScreenState();
}

class _GameSplashScreenState extends State<GameSplashScreen> {
  Color splashbg = Colors.white;

  void continueAnimation() {
    setState(() {
      if (splashbg == Colors.white) {
        splashbg = Colors.lightBlue;
      } else
        splashbg = Colors.white;
    });
    Timer(
      const Duration(milliseconds: 200),
      () => continueAnimation(),
    );
    // continueAnimation();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // continueAnimation();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GamePlay())));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.white,
        color: splashbg,
        duration: const Duration(milliseconds: 300),

        // color: Color(0xFF080808),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tic Tac Toe',
              style: TextStyle(
                  color: Color.fromARGB(
                    255,
                    5,
                    26,
                    74,
                  ),
                  decoration: TextDecoration.none,
                  fontSize: 60,
                  letterSpacing: -3,
                  wordSpacing: -3,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BlackOpsOne'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                'assets/images/image1.png', fit: BoxFit.cover,
                // color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Created By Rohan Yadav', textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(237, 18, 45, 109),
                    decoration: TextDecoration.none,
                    fontSize: 28,
                    letterSpacing: 0,
                    wordSpacing: 0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BlackOpsOne'),
              ),
            ),
          ],
        ));
  }

  TextStyle DefaultTextStyle(double fontsize) {
    return TextStyle(color: Colors.white, fontSize: fontsize);
  }
}
