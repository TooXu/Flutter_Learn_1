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
      home: RandomWords(),
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
//          child: new RandomWords(),
//
//        ),
//      ),
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
  // Dart 语言中使用下划线前缀标示符,会强制其变成私有变量.
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 19.0,color: CSSColors.darkGoldenRod);
  final _saved = new Set<WordPair>();


  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase,style: TextStyle(color: CSSColors.red));
    return Scaffold (
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        if(i.isOdd)return Divider();
        final index = i ~/2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow (WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // add icon to listView
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? CSSColors.red : null,
      ),
      // add interactivity
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          }else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
                  return new ListTile (
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                }
            );

            final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Saved the suggestion'),
              ),
              body: new ListView(
                children: divided
              ),
            );
          }
      ),
    );
  }

}