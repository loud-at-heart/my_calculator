import 'package:flutter/material.dart';

class HistoryDisplay extends StatefulWidget {
  const HistoryDisplay({Key? key, required this.data}) : super(key: key);

  final List<String> data;

  @override
  _HistoryDisplayState createState() => _HistoryDisplayState();
}

class _HistoryDisplayState extends State<HistoryDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        color: Colors.black,
        child: ListView.builder(
            reverse: true,
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(
                widget.data[index],
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white, fontSize: 34),
              ));
            }));
  }
}
