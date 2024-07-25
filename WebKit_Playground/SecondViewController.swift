//
//  SecondViewController.swift
//  WebKit_Playground
//
//  Created by Ruslan Yelguldinov on 19.06.2024.
//

import UIKit
import WebKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
    }
    
    @IBOutlet weak var takeGiftBtn: UIButton!
    @IBOutlet weak var visitWebSite: UIButton!
    @IBOutlet weak var joinTelegramChat: UIButton!
    
    
    @IBAction func loadURLButtonTapped(_ sender: UIButton) {
        navigateToWebViewVC(withAction: .loadURL)
    }
    
    @IBAction func loadPDFButtonTapped(_ sender: UIButton) {
        navigateToWebViewVC(withAction: .loadPDF)
    }
    
    @IBAction func loadTelegramChatButtonTapped(_ sender: UIButton) {
        navigateToWebViewVC(withAction: .loadTelegramChat)
    }
    
    func navigateToWebViewVC(withAction action: WebViewAction) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webViewVC = storyboard.instantiateViewController(withIdentifier: "WebView_ViewController") as? WebViewVC {
            
            webViewVC.actionToPerform = action
            navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
    

}
