import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 250);

class CarouselSlider extends StatefulWidget {
  final int initialPage;
  final double height;
  final List<Widget> children;

  const CarouselSlider({
    super.key,
    required this.children,
    required this.height,
    this.initialPage = 0,
  });

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late final PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
    controller = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          OverlappedCarouselCardItems(
            cards: [
              for (var i = 0; i < widget.children.length; i++)
                CardModel(
                  id: i,
                  child: widget.children[i],
                ),
            ],
            centerIndex: currentPage.toDouble(),
            maxHeight: widget.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          PageView.builder(
            clipBehavior: Clip.none,
            itemCount: widget.children.length,
            onPageChanged: (i) {
              currentPage = i;
              setState(() {});
            },
            itemBuilder: (_, i) => const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class OverlappedCarouselCardItems extends StatelessWidget {
  final List<CardModel> cards;
  final double centerIndex;
  final double maxHeight;
  final double maxWidth;

  const OverlappedCarouselCardItems({
    super.key,
    required this.cards,
    required this.centerIndex,
    required this.maxHeight,
    required this.maxWidth,
  });

  double getCardPosition(int index) {
    final center = maxWidth / 2 - 60;
    final centerWidgetWidth = maxWidth / 5;
    final basePosition = center - centerWidgetWidth / 2;
    final distance = centerIndex - index;

    final nearWidgetWidth = centerWidgetWidth / 5 * 4;
    final farWidgetWidth = centerWidgetWidth / 5 * 3;

    if (distance == 0) {
      return basePosition;
    } else if (distance.abs() > 0.0 && distance.abs() <= 1.0) {
      if (distance > 0) {
        return basePosition - nearWidgetWidth * distance.abs();
      } else {
        return basePosition + nearWidgetWidth * distance.abs();
      }
    } else if (distance.abs() >= 1.0 && distance.abs() <= 2.0) {
      if (distance > 0) {
        return (basePosition - centerWidgetWidth) - 34 * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth) + 12 * (distance.abs() + 1);
      }
    } else {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2);
      }
    }
  }

  Widget _buildItem(CardModel item) {
    final index = item.id;
    final height = maxHeight;
    final position = getCardPosition(index);

    return AnimatedPositioned(
      key: ValueKey(index),
      left: position,
      duration: _duration,
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: (centerIndex - index).abs() == 3 ? 0 : 1,
        duration: _duration,
        child: AnimatedScale(
          duration: _duration,
          scale: index == centerIndex
              ? 1.0
              : (centerIndex - index).abs() == 2
                  ? 0.6
                  : 0.8,
          alignment: FractionalOffset.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: height,
                child: item.child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _sortedStackWidgets(List<CardModel> widgets) {
    for (var i = 0; i < widgets.length; i++) {
      if (widgets[i].id == centerIndex) {
        widgets[i].zIndex = widgets.length.toDouble();
      } else if (widgets[i].id < centerIndex) {
        widgets[i].zIndex = widgets[i].id.toDouble();
      } else {
        widgets[i].zIndex =
            widgets.length.toDouble() - widgets[i].id.toDouble();
      }
    }
    widgets.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return widgets.map((e) {
      final distance = (centerIndex - e.id).abs();
      if (distance >= 0 && distance <= 3) {
        return _buildItem(e);
      } else {
        return Container();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      clipBehavior: Clip.none,
      children: _sortedStackWidgets(cards),
    );
  }
}

class CardModel {
  final int id;
  double zIndex;
  final Widget child;

  CardModel({
    required this.id,
    required this.child,
    this.zIndex = 0.0,
  });
}
