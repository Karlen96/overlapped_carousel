import 'package:flutter/material.dart';
import 'package:overlapped_carousel/carousel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Carousel',
      home: CarouselExample(),
    );
  }
}

class CarouselExample extends StatelessWidget {
  const CarouselExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CarouselSlider'),
        backgroundColor: Colors.blueAccent,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: CarouselSlider(
              height: 196,
              initialPage: 0,
              children: List.generate(
                3,
                (i) => CardItem(index: i),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 1000)),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 191 / 191,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: Colors.blueAccent,
                child: SizedBox(
                  height: 76,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Lorem title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                'Lorem description',
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
