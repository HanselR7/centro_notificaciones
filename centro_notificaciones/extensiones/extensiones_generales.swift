import Foundation
import UIKit

extension UIViewController
{
    func quitar_barra_navegacion(){
        self.navigationController?.navigationBar.isHidden = true
    }
    func agregar_barra_navegacion(){
        self.navigationController?.navigationBar.isHidden = false
    }
    func Alerta_Mensaje(title: String, Mensaje: String)
    {
        let Mensaje_alerta = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        
        let BotonAlertaOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        Mensaje_alerta.addAction(BotonAlertaOk)
        
        self.present(Mensaje_alerta, animated: true, completion:nil)
    }
    
    func obtener_valor_fecha(fecha: Date, stilo: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        switch stilo {
        case "fecha_usuario":
            formatter.dateFormat = "dd/MMMM/yyyy"
        case "fecha_base_datos":
            formatter.dateFormat = "yyyy/MM/dd"
        case "dia": formatter.dateFormat = "dd"
        case "mes": formatter.dateFormat = "MM"
        case "year": formatter.dateFormat = "yyyy"
        case "hora_completa_usuario": formatter.dateFormat = "hh:mm a"
        case "hora_completa_base_datos": formatter.dateFormat = "HH:mm:ss"
        case "am_pm": formatter.dateFormat = "a"
        case "hora": formatter.dateFormat = "hh"
        case "minutos": formatter.dateFormat = "mm"
        default:
            formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        }
        
        return formatter.string(from: fecha)
    }
    
}
