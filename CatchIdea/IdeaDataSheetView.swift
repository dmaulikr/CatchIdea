//
//  IdeaDataSheetView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/21.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

internal class IdeaDataSheetView: UIView {

    private var headerTextField: UITextField!
    private var contentTextView: UITextView!
    private var reminderSwitch: UISwitch!
    private var markColorView: MarkColorsView!
    private var reminderIntervalSlider: UISlider!
    
    private let dataManager = DataManager.shared
    
    internal var idea : IdeaData?{
        didSet{
            guard let idea = idea else {return}
            headerTextField.text = idea.header
            contentTextView.text = idea.content
            markColorView.select(color: idea.markColor)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        headerTextField = viewWithTag(1) as! UITextField
        contentTextView = viewWithTag(2) as! UITextView
        markColorView = viewWithTag(3) as! MarkColorsView
        reminderSwitch = viewWithTag(4) as! UISwitch
        reminderIntervalSlider = viewWithTag(5) as! UISlider
        
    }

    internal func saveIdea(){
        if let header = headerTextField.text, header != "" {
            if let idea = idea {
                dataManager.deleteOneIdeaData(deleteStyle: .deleteForever, ideaData: idea)
            }
            let interval = TimeInterval(reminderIntervalSlider.value*30 + 10)
            let notificationDate = reminderSwitch.isOn ? Date(timeIntervalSinceNow: interval) : nil
            let ideaData = IdeaData(addingDate: Date(), header: header, content: contentTextView.text,markColor: markColorView.currentSelectedColor, notificationDate: notificationDate)
            dataManager.saveOneIdeaData(ideaData: ideaData)
        }
    }
    
    internal func resignSubviewsFirstResponder() {
        headerTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
}
