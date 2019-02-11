import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:css_colors/css_colors.dart';
import 'package:flutter/cupertino.dart';
import 'basicWidgetPage.dart';
import 'sampleAppPageState.dart';

void main() => runApp(new SampleApp());

//void main() => runApp(new MaterialApp(
//      title: 'Flutter Tutorial',
//      home: new Container(
//        child: new MyScaffold(),
//      ),
//    ));

/*
 * Material Components2
 * */

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // Scaffold 是 Material 中的主要布局组件.

    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: new Icon(Icons.menu), onPressed: null),
        title: new Text('Title'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed: null),
        ],
      ),
      body: new Center(
        child: new Text('hello world'),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'add',
        child: new Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

/*
  手势处理
* */

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: () {
        print('my button was tapped!');
      },
      child: new Container(
        height: 33.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.8),
          color: Colors.lightGreen[500],
        ),
        child: new Center(
          child: new Text('engage '),
        ),
      ),
    );
  }
}

/*
 * 更改 widgets 显示状态
 * */
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      children: <Widget>[
        new CounterIncrementor(
          onPressed: _increment,
        ),
        new CounterDisplay(
          count: _counter,
        )
      ],
    );
  }
}

class CounterDisplay extends StatelessWidget {
  final int count;

  const CounterDisplay({Key key, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text('Count:$count');
  }
}

class CounterIncrementor extends StatelessWidget {
  final VoidCallback onPressed;

  const CounterIncrementor({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

/// interact
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();

    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: CSSColors.bisque,
      ),
      home: new RandomWords(),
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
  final _biggerFont =
      const TextStyle(fontSize: 19.0, color: CSSColors.darkGoldenRod);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase,style: TextStyle(color: CSSColors.red));
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          new IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: _goBasicWidget)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
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
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  // create a route and added logic for moving between the home route and the new route
  void _pushSaved() {
    Navigator.of(context).push(
      new CupertinoPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });

        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return new Scaffold(
          appBar: new AppBar(
            title: const Text('Saved the suggestion'),
          ),
          body: new ListView(children: divided),
        );
      }),
    );
  }

  void _goBasicWidget() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new MyScaffold();
    }));
  }
}
