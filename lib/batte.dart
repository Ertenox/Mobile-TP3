import 'package:flutter/material.dart';

class Batte extends StatelessWidget {
  double largeur;
  double hauteur;

  Batte({super.key, required this.largeur , required this.hauteur });



  @override
  Widget build(BuildContext context) {
    return Container(
      width: largeur,
      height: hauteur,
      decoration: BoxDecoration(
        color: Colors.blue[900],
      ),
    );
  }
}
