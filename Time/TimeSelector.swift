//
//  WWCalendarTimeSelector.swift
//  WWCalendarTimeSelector
//
//  Created by Weilson Wonder on 18/4/16.
//  Copyright © 2016 Wonder. All rights reserved.
//

import UIKit
import ESTimePicker


@objc public protocol TimeSelectorProtocol {
    
    @objc optional func TimeSelectorDone(_ selector: TimeSelector, dates: String)
    @objc optional func TimeSelectorDidDismiss(_ selector: TimeSelector)
    @objc optional func TimeSelectorWillDismiss(_ selector: TimeSelector)
    @objc optional func TimeSelectorCancel(_ selector: TimeSelector, date: String)
    
    
}


open class TimeSelector: UIViewController,ESTimePickerDelegate {
    
    
    @IBOutlet weak var viewTimer: UIView!
    
    @IBOutlet weak var backGround: UIView!
    
    @IBOutlet weak var labelHour: UILabel!
    
    @IBOutlet weak var labelMin: UILabel!
    
    
    open var optionStyleBlurEffect: UIBlurEffectStyle = .dark
    open weak var delegate: TimeSelectorProtocol?
    
     let ESTimePicker1 = ESTimePicker()
    
    
    @IBAction func done(_ sender: Any) {
        
        let picker = self
        let del = delegate
        
         let ouput = labelHour.text! + ":" + labelMin.text! + ":"+"00"
         del?.TimeSelectorDone?(picker, dates: ouput)
        dismiss()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        let picker = self
        let del = delegate
        
        del?.TimeSelectorCancel?(picker, date: "")
        dismiss()
        
    }
    
    
    
    fileprivate func dismiss() {
        let picker = self
        let del = delegate
        del?.TimeSelectorWillDismiss?(picker)
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
            del?.TimeSelectorDidDismiss?(picker)
        } else if presentingViewController != nil {
            self.dismiss(animated: true) {
                del?.TimeSelectorDidDismiss?(picker)
            }
        }
    }
 
    
    
    

    open static func instantiate() -> TimeSelector {
        let podBundle = Bundle(for: self.classForCoder())
        let bundleURL = podBundle.url(forResource: "TimeSelectorStoryboardBundle", withExtension: "bundle")
        var bundle: Bundle?
        if let bundleURL = bundleURL {
            bundle = Bundle(url: bundleURL)
        }
        return UIStoryboard(name: "TimeSelector", bundle: bundle).instantiateInitialViewController() as! TimeSelector
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }

    
    open override func viewDidLoad() {
        super.viewDidLoad()
        

        
         backGround.backgroundColor = UIColor(red:156/255,green:39/255,blue:176/255,alpha:1)
        
        // Add background
        let background: UIView
        if navigationController != nil {
            background = UIView()
            background.backgroundColor = UIColor.white
        } else {
            background = UIVisualEffectView(effect: UIBlurEffect(style: optionStyleBlurEffect))
        }
        
        
        background.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(background, at: 0)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bg]|", options: [], metrics: nil, views: ["bg": background]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[bg]|", options: [], metrics: nil, views: ["bg": background]))
        

        ESTimePicker1.frame = CGRect(x: CGFloat(8), y: CGFloat(8), width: CGFloat(230), height: CGFloat(230))
        ESTimePicker1.wheelColor = UIColor(red:245/256,green:245/256,blue:245/256,alpha:1)
       // ESTimePicker1.textColor = UIColor.red
        ESTimePicker1.tintColor = UIColor.blue
        ESTimePicker1.highlightColor = UIColor(red:156/255,green:39/255,blue:176/255,alpha:1)
        ESTimePicker1.selectColor = UIColor(red:156/255,green:39/255,blue:176/255,alpha:0.01)
        
        
        ESTimePicker1.isNotation24Hours = true
        
        ESTimePicker1.delegate = self
        viewTimer.addSubview(ESTimePicker1)
        
     
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TimeSelector.scrollViewTapped(gesture:)))
        
        labelHour.addGestureRecognizer(tapGesture)
        labelHour.isUserInteractionEnabled = true
        
        view.layoutIfNeeded()

    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
    }
    

    func scrollViewTapped(gesture: UIGestureRecognizer) {
        
        
        ESTimePicker1.type = .hours
        
    }
    
    public func timePickerHoursChanged(_ timePicker: ESTimePicker!, toHours hours: Int32) {
        
        var h = hours.description
        
        if hours<10 {
        
            h = "0\(h.description)"
        }
        
        labelHour.text = "\(h)"
        
        
    }
    
    public func timePickerMinutesChanged(_ timePicker: ESTimePicker!, toMinutes minutes: Int32) {
        
        var h = minutes.description
        
        if minutes < 10 {
            
            h = "0\(minutes)"
        }
        
        labelMin.text = "\(h)"
        
        
    }


    
}
    
   
    
 
