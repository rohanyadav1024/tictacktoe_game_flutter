import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({super.key});

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  List<String> displayOnGrid = ["", "", "", "", "", "", "", "", ""];

  // List<Color> colorPalletes = [
  //   Colors.amber,
  //   Colors.green,
  //   Colors.orange.shade900,
  //   Colors.lightGreen
  // ];
  // List<Color> colorsOfGrid = [
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  //   Colors.transparent,
  // ];
  // Random random = new Random();

  bool turnOn = true;
  bool startWithTurnX = true;
  int playerOscore = 0;
  int playerXscore = 0;

  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTurnAfterRound();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFF080808),
        body: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    // color: Colors.amber,
                    child: SizedBox(
                        // height: 50,
                        // width: width * .6,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: turnOn
                                        ? Colors.green
                                        : Colors.transparent),
                                child: Text(
                                  'Player 0',
                                  style: DefaultTextStyle(25.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '$playerOscore',
                                style: DefaultTextStyle(30.0),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: !turnOn
                                        ? Colors.green
                                        : Colors.transparent),
                                child: Text(
                                  'Player X',
                                  style: DefaultTextStyle(25.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                '$playerXscore',
                                style: DefaultTextStyle(30.0),
                              ),
                            ],
                          )
                        ])),
                  )),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 0.0),
                  // decoration:
                  //     BoxDecoration(image: DecorationImage(image: AssetImage())),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: ((BuildContext context, int index) =>
                          GestureDetector(
                            onTap: () {
                              _showOnGrid(index);
                            },
                            child: Container(
                              // margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  // color: colorsOfGrid[index],
                                  border: Border.all(color: Colors.white30)),
                              child: Center(
                                // child: Text(
                                //   '${displayOnGrid[index]}',
                                //   // '$index',
                                //   style: TextStyle(
                                //     fontSize: 60.0,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //     // fontFamily: 'BlackOpsOne',
                                //   ),
                                // ),
                                // child: Icon(Icons., color: Colors.white,),
                                child: displayOnGrid[index] == ""
                                    ? Text('')
                                    : SvgPicture.asset(
                                        displayOnGrid[index] == "O"
                                            ? 'assets/images/circle3.svg'
                                            : 'assets/images/cross3.svg',
                                        color: Colors.white,
                                        height: 50,
                                      ),
                              ),
                            ),
                          ))),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => _restartGame(),
                      child: Text(
                        'RESTART',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(150, 60),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent),
                    ),
                  )),
            ],
          ),
        ),

        // body:
      ),
    );
  }

  TextStyle DefaultTextStyle(double fontsize) {
    return TextStyle(color: Colors.white, fontSize: fontsize);
  }

  void _showOnGrid(int index) {
    setState(() {
      if (displayOnGrid[index] == "") {
        if (turnOn) {
          displayOnGrid[index] = "O";
        }
        if (!turnOn) {
          displayOnGrid[index] = "X";
        }
        turnOn = !turnOn;
        // _getColor(index);
        _showWinner();
        _showDraw();
      }
      return;
    });
  }

  // void _getColor(int index) {
  //   colorsOfGrid[index] = colorPalletes[random.nextInt(4)];
  // }

  void _restartGame() {
    _clearGamePlayGrid();
    playerOscore = playerXscore = 0;
  }

  void _showWinner() {
    // for vertical columns
    for (var i = 0; i < 3; i++) {
      if (displayOnGrid[i] == displayOnGrid[i + 3] &&
          displayOnGrid[i] == displayOnGrid[i + 6] &&
          displayOnGrid[i] != "") {
        _showWinDialog(displayOnGrid[i]);
      }
    }

    // for horizontal rows
    for (var i = 0; i < 7; i += 3) {
      if (displayOnGrid[i] == displayOnGrid[i + 1] &&
          displayOnGrid[i] == displayOnGrid[i + 2] &&
          displayOnGrid[i] != "") {
        _showWinDialog(displayOnGrid[i]);
      }
    }

    // diagonals
    if ((displayOnGrid[4] == displayOnGrid[0] &&
            displayOnGrid[4] == displayOnGrid[8] &&
            displayOnGrid[4] != "") ||
        (displayOnGrid[4] == displayOnGrid[2] &&
            displayOnGrid[4] == displayOnGrid[6] &&
            displayOnGrid[4] != "")) {
      _showWinDialog(displayOnGrid[4]);
    }
  }

  _updateScoreBoard(String winner) {
    setState(() {
      if (winner == "O") {
        playerOscore += 1;
      } else {
        playerXscore += 1;
      }
    });
  }

  void _updateTurnAfterRound() {
    startWithTurnX = !turnOn;
  }

  void _showWinDialog(String winner) {
    _updateScoreBoard(winner);
    _updateTurnAfterRound();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _clearGamePlayGrid();
                    Navigator.of(context).pop();
                  },
                  child: const Text('START AGAIN'))
            ],
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0.0),
            content: Container(
              height: height * .4,
              width: width * 0.8,
              decoration: BoxDecoration(
                  // color: Colors.black,
                  border: Border.all(
                    color: Colors.amber,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15.0)),
              // color: Colors.amber.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${winner}\nWON',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //       initState();
                  //     },
                  //     child: Text('START AGAIN'))
                ],
              ),
            ),
          );
        });
  }

  void _clearGamePlayGrid() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayOnGrid[i] = "";
        // colorsOfGrid[i] = Colors.transparent;
      }
    });
  }

  void _showDraw() {
    for (var i = 0; i < 9; i++) {
      if (displayOnGrid[i] == "") return;
    }
    _showDrawDialog();
    _updateTurnAfterRound();
  }

  void _showDrawDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _clearGamePlayGrid();
                    Navigator.of(context).pop();
                  },
                  child: const Text('START AGAIN'))
            ],
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0.0),
            content: Container(
              height: height * .4,
              width: width * 0.8,
              decoration: BoxDecoration(
                  // color: Colors.black,
                  border: Border.all(color: Colors.amber, width: 1),
                  borderRadius: BorderRadius.circular(15.0)),
              // color: Colors.amber.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'GAME\DRAW',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //       initState();
                  //     },
                  //     child: Text('START AGAIN'))
                ],
              ),
            ),
          );
        });
  }
}
