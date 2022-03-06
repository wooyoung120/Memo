//
//  MemoReadVC.swift
//  Memo
//
//  Created by wooyoung on 2022/03/04.
//

import UIKit

class MemoReadVC: UIViewController {

    // 콘텐츠 데이터를 저장하는 변수
    var param: MemoData?
    
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        self.navigationItem.title = dateString
    }
}
