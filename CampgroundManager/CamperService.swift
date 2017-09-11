//
//  CamperService.swift
//  CampgroundManager
//
//  Created by lokizero00 on 2017/9/8.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import Foundation
import CoreData

public class CamperService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    public func addCamper(name:String,phoneNumber:String)->Camper?{
        let camper=NSEntityDescription.insertNewObject(forEntityName: "Camper", into: coreDataStack.viewContext) as! Camper
        camper.fullName=name
        camper.phoneNumber=phoneNumber
        
        do{
            try coreDataStack.viewContext.save()
        }catch{
            print("Could not save: \(error)")
        }
        
        return camper
    }
    
    public func getCampers()->[Camper]{
        let fetchRequest=NSFetchRequest<Camper>(entityName: "Camper")
        var result=[Camper]()
        do{
            result=try coreDataStack.viewContext.fetch(fetchRequest)
        }catch{
            print("Could not fetch: \(error)")
        }
        return result
    }
}
