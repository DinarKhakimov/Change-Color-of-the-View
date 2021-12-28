//
//  ViewController.swift
//  Change Color of the View
//
//  Created by Johnny Boshechka on 12/11/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - IBOutletes
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var valueRedLabel: UILabel!
    @IBOutlet weak var valueGreenLabel: UILabel!
    @IBOutlet weak var valueBlueLabel: UILabel!
    
    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    // MARK: - Public Properties
    var delegate: SecondViewControllerDelegate!
    var firstVcViewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        colorView.layer.cornerRadius = 15
        
        setSliders()
        setValue(for: valueRedLabel, valueGreenLabel, valueBlueLabel)
        setValue(for: redColorTextField, greenColorTextField, blueColorTextField)
        
        redColorSlider.tintColor = .red
        greenColorSlider.tintColor = .green
    }
    
    // MARK: - IBActions
    @IBAction func donePressedButton(_ sender: UIButton) {
        delegate.setBackgroundCololor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func rgbChangeSlider(_ sender: UISlider) {
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
        viewColorChange()
    }
}

// MARK: - Private methods
extension SecondViewController {
    
    private func viewColorChange() {
        colorView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value),
                                            blue: CGFloat(blueColorSlider.value),
                                            alpha: 1)
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: firstVcViewColor)
        redColorSlider.value = Float(ciColor.red)
        greenColorSlider.value = Float(ciColor.green)
        blueColorSlider.value = Float(ciColor.blue)
        
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
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, messsage: String) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITExtFieldeDelegate
extension SecondViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let newValue = textField.text else { return }
        
        if let currentValue = Float(newValue) {
            switch textField {
            case redColorTextField:
                redColorSlider.setValue(currentValue, animated: true)
            case greenColorTextField:
                greenColorSlider.setValue(currentValue, animated: true)
            default:
                blueColorSlider.setValue(currentValue, animated: true)
            }
            viewColorChange()
            return
        }
        showAlert(title: "Error", messsage: "Please enter correct value")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.keyboardType = .asciiCapableNumberPad
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        keyboardToolBar.items = [flexBarButton, doneButton]
    }
}
