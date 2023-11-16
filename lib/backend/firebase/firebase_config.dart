import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDSWPm3ZK7uwA36tCDM5c9FF1PauOsHRX4",
            authDomain: "yttt-9b530.firebaseapp.com",
            projectId: "yttt-9b530",
            storageBucket: "yttt-9b530.appspot.com",
            messagingSenderId: "90897806097",
            appId: "1:90897806097:web:e96909d13cf77d1a7592b0"));
  } else {
    await Firebase.initializeApp();
  }
}
