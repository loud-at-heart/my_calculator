import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_calculator/history.dart';
import 'package:my_calculator/return_display.dart';

import 'calculator_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome to my Calculator",
      home: Scaffold(
        body: SafeArea(child: Calculation()),
      ),
    );
  }
}

class Calculation extends StatefulWidget {
  const Calculation({Key? key}) : super(key: key);

  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  int? firstOperand;
  String? operator;
  String? his;
  int? secondOperand;
  int? result = 0;
  late double width;
  final _suggestions = <String>[];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  Widget _getButton(
      {required String text,
      required VoidCallback onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  numberPressed(int number) {
    setState(() {
      if (result != null) {
        result = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }
      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = firstOperand! + secondOperand!;
          _suggestions.add(result.toString());
          break;
        case '-':
          result = firstOperand! - secondOperand!;
          _suggestions.add(result.toString());
          break;
        case '*':
          result = firstOperand! * secondOperand!;
          _suggestions.add(result.toString());
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = firstOperand! ~/ secondOperand!;
          _suggestions.add(result.toString());
          break;
      }
      firstOperand = result;
      operator = null;
      secondOperand = null;
      result = null;
    });
  }

  clear() {
    setState(() {
      result = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  String _getDisplayText() {
    if (result != null) {
      return '$result';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.black,
          child: Text(
            "History",
            style: TextStyle(color: Colors.white),
          ),
        ),
        HistoryDisplay(data: _suggestions),
        ResultDisplay(text: _getDisplayText()),
        Row(
          children: [
            _getButton(text: '7', onTap: () => numberPressed(7)),
            _getButton(text: '8', onTap: () => numberPressed(8)),
            _getButton(text: '9', onTap: () => numberPressed(9)),
            _getButton(
                text: 'x',
                onTap: () => operatorPressed('*'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          children: [
            _getButton(text: '4', onTap: () => numberPressed(4)),
            _getButton(text: '5', onTap: () => numberPressed(5)),
            _getButton(text: '6', onTap: () => numberPressed(6)),
            _getButton(
                text: '/',
                onTap: () => operatorPressed('/'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          children: [
            _getButton(text: '1', onTap: () => numberPressed(1)),
            _getButton(text: '2', onTap: () => numberPressed(2)),
            _getButton(text: '3', onTap: () => numberPressed(3)),
            _getButton(
                text: '+',
                onTap: () => operatorPressed('+'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1))
          ],
        ),
        Row(
          children: [
            _getButton(
                text: '=',
                onTap: calculateResult,
                backgroundColor: Colors.orange,
                textColor: Colors.white),
            _getButton(text: '0', onTap: () => numberPressed(0)),
            _getButton(
                text: 'C',
                onTap: clear,
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            _getButton(
                text: '-',
                onTap: () => operatorPressed('-'),
                backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
      ],
    );
  }
}
