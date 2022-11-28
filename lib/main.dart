import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstVal = 0.0;
  double secondVal = 0.0;
  var input = '';
  var result = '';
  var operators = '';
  var hideInput = false;
  var resultSize = 40.0;

  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      result = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var finalResult = input;

        finalResult = input.replaceAll('X', '*');
        Parser print = Parser();
        Expression expression = print.parse(finalResult);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        result = finalValue.toString();
        if (result.endsWith('.0')) {
          result = result.substring(0, result.length - 2);
        }
        input = result;
        hideInput = true;
        resultSize = 60;
      }
    } else {
      input = input + value;
      hideInput = false;
      resultSize = 40;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator', style: TextStyle(color: Colors.white,fontSize: 24),),),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? '' : input,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  result,
                  style: TextStyle(
                    fontSize: resultSize,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
          Row(
            children: [
              calcButton(
                  calcText: 'C',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
              calcButton(
                  calcText: '%',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
              calcButton(
                  calcText: '<',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
              calcButton(
                  calcText: '/',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
            ],
          ),
          Row(
            children: [
              calcButton(calcText: '7'),
              calcButton(calcText: '8'),
              calcButton(calcText: '9'),
              calcButton(
                  calcText: 'X',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
            ],
          ),
          Row(
            children: [
              calcButton(calcText: '4'),
              calcButton(calcText: '5'),
              calcButton(calcText: '6'),
              calcButton(
                  calcText: '-',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
            ],
          ),
          Row(
            children: [
              calcButton(calcText: '3'),
              calcButton(calcText: '2'),
              calcButton(calcText: '1'),
              calcButton(
                  calcText: '+',
                  buttonColor: Colors.white,
                  textColor: Colors.blue),
            ],
          ),
          Row(
            children: [
              calcButton(calcText: '00'),
              calcButton(calcText: '0'),
              calcButton(calcText: '.'),
              calcButton(
                  calcText: '=',
                  buttonColor: Colors.blue,
                  textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget calcButton({
    calcText,
    textColor = Colors.white,
    buttonColor = Colors.grey,
  }) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  padding: const EdgeInsets.all(14),
                  backgroundColor: buttonColor),
              onPressed: () => onButtonClick(calcText),
              child: Text(
                calcText,
                style: TextStyle(
                    fontSize: 26,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
