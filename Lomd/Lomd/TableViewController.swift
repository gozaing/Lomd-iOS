//
//  TableViewController.swift
//  Lomd
//
//  Created by tobaru on 2016/01/09.
//  Copyright © 2016年 tobaru. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // APIのURLを定義
    // APPID=XXXは先程取得したAPI KEYを各自設定してください
    var urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=Tokyo&APPID=a0d989ae2d4390245788b642c3c83f0f"
    
    var cellItems = NSMutableArray()
    let cellNum = 10
    var selectedInfo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTableData()
        
    }
    
    // セクション数を設定
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // 1セクションあたりの行数を設定
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellNum
    }
    
    // コメントアウトされてるのをはずす & cellにテスト表示をつっこむ
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if self.cellItems.count > 0 {
            cell.textLabel?.text = self.cellItems[indexPath.row] as? String
        }
        return cell
    }
    // 継承時は書かれていない。メソッドを追加。
    // テーブルのcellを選択した時に呼ばれる関数。
    // その中で先ほど作成したsegueを呼び出して画面遷移させる
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        self.selectedInfo = self.cellItems[indexPath.row] as! String
        performSegueWithIdentifier("toDetail", sender: nil)
    }
    // segueで遷移するときに、行われる前処理
    // 今選択されたcellの情報を遷移先の画面に渡す
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetail") {
            let viewController : ViewController = segue.destinationViewController as! ViewController
            viewController.info = self.selectedInfo
        }
    }
    // APIをたたいて、配列に保存する
    // 非同期でAPIを叩いている
    func makeTableData() {
        let url = NSURL(string: self.urlString)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            // リソースの取得が終わると、ここに書いた処理が実行される
            print("load json")
            let json = JSON(data: data!)
            // 各セルに情報を突っ込む
            for var i = 0; i < self.cellNum; i++ {
                let dt_txt = json["list"][i]["dt_txt"]
                let weatherMain = json["list"][i]["weather"][0]["main"]
                let weatherDescription = json["list"][i]["weather"][0]["description"]
                let info = "\(dt_txt), \(weatherMain), \(weatherDescription)"
                print(info)
                self.cellItems[i] = info
            }
            self.tableView.reloadData()
        })
        task.resume()
    }
}
