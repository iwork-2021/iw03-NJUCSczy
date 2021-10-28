# iw03实验报告

一、NewsTableViewCell类
---------------------------
前四个栏目的TableViewCell均使用此类，在cell上展示新闻的标题和日期。

二、NewsTableViewController类
---------
前四个栏目的TableViewController类与此类类似。此类包含一个子类News，其中定义了一条新闻的标题、日期和跳转URL。在初始化或翻页时，根据当前页码，通过load_web()，获取当前新闻目录网页的html源码，并从中解析出对应的新闻标题、日期、跳转URL，然后存储进NewsArray数组中。已经加载完成的新闻条目信息会存储在数组中，不需要重复下载。最后，在点击一个TableViewCell时，会跳转到InfoViewController界面，在prepare()函数中将点击的新闻条目的跳转URL传给对应的界面。

三、InfoTableViewController类
-------------
用于显示新闻详细信息的类，顶端有一张UIImage，其余部分用于显示网页中的内容。根据传入的URL，此类在初始化时解析网页的html源码，解析出其中的content部分，然后展示在此场景的WebView中。每次从网页完成下载后，会将content内容存储在一个以URL作为key值的字典中，并存储在文件中。如果文件中已有对应新闻界面的信息，则不会重复下载。
AboutUsViewController类实现方法也与此类类似。