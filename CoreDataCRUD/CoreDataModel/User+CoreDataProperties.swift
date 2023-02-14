//
//  User+CoreDataProperties.swift
//  CoreDataCRUD
//
//  Created by mac on 02/02/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var gender: String?

}

extension User : Identifiable {

}
