import 'package:flutter/material.dart';
import 'pages/hidden_webview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice Test Login',
      home: Scaffold(
        backgroundColor: Colors.blue[400],
        body: LoginWebView(),
      ),
    );
  }
}
