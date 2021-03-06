//
//  Resturant.swift
//  yemekye
//
//  Created by Arsalan Wahid Asghar on 12/5/17.
//  Copyright © 2017 Arsalan Wahid Asghar. All rights reserved.
//

import UIKit


class Resturant{
    
    var name :String
    var menu : Menu
    var timing : [(String,String)]
    var resturantImage: UIImage
    var status: String
    var address: String
    var phoneNumber: String
    var rating: Int
    
    //The mighty Restuart Object
    //Failable as some parameteres cannot be nil
    init?(name: String,menu: Menu,timings:[(String,String)],resturantImage:UIImage, status:String, address:String, phonenumber:String,rating: Int) {
        
        //Resturant name cannot be nil
        guard !name.isEmpty else {
            return nil
        }
        
        //resturant address cannot be nil
        guard !address.isEmpty else{
            return nil
        }
        
        //Set the Object Properties
        self.name = name
        self.menu = menu
        self.timing = timings
        self.resturantImage = resturantImage
        self.status = status
        self.address = address
        self.phoneNumber = phonenumber
        self.rating = rating
    }
    
}



