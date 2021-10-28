//
//  AboutUsViewController.swift
//  ITSC
//
//  Created by nju on 2021/10/27.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
            loadHTMLFragment()
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
    
    func loadHTMLFragment() {
            let content = """
                <div class="post post1 post-91 mbox" frag="窗口91">
                                    <div class="con">
                                        <div id="wp_news_w91">

                                            <ul class="news_list clearfix">
                                                
                                                <li class="news n1 clearfix">
                                                    <div class="news_box">
                                                        <div class="news_title">
                                                        
                                                        服务电话</a>
                                                        
                                                        </div>
                                                        <div class="news_fbt">025-89683791</div>
                                                        <div class="news_text">服务时间：每天（8：00-19：00）</div>
                                                    </div>
                                                </li>
                                                
                                                <li class="news n2 clearfix">
                                                    <div class="news_box">
                                                        <div class="news_title">
                                                        
                                                        校园卡电话</a>
                                                        
                                                        </div>
                                                        <div class="news_fbt">025-89683791</div>
                                                        <div class="news_text">服务时间：每天（8：00-19：00）</div>
                                                    </div>
                                                </li>
                                                
                                                <li class="news n3 clearfix">
                                                    <div class="news_box">
                                                        <div class="news_title">
                                                        
                                                        服务邮箱</a>
                                                        
                                                        </div>
                                                        <div class="news_fbt">ITSC@nju.edu.cn</div>
                                                        <div class="news_text"></div>
                                                    </div>
                                                </li>
                                                
                                                <li class="news n4 clearfix">
                                                    <div class="news_box">
                                                        <div class="news_title">
                                                        
                                                        招聘邮箱</a>
                                                        
                                                        </div>
                                                        <div class="news_fbt">ITSChr@nju.edu.cn</div>
                                                        <div class="news_text"></div>
                                                    </div>
                                                </li>
                                                
                                                <li class="news n5 clearfix">
                                                    <div class="news_box">
                                                        <div class="news_title">
                                                        
                                                        仙林信息化中心楼</a>
                                                        
                                                        </div>
                                                        <div class="news_fbt"></div>
                                                        <div class="news_text">前台工作时间：每天8：00–19：00</div>
                                                    </div>
                                                </li>
                                                
                                                <li class="news n6 clearfix">
                                                    <div class="news_box">
                                                        <div class="news_title">
                                                        
                                                        鼓楼综合服务大厅</a>
                                                        
                                                        </div>
                                                        <div class="news_fbt"></div>
                                                        <div class="news_text">工作日：9:00–12:00、13:00–17:00</div>
                                                    </div>
                                                </li>
                                                
                                            </ul>
                                        </div>

                                    </div>
                                </div>
            """
            
            webView.loadHTMLString(content, baseURL: nil)
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
