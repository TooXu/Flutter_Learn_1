import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:css_colors/css_colors.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    final wordPair = new WordPair.random();

    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new RandomWords(),

        ),
      ),
    );
  }
}

// stateful widgets 持有的状态可能在 widget 生命周期中发生变化,实现一个 stateful widget 至少需要两个类
// 1. 一个 StatefulWidget 类
// 2. 一个 state 类. statefulWidget 类本身是不变的,但是 state 类在 widget 生命周期中始终存在.

class RandomWords extends StatefulWidget {
  @override
  // 创建 State 类
  RandomWordState createState() => RandomWordState();
}

// 添加 RandomWordsState 类. 该应用的大部分代码都在该类中 该类持有 RandomWords widget 的状态.
class RandomWordState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(wordPair.asPascalCase,style: TextStyle(color: CSSColors.red));
  }
}