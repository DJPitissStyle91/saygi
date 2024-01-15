//test

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ResultView extends StatelessWidget {
  final Response response;

  const ResultView({Key? key, required this.response}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isPlaka = false;
    if (jsonDecode(response.body)['data_exists'] == "true")
      isPlaka = true;
    
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        title: const Text(
          'Sorgu sonucu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.amber.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    isPlaka ? "Karşınızda 65 yaş üstü bir birey vardır. Araç plakası: ${jsonDecode(response.body)['plate']}" : "Karekod sisteme kayıtlı değildir.",
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
