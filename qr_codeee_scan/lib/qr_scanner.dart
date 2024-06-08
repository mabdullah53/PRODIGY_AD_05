import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String scannedCode = ''; //variable to hold the screen code

  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedCode = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Qr Scanner')),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please the qr inside the frame',style: TextStyle(
                  fontSize: 18
                ),),
              ),
              Expanded(
                flex: 8,
                child: QRView(
                    key: qrKey ,
                    onQRViewCreated: _onQRViewCreated,
                ),
              ),

              Expanded(
                flex: 2,
                  child:Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(child: Text('Scanned Code : ',style:  TextStyle(fontSize: 18),)),
                          Expanded(child: Link(
                            target:  LinkTarget.blank,
                            uri: Uri.parse('$scannedCode'),
                            builder: (context,followLink)=> TextButton(
                              child: Text('$scannedCode',style: TextStyle(fontSize: 18),),
                                onPressed: followLink,

                            ),
                          )
                          )
                        ],
                      ),
                    ),
                  )

              )

            ],
          ),
        ),
      ),
    );
  }
}
