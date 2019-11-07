//
//  ViewControllerTableBase.swift
//  SQLITE_MUSIC
//
//  Created by RTC-HN154 on 11/6/19.
//  Copyright © 2019 RTC-HN154. All rights reserved.
//

import UIKit

class ViewControllerTableBase: ViewControllerBase {
    var myTableView: UITableView!
    var nameArtists = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        // Do any additional setup after loading the view.
    }
    func getArtistWithSongID()
    {
        for song in items
        {
            let detail = dataBase.viewDataBase(tableName: "DETAILALBUM", columns: ["ARTISTS.ArtistName"], statement: "JOIN ARTISTS on DETAILALBUM.ArtistID = ARTISTS.ID where SONGID = \(song["ID"]!)")
            nameArtists.append(detail.first!["ArtistName"] as! String)
        }
    }
    func addTableView() {
        myTableView = UITableView()
//        myTableView.register(UINib(nibName: "SongName", bundle: nil), forCellReuseIdentifier: "SongName")
//        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.backgroundColor = UIColor.brown
        self.view.addSubview(myTableView)
        
        // CONTRAINT
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: myTableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let cn2 = NSLayoutConstraint(item: myTableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let cn3 = NSLayoutConstraint(item: myTableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 104)
        let cn4 = NSLayoutConstraint(item: myTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([cn1, cn2, cn3, cn4])
    }

    

}
