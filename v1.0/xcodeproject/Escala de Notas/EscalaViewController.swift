//
//  EscalaViewController.swift
//  Escala de Notas
//
//  Created by Javier López Achondo on 02-03-16.
//  Copyright © 2016 Javier López Achondo. All rights reserved.
//

import Foundation
import UIKit

class EscalaViewController : ViewController {
    
    @IBOutlet var EscalaTextView: UITextView!
    
    @IBOutlet var PuntajeLabel: UILabel!
    
    @IBOutlet var NotaLabel: UILabel!
    
    var EscalaGenerada = String()
    var Mostrar = String()
    
    override func viewDidLoad() {
        
        if Mostrar == "YES" {
            PuntajeLabel.hidden = false
            NotaLabel.hidden = false
        }
        
        EscalaTextView.text = EscalaGenerada
        
    }
}