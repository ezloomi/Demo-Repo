import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// A single scan entry in the history list
class ScanEntry {
  final String barcode;
  final DateTime scannedAt;

  ScanEntry({required this.barcode, required this.scannedAt});

  // Formats the time
  String get formattedTime {
    final t = scannedAt;
    return '${t.hour.toString().padLeft(2, '0')}:'
        '${t.minute.toString().padLeft(2, '0')}:'
        '${t.second.toString().padLeft(2, '0')}';
  }
}

abstract class HomeController<T extends StatefulWidget> extends State<T> {
  final TextEditingController manualController = TextEditingController();
  final MobileScannerController cameraController = MobileScannerController();

  // History list — each scan gets added here
  List<ScanEntry> history = [];

  // Whether the camera is actively scanning or paused
  bool isScanning = true;

  //  Called by mobile_scanner when a barcode is detected
  void onDetect(BarcodeCapture capture) {
    // Ignore if camera is paused this prevents duplicate scans
    if (!isScanning) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    _addEntry(barcode!.rawValue!);
  }

  //  Called when user taps Lookup
  void onLookup() {
    final text = manualController.text.trim();
    if (text.isEmpty) return;
    manualController.clear();
    _addEntry(text);
  }

  //  Adds a new entry to history and pauses camera
  void _addEntry(String barcode) {
    // Haptic feedback short vibration on successful scan
    HapticFeedback.mediumImpact();

    setState(() {
      // Add to the TOP of the list so newest is first
      history.insert(0, ScanEntry(barcode: barcode, scannedAt: DateTime.now()));
      // Pause camera until user taps Scan Again
      isScanning = false;
    });

    // Tell the camera to stop processing
    cameraController.stop();
  }

  //  Called when user taps Scan Again
  void onScanAgain() {
    setState(() => isScanning = true);
    cameraController.start();
  }

  //  Called when user deletes a history entry
  void onDeleteEntry(int index) {
    setState(() => history.removeAt(index));
  }

  @override
  void dispose() {
    cameraController.dispose();
    manualController.dispose();
    super.dispose();
  }
}
