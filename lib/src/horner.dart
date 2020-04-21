import 'dart:io';
import 'package:collection/collection.dart';

List ask(str) {
  stdout.write(str);
  return inputToList(stdin.readLineSync());
}

List inputToList(str) {
  return List.from(str.trim().split(',').map((e) => int.parse(e)));
}

void start() {
  final exponents = ask(
      'Please input a comma separated list of your exponents in descending order: ');
  var sortedExponents = List.from(exponents)..sort();
  sortedExponents = sortedExponents.reversed.toList();
  assert(ListEquality().equals(exponents, sortedExponents));
  final coefficents = ask(
      'Please input a comma separated list of your coefficients according to the order of the exponents: ');
  stdout.write('Where do you want to evaluate the polynomial: ');
  final x_0 = int.parse(stdin.readLineSync());
  final result = horner(exponents, coefficents, x_0);
  print('Result $result');
}

int horner(List exponents, coefficients, x_0) {
  final hornerCoefficients = getHornerCoefficients(exponents,
      coefficients); //complete list of all coefficients, including zeros
  var y = hornerCoefficients[0];
  for (var i = 0; i < hornerCoefficients.length - 1; i++) {
    y = y * x_0 + hornerCoefficients[i + 1];
  }
  return y;
}

List getHornerCoefficients(exponents, coefficients) {
  var hornerCoefficients = [];
  final maxExponent = exponents[0];
  var coefficientCounter = 0;

  for (var i = maxExponent; i >= 0; i--) {
    if (!exponents.contains(i)) {
      hornerCoefficients.add(0);
    } else {
      hornerCoefficients.add(coefficients[coefficientCounter]);
      coefficientCounter++;
    }
  }
  return hornerCoefficients;
}
