//
//  ViewController.swift
//  Change Color of the View
//
//  Created by Johnny Boshechka on 12/11/21.
//

import UIKit

class SecondViewController: UIViewController {
    
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
    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!
    
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    var delegate: SecondViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        
        viewColorChange()
        setValue(for: valueRedLabel, valueGreenLabel, valueBlueLabel)
        
        setupSlider(slider: redColorSlider, color: .red)
        setupSlider(slider: greenColorSlider, color: .green)
        setupSlider(slider: blueColorSlider, color: .blue)
    }
    
    @IBAction func donePressedButton(_ sender: UIButton) {
        viewColorChange()
        delegate.setBackgroundCololor(for: UIColor(red: CGFloat(redColorSlider.value),
                                                   green: CGFloat(greenColorSlider.value),
                                                   blue: CGFloat(blueColorSlider.value),
                                                   alpha: 1))
        view.endEditing(true)
        dismiss(animated: true)

    }
    
    @IBAction func rgbChangeSlider(_ sender: UISlider) {
        viewColorChange()
        switch sender {
        case redColorSlider:
            setValue(for: valueRedLabel)
            setValue(for: redColorTextField)
        case greenColorSlider:
            setValue(for: valueGreenLabel)
            setValue(for: greenColorTextField)

        default:
            setValue(for: valueBlueLabel)
            setValue(for: blueColorTextField)

        }
    }
}

extension SecondViewController {
    
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
        private func setValue(for textFields: UITextField...) {
            textFields.forEach { textField in
                switch textField {
                case redColorTextField:
                    textField.text = string(from: redColorSlider)
                case greenColorTextField:
                    textField.text = string(from: greenColorSlider)
                default:
                    textField.text = string(from: blueColorSlider)

            }
        }
    }

    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SecondViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let newValue = textField.text else { return }
        guard let floatValue = Float(newValue) else { return }
        
        if textField == redColorTextField {
            redColorSlider.value = floatValue
            setValue(for: valueRedLabel)
        } else if textField == greenColorTextField {
            greenColorSlider.value = floatValue
            setValue(for: valueGreenLabel)
        } else {
            blueColorSlider.value = floatValue
            setValue(for: valueBlueLabel)
        }
    }
}
