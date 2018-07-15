//
//  SummaryProvider.swift
//  DHBW Seminar App
//
//  Created by Daniel Sogl on 15.07.18.
//  Copyright © 2018 Daniel Sogl. All rights reserved.
//

import Foundation
import Reductio

class SummaryProvider {
    
    func getSummary(forText text: String) -> String {
        
        var summary = ""
        
        if text.count > 0 {
            summarize(text: text, compression: 0.80) { phrases in
                if phrases.count > 0 {
                    summary = phrases[0]
                } else {
                    summary = "Review is to short"
                }
            }
        } else {
            summary = "Review is to short"
        }
        
        return summary
    }
    
}
