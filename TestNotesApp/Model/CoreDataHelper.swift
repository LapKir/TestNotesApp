//
//  CoreDataHelper.swift
//  TestNotesApp
//
//  Created by Cyril on 5.08.21.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newNote() -> NoteModel {
        let note = NSEntityDescription.insertNewObject(forEntityName: "NoteModel", into: context) as! NoteModel
        return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(note: NoteModel) {
        context.delete(note)
        saveNote()
    }
    
    static func retrieveNotes() -> [NoteModel] {
        do {
            let fetchRequest = NSFetchRequest<NoteModel>(entityName: "NoteModel")
            let result = try context.fetch(fetchRequest)
            return result
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            return []
        }
    }
}
