//
//  ViewSongs.swift
//  SQLITE_MUSIC
//
//  Created by RTC-HN154 on 11/6/19.
//  Copyright © 2019 RTC-HN154. All rights reserved.
//

import UIKit

class ViewSongs: ViewControllerTableBase, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "SongName", for: indexPath)
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem.object(forKey: "SongName")
         as? String
        return cell
    }
    
    func getDataSong(statement: String)
    {()
        items = self.dataBase.viewDataBase(tableName: "SONGS", columns: ["*"], statement: statement)
        self.myTableView.reloadData()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SongName")
        getDataSong(statement: "")
        getArtistWithSongID()
        
        // Do any additional setup after loading the view.
    }

  
}
//extension ViewSongs: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        tableView.register(UINib(nibName: "UITableViewCellBase", bundle: nil), forCellReuseIdentifier: "cell")
//        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "SongName", for: indexPath)
//        let currentItem = items[indexPath.row]
//        cell.textLabel?.text = currentItem.object(forKey: "SongName") as? String
//
//        return cell
//    }
//
//
//
//
//}
