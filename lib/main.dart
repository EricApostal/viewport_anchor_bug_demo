import 'package:flutter/material.dart';
import 'package:flutter_application_1/scroll.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BidirectionalScrollView(
          aboveBuilder: (context, index) {
            return ListTile(
              title: SelectableText(
                "Above Tile - $index\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\n",
              ),
            );
          },
          belowBuilder: (context, index) {
            return ListTile(
              title: SelectableText(
                "Below Tile - $index\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\n",
              ),
            );
          },
        ),
      ),
    );
  }
}
