
# NotificationRepository

The `NotificationRepository` class provides a simple way to manage notifications using Firebase Cloud Messaging (FCM) and local notifications in a Flutter application. It includes methods for initializing Firebase messaging, obtaining a device token, handling background messages, and displaying local notifications.

## Usage

### Initialization

Before using the `NotificationRepository`, ensure that Firebase messaging is properly configured in your Flutter project. You can do this by following the official Firebase Flutter setup guide.

### Creating an Instance

To use the `NotificationRepository`, create an instance of the class:

```dart
final notificationRepository = NotificationRepository();
```

### Initializing Firebase Messaging

Initialize Firebase messaging and request permission for notifications:

```dart
await notificationRepository.initializeApp()
```

### Getting a Device Token

To obtain the device token for sending notifications, use the `getToken()` method:

```dart
final token = //await 

notificationRepository.getToken();
```

### Handling Background Messages

Handle background messages using the `getBackgroundMessage()` method. This method can be used to navigate to specific screens or handle notifications differently based on the message content:

```dart
notificationRepository.getBackgroundMessage()
```

### Displaying Local Notifications

To display local notifications, use the `showNotification()` method. Specify the notification ID, title, and body:

```dart
await notificationRepository.showNotification(
 /* id: 0,
  title: 'Title',
  body: 'Body',*/
)
```

### Customization

You can customize the notification settings by modifying the `notificationDetails()` method. This method defines the channel settings for Android and iOS notifications.

## Dependencies

This class relies on the following Flutter packages:

- firebase_messaging
- flutter_local_notifications

Ensure that these packages are included in your `pubspec.yaml` file.

## Note

This class provides a basic implementation for managing notifications in a Flutter application. Additional customization and error handling may be required based on your specific use case.

---

Feel free to adjust the content based on your specific requirements or add more detailed instructions as needed.