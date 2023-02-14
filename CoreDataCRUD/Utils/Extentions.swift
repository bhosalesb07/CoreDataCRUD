//
//  Extentions.swift
//  CoreDataCRUD
//
//  Created by mac on 02/02/23.
//

import Foundation
import UIKit

extension ViewController: ViewControllerProtocol {
    var controller: ViewController {
        self
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
    
}

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: range)
        self.attributedText = attribute
    }
}

extension UIButton{
    func addShadow(){
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.masksToBounds = false
    }
    func roundedButton(height:CGFloat){
        layer.cornerRadius = height
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
