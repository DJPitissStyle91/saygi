import 'package:arackaydet/result_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QRScanScreen(),
    );
  }
}
 
class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}
 
class _QRScanScreenState extends State<QRScanScreen> {
  late QRViewController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        title: const Text(
          'Saygı',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }
 
  void _onQRViewCreated(QRViewController controller) {
    this.qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      _handleScan(scanData?.code ?? '');
    });
  }
 
  void _handleScan(String scannedData) async {
    print("calling");
    try {
      final response = await http.post(
        Uri.parse('http://<ENDPOINT IP>:8000/data_checker/check_data/'),
        body: {'data_to_check': scannedData},
      );
 
      if (response.statusCode == 200) {
        print(response.body);
        _pushNavigationResultView(response);
      } else {
        print('POST request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during POST request: $e');
    }
  }
 
  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }
  void _pushNavigationResultView(Response response) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultView(response: response),
      ),
    );
  }
}
