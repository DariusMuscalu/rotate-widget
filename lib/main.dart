import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'widgets/image_rotate.dart';

void main() {
  debugPaintSizeEnabled = false;

  return runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Stack(
            children: [
              ImageRotate(
                draggableKey: _key,
                key: _key,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
