//
//  HouseKeepingApp.swift
//  HouseKeeping
//
//  Created by Selim Enes  Ağca on 28.03.2023.
//

import SwiftUI

@main
struct HouseKeepingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
