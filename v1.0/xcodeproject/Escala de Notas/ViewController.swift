//
//  ViewController.swift
//  Escala de Notas
//
//  Created by Javier López Achondo on 02-03-16.
//  Copyright © 2016 Javier López Achondo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var PremaText: UITextField!

    @IBOutlet weak var NotaAprobacionText: UITextField!
    
    @IBOutlet weak var NotaMinimaText: UITextField!
    
    @IBOutlet weak var NotaMaximaText: UITextField!

    @IBOutlet weak var PuntajeMinimoText: UITextField!
    
    @IBOutlet weak var PuntajeMaximoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController!.navigationBar.barTintColor = UIColor.redColor()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController : EscalaViewController = segue.destinationViewController as! EscalaViewController
        
        var MostrarTitulos = "NO"
        
        var TextoGenerado = String()
        
        // Cambio de comas por puntos
        let premaC = PremaText.text!.stringByReplacingOccurrencesOfString(",", withString: ".")
        let notaaprobacionC = NotaAprobacionText.text!.stringByReplacingOccurrencesOfString(",", withString: ".")
        let notaminimaC = NotaMinimaText.text!.stringByReplacingOccurrencesOfString(",", withString: ".")
        let notamaximaC = NotaMaximaText.text!.stringByReplacingOccurrencesOfString(",", withString: ".")
        let puntajeminimoC = PuntajeMinimoText.text!.stringByReplacingOccurrencesOfString(",", withString: ".")
        let puntajemaximoC = PuntajeMaximoText.text!.stringByReplacingOccurrencesOfString(",", withString: ".")
        
        // Conteo de puntos de cada field
        let pPREMA = premaC.componentsSeparatedByString(".").count - 1
        let pNOTA_APROBACION = notaaprobacionC.componentsSeparatedByString(".").count - 1
        let pNOTA_MINIMA = notaminimaC.componentsSeparatedByString(".").count - 1
        let pNOTA_MAXIMA = notamaximaC.componentsSeparatedByString(".").count - 1
        let pPUNTAJE_MINIMO = puntajeminimoC.componentsSeparatedByString(".").count - 1
        let pPUNTAJE_MAXIMO = puntajemaximoC.componentsSeparatedByString(".").count - 1
        
        // Verificación puntos
        if pPREMA > 1 || pNOTA_APROBACION > 1 || pNOTA_MINIMA > 1 || pNOTA_MAXIMA > 1 || pPUNTAJE_MINIMO > 1 || pPUNTAJE_MAXIMO > 1 {
            
            // Alerta de puntos extra
            TextoGenerado = "Uno de los valores ingresados tiene error de puntuación, por favor vuelva atrás para corregirlo e intente otra vez."
            
        }
            
        // Verificacion fields vacíos
        else if PremaText.text! == "" || NotaAprobacionText.text! == "" || NotaMinimaText.text! == "" || NotaMaximaText.text! == "" || PuntajeMinimoText.text! == "" || PuntajeMaximoText.text! == "" {
            
            // Alerta field vacío
            TextoGenerado = "Uno de los campos está vacío, por favor vuelva atrás para llenarlo e intente otra vez."
        }
            
        // Verificacion valores ingresados
        else if Double(premaC) > 100 || Double(notaminimaC) > Double(notamaximaC) || Double(notamaximaC) < Double(notaaprobacionC) || Double(notaminimaC) > Double(notaaprobacionC) || Double(puntajeminimoC) > Double(puntajemaximoC) {
            
            // Alerta valores incorrectos
            TextoGenerado = "Revise los valores ingresados, se presentan inconsistencias. Vuelva atrás e intente otra vez."
        }
        
        // Formato de los valores ingresados es correcto
        else {
            let PREMA = Double(premaC)
            let NOTA_APROBACION = Double(notaaprobacionC)
            let NOTA_MINIMA = Double(notaminimaC)
            let NOTA_MAXIMA = Double(notamaximaC)
            let PUNTAJE_MINIMO = Double(puntajeminimoC)
            let PUNTAJE_MAXIMO = Double(puntajemaximoC)
            
            let PUNTAJE_APROBACION : Double = (PREMA! * PUNTAJE_MAXIMO!) / 100
            
            // Se genera la escala
            var NOTA_ALUMNO = Double()
            
            for PUNTAJE_ALUMNO in Int(PUNTAJE_MINIMO!)...Int(PUNTAJE_MAXIMO!) {
                if Double(PUNTAJE_ALUMNO) <= PUNTAJE_APROBACION {
                    let a = NOTA_APROBACION! - NOTA_MINIMA!
                    let b = PUNTAJE_APROBACION - PUNTAJE_MINIMO!
                    let c = Double(PUNTAJE_ALUMNO) - PUNTAJE_MINIMO!
                    
                    NOTA_ALUMNO = ((a / b) * c) + NOTA_MINIMA!
                }
                else if Double(PUNTAJE_ALUMNO) > PUNTAJE_APROBACION {
                    let a = NOTA_MAXIMA! - NOTA_APROBACION!
                    let b = PUNTAJE_MAXIMO! - PUNTAJE_APROBACION
                    let c = Double(PUNTAJE_ALUMNO) - PUNTAJE_APROBACION
                    
                    NOTA_ALUMNO = ((a / b) * c) + NOTA_APROBACION!
                }
            
                NOTA_ALUMNO = round(10*NOTA_ALUMNO)/10
                
                TextoGenerado += "\(PUNTAJE_ALUMNO)                       \(NOTA_ALUMNO)\n"
            }
            MostrarTitulos = "YES"
        }
        
        DestViewController.EscalaGenerada = TextoGenerado
        DestViewController.Mostrar = MostrarTitulos
    }



}

