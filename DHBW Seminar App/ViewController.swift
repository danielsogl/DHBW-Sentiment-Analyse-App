//
//  ViewController.swift
//  DHBW Seminar App
//
//  Created by Daniel Sogl on 15.07.18.
//  Copyright © 2018 Daniel Sogl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var summarizedReviewLabel: UILabel!
    
    // MARK: Variables
    let sentimentProvider = SentimentProvider()
    let summaryProvider = SummaryProvider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reviewText.delegate = self
        initView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func initView() -> Void {
        reviewText.text = ""
        sentimentLabel.text = "😐"
        summarizedReviewLabel.text = ""
    }
    
    // MARK: Actions

    @IBAction func pasteReview() {
        if let clipboard = UIPasteboard.general.string {
            reviewText.text = clipboard
            
            runSentiment()
            runSummary()
        }
    }
    
    /// If user types something into the testfield this function will be called
    ///
    /// - Parameter textView: UITextView
    func textViewDidChange(_ textView: UITextView) {
        runSentiment()
        runSummary()
    }
    
    // MARK: Functions
    
    func runSentiment() -> Void {
        do {
            // Set emoji
            let sentiment = try sentimentProvider.getSentiment(forText: reviewText.text)
            sentimentLabel.text = sentimentProvider.getSentimentEmoji(forSentiment: sentiment)
            
            // Set background image
            let backgroundImage = sentimentProvider.getBackgroundImage(forSentiment: sentiment)
            animateBackground(newImage: backgroundImage)
        } catch let error {
            print(error)
        }
    }
    
    func runSummary() -> Void {
        let summary = summaryProvider.getSummary(forText: reviewText.text)
        summarizedReviewLabel.text = summary
    }
    
    /// Animates background image changes
    ///
    /// - Parameter newImage: New image
    func animateBackground(newImage image: UIImage) -> Void {
        UIView.transition(with: backgroundImage, duration:0.9, options: .transitionCrossDissolve,
                          animations: { self.backgroundImage.image = image },
                          completion: nil)
    }
    
}

