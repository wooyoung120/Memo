//
//  MemoFormVC.swift
//  Memo
//
//  Created by wooyoung on 2022/03/04.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    override func viewDidLoad() {
        self.contents.delegate = self
    }
    
    // 저장
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우, 경고 메시지 출력
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject           // 제목
        data.contents = self.contents.text  // 내용
        data.image = self.preview.image     // 이미지
        data.regdate = Date()               // 작성 시각
        
        // 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // 카메라
    @IBAction func pick(_ sender: Any) {
        let select = UIAlertController(title: "이미지를 가져올 곳을 선택하세요.", message: nil, preferredStyle: .actionSheet)
        select.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
            self.presentPicker(source: .camera)
        })
        select.addAction(UIAlertAction(title: "저장앨범", style: .default) { (_) in
            self.presentPicker(source: .savedPhotosAlbum)
        })
        select.addAction(UIAlertAction(title: "사진 라이브러리", style: .default) { (_) in
            self.presentPicker(source: .photoLibrary)
        })
        self.present(select, animated: false)
    }
    
    func presentPicker(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else {
            let alert = UIAlertController(title: "사용할 수 없는 타입입니다.", message: nil, preferredStyle: .alert)
            self.present(alert, animated: false)
            return
        }
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker, animated: false)
    }
    
    // 사용자가 이미지를 선택하면 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 미리보기에 출력
        self.preview.image = info[.editedImage] as? UIImage
        
        picker.dismiss(animated: false)
    }
    
    // 사용자가 텍스트 뷰에 내용을 입력하면 호출
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = self.subject
    }
}


