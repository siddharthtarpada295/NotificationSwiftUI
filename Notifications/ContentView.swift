//
//  ContentView.swift
//  Notifications
//
//  Created by Siddharth Tarpada on 15/05/20.
//  Copyright © 2020 Siddharth Tarpada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var show = false
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: Text("Detail View"), isActive: self.$show) {
                    Text("")
                }
                Button(action: {
                    self.send()
                }) {
                    Text("Tap Me!!")
                }.navigationBarTitle("Home")
            }.onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { (_) in
                    self.show.toggle()
                }
            }
        }
        
    }
    
    func send() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (_, _) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "New Notification from your Project!!"
        
        let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
        let cancel = UNNotificationAction(identifier: "Close", title: "Close", options: .destructive)
        
        let category = UNNotificationCategory(identifier: "action", actions: [open,cancel], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        content.categoryIdentifier = "action"
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let req = UNNotificationRequest(identifier: "req", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct  Detail : View {
    
    @Binding var show : Bool
    var body: some View {
        NavigationView {
            Button(action: {
                self.show.toggle()
            }) {
                Text("Detail View")
            }
        }
    }
}
