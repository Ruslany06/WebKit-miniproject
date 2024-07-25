//
//  FirstViewController.swift
//  WebKit_Playground
//
//  Created by Ruslan Yelguldinov on 18.06.2024.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var goBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
    }
    
    
    @IBAction func goBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SecondVC") as? SecondViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    


}
