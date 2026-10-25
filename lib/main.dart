
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/firebase_options.dart';
import 'package:firebasedemo/home_page.dart';
import 'package:firebasedemo/notification_api.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final notificationApi = NotificationApi(navigatorKey);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

  await notificationApi.initializeNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
