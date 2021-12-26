//
//  First View Controller.swift
//  Change Color of the View
//
//  Created by Johnny Boshechka on 12/27/21.
//

import Foundation
import UIKit

protocol SecondViewControllerDelegate {
    func setBackgroundCololor(for viewColor: UIColor)
}


class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination as? SecondViewController else { return }
        secondVC.delegate = self
    }
}


extension FirstViewController: SecondViewControllerDelegate {
    func setBackgroundCololor(for viewColor: UIColor) {
        view.backgroundColor = viewColor
    }
    
}
