//
//  CoreDataStack.swift
//  BubbleTea
//
//  Created by lokizero00 on 2017/9/5.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import CoreData

class CoreDataStack{
    static let shared=CoreDataStack()
    var errorHandler:(Error)->Void={_ in}
    
//    init() {
//        let container=NSPersistentContainer(name: "CampgroundManager")
//        do{
//            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
//        }catch{
//            print("Could not change PersistentStore Type: \(error.localizedDescription)")
//        }
//        self.persistentContainer=container
//    }
    
    lazy var persistentContainer:NSPersistentContainer = {
        let container=NSPersistentContainer(name: "CampgroundManager")
        container.loadPersistentStores(completionHandler: {
            [weak self] (storeDescription,error) in
            if let error=error as NSError? {
                NSLog("CoreData error \(error),\(error.userInfo)")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    
    lazy var viewContext:NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var backgroundContext:NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext)->Void){
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext)->Void){
        self.persistentContainer.performBackgroundTask(block)
    }
    
    func saveContext(){
        let context=self.persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let nserror=error as NSError
                NSLog("CoreData error \(nserror), \(nserror.userInfo)")
                self.errorHandler(nserror)
            }
        }
    }
}
