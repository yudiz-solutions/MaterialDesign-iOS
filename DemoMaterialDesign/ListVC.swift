//
//  ListVC.swift
//  DemoMaterialDesign
//
//  Created by Yudiz Solutions Pvt. Ltd. on 31/07/18.
//  Copyright © 2018 Yudiz Solution Pvt Ltd. All rights reserved.
//

import UIKit

enum SelectedTab: Int{
    case textField = 0
    case button
    case chipView
    case bottomView
    case snackBar
    case tabBar
    case slider
    case pageController
    case spinner
    case highlightView
    case none
    
    var setTitle: String{
        switch self{
        case .textField:
            return "TextField"
        case .button:
            return "Button"
        case .chipView:
            return "Chip View"
        case .bottomView:
            return "Bottom View"
        case .snackBar:
            return "Snack Bar"
        case .tabBar:
            return "Tab Bar"
        case .slider:
            return "Slider"
        case .pageController:
            return "Page Control"
        case .spinner:
            return "Spinner"
        case .highlightView:
            return "Highlight View"
        case .none:
            break
        }
        return ""
    }
}


class TableCell: UITableViewCell{
    @IBOutlet var lblTitle: UILabel!
}

class ListVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tabType: SelectedTab = .none
    var arrListData = ["TextField", "Button", "Chip View", "Bottom View", "SnackBar", "TabBar", "Slider", "Page Control", "Spinner", "Highlight View"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ListVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        cell.lblTitle.text = arrListData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabType = SelectedTab(rawValue: indexPath.row)!
        if tabType.rawValue == 7 {
            performSegue(withIdentifier: "seguePageControl", sender: tabType)
        } else {
            performSegue(withIdentifier: "detailSegue", sender: tabType)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let listVC = segue.destination as! ViewController
            listVC.selectedTab = sender as! SelectedTab
        }
    }
}
