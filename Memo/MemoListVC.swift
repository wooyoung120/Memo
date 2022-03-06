//
//  MemoListVC.swift
//  Memo
//
//  Created by wooyoung on 2022/03/04.
//

import UIKit

class MemoListVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 테이블 뷰의 셀 개수를 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // memolist 배열 데이터에서 주어진 행에 맞는 데이터 추출
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받음
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MemoCell {
            cell.subject.text = row.title
            cell.contents.text = row.contents
            cell.img?.image = row.image
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.regdate.text = formatter.string(from: row.regdate!)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // memolist 배열에서 선택된 행에 맞는 데이터 추출
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 상세 화면의 인스턴스 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        // 값을 전달한 다음, 상세 화면으로 이동
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}
