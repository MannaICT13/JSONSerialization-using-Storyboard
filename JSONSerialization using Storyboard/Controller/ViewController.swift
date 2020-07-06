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

