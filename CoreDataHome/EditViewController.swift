//
//  EditViewController.swift
//  CoreDataHome
//
//  Created by Anusha on 27/12/22.
//

import UIKit

class EditViewController: UIViewController {
    
    var controller: ViewController!
    @IBOutlet weak var editSaveBtn: UIBarButtonItem!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var noteSelected: String?
    var descriptionSelected: String?
    var titleIs: String?
    var descriptionIs: String?
    var items: NoteData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = noteSelected
        titleTextField.text = descriptionSelected
        
        titleIs = titleTextField.text
        descriptionIs = descriptionTextView.text
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveChanges(_ sender: UIBarButtonItem) {
        
        guard !titleIs!.isEmpty , !descriptionIs!.isEmpty else {
            controller.createItem(nameNote:titleTextField.text!, descriptionNote: descriptionTextView.text)
          
             self.navigationController?.popViewController(animated: true)
           
           return
        }
        if let item = items {
          controller.updateItem(item: item, newName: titleTextField.text!, newDescription: descriptionTextView.text!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
