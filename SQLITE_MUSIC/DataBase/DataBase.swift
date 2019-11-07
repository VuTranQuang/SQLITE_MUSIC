//
//  DataBase.swift
//  SQLITE_MUSIC
//
//  Created by RTC-HN154 on 11/5/19.
//  Copyright © 2019 RTC-HN154. All rights reserved.
//

import Foundation

class DataBase {
    
    static let sharedInstance = DataBase()
       
    var dataBasePath = String()
    init() {
        getPath()
        createDataBase()
        insertDatabase(nameTable: "ALBUMS", dict: ["Price":"200.000", "AlbumName":"Anh Bỏ Thuốc Em Sẽ Yêu", "ReleaseDate":"11/1/2015", "UrlImg":"Anh Bỏ Thuốc Em Sẽ Yêu - Lyna Thùy Linh.jpg"])
        insertDatabase(nameTable: "SONGS", dict: ["SongName":"Anh Bỏ Thuốc Em Sẽ Yêu", "UrlImg":"Anh Bỏ Thuốc Em Sẽ Yêu.jpg"])
        print(viewDataBase(tableName: "ALBUMS", columns: ["*"], statement: ""))
    }
    func getPath() {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = NSString(string: dirPaths[0])
        dataBasePath = docsDir.appendingPathComponent("musics.db")
        print(dataBasePath)
    }
    
    func createDataBase() -> Bool {
        let file = FileManager.default
        if !file.fileExists(atPath: dataBasePath) {
            let musicsDB = FMDatabase(path: dataBasePath)
            if musicsDB == nil {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            if musicsDB.open() {
                let sql_Create_SONGS = "create table if not exists SONGS (ID interger primary key autoincrement, SongName text, UrlImg text)"
                let sql_Create_DetailPlayList = "create table if not exists DetailPlayList (SongID interger not null, PlayListID interger, foreign key (PlayListID) references PLAYLIST(ID), foreign key (SongID) references SONG(ID), primary key (SongID, PlayListID))"
                let sql_Create_PlayList = "create table if not exists PLAYLIST (ID integer primary key autoincrement, PlaylistName text)"
                let sql_Create_ALBUMS = "create table if not exists ALBUMS (ID integer primary key autoincrement, Price text, AlbumName text, ReleaseDate text, UrlImg text)"
                
                let sql_Create_DetailAlbum = "create table if not exists DETAILALBUM (AlbumID integer, GenreID integer, ArtistID integer, SongID integer, foreign key (AlbumID) references ALBUMS(ID), foreign key (GenreID) references GENRES(ID), foreign key (ArtistID) references ARTISTS(ID), foreign key (SongID) references SONGS(ID), primary key (AlbumID, GenreID, ArtistID, SongID))"
                
                let sql_Create_ARTISTS = "create table if not exists ARTISTS (ID integer primary key autoincrement, ArtistName text, UrlImg text, Born text not null)"
                
                let sql_Create_GENRES = "create table if not exists GENRES (ID integer primary key autoincrement, GenreName text)"
                
                if !musicsDB.executeStatements(sql_Create_SONGS) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                
                if !musicsDB.executeStatements(sql_Create_DetailPlayList) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                
                if !musicsDB.executeStatements(sql_Create_PlayList) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                
                if !musicsDB.executeStatements(sql_Create_ALBUMS) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                
                if !musicsDB.executeStatements(sql_Create_DetailAlbum) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                
                if !musicsDB.executeStatements(sql_Create_ARTISTS) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                
                if !musicsDB.executeStatements(sql_Create_GENRES) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
            } else {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            musicsDB.open()
            return true
        }
        return false
    }
    
    func insertDatabase(nameTable: String, dict: NSDictionary) {
        var keys = String()
        var values = String()
        var first = true
        for key in dict.allKeys {
            if first == true {
                keys = "'" + (key as! String) + "'"
                values = "'" + (dict.object(forKey: key) as! String) + "'"
                first = false
                continue
            }
            keys = keys + "," + "'" + (key as! String) + "'"
            values = values + "," + "'" + (dict.object(forKey:key) as! String) + "'"
        }
        let musicsDB = FMDatabase(path: dataBasePath)
        if musicsDB == nil {
            print("Error: \(musicsDB.lastErrorMessage())")
        }
        if musicsDB.open() {
            if !musicsDB.executeStatements("PRAGMA foreign_keys = ON") {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            
            let insertSQL = "INSERT INTO \(nameTable) (\(keys)) VALUES (\(values))"
            let result = musicsDB.executeUpdate(insertSQL, withArgumentsIn: [])
            if !result {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
        }
        musicsDB.close()
    }
    func viewDataBase(tableName: String, columns: [String], statement: String) -> [NSDictionary] {
        let musicsDB = FMDatabase(path: dataBasePath)
        var items = [NSDictionary]()
        if musicsDB == nil {
            print("Error: \(musicsDB.lastErrorMessage())")
        }
        if musicsDB.open() {
            var allColumns = ""
            
            for column in columns {
                if allColumns == "" {
                    allColumns = column
                } else {
                    allColumns = allColumns + "," + column
                }
            }
            let querySQL = "Select DISTINCT \(allColumns) From \(tableName) \(statement)"
            let resutls: FMResultSet? = musicsDB.executeQuery(querySQL, withArgumentsIn: [])
            while resutls?.next() == true {
                items.append(resutls?.resultDictionary as! NSDictionary)
            }
        }
        musicsDB.close()
        return items
    }
}
