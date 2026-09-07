package com.example.mindgate
import android.os.Bundle
// FlutterActivity allows our Android activity to host the Flutter app.
import io.flutter.embedding.android.FlutterActivity

// MethodChannel allows Flutter (Dart) and Android (Kotlin)
// to communicate with each other.
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    // This is the name of the communication channel.
    //
    // Flutter and Kotlin must use exactly the same channel name
    // to communicate.
    private val CHANNEL = "com.example.mindgate/native"


    // onCreate() is called when the Android Activity is created.
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Get Flutter's communication system.
        //
        // flutterEngine gives us access to the Flutter engine
        // running our Dart application.
        MethodChannel(
            flutterEngine!!.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            // Check which method Flutter is asking Android to execute.
            when (call.method) {

                // Flutter will call this method.
                "testConnection" -> {

                    // Send a response back to Flutter.
                    result.success("Android connection successful!")
                }

                // If Flutter asks for a method that we haven't implemented...
                else -> {

                    // Tell Flutter that the requested method doesn't exist.
                    result.notImplemented()
                }
            }
        }
    }
}