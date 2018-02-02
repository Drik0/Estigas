//
//  ViewController.swift
//  Estigas
//
//  Created by Gerson Costa on 01/02/2018.
//  Copyright © 2018 Gerson Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelEstiga: UILabel!
    
    let url = URL(string: "https://api.andecoder.io/estigas/index.php")!
    
    var estigaId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEstiga()
    }
    
    func getEstiga() {
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var estiga = ""
            
            if let error = error {
                print(error)
            } else {
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = "id\":\"\(self.estigaId)\",\"estiga\":"
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        if contentArray.count > 0 {
                            stringSeparator = "},{"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentArray.count > 0 {
                                estiga = newContentArray[0]
                            }
                        }
                    }
                }
            }
            if estiga == "" {
                estiga = "Oh não 😱"
            }
            DispatchQueue.main.sync {
                self.labelEstiga.text = estiga
            }
        }
        task.resume()
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if estigaId < 176 {
            estigaId += 1
            getEstiga()
        }
    }
    
    @IBAction func previousBtnPressed(_ sender: UIButton) {
        if estigaId > 1 {
            estigaId -= 1
            getEstiga()
        }
    }
}

