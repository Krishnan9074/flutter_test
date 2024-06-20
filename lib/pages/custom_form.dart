import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  final Function(String, String) onSubmit;

  CustomForm({required this.onSubmit});

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
            onChanged: (value) {
              setState(() {
                username = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit(username, password);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
