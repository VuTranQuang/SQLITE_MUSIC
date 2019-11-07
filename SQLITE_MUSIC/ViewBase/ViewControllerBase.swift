//
//  ViewControllerBase.swift
//  SQLITE_MUSIC
//
//  Created by RTC-HN154 on 11/6/19.
//  Copyright © 2019 RTC-HN154. All rights reserved.
//

import UIKit

class ViewControllerBase: UIViewController {
    var btn_Title: UIButton!
    var txt_Search: UITextField!
    var items = [NSDictionary]()
    var dataBase = DataBase()
    override func viewDidLoad() {
        super.viewDidLoad()
        addBtn_Title()
        addTxt_Search()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setActionForRightBarButton()
    }
    func setActionForRightBarButton() {
        self.tabBarController?.navigationItem.rightBarButtonItem?.target = self
        self.tabBarController?.navigationItem.rightBarButtonItem?.action = #selector(checkHiddenSearch)
    }
    @objc func checkHiddenSearch() {
        if txt_Search.isHidden == true {
            UIView.transition(with: self.txt_Search, duration: 0.5, options: .transitionCurlDown, animations: nil, completion: nil)
        } else {
            UIView.transition(with: self.txt_Search, duration: 0.5, options: .transitionCurlUp, animations: nil, completion: nil)
        }
        txt_Search.isHidden = !txt_Search.isHidden
    }
    func addTxt_Search() {
        txt_Search = UITextField()
        txt_Search.isHidden = true
        txt_Search.borderStyle = .roundedRect
        txt_Search.placeholder = "Enter name here!!!"
        txt_Search.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(txt_Search)
        
        // Contraint
        let cn1 = NSLayoutConstraint(item: txt_Search, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let cn2 = NSLayoutConstraint(item: txt_Search, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let cn3 = NSLayoutConstraint(item: txt_Search, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let cn4 = NSLayoutConstraint(item: txt_Search, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 64)
        NSLayoutConstraint.activate([cn1, cn2, cn3, cn4])
    }
    
    func addBtn_Title() {
        btn_Title = UIButton()
        btn_Title.setTitle("Name", for: .normal)
        btn_Title.setTitleColor(UIColor.gray, for: .highlighted)
        btn_Title.addTarget(self, action: #selector(chooseOder), for: .touchUpInside)
        btn_Title.backgroundColor = UIColor.black
        self.view.addSubview(btn_Title)
        
        // Contraint
        btn_Title.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: btn_Title, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let cn2 = NSLayoutConstraint(item: btn_Title, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let cn3 = NSLayoutConstraint(item: btn_Title, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let cn4 = NSLayoutConstraint(item: btn_Title, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 64)
        NSLayoutConstraint.activate([cn1, cn2, cn3, cn4])
    }
    @objc func chooseOder() {
        print("Vu")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
