import 'package:flutter/material.dart';
import 'package:hangman/src/puzzle.dart';

import 'caracter_picker.dart';
import 'game_stage_bloc.dart';
import 'hang_man_painter.dart';

class GameStage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameStage();
  }
}

class _GameStage extends State<GameStage> {

  late GameStageBloc _gameStageBloc;

  @override
  void initState() {
    super.initState();
    _gameStageBloc = GameStageBloc();
  }

  @override
  void dispose() {
    _gameStageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQd = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red]
            )
          ),
          padding: EdgeInsets.all(24.0),
          width: mediaQd.width,
          height: mediaQd.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 270,
                height: mediaQd.height,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: CustomPaint(
                  painter: HangManPainter(_gameStageBloc),
                  size: Size(
                    (270 - 24.0),
                    (mediaQd.height - 24.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: ValueListenableBuilder(
                  valueListenable: _gameStageBloc.curGuessWord,
                  builder: (BuildContext ctxt, String guessWord, Widget? child) {
                    if (guessWord == null || guessWord == '') {
                      return Center(
                          child: ElevatedButton(
                        child: Text('Alusta Uut Mängu'),
                        onPressed: () {
                          _gameStageBloc.createNewGame();
                        },
                      ));
                    }

                    return ValueListenableBuilder(
                        valueListenable: _gameStageBloc.curGameState,
                        builder: (BuildContext ctxt, GameState gameState,
                            Widget? child) {
                          if (gameState == GameState.succeeded) {
                            return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Tubli! Arvasid ära.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0)),
                                  ElevatedButton(
                                    child: Text('Alusta Uut Mängu'),
                                    onPressed: () {
                                      _gameStageBloc.createNewGame();
                                    },
                                  )
                                ]);
                          }

                          if (gameState == GameState.failed) {
                            return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Uups kaotasid!',
                                      style: TextStyle(
                                          // color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24.0)),
                                  RichText(
                                    text: TextSpan(children: [
                                      const TextSpan(
                                          text: 'Õige vastus oli: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16.0)),
                                      TextSpan(
                                          text:
                                              _gameStageBloc.curGuessWord.value,
                                          style: const TextStyle(
                                              // color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0))
                                    ]),
                                  ),
                                  ElevatedButton(
                                    child: Text('Alusta Uut Mängu'),
                                    onPressed: () {
                                      _gameStageBloc.createNewGame();
                                    },
                                  )
                                ]);
                          }

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Arva ära looma...',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.restore,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      _gameStageBloc.createNewGame();
                                    },
                                  ),
                                ],
                              ),
                              CharacterPicker(
                                gameStageBloc: _gameStageBloc,
                              ),
                              Puzzle(
                                guessWord: guessWord,
                                gameStageBloc: _gameStageBloc,
                              )
                            ],
                          );
                        });
                  }))
              )
            ],
          )),
    );
  }
}