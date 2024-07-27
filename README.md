# Overlapped Carousel

A simple horizontal overlapped carousel widget.

<img src="https://github.com/Karlen96/listener_app/blob/master/assets/preview_1.png" width="240">

<img src="https://github.com/Karlen96/listener_app/blob/master/assets/preview_1.png" width="240">

```dart
import 'package:flutter/material.dart';
import 'package:overlapped_carousel/carousel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Demo',
      home: Material(
        child: Carousel(
          height: 190,
          width: 350,
          initialPage: 0,
          children: List.generate(
            5,
                (i) =>
                Container(
                  color: Colors.red,
                  child: Center(child: Text('$i')),
                ),
          ),
        ),
      ),
    );
  }
}
``` 