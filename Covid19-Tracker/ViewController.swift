//
//  ViewController.swift
//  Covid19-Tracker
//
//  Created by paritosh on 14/04/20.
//  Copyright © 2020 paritosh. All rights reserved.
//

import UIKit
import CountryList

class ViewController: UIViewController, CountryListDelegate {
   
    @IBOutlet weak var caseTf: UITextField!
    @IBOutlet weak var recoverTf: UITextField!
    @IBOutlet weak var deathTf: UITextField!
    
    var countryName:String?
   let url = "https://api.covid19api.com/summary"
    @IBOutlet weak var btnVariable: UIButton!
    func selectedCountry(country: Country) {
        btnVariable.setTitle(country.name,for: .normal)
        countryName = country.name
        print(country.name)
                      print(country.flag)
                      print(country.countryCode)
                      print(country.phoneExtension)
        performRequest(with: url)
        
    }
  
    
    func performRequest(with urlString: String) {
           
           if let url = URL(string: urlString) {
               
               //2. create url session
               
               let session = URLSession(configuration: .default)
               
               //3. give session a task
               
               let task = session.dataTask(with: url) { (data, response, error) in
                   
                   if error != nil {
                       
               print(error)
                       return
                       
                   }
                   
                   if let safeData = data {
                       
            if  let weather  =  self.parseJSON(safeData){
                DispatchQueue.main.async {
                self.caseTf.text = String(weather.cases)
                self.deathTf.text = String(weather.deaths)
                self.recoverTf.text = String(weather.recover)
                }
                }
                       
                   }
                   
               }
               
               //4. start task
               
               task.resume()
               
           }
           
       }
    func parseJSON (_ weatherData: Data) ->data?{
        
        let decoder = JSONDecoder()
        var data1 = data(cases: 1, recover: 2, deaths: 3)
        do {
            
            let decodedData = try decoder.decode(CovidModel.self, from: weatherData)
            for name in decodedData.Countries{
               if name.Country == countryName
               {
                let cases = name.TotalConfirmed
                let recover = name.TotalRecovered
                let deaths = name.TotalDeaths
                data1 = data(cases: cases, recover: recover, deaths: deaths)
               
                }
            }
         return data1
        
            
        } catch {
            
          print(error)
    return nil
            
        }
        
    }
    
    
    
    
    
    
    
    
    var countryList = CountryList()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryList.delegate = self
        
        // Do any additional setup after loading the view.
    }

    @IBAction func countyBtn(_ sender: UIButton) {
   let navController = UINavigationController(rootViewController: countryList)
   self.present(navController, animated: true, completion: nil)
       
    
    
    }
    
}

