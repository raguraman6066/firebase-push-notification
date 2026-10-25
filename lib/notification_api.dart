
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebasedemo/home_page.dart';
import 'package:flutter/material.dart';

class NotificationApi {
  final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  final GlobalKey<NavigatorState> navigatorKey;

  NotificationApi(this.navigatorKey);

  StreamSubscription<String>? _registrationSubscription;
  StreamSubscription<RemoteMessage>? _messageOpenedSubscription;

  Future<void> getFirebaseToken() async {
    await _firebaseMessaging.requestPermission();

    _registrationSubscription =
        _firebaseMessaging.onRegistered.listen(
      (String installationId) {
        debugPrint('Installation ID: $installationId');
      },
      onError: (Object error) {
        debugPrint('Registration error: $error');
      },
    );

    await _firebaseMessaging.register();
  }

  Future<void> initializeNotification() async {
    await getFirebaseToken();
    await initPushnotification();
  }

  void handleMessage(RemoteMessage? msg) {
    if (msg == null) return;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => HomePage(msg: msg),
      ),
    );
  }

  Future<void> initPushnotification() async {
    // App opened from a terminated state.
    final initialMessage =
        await _firebaseMessaging.getInitialMessage();

    handleMessage(initialMessage);

    // App opened from the background.
    _messageOpenedSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen(
      handleMessage,
    );
  }

  Future<void> dispose() async {
    await _registrationSubscription?.cancel();
    await _messageOpenedSubscription?.cancel();
  }
}
