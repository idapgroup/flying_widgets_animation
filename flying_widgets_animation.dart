import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FlyingWidgetsAnimation extends StatefulWidget {
  final int numberOfItems;
  final Widget? animatedItem;
  final Widget? child;
  final double? size;
  final Color? background;

  const FlyingWidgetsAnimation({
    required this.numberOfItems,
    this.animatedItem,
    this.child,
    this.size,
    this.background,
    super.key,
  });

  @override
  State<FlyingWidgetsAnimation> createState() => _FlyingWidgetsAnimationState();
}

class _FlyingWidgetsAnimationState extends State<FlyingWidgetsAnimation>
    with TickerProviderStateMixin {
  List<AnimatedObject> animatedObjects = [];
  Timer? timer;
  final int period = 3;

  void _startAnimation() {
    final Duration interval =
        Duration(milliseconds: (period / widget.numberOfItems * 1000).toInt());

    timer = Timer.periodic(interval, (Timer t) {
      if (animatedObjects.length < widget.numberOfItems) {
        var newAnimation = _createAnimatedObject();
        setState(() {
          animatedObjects.add(newAnimation);
        });
      } else {
        timer?.cancel();
      }
    });
  }

  AnimatedObject _createAnimatedObject() {
    var controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    var animation = _createRandomAnimation(controller);
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.forward(from: 0.0);
      }
    });
    return AnimatedObject(controller, animation);
  }

  Animation<Offset> _createRandomAnimation(AnimationController controller) {
    return Tween<Offset>(
      begin: Offset(-Random().nextDouble(), -Random().nextDouble()),
      end: Offset(Random().nextDouble() + 1, Random().nextDouble() + 1),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );
  }

  List<SlideTransition> _animationList() {
    return animatedObjects.map((animatedObject) {
      return SlideTransition(
        position: animatedObject.animation,
        child: Container(
          alignment: Alignment.center,
          child: widget.animatedItem ??
              Icon(
                Icons.sentiment_satisfied_alt,
                size: widget.size ?? 100,
                color: Color.fromARGB(
                  255,
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255),
                ),
              ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.background ?? Colors.white,
      child:
          Stack(children: [..._animationList(), Center(child: widget.child)]),
    );
  }

  @override
  void dispose() {
    animatedObjects.forEach((animatedObject) {
      animatedObject.controller.dispose();
    });
    timer?.cancel();
    super.dispose();
  }
}

class AnimatedObject {
  final AnimationController controller;
  final Animation<Offset> animation;

  AnimatedObject(this.controller, this.animation);
}
