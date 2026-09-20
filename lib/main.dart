import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Calculator',
home: const CalculatorScreen(),
);
}
}

class CalculatorScreen extends StatefulWidget {
const CalculatorScreen({super.key});

@override
State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
String _expression = '';
String _display = '';

void _onButtonPressed(String value) {
setState(() {
if (value == 'C') {
_expression = '';
_display = '';
} else if (value == '=') {
_evaluate();
} else {
_expression += value;
_display = _expression;
}
});
}

void _evaluate() {
try {
final exp = Expression.parse(_expression);
const evaluator = ExpressionEvaluator();
final result = evaluator.eval(exp, {});
_display = '$_expression = $result';
_expression = result.toString();
} catch (e) {
_display = 'Error';
_expression = '';
}
}

Widget _buildButton(String label) {
return ElevatedButton(
onPressed: () => _onButtonPressed(label),
child: Text(label, style: const TextStyle(fontSize: 20)),
);
}

@override
Widget build(BuildContext context) {
final buttons = [
'7', '8', '9', '/',
'4', '5', '6', '*',
'1', '2', '3', '-',
'C', '0', '=', '+',
];
return Scaffold(
appBar: AppBar(title: const Text("Edrees's Calculator")),
body: Column(
children: [
Container(
padding: const EdgeInsets.all(24.0),
alignment: Alignment.centerRight,
child: Text(_display, style: const TextStyle(fontSize: 28)),
),
Expanded(
child: GridView.count(
crossAxisCount: 4,
children: buttons.map((b) => _buildButton(b)).toList(),
),
),
],
),
);
}
}