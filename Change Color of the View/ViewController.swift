//
//  ViewController.swift
//  Change Color of the View
//
//  Created by Johnny Boshechka on 12/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView! {
        didSet{
            colorView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var valueRedLabel: UILabel! {
        didSet{
            valueRedLabel.textColor = .white
        }
    }
    @IBOutlet weak var valueGreenLabel: UILabel! {
        didSet {
            valueGreenLabel.textColor = .white
        }
    }
    @IBOutlet weak var valueBlueLabel: UILabel! {
        didSet {
            valueBlueLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        
        viewColorChange()
        setValue(for: valueRedLabel, valueGreenLabel, valueBlueLabel)
        
        setupSlider(slider: redColorSlider, color: .red)
        setupSlider(slider: greenColorSlider, color: .green)
        setupSlider(slider: blueColorSlider, color: .blue)
    }
    
    @IBAction func rgbChangeSlider(_ sender: UISlider) {
        viewColorChange()
        switch sender {
        case redColorSlider:
            setValue(for: valueRedLabel)
        case greenColorSlider:
            setValue(for: valueGreenLabel)
        default:
            setValue(for: valueBlueLabel)
        }
    }
}

extension ViewController {
    
    private func viewColorChange() {
        colorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value),
                                            blue: CGFloat(blueColorSlider.value),
                                            alpha: 1)
    }
    
    private func setupSlider (slider: UISlider, color: UIColor) {
        slider.tintColor = color
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case valueRedLabel:
                label.text = string(from: redColorSlider)
            case valueGreenLabel:
                label.text = string(from: greenColorSlider)
            default:
                label.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
