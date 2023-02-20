import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Animal_Page(),
    ),
  );
}

class Animal_Page extends StatefulWidget {
  const Animal_Page({Key? key}) : super(key: key);

  @override
  State<Animal_Page> createState() => _Animal_PageState();
}

class _Animal_PageState extends State<Animal_Page> {
  late List<ItemModal> items;
  late List<ItemModal> items2;

  late int score;
  late bool gameover;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    gameover = false;
    score = 0;
    items = [
      ItemModal(
          image: const Image(
            image: AssetImage("assets/image/ant.gif"),
            height: 70,
            width: 70,
          ),
          name: "🐜",
          value: "aa"),
      ItemModal(
          image: const Image(
            image: AssetImage("assets/image/74268-cute-tiger.gif"),
            height: 70,
            width: 70,
          ),
          name: "🐯",
          value: "bb"),
      ItemModal(
          image: const Image(
            image: AssetImage("assets/image/80615-horse-walk-loop.gif"),
            height: 70,
            width: 70,
          ),
          name: "🐎",
          value: "cc"),
      ItemModal(
          image: const Image(
            image: AssetImage("assets/image/101336-toucan.gif"),
            height: 70,
            width: 70,
          ),
          name: "🐧",
          value: "dd"),
      ItemModal(
          image: const Image(
            image: AssetImage("assets/image/14348-just-a-pigeon.gif"),
            height: 70,
            width: 70,
          ),
          name: "🕊️",
          value: "ee"),
    ];
    items2 = List<ItemModal>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animals Game"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.black54)),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "scrore: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      TextSpan(
                        text: "$score",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (!gameover)
              Row(
                children: [
                  Column(
                      children: items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Draggable(
                            data: item,
                            childWhenDragging: item.image,
                            feedback: item.image,
                            child: item.image),
                      ),
                    );
                  }).toList()),
                  const Spacer(),
                  Column(
                      children: items2.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DragTarget<ItemModal>(
                        onAccept: (receivedItem) {
                          if (item.value == receivedItem.value) {
                            setState(() {
                              items.remove(receivedItem);
                              items2.remove(item);
                              score += 10;
                              item.accepting = false;
                            });
                          } else {
                            setState(() {
                              score -= 5;
                              item.accepting = false;
                            });
                          }
                        },
                        onLeave: (recevedItem) {
                          setState(() {
                            item.accepting = false;
                          });
                        },
                        onWillAccept: (receivedItem) {
                          setState(() {
                            item.accepting = true;
                          });
                          return true;
                        },
                        builder: (context, acceptedItems, rejectedItem) =>
                            Container(
                          height: 70,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: item.accepting ? Colors.teal : Colors.grey,
                          ),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                ],
              ),
            if (!gameover)
              Text(
                "GameOver",
                style: TextStyle(
                  color: Colors.deepOrange[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            if (!gameover)
              Center(
                child: OutlinedButton(
                  child: const Text(
                    "New Game",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onPressed: () {
                    initGame();
                    setState(() {});
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ItemModal {
  final String name;
  final String value;
  final Image image;
  bool accepting;

  ItemModal(
      {required this.name,
      required this.value,
      required this.image,
      this.accepting = false});
}
