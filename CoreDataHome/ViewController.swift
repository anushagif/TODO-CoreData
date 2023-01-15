//
//  ViewController.swift
//  CoreDataHome
//
//  Created by Anusha on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var model = [NoteData]()
    @IBOutlet weak var NoteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CoreData"
        getAllItem()
      
    }
    
    override func loadView() {
        super.loadView()
        NoteTableView?.reloadData()
    
    }
    
    @IBAction func plusBtnPressed(_ sender: Any) {
        didAdd()
    }
    
    func didAdd(){
        
        let alert = UIAlertController(title: "New Note", message: "Do you really want to add a new note?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
            
            let vc = self?.storyboard!.instantiateViewController(withIdentifier: "edit")as! EditViewController
            vc.controller = self
           self?.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NoteTableView.deselectRow(at: indexPath, animated: true)
        let item = model[indexPath.row]
        let sheet = UIAlertController(title: "Modify", message: "Do you really want to delete note?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "edit", style: .default, handler: { [weak self] _ in
            
            let vc = self?.storyboard!.instantiateViewController(withIdentifier: "edit")as! EditViewController
            vc.noteSelected = item.name!
            vc.controller = self
            vc.descriptionSelected = item.descriptions!
            vc.items = item
           self?.navigationController?.pushViewController(vc, animated: true)
            
        
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ [weak self] _ in
            
            self!.deleteItem(item: item )
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(sheet, animated: true)
    }
    
    func getAllItem(){

        do{
            model = try context.fetch(NoteData.fetchRequest())
            print(model)
            DispatchQueue.main.async {
                
                self.NoteTableView?.reloadData()
                
            }
           

        }
        catch{
            
            print(error.localizedDescription)

        }

    }

    func createItem(nameNote: String, descriptionNote: String ){

        let newItem = NoteData(context: context)
        newItem.name = nameNote
        newItem.descriptions = descriptionNote

        do{
            
            try context.save()
            getAllItem()
            
        }catch{

        }
    }

    func deleteItem(item : NoteData){
        context.delete(item)
        do{
            try context.save()
            getAllItem()
        }catch{

        }
    }

    func updateItem(item: NoteData, newName: String, newDescription: String ){
        item.name = newName
        item.descriptions = newDescription
        do{
            try context.save()
            getAllItem()
        }catch{

        }
    }




}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = NoteTableView.dequeueReusableCell(withIdentifier: "cellone", for: indexPath) as! NoteTableViewCell
        cell.titleLabel?.text = model[indexPath.row].name
        cell.descriptionLabel?.text = model[indexPath.row].descriptions
        return cell
    }


    
}
