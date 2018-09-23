//
//  ViewController.swift
//  FinalOne
//

//  Created by James Liddle on 22/09/2018.
//  Copyright © 2018 appCoda. All rights reserved.



import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
   
    @IBOutlet var tableView: UITableView!
    
    
    
    struct Options
    {
        var name = String()
        var list = String()
    }
    
    var options = [Options(name: "Workout",list: "Legs"),
                   Options(name: "Workout",list: "Arms"),
                   Options(name: "Workout",list: "Abs"),
                   Options(name: "Workout",list: "Chest"),
                   Options(name: "Nutrition",list: "Calories"),
                   Options(name: "Nutrition",list: "Carbs"),
                   Options(name: "Nutrition",list: "Protein"),
                   Options(name: "Nutrition",list: "Fibre")]
                   
    
    var filteredOptions = [Options]()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredOptions = options
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredOptions = options
        } else {
            // Filter the results
            filteredOptions = options.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell     {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = self.filteredOptions[indexPath.row].name
        cell.detailTextLabel?.text = self.filteredOptions[indexPath.row].list
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
    }
    
}

