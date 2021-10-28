//
//  DynamicsTableViewController.swift
//  ITSC
//
//  Created by nju on 2021/10/27.
//

import UIKit

class DynamicsTableViewController: UITableViewController {
    var NewsArray:Array<Array<News>>=[]
    var currentPage:Int=0
    @IBOutlet weak var pageController: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_web()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func load_web() {
        let loadingPage=self.currentPage
        while self.NewsArray.count < loadingPage+1{
            self.NewsArray.append([])
        }
        if self.NewsArray[loadingPage].count>0{
            self.tableView.reloadData()
            return
        }
        let url = URL(string: "https://itsc.nju.edu.cn/wlyxqk/list\(self.currentPage+1).htm")!
            let task = URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("server error")
                    return
                }
                if let mimeType = httpResponse.mimeType, mimeType == "text/html",
                            let data = data,
                            let string = String(data: data, encoding: .utf8) {
                                DispatchQueue.main.async {
                                    if self.NewsArray[loadingPage].count>0{
                                        self.tableView.reloadData()
                                        return
                                    }
                                    var lines=string.replacingOccurrences(of: "\t", with: "").split(separator: "\r\n")
                                    for i in lines{
                                        var contents=i.split(separator: ">")
                                        if contents[0] == "<span class=\"news_title\""{
                                            var news=News()
                                            news.Title=contents[2].replacingOccurrences(of: "</a", with: "")
                                            news.URL="https://itsc.nju.edu.cn"+contents[1].split(separator: "\'")[1]
                                            self.NewsArray[loadingPage].append(news)
                                        }
                                        else if contents[0] == "<span class=\"news_meta\""{
                                            if self.NewsArray[loadingPage].count>0{
                                                self.NewsArray[loadingPage].last?.Date=contents[1].replacingOccurrences(of: "</span", with: "")
                                            }
                                        }else if contents[0]=="         <span class=\"pages\""{
                                            self.pageController.numberOfPages=((contents[4].replacingOccurrences(of: "</em", with: "")) as NSString).integerValue
                                            if self.pageController.numberOfPages<2{
                                                self.pageController.isHidden=true
                                            }
                                        }
                                }
                                    self.tableView.reloadData()
                            }
                }
            })
        task.resume()
        task.priority=1
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.NewsArray[self.currentPage].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        if self.NewsArray[self.currentPage].count>=indexPath.row+1{
            cell.Date.text=self.NewsArray[self.currentPage][indexPath.row].Date
            cell.Title.text=self.NewsArray[self.currentPage][indexPath.row].Title
            cell.backgroundColor=UIColor(red:0.3 , green:0.2 , blue: 0.5+0.03*CGFloat(indexPath.row%16)+0.02*CGFloat(self.currentPage%16), alpha: 0.5)
        }
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        (segue.destination as! InfoViewController).myURL = NewsArray[self.currentPage][tableView.indexPath(for: sender as! NewsTableViewCell)!.row].URL
    }

    class News{
        var Title:String=""
        var Date:String=""
        var URL:String=""
    }
    

    @IBAction func change_page(_ sender: Any) {
        self.currentPage=(sender as! UIPageControl).currentPage
        load_web()
    }
}
