//
//  CovidModel.swift
//  Covid19-Tracker
//
//  Created by paritosh on 14/04/20.
//  Copyright © 2020 paritosh. All rights reserved.
//

import Foundation
struct CovidModel : Codable{
    let Countries: [countries]
    
}
struct countries: Codable{
    let Country: String 
    let TotalConfirmed:Int
    let TotalDeaths:Int
    let TotalRecovered:Int
    
}
