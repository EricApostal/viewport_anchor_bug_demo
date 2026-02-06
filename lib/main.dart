import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _controller = ScrollController();
  final Key _centerKey = const ValueKey('center_anchor');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction != ScrollDirection.idle) {
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          }
          return false;
        },
        child: Scrollable(
          controller: _controller,
          axisDirection: AxisDirection.down,
          physics: const AlwaysScrollableScrollPhysics(),
          viewportBuilder: (context, position) {
            return Viewport(
              offset: position,
              center: _centerKey,
              anchor: 1.0,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ListTile(
                      title: SelectableText(
                        "Above Tile - $index\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\n",
                      ),
                    );
                  }),
                ),
                SliverList(
                  key: _centerKey,
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ListTile(
                      title: SelectableText(
                        "Below Tile - $index\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\nadding some extra text since it makes it easier for testing\n",
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
