//
//  POIsTableViewController.swift
//  GrailDiary
//
//  Created by Aaron Cleveland on 12/12/19.
//  Copyright © 2019 Aaron Cleveland. All rights reserved.
//

import UIKit

class POIsTableViewController: UIViewController {
    
    var pois: [POI] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddPOIModelSegue" {
            
            guard let addPOIVC = segue.destination as?
                AddPOIViewController else { return }
            
            addPOIVC.delegate = self
        } else if segue.identifier == "ShowPOIDetailSegue" {
            
            guard let poiDetailVC = segue.destination as?
                POIDetailViewController else { return }
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let poi = pois[indexPath.row]
                
                poiDetailVC.poi = poi
            }
        }
    }
}

extension POIsTableViewController: UITableViewDelegate, UITableViewDataSource, AddPOIDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "POICell", for: indexPath) as?
            POITableViewCell else { fatalError("The cell is not a POITableViewCell") }
        
        let poi = pois[indexPath.row]
        cell.poi = poi
        return cell
    }
    
    func poiWasAdded(poi: POI) {
        pois.append(poi)
        tableView.reloadData()
    }
}
