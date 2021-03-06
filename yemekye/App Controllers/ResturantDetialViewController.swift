//
//  ResturantDetialViewController.swift
//  yemekye
//
//  Created by Arsalan Wahid Asghar on 10/22/17.
//  Copyright © 2017 Arsalan Wahid Asghar. All rights reserved.
//

import UIKit

/*
 TODO-LIST
 
 contains
 
 1. tableview
 2. ScrollView
 3. Collection View
 4. Navigation
 5.Resturant Details
 6.menu Clickable
 
 
 WorkFlow
 1.This is presented after user selects a resturant from the mainViewControllerafter
 2. Fix this view with auto layout
 2a. This scene will show all the properties of the resturant object that has been selected
 3. Implement scoll view
 */




class ResturantDetialViewController: UITableViewController{
    
    //MARK:- Properties
    private let tableCells = 4
    private let tableHeaderViewHeight:CGFloat = 300
    private let tableViewheaderCutAway : CGFloat = 40
    
    var image: UIImage?
    var headerView: ResturantHeaderView!
    var headerMaskLayer: CAShapeLayer!
    
    
    
    
    //MARK:- Resturant Cells
    struct restuarntDetailCells{
        static let infoCell = "infoCell"
        static let actionsCell = "actionsCell"
        static let amenitiesCell = "amenitiesCell"
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = tableView.tableHeaderView as! ResturantHeaderView
        headerView.image = image
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        //At this point the table view header is not over the top of rest of the views
        
        //Pushed the tableview down by top CGFloat points
        tableView.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0 )
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderViewHeight + 64)
        
        //cut Away header View
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        
        let effectiveHeight = tableHeaderViewHeight - tableViewheaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        updateheaderView()
        
        //MARK:- NavigationBar

        if ResturantsFromAPI.count > 0{
        self.navigationItem.title = ResturantsFromAPI[cellIndex].name
        }else{
            self.navigationItem.title = RData.Rdata.resturants[cellIndex].name
        }
        
        navigationItem.backBarButtonItem?.tintColor = .white
        
    }
    
    //MARK:- Helper Method
    
    private func  updateheaderView(){
        let effectiveheight = tableHeaderViewHeight - tableViewheaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveheight, width: tableView.bounds.width, height: tableHeaderViewHeight)
        if tableView.contentOffset.y < -effectiveheight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableViewheaderCutAway / 2
        }
        headerView.frame = headerRect
        //
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - tableViewheaderCutAway))
        headerMaskLayer?.path = path.cgPath
    }
    
    
//    //MARK:- Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showMenu"{
//            let DVC = segue.destination as! MenuTableViewController
//            DVC.menu = RData.Rdata.resturants[cellIndex].menu
//        }
//    }
    
}



//MARK:- UITableViewDataSource
extension ResturantDetialViewController{
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //set info cell
        if indexPath.row == 0{
            let cell = Bundle.main.loadNibNamed("InfoTableViewCell", owner: self, options: nil)?.first as! InfoTableViewCell
            
            if ResturantsFromAPI.count >= 1{
            cell.nameLabel.text = ResturantsFromAPI[cellIndex].name
            cell.addressLabel.text = ResturantsFromAPI[cellIndex].location.locality
            cell.statusLabel.text = ResturantsFromAPI[cellIndex].user_rating.aggregate_rating
            var time = ""
            for n in RData.Rdata.resturants[cellIndex].timing
            {
                let (open,close) = n
               
                time += "\(open)-\(close)\n"
                
            }
            cell.timingsLabel.text = time
            }else{
                cell.nameLabel.text = RData.Rdata.resturants[cellIndex].name
                cell.addressLabel.text = RData.Rdata.resturants[cellIndex].address
                cell.statusLabel.text = RData.Rdata.resturants[cellIndex].status
                var time = ""
                for n in RData.Rdata.resturants[cellIndex].timing
                {
                    let (open,close) = n
                    
                    time += "\(open)-\(close)\n"
                    
                }
                cell.timingsLabel.text = time
            }
            return cell
            
        }
            //set actions cell
        else if indexPath.row == 1{
            let cell = Bundle.main.loadNibNamed("ActionsTableViewCell", owner: self, options: nil)?.first as! ActionsTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            //Check if any data is Resturants
            if ResturantsFromAPI.count >= 1{
            
            cell.phone.titleLabel?.text = "03312226043"
            cell.websiteurl.text = ResturantsFromAPI[cellIndex].url
        
            }else{
                cell.phone.titleLabel?.text = "03312226034"
                cell.website.titleLabel?.text = "https://www.zomato.com/buffalo"
            }
            return cell
            
        }else if indexPath.row == 2{
            let cell = Bundle.main.loadNibNamed("PromotionsTableViewCell", owner: self, options: nil)?.first as! PromotionsTableViewCell
            cell.promotionsImage.image = UIImage(named: "menuicon")
            cell.promotionsLabel.text = "Menu"
            cell.accessoryType = .disclosureIndicator
            return cell
            
        }else if indexPath.row == 3{
            
            let cell = Bundle.main.loadNibNamed("AmenitiesTableViewCell", owner: self, options: nil)?.first as! AmenitiesTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            print(" REstuarnt Phone number \(ResturantsFromAPI[cellIndex].phone_numbers)")
            cell.phone.titleLabel?.text = ResturantsFromAPI[cellIndex].phone_numbers
            cell.cuisinesLabel.text = ResturantsFromAPI[cellIndex].cusines
            cell.avgCostLabel.text = String(ResturantsFromAPI[cellIndex].average_cost_for_two)
            cell.currency.text = ResturantsFromAPI[cellIndex].currency
            return cell
        }else{
            fatalError("no cell exists in ResturantDetailViewconteller")
        }
        //will never run I Guess
        return UITableViewCell()
    }
    
    
    //MARK:- UITalbeViewDelegate
    //Controls the Custom heights of each cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(186.0)
        }else if indexPath.row == 1{
            return CGFloat(100.0)
        }else if indexPath.row == 2{
            return CGFloat(80)
        }else if indexPath.row == 3{
            return CGFloat(330)
        }
        return CGFloat(44)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            var url: URL!
            let menu = ResturantsFromAPI[cellIndex].menu_url
            if let menu  = menu{
               url  = URL(string: "\(menu)")!
            }else{
                print("no menu found")
                url = URL(string: "https://www.zomato.com/buffalo")
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

//MARK:- Update Streachy Header
extension ResturantDetialViewController{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateheaderView()
    }
}


