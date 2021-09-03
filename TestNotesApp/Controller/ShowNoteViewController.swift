//
//  ShowNoteViewController.swift
//  TestNotesApp
//
//  Created by Cyril on 4.08.21.
//

import UIKit
import CoreData

class ShowNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var note: NoteModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indentifier = segue.identifier else { return }
        switch indentifier {
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modifyTime = Date()
            CoreDataHelper.saveNote()
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modifyTime = Date()
            CoreDataHelper.saveNote()
        case "cancel":
            print("cancel tapped")
        default:
            print("unspecified segue indentifier")
        }
    }
}
