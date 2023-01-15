//
//  NoteData+CoreDataProperties.swift
//  CoreDataHome
//
//  Created by Anusha on 27/12/22.
//
//

import Foundation
import CoreData


extension NoteData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteData> {
        return NSFetchRequest<NoteData>(entityName: "NoteData")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var name: String?

}

extension NoteData : Identifiable {

}
