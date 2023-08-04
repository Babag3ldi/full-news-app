import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';



@immutable
class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
     DeviceUtility.instance;   
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );

    // FirebaseUIAuth.configureProviders(
    //   [EmailAuthProvider(), GoogleProvider(clientId: '')],
    // );

    // await AppCache.instance.setup();
  }
}
