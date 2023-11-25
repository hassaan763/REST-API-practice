import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Screen5 extends StatelessWidget {
  const Screen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screen5'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [ 
          Text('data')
        ],
      ),
    );
  }
}
