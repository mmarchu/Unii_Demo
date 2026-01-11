
import 'package:flutter/material.dart';
import 'package:unii_demo/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String code = "TH";
    String dial = "+66";
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage(code: code, dial: dial));
  }
}
