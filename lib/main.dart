import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;

// import 'package:reorderables/reorderables.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // key: key,
      home: PositionedTiles(),
    );
  }
}

class PositionedTiles extends StatefulWidget {
  PositionedTilesState createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles;

  void swapTiles() {
    // print((tiles[0] as dynamic).child.key);
    // print((tiles[1] as dynamic).child.key);
    if (mounted) {
      setState(() {
        tiles.insert(1, tiles.removeAt(0));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tiles = [
      StatefulColorfulTile(UniqueKey()),
      StatefulColorfulTile(UniqueKey()),
      // if (true)
      //   Text(
      //     'Hello',
      //     key: UniqueKey(),),
      // ...for () builder('1')
    ];

/*     
    If the key of ColorTile is localized below the Padding Widget, the corresponding element could not locate the right position of the ColorTile so that Flutter framework will delete both the widget (and its element) and rebuild them. And the colors displayed will be radom.  
    tiles = [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: StatefulColorfulTile(UniqueKey()),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: StatefulColorfulTile(UniqueKey()),
      ),
    ];  

    Stateful sample with Key.
    tiles = [
      StatefulColorfulTile(UniqueKey()),
      StatefulColorfulTile(UniqueKey()),
    ];

    Stateless sample.   
*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ReorderableListView(
        // key: UniqueKey(),
        reverse: false,
        children: tiles,
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            // removing the item at oldIndex will shorten the list by 1.
            newIndex -= 1;
          }
          final Widget element = tiles.removeAt(oldIndex);
          tiles.insert(newIndex, element);
        }, //! Method to manimulate ListWidget!
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_very_dissatisfied),
        onPressed: swapTiles,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // tiles; //? When and How to dispose it?
  }
}

class StatelessColorfulTile extends StatelessWidget {
  final Color icolor = RandomColor().randomColor();
  final Key key;
  StatelessColorfulTile([this.key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: 100.0,
      height: 100.0,
      color: icolor,
    );
  }
}


class StatefulColorfulTile extends StatefulWidget {
  final Key key;
  StatefulColorfulTile(this.key) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _StatefulColorfulTileState();
  }
}

class _StatefulColorfulTileState extends State<StatefulColorfulTile> {
  final Color icolor = RandomColor().randomColor();
  final String name = Faker().person.firstName();
  // final Key key = UniqueKey(); 

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      width: 100.0,
      height: 100.0,
      color: icolor,
      child: Text(name),
    );
  }
}
