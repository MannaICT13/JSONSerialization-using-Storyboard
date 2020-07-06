//
//  ViewController.swift
//  JSONSerialization using Storyboard
//
//  Created by Md Khaled Hasan Manna on 6/7/20.
//  Copyright © 2020 Md Khaled Hasan Manna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Properties
    var countryList = [[String : Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Initializers
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        JSONHandler()
    }
    
    //MARK:- Handlers
    
    func JSONHandler(){
        
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else {return}
     
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data,error == nil else{
                print(error!.localizedDescription)
                return
            }

            
            do{
                self.countryList = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : Any]]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                for (key ,value) in self.countryList.enumerated() {
                    print("\(key) and \(value)")
                }
               
                
            }catch let persingError{
                print(persingError)
            }
            
        }
        task.resume()
        
        
    }
    


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.countryList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CountryCell
        
        let item = countryList[indexPath.row]
        
        cell.capitalLbl.text = item["capital"] as? String
        cell.regionLbl.text = item["region"] as? String
        cell.name.text = item["name"] as? String
        
        
        return cell
        
    }
    
    
    
    
}
