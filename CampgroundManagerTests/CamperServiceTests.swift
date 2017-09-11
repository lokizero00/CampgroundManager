//
//  CamperServiceTests.swift
//  CampgroundManager
//
//  Created by lokizero00 on 2017/9/8.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import XCTest
@testable import CampgroundManager

class CamperServiceTests: XCTestCase {
    var camperService:CamperService!
    var coreDataStack:CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack=TestCoreDataStack()
        camperService=CamperService(managedObjectContext: coreDataStack.viewContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        camperService = nil
        coreDataStack = nil
    }
    
    func testExample() {
        let camper=camperService.addCamper(name: "Bacon Lover", phoneNumber: "13862342053")
        
        XCTAssertNotNil(camper,"Camper should not be nil")
        XCTAssertTrue(camper?.fullName == "Bacon Lover")
        XCTAssertTrue(camper?.phoneNumber == "13862342053")
        
        let campers_after=camperService.getCampers()
        XCTAssertTrue(campers_after.count>0)
    }
    
    func testResult(){
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
