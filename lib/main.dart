import 'package:ar_face_filters_app/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Face Filters App',
      home:MySplashScreen(),
    );
  }
}
