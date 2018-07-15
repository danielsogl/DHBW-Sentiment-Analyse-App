//
//  SentimentProvider.swift
//  DHBW Seminar App
//
//  Created by Daniel Sogl on 15.07.18.
//  Copyright © 2018 Daniel Sogl. All rights reserved.
//

import UIKit

enum SentimentError: Error {
    case noClassification
}

class SentimentProvider {
    
    let sentimentClassifier = SentimentClassifier()
    
    /// Returns sentiment based on an text
    ///
    /// - Parameter forText: String input
    func getSentiment(forText text: String) throws -> String {
        
        let sentiment = try? sentimentClassifier.prediction(text: text)
        
        if let sentiment = sentiment {
            return sentiment.label
        } else {
            throw SentimentError.noClassification
        }
    }
    
    /// Returns an emijicon based on the sentiment
    ///
    /// - Parameter sentiment: Sentiment ("POS", "NEU", "NEG")
    func getSentimentEmoji(forSentiment sentiment: String) -> String {
        if sentiment == "POS" {
            return "😀"
        } else if sentiment == "NEG" {
            return "☹️"
        } else {
            return "😐"
        }
    }
    
    /// Returns the background image based on the sentiment
    ///
    /// - Parameter sentiment: Sentiment ("POS", "NEU", "NEG")
    func getBackgroundImage(forSentiment sentiment: String) -> UIImage {
        if let image = UIImage(named: sentiment.lowercased()) {
            return image
        } else {
            return UIImage(named: "neu")!
        }
    }
    
}
