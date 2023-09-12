import 'package:flutter/material.dart';
import 'dart:math'; // Import the math library for the pow function

void main() {
  runApp(MaterialApp(
    title: "Calculadora de Prestações",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _loanAmount = 0.0;
  double _interestRate = 0.0;
  int _loanTerm = 1;
  double _monthlyPayment = 0.0;

  void _calculateMonthlyPayment() {
    setState(() {
      double monthlyInterestRate = _interestRate / 12 / 100;
      int totalPayments = _loanTerm * 12;
      if (monthlyInterestRate > 0) {
        _monthlyPayment =
            (_loanAmount * monthlyInterestRate) /
                (1 - pow(1 + monthlyInterestRate, -totalPayments));
      } else {
        _monthlyPayment = _loanAmount / totalPayments;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Prestações"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Valor do Empréstimo: \$$_loanAmount",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Slider(
              value: _loanAmount,
              min: 0,
              max: 10000,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _loanAmount = value;
                });
              },
            ),
            Text(
              "Taxa de Juros Anual: ${_interestRate.toStringAsFixed(2)}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Slider(
              value: _interestRate,
              min: 0,
              max: 20,
              divisions: 200,
              onChanged: (value) {
                setState(() {
                  _interestRate = value;
                });
              },
            ),
            Text(
              "Número de Meses: $_loanTerm",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Slider(
              value: _loanTerm.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              onChanged: (value) {
                setState(() {
                  _loanTerm = value.toInt();
                });
              },
            ),
            ElevatedButton(
              onPressed: _calculateMonthlyPayment,
              child: Text("Calcular"),
            ),
            Text(
              "Prestação Mensal: \$${_monthlyPayment.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
