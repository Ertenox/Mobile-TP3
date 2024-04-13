import 'package:flutter/material.dart';
import 'batte.dart';
import 'balle.dart';

enum Direction { haut, bas, gauche, droite }

class PagePrincipale extends StatefulWidget {
  const PagePrincipale({super.key});

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> with SingleTickerProviderStateMixin {
  var animation, controleur;
  Direction vDir = Direction.bas;
  Direction hDir = Direction.gauche;

  double largeur = 400;
  double hauteur = 400;
  double posX = 0;
  double posY = 0;
  double largeurBatte = 0;
  double hauteurBatte = 0;
  double positionBatte = 0;
  int score = 0;
  double increment = 5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        hauteur = constraints.maxHeight;
        largeur = constraints.maxWidth;
        largeurBatte = largeur / 2;
        hauteurBatte = hauteur / 20;
        return Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 10,
              child: Text('Score: $score'),
            ),
            Positioned(
              top: posY,
              left: posX,
              child: const Balle(),
            ),
            Positioned(
              bottom: 0,
              left: positionBatte,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails maj) =>
                    deplacerBatte(maj, context),
                child: Batte(largeur : largeurBatte, hauteur : hauteurBatte),
              ),
            ),

          ],
        );
      },
    );
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controleur = AnimationController(
      duration: const Duration(seconds: 10000),
      vsync: this,
    );
    controleur.forward();
    super.initState();
    animation = Tween<double>(begin: 0, end: 100).animate(controleur);
    animation.addListener(() {
      safeSetState(()  {
        (hDir == Direction.droite)
            ? posX += increment
            : posX -= increment;
        (vDir == Direction.bas)
            ? posY += increment
            : posY -= increment;
      });
      testerBordures();
    });

  }

  @override
  void dispose() {
    controleur.dispose();
    super.dispose();
  }

  void testerBordures() {
    if (posX >= largeur - Balle.diametre) {
      hDir = Direction.gauche;
    } else if (posX <= 0) {
      hDir = Direction.droite;
    }
    if (posY >= hauteur - Balle.diametre - hauteurBatte) {
      print('posX: $posX, positionBatte: $positionBatte, largeurBatte: $largeurBatte');
      if (posX >= positionBatte - Balle.diametre  && posX <= positionBatte + largeurBatte + Balle.diametre) {
        vDir = Direction.haut;
        score++;
      } else {
        afficherMessage(context);
        controleur.stop();
      }
    } else if (posY <= 0) {
      vDir = Direction.bas;
    }
  }

  void deplacerBatte(DragUpdateDetails maj, BuildContext context) {
    safeSetState(() {
      positionBatte += maj.delta.dx;
    });
  }

  void safeSetState(Function function) {
    if (mounted && controleur.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void afficherMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fin du jeu'),
          content: Text('Voulez vous faire une autre partie ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  posX = 0;
                  posY = 0;
                  score = 0;
                  controleur.repeat();
                });
              },
              child: const Text('oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                dispose();
              },
              child: const Text('non'),
            ),
          ],
        );
      },
    );
  }

}
