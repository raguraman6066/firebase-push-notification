
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final RemoteMessage? msg;

  const HomePage({super.key, this.msg});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notification = widget.msg?.notification;

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(notification?.title ?? 'No notification title'),
            Text(notification?.body ?? 'No notification body'),
          ],
        ),
      ),
    );
  }
}
