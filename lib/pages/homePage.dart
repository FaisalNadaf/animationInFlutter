import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _borderRadius = 100;

  final Tween<double> _pageBgScale = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );

  AnimationController? _starIconControler;

  @override
  void initState() {
    super.initState();
    _starIconControler = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );
    _starIconControler!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.none,
        child: Stack(
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _AnimatedButton(),
                _starAnimation(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      curve: Curves.easeInCirc,
      tween: _pageBgScale,
      duration: const Duration(seconds: 1),
      builder: (_context, double _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _AnimatedButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _borderRadius = _borderRadius == 200 ? 100 : 200;
          });
        },
        child: AnimatedContainer(
          curve: Curves.elasticInOut,
          duration: const Duration(
            seconds: 1,
          ),
          height: _borderRadius,
          width: _borderRadius,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(
              _borderRadius,
            ),
          ),
          child: const Center(
            child: Text(
              'Basic!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _starAnimation() {
    return AnimatedBuilder(
      animation: _starIconControler!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _starIconControler!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
