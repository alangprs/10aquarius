//
//  ViewController.swift
//  10aquarius
//
//  Created by user on 2020/8/1.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//物件的oulet連線
    @IBOutlet weak var calenderImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    
//設定變數在 @IBAction yearChangeSlider func 中使用
    var sliderNumber = 0
    
//設定變數在  func compare 中使用
    var imgnum = 0
//讀取系統日期
    let dateformatter = DateFormatter()

//利用 Array 對應 Assets 圖片名稱
    let image = [2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020]
 
    
 // viewDidLoad 設定最開始的啟動程式
    override func viewDidLoad() {
        
        time() // 讓系統開始讀取時間執行比對
        datePicker.locale = Locale(identifier: "zh_TW")
        dateformatter.dateFormat = "yyyy/mm/dd"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

// 讓使用者可以改變日期後對應圖片與文字的更改
    @IBAction func changeImageDatePicker(_ sender: Any) {
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        let picName = "\(year)"
        calenderImageView.image = UIImage(named: picName)
        yearSlider.value = Float(year - 2010)
        yearLabel.text = "\(year) 年"
        
    }
  // 直接改變 slider 後 圖片與文字的更改
    @IBAction func yearChangeSlider(_ sender: UISlider) {
        sender.value.round()
        sliderNumber = Int(sender.value)
        let imageSlider = image[sliderNumber]
        calenderImageView.image = UIImage(named: String(imageSlider))
        yearLabel.text = "\(image[sliderNumber]) 年"
        
    }
    
    //利用 switch 與 image array 取元件的對應 抓取日期與文字的呈現
    // 以下三個 func 均與 autoSwitch 的作用有關。尤其與 timer()搭配的應用
    var dateString : String = ""
    func choosePicture (num2 : Int){
        switch num2 {
        case 0:
            dateString = "2010/01/01"
        case 1:
            dateString = "2011/01/01"
        case 2:
            dateString = "2012/01/01"
        case 3:
            dateString = "2013/01/01"
        case 4:
            dateString = "2014/01/01"
        case 5:
            dateString = "2015/01/01"
        case 6:
            dateString = "2016/01/01"
        case 7:
            dateString = "2017/01/01"
        case 8:
            dateString = "2018/01/01"
        case 9:
            dateString = "2019/01/01"
        default:
            dateString = "2010/01/01"
        }
        let date = dateformatter.date(from: dateString)
        datePicker.date = date!
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        yearLabel.text = "\(year) 天秤座的 \(num2) 句話"
        
    }
    // 利用 if else 比較陣列圖片
    var ignum = 0
    func compare () {
        if ignum >= image.count {
            ignum = 0
            choosePicture(num2: ignum)
            calenderImageView.image = UIImage(named: String(image[ignum]))
        }else {
            choosePicture(num2: ignum)
            calenderImageView.image = UIImage(named: String(image[ignum]))
        }
        yearSlider.value = Float(ignum)
        ignum += 1
    }
    
    // 以下使啟動時間 time 的寫法
    var timer : Timer?
    func time () {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.compare()
        })
        
    }
    
    //以下是 autoSwitch 的寫法
    @IBAction func autoPlaySwitch(_ sender: UISwitch) {
        if sender.isOn {
            time()
            ignum = sliderNumber
            yearSlider.value = Float(ignum)
            
        } else {
            timer?.invalidate()
        }
        
    }
    //程式結束執行後 要 disable timer 
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

}

