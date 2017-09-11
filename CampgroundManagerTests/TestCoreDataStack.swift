//
//  TestCoreDataStack.swift
//  CampgroundManager
//
//  Created by lokizero00 on 2017/9/8.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import Foundation
@testable import CampgroundManager
import CoreData

class TestCoreDataStack:CoreDataStack {
    override init() {
        super.init()
        let container=NSPersistentContainer(name: "CampgroundManager")
        do{
            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }catch{
            print("Could not change PersistentStore Type: \(error.localizedDescription)")
        }
        self.persistentContainer=container
    }
}
