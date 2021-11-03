//
//  ViewController.swift
//  centro_notificaciones
//
//  Created by Hansel on 02/11/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let selector_fecha = UIDatePicker()
    
    @IBOutlet weak var textNombre: UITextField!
    @IBOutlet weak var textApellido: UITextField!
    @IBOutlet weak var textEdad: UITextField!
    @IBOutlet weak var textDireccion: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurar_text()
    }
    
    func configurar_text() {
        configurar_data_picker()
        
        textNombre.delegate = self
        textApellido.delegate = self
        textEdad.delegate = self
        textDireccion.delegate = self
        
        // Gesto para cerrar el teclado en pantalla
        let gesto_tap = UITapGestureRecognizer(target: self, action: #selector(ocultar_teclado(_:)))
        
        self.view.addGestureRecognizer(gesto_tap)
        
        // Centro de notificaciones (Detectamos evento de teclado)
        NotificationCenter.default.addObserver(self, selector: #selector(cambio_teclado(notificacion:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cambio_teclado(notificacion:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cambio_teclado(notificacion:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func ocultar_teclado(_ sender: UITapGestureRecognizer) {
        textNombre.resignFirstResponder()
        textApellido.resignFirstResponder()
        textEdad.resignFirstResponder()
        textDireccion.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object:  nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object:  nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object:  nil)
    }
    
    @objc func cambio_teclado(notificacion: Notification) {
        let info_teclado = notificacion.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
        let dimenciones_teclado = info_teclado?.cgRectValue
        let altura_teclado = dimenciones_teclado?.height
        
        let nombre_notificacion = notificacion.name.rawValue
        
        switch nombre_notificacion {
        case "UIkeyboardWillHideNotification": view.frame.origin.y = 0
        case "UIKeyboardWillShowNotification":
            if textDireccion.isFirstResponder {
                view.frame.origin.y = (-1 * altura_teclado!) * 0.8
            }
            if textEdad.isFirstResponder {
                view.frame.origin.y = (-1 * altura_teclado!) * 0.7
            }
            if textApellido.isFirstResponder {
                view.frame.origin.y = (-1 * altura_teclado!) * 0.6
            }
            if textNombre.isFirstResponder {
                view.frame.origin.y = (-1 * altura_teclado!) * 0.5
            }
        default: view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textNombre:
            textApellido.becomeFirstResponder()
        case textApellido:
            textEdad.becomeFirstResponder()
        case textEdad:
            textDireccion.becomeFirstResponder()
        default:
            textField.becomeFirstResponder()
        }
        return true
    }
    
    func configurar_data_picker() {
        if #available(iOS 13.4, *) {
            selector_fecha.preferredDatePickerStyle = .wheels
        }
        
        selector_fecha.locale = Locale(identifier: "es_MX")
        
        // Subvista para el picker
        let barra_herramientas = UIToolbar()
        barra_herramientas.sizeToFit()
        
        let boton_listo = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(fecha_elegida))
        
        barra_herramientas.setItems([boton_listo], animated: true)
        
        textEdad.inputAccessoryView = barra_herramientas
        textEdad.inputView = selector_fecha
        selector_fecha.datePickerMode = .date
    }
    
    @objc func fecha_elegida() {
        let fecha = selector_fecha.date
        textEdad.text = "\(obtener_valor_fecha(fecha: fecha, stilo: "fecha_usuario"))"
        self.view.endEditing(true)
    }

    @IBAction func btnEnviarPress(_ sender: Any) {
        
    }
    
}

