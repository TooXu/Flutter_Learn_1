import 'package:flutter/material.dart';

//class basicWidgetPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return new basicWidgetState(
//      Text('JOJOJOJOJOJOJOJOJO',style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),
//    );
//  }
//}

class basicWidgetPage extends StatelessWidget {
  final Widget title;

  const basicWidgetPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
//      appBar: new AppBar(
//        title: new Text("关于", style: new TextStyle(color: Colors.lightGreen),),
//        ),
      child: new Container(
        height: 76.0,
        padding: const EdgeInsets.symmetric(horizontal: 9.0,vertical:20 ),
        decoration: BoxDecoration(color: Colors.red),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null,
            ),
            Expanded(
              child: title,
            ),
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'search',
              onPressed: null,
            )
          ],
        ),
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: new Column(
        children: <Widget>[
          new basicWidgetPage(
            title: new Text('Title'),
          )
        ],
      ),
    );
  }
}
