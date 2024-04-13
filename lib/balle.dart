import 'package:flutter/material.dart';


class Balle extends StatelessWidget {
  const Balle({super.key});

  static double diametre = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: diametre,
        height: diametre,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow,
        )
    );
  }
}
