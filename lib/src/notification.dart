import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRepository {
  NotificationRepository();

  String? token = "";
  final _localNotificationServices = FlutterLocalNotificationsPlugin();

  Future<void> initializeApp() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
    await Future.wait([
      getToken(),
      initializeLocalNotification(),
    ]);
  }

  Future<String?> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  Future<void> getBackgroundMessage(context) async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      debugPrint("FirebaseMessaging.getInitialMessage");

      /*if (message != null) {
        if (message.data['type'] == "message") {
          AppRouter.pushScreen(
              widget: const MessagesScreen(), context: context);
        } else {
          AppRouter.pushScreen(
              widget: const NotificationScreen(), context: context);
        }
      }*/
    });
  }

  Future<void> initializeLocalNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/notification_icon");
    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestSoundPermission: true,
            requestBadgePermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _localNotificationServices.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {},
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails androidNotification =
        AndroidNotificationDetails("channel_id", "channel_name",
            channelDescription: "description",
            playSound: true,
            priority: Priority.max,
            importance: Importance.max);
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      sound: "default",
      presentSound: true,
    );
    return const NotificationDetails(
        android: androidNotification, iOS: iosNotificationDetails);
  }

  Future<void> showNotification(
      {required int? id, required String body, required String title}) async {
    final details = await notificationDetails();
    try {
      await _localNotificationServices.show(
        id!,
        title,
        body,
        details,
      );
    } catch (e) {
      debugPrint("Error showing notification: $e");
    }
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}
}
