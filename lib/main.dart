import 'package:flutter/material.dart';

// MethodChannel allows Dart (Flutter) to communicate
// with native Android code written in Kotlin.
import 'package:flutter/services.dart';

void main() {
  runApp(const MindGateApp());
}


// Root widget of the MindGate application.
class MindGateApp extends StatelessWidget {
  const MindGateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'MindGate',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),

      home: const HomePage(),
    );
  }
}


// Main screen of MindGate.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


// We use StatefulWidget because the message displayed on
// the screen will change after Android sends a response.
class _HomePageState extends State<HomePage> {

  // This MUST match the channel name used in MainActivity.kt.
  static const MethodChannel _channel =
      MethodChannel('com.example.mindgate/native');


  // Stores the response we receive from Android.
  String _androidMessage = 'Not connected yet';


  // Calls the Android method through the MethodChannel.
  Future<void> _testAndroidConnection() async {

    try {

      // Ask Android to execute the "testConnection" method.
      //
      // Android will then return:
      // "Android connection successful!"
      final String result =
          await _channel.invokeMethod('testConnection');


      // Update the screen with Android's response.
      setState(() {
        _androidMessage = result;
      });

    } on PlatformException catch (e) {

      // If communication with Android fails,
      // display an error message.
      setState(() {
        _androidMessage = 'Connection failed: ${e.message}';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('MindGate'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Text(
              'MindGate',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Displays the response received from Android.
            Text(
              _androidMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            // Button that starts the Flutter → Android test.
            ElevatedButton(
              onPressed: _testAndroidConnection,
              child: const Text('Test Android Connection'),
            ),
          ],
        ),
      ),
    );
  }
}