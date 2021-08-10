import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  ResultDisplay({
    required this.text,
  });

  late final text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 30),
          width: double.infinity,
          height: 80,
          color: Colors.black,
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white, fontSize: 34),
          )),
    );
  }
}
