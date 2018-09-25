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
    
    var options = [Options(name: "Legs",list: "Workout"),
                   Options(name: "Arms",list: "Workout"),
                   Options(name: "Abs",list: "Workout"),
                   Options(name: "Chest",list: "Workout"),
                   Options(name: "Calories",list: "Nutrition"),
                   Options(name: "Carbs",list: "Nutrition"),
                   Options(name: "Protein",list: "Nutrition"),
                   Options(name: "Fibre",list: "Nutrition")]
                   
    
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
        if searchController.searchBar.text! == "ALL" {
            filteredOptions = options
        } else {
            // Filter the results
            filteredOptions = options.filter { $0.name.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredOptions.count
        }
        return 0
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

