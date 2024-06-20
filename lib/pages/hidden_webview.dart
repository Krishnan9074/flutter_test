import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebView extends StatefulWidget {
  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  WebViewController? _controller;
  bool _webViewVisible = false;

  Future<void> _injectLoginDetails() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final javascript = """
      document.getElementById('username').value = '$username';
      document.getElementById('password').value = '$password';
      document.querySelector('#loginForm').submit();
    """;
    await _controller?.runJavascript(javascript);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Test Login'),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: _webViewVisible,
            child: WebView(
              initialUrl:
                  'https://practicetestautomation.com/practice-test-login/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (url) {
                if (url ==
                    'https://practicetestautomation.com/practice-test/welcome/') {
                  print('Login successful!');
                }
              },
            ),
          ),
          Center(
            child: Visibility(
              visible: !_webViewVisible,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _injectLoginDetails();
                          setState(() {
                            _webViewVisible = true;
                          });
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
