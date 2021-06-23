import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:naive_bayes/models/ResponseData.dart';

class NaiveBayes {
  List<Map<String, dynamic>> selectedValues;

  NaiveBayes(this.selectedValues);

  Future<ResponseData> resolveAlgorim() async {
    double respSi = 0.0;
    double respNo = 0.0;
    try {
      final response = await rootBundle.loadString('assets/naiveData.json');
      final data = json.decode(response);
      respSi = calcResponse(selectedValues, data, true);
      respNo = calcResponse(selectedValues, data, false);
    } catch (e) {
      print(e);
    }
    return ResponseData(
      response: respSi > respNo,
      totalSi: respSi,
      totalNo: respNo,
    );
  }

  double calcResponse(List<Map<String, dynamic>> selectedValues, data, bool type) {
    double total = 1.0;
    final totalCount = data['totales'][type ? 'Si':'No'];
    selectedValues.forEach((value) {
      final key = value.keys.first;
      final response = value.values.first.toString().replaceAll(' ', '');
      data[key].forEach((value) {
        if (response == value.keys.first) {
          total = total * (value[response][type ? 'Si':'No'] / totalCount);
        }
      });
    });
    return total;
  }
}
