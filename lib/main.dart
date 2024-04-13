import 'package:flutter/material.dart';
import'page_principale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP3 Jeu PONG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jeu Pong'),
        ),
        body: const SafeArea(
          child: PagePrincipale(),
        ),
      ),
    );
  }
}
