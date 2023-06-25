import 'package:flutter/material.dart';

class ImageRotate extends StatefulWidget {
  GlobalKey draggableKey = GlobalKey();

  ImageRotate({
    required this.draggableKey,
    super.key,
  });

  @override
  _ImageRotateState createState() => _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate> {
  // Size and position.
  final _draggableSize = Size(300, 200);
  Offset _draggablePos = Offset(10, 10);

  // Size of the rotating button.
  final double _rotationHandleBtnSize = 30;

  // The angle at which the widget is rotated.
  double _rotationAngle = 0.0;

  double _angleOnPanStart = 0.0;

  // Whether or not the pointer touched the rotating button.
  bool _isRotating = false;

  // Position of the pointer when touching the GestureDetector.
  Offset _touchPos = Offset.zero;

  @override
  Widget build(BuildContext context) => _draggableAndRotatable(
    children: [
      GestureDetector(
        onPanStart: _onDragStart,
        onPanUpdate: _onDragUpdate,
        onPanEnd: (details) {
          _isRotating = false;
        },
        child: _image(),
      ),
      IgnorePointer(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: ClipOval(
            child: Container(
              height: _rotationHandleBtnSize,
              width: _rotationHandleBtnSize,
              color: Colors.blue,
            ),
          ),
        ),
      )
    ],
  );

  Widget _draggableAndRotatable({required List<Widget> children}) => Positioned(
    left: _draggablePos.dx,
    top: _draggablePos.dy,
    child: Transform.rotate(
      angle: _rotationAngle,
      child: SizedBox(
        height: _draggableSize.height,
        width: _draggableSize.width,
        child: Stack(
          children: children,
        ),
      ),
    ),
  );

  Widget _image() => Image.network(
    'https://via.placeholder.com/300x200',
    height: _draggableSize.height,
    width: _draggableSize.width,
    fit: BoxFit.fill,
  );

  void _onDragStart(DragStartDetails details) {
    // Set angle on start.
    final centerOfGestureDetector = Offset(
      _draggableSize.width / 2,
      _draggableSize.height / 2,
    );
    final touchPositionFromCenter =
        details.localPosition - centerOfGestureDetector;

    _angleOnPanStart = touchPositionFromCenter.direction - _rotationAngle;

    // Set touch pos.
    final RenderBox referenceBox =
    widget.draggableKey.currentContext?.findRenderObject() as RenderBox;
    var localPos = referenceBox.globalToLocal(details.globalPosition);

    _touchPos = Offset(
      localPos.dx,
      localPos.dy,
    );

    // Check if user tapped inside the rotate btn area.
    final isRotateBtnWidth = details.localPosition.dx <= _rotationHandleBtnSize;
    final isRotateBtnHeight = details.localPosition.dy >=
        _draggableSize.height - _rotationHandleBtnSize;
    if (isRotateBtnWidth && isRotateBtnHeight) {
      _isRotating = true;
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isRotating) {
      final centerOfGestureDetector = Offset(
        _draggableSize.width / 2,
        _draggableSize.height / 2,
      );
      final touchPositionFromCenter =
          details.localPosition - centerOfGestureDetector;

      _rotationAngle = touchPositionFromCenter.direction - _angleOnPanStart;
    } else {
      final globalPos = _draggablePos + details.globalPosition;
      final localPos = globalPos - _touchPos;
      _draggablePos = localPos - _draggablePos;
    }

    // Refresh
    setState(() {});
  }
}
