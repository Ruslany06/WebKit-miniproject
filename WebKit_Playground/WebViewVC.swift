//
//  ViewController.swift
//  WebKit_Playground
//
//  Created by Ruslan Yelguldinov on 18.06.2024.
//

enum WebViewAction {
    case loadURL
    case loadPDF
    case loadTelegramChat
}


import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        HTTP_label.isHidden = false
        toolbar.isHidden = false
                webViewBottomToToolbarConstraint.priority = UILayoutPriority(1000)
                webViewBottomToSafeAreaConstraint.priority = UILayoutPriority(750)
        loadsOfWebView()
        
        webView.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "canGoForward", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        
        updateNavigationButtons()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "canGoBack", context: nil)
        webView.removeObserver(self, forKeyPath: "canGoForward", context: nil)
        webView.removeObserver(self, forKeyPath: "URL", context: nil)
    }
    
    var actionToPerform: WebViewAction?
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var HTTP_label: UILabel!
    
    @IBOutlet weak var webViewBottomToToolbarConstraint: NSLayoutConstraint!
    @IBOutlet weak var webViewBottomToSafeAreaConstraint: NSLayoutConstraint!
    
    
    func loadURL() {
        guard let url = URL(string: "https://mobydev.kz/academy") else { return }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func loadPDF() {
        guard let url = Bundle.main.url(forResource: "PDF_file", withExtension: "pdf") else {
            return
        }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func loadTelegramChat() {
        guard let url = URL(string: "https://t.me/+EPaN4yCIExdhZDli") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func loadsOfWebView() {
        switch actionToPerform {
        case .loadURL:
            loadURL()
        case .loadPDF:
            loadPDF()
            toolbar.isHidden = true
            HTTP_label.isHidden = true
            webViewBottomToToolbarConstraint.isActive = false
            webViewBottomToSafeAreaConstraint.isActive = true
        case .loadTelegramChat:
            loadTelegramChat()
        case .none:
            print("Error. Link is not found")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    @IBAction func forwardButtonTapped(_ sender: UIBarButtonItem) {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "canGoBack" || keyPath == "canGoForward" {
            updateNavigationButtons()
        }
        if keyPath == "URL" {
            if let url = webView.url {
                HTTP_label.text = url.absoluteString
            }
        }
    }
       // Метод обновления состояния кнопок
       func updateNavigationButtons() {
           backBtn.isEnabled = webView.canGoBack
           forwardBtn.isEnabled = webView.canGoForward
           
           if let url = webView.url {
               HTTP_label.text = url.absoluteString
           }
       }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            if let url = webView.url {
                HTTP_label.text = url.absoluteString
            }
        }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let url = webView.url {
            HTTP_label.text = url.absoluteString
        }
        updateNavigationButtons()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
           if let url = webView.url {
               HTTP_label.text = url.absoluteString
           }
       }
    
}

