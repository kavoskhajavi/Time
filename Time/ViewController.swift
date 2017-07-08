//
//  ViewController.swift
//  Time
//
//  Created by bfpig on 3/23/1396 AP.
//  Copyright © 1396 bfpig. All rights reserved.
//

//////kavoskhajavi
import UIKit
import  ESTimePicker

class ViewController: UIViewController ,TimeSelectorProtocol{
    
    let ESTimePicker1 = ESTimePicker()
    
 
    @IBOutlet weak var labelHour: UILabel!


    
    let date = Date()
    let calendar = Calendar.current
  


    @IBAction func btn_timer(_ sender: Any) {
        
        let selector = UIStoryboard(name: "TimeSelector", bundle: nil).instantiateInitialViewController() as! TimeSelector
        selector.delegate = self
        present(selector, animated: true, completion: nil)
        
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
    

        

        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func TimeSelectorDone(_ selector: TimeSelector, dates: String) {
     
        
        labelHour.text = dates
        
            
        }
        
        
}


