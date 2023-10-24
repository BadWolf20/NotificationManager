// The Swift Programming Language
// https://docs.swift.org/swift-book

import UserNotifications

public class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    public static let shared = NotificationManager()

    private let notificationCenter = UNUserNotificationCenter.current()

    private override init() { }

    /// Запрашивает разрешение на отправку уведомлений пользователю.
    public func requestNotificationAccess() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        notificationCenter.delegate = self
    }

    /// Отправляет уведомление с указанным заголовком.
    ///
    /// - Parameter title: Заголовок уведомления
    public func sendNotification(withTitle title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
//            print(error?.localizedDescription ?? "No error description")
        }
    }

    /// Отображает уведомление внутри приложения.
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.sound, .banner])
        } else {
            // Fallback on earlier versions
        }
    }

    /// Обрабатывает действия пользователя при нажатии на уведомление.
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
