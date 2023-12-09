//
//  ItemDataSource.swift
//  StrykerTestApp
//
//  Created by Mudit Jain on 09/12/23.
//

import Foundation
import SwiftUI
import SwiftData

/**
 Class created for integrating Swift Data in the app.
 - This class is responsible for managing the ModelContainer across the app
 - This class will also act as a intermediate layer between the app and the SwiftData. Thus all calls for Swift data can be routed throught this class.
 - This datasource class is singletong and hence it ensures only one instance of Model Container exists in the app.
 - Important: This class is created so that - it can act as single point of DB operations, another important reason is in future if we want plug-in another DB then only this class will undergo changes.
 - Note: This class can be more generic thus can be refactored to support anykind of model interaction, however at this point is not cosidered.
 - Warning: Since, this is a demo app and `SwiftData` is opted thus this restricts the app to be deployed only on devices running iOS 17.0 and above. 
 */
final class ItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ItemDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Item.self)
        self.modelContext = modelContainer.mainContext
    }

    /**
     Appends the single item in the DB
     - Parameter item: Single instance of item which needs to be inserted in DB
     - Throws: Error if any.
     */
    func appendItem(item: Item) throws{
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
//            fatalError(error.localizedDescription)
            throw error
        }
    }

    /**
     Fetches all items from the DB
     - Returns: Array of items fetched from DB
     - Throws: Error if any.
     */
    func fetchItems() throws -> [Item] {
        do {
            return try modelContext.fetch(FetchDescriptor<Item>())
        } catch {
//            fatalError(error.localizedDescription)
            throw error
        }
    }

    /**
    Remove sepecific item instance from DB
     - Parameter item: Single instance of item which needs to be inserted in DB
     */
    func removeItem(_ item: Item) {
        modelContext.delete(item)
    }
}
