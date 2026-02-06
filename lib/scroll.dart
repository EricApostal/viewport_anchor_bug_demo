import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BidirectionalScrollView extends StatefulWidget {
  final ScrollController? controller;
  final Widget Function(BuildContext context, int index) aboveBuilder;
  final Widget Function(BuildContext context, int index) belowBuilder;
  final int? aboveItemCount;
  final int? belowItemCount;
  final int? Function(Key)? findAboveChildIndexCallback;
  final int? Function(Key)? findBelowChildIndexCallback;
  final EdgeInsetsGeometry padding;

  const BidirectionalScrollView({
    super.key,
    this.controller,
    required this.aboveBuilder,
    required this.belowBuilder,
    this.aboveItemCount,
    this.belowItemCount,
    this.findAboveChildIndexCallback,
    this.findBelowChildIndexCallback,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<BidirectionalScrollView> createState() =>
      _BidirectionalScrollViewState();
}

class _BidirectionalScrollViewState extends State<BidirectionalScrollView> {
  late final ScrollController _controller;
  final Key _centerKey = const ValueKey('center_anchor');

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets verticalPadding = widget.padding.resolve(
      Directionality.of(context),
    );
    final topPadding = EdgeInsets.only(top: verticalPadding.top);
    final bottomPadding = EdgeInsets.only(bottom: verticalPadding.bottom);

    final crossAxisPadding = EdgeInsets.only(
      left: verticalPadding.left,
      right: verticalPadding.right,
    );

    return NotificationListener<UserScrollNotification>(
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
        physics: AlwaysScrollableScrollPhysics(),
        viewportBuilder: (context, position) {
          return Viewport(
            offset: position,
            center: _centerKey,
            // HERE - can mess around with this and see the problem
            anchor: 1,
            slivers: [
              SliverPadding(
                padding: topPadding.add(crossAxisPadding),
                sliver: SliverList(
                  delegate: _BidirectionalSliverDelegate(
                    widget.aboveBuilder,
                    childCount: widget.aboveItemCount,
                    findChildIndexCallback: widget.findAboveChildIndexCallback,
                  ),
                ),
              ),

              SliverPadding(
                key: _centerKey,
                padding: bottomPadding.add(crossAxisPadding),
                sliver: SliverList(
                  delegate: _BidirectionalSliverDelegate(
                    widget.belowBuilder,
                    childCount: widget.belowItemCount,
                    findChildIndexCallback: widget.findBelowChildIndexCallback,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BidirectionalSliverDelegate extends SliverChildBuilderDelegate {
  const _BidirectionalSliverDelegate(
    super.builder, {
    super.childCount,
    super.findChildIndexCallback,
  });

  @override
  bool shouldRebuild(covariant _BidirectionalSliverDelegate oldDelegate) {
    return oldDelegate.childCount != childCount;
  }
}
