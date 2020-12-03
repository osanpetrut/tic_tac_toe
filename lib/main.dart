import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstPlayer = true; //first player is 0.
  List<String> displayCell = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  int oScore = 0;
  int xScore = 0;
  int equality = 0;

  // static var newFont = GoogleFonts.pressStart2p(
  //   textStyle: const TextStyle(color: Colors.red, letterSpacing: 3),
  // );
  // static var newWhiteFromFont = GoogleFonts.pressStart2p(
  //     textStyle:
  //         const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text(
          'Tic Tac Toe',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Player X',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          xScore.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Player O',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          oScore.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //color: Colors.red,
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700])),
                    child: Center(
                      child: Text(
                        displayCell[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (firstPlayer && displayCell[index] == '') {
        displayCell[index] = 'o';
        equality += 1;
      } else if (!firstPlayer && displayCell[index] == '') {
        displayCell[index] = 'x';
        equality += 1;
      }
      firstPlayer = !firstPlayer;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //ist raw.
    if (displayCell[0] == displayCell[1] &&
        displayCell[0] == displayCell[2] &&
        displayCell[0] != '') {
      _showWinDialog(displayCell[0]);
    }
    //2st row.
    if (displayCell[3] == displayCell[4] &&
        displayCell[3] == displayCell[5] &&
        displayCell[3] != '') {
      _showWinDialog(displayCell[3]);
    }
    //3st row
    if (displayCell[6] == displayCell[7] &&
        displayCell[6] == displayCell[8] &&
        displayCell[6] != '') {
      _showWinDialog(displayCell[6]);
    }
    //1st column
    if (displayCell[0] == displayCell[3] &&
        displayCell[0] == displayCell[6] &&
        displayCell[0] != '') {
      _showWinDialog(displayCell[0]);
    }
//2st column
    if (displayCell[1] == displayCell[4] &&
        displayCell[1] == displayCell[7] &&
        displayCell[1] != '') {
      _showWinDialog(displayCell[1]);
    }
//3st column
    if (displayCell[2] == displayCell[5] &&
        displayCell[2] == displayCell[8] &&
        displayCell[2] != '') {
      _showWinDialog(displayCell[2]);
    }
//main diagonal
    if (displayCell[6] == displayCell[4] &&
        displayCell[6] == displayCell[2] &&
        displayCell[6] != '') {
      _showWinDialog(displayCell[6]);
    }
//second diagonal
    if (displayCell[0] == displayCell[4] &&
        displayCell[0] == displayCell[8] &&
        displayCell[0] != '') {
      _showWinDialog(displayCell[0]);
    } else if (equality == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Equality! Next time more focused.'),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Play again!'),
                  onPressed: () {
                    _clear();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner is: ' + winner),
            actions: <Widget>[
              FlatButton(
                  child: const Text('Play again!'),
                  onPressed: () {
                    _clear();
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });

    if (winner == 'o') {
      oScore++;
      _winnerSound();
    } else if (winner == 'x') {
      _winnerSound();
      xScore++;
    }
    _clear();
    if (oScore == 5 || xScore == 5) {
      oScore = 0;
      xScore = 0;
    }
  }

  void _clear() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayCell[i] = '';
      }
    });
    equality = 0;
  }

  void _winnerSound() async {
    final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio('song/winner.mp3'));
  }
}
