import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      color: Colors.grey.shade300,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String input = '';
  String output = '';

  List<String> buttons = [
    '(',
    ')',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'DEL',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A28),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    child: Text(
                      input,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  ),
                  Container(
                    child: Text(
                      output,
                      style: TextStyle(
                          color: Color(0xFFD4D4D4),
                          fontSize: 35.0
                      ),
                    ),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {

                  // Delete button
                  if(index == buttons.length - 2) {
                    return CalButton(
                      color: Color(0xFFf55255),
                      buttonText: buttons[index],
                      textColor: Color(0xFFD4D4D4),
                      buttonTapped: () {
                        setState(() {
                          input = input.length > 0 ? input.substring(0, input.length - 1) : '' ;
                        });
                      },
                      clear: () {
                        setState(() {
                          input = '';
                          output = '';
                        });
                      },
                    );
                  }

                  // Equal button
                  else if(index == buttons.length - 1) {
                    return CalButton(
                      color: Colors.green,
                      buttonText: buttons[index],
                      textColor: Color(0xFFD4D4D4),
                      buttonTapped: () {
                        setState(() {
                          calOutput();
                        });
                      },
                    );
                  }

                  // Other buttons
                  else {
                    return CalButton(
                      color: isOperator(buttons[index]) ? Color(0xFF4682B4) : Color(0xFFD4D4D4),
                      buttonText: buttons[index],
                      textColor: isOperator(buttons[index]) ? Color(0xFFD4D4D4) : Color(0xFF4682B4),
                      buttonTapped: () {
                        setState(() {
                          input += buttons[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if(x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '(' || x == ')') {
      return true;
    }
    return false;
  }

  void calOutput() {
    try {
      String finalInput = input;
      finalInput = finalInput.replaceAll('x', '*');

      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      output = eval.toString();
    }
    catch(e) {
      print(e);
    }
  }
}