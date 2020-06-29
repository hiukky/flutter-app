import 'dart:math';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Map<String, bool> score = {};

  final Map choices = {
    'A': Colors.green,
    'B': Colors.blue,
    'C': Colors.yellow,
    'D': Colors.pink
  };

  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score ${score.length} / 6'),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys
                  .map((emoji) => Draggable<String>(
                        data: emoji,
                        child: Emoji(
                          emoji: score[emoji] == true ? 'OK' : emoji,
                        ),
                        feedback: Emoji(
                          emoji: emoji,
                        ),
                        childWhenDragging: Container(),
                      ))
                  .toList()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                  ..shuffle(Random(seed)),
          )
        ],
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String> incoming, List rejected) {
        if (score[emoji] == true) {
          return Container(
            color: Colors.blue,
            height: 50,
            width: 70,
            child: Text('CORRECT'),
            alignment: Alignment.center,
          );
        } else {
          return Container(
            color: choices[emoji],
            height: 50,
            width: 70,
          );
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        child: Text(emoji),
      ),
    );
  }
}
