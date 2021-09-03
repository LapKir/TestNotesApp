//
//  NotesTableViewController.swift
//  TestNotesApp
//
//  Created by Cyril on 4.08.21.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    var notes = [NoteModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        notes = CoreDataHelper.retrieveNotes()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesTableViewCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.timeLabel.text = note.modifyTime?.convertToString() ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            CoreDataHelper.delete(note: noteToDelete)
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indentifier = segue.identifier else { return }
        switch indentifier {
        case "show":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = notes[indexPath.row]
            let destination = segue.destination as! ShowNoteViewController
            destination.note = note
        case "add":
            print("create button tapped")
        default:
            print("Unspecified indentifier")
        }
    }
}
