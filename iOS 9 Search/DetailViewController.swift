//
//  DetailViewController.swift
//  iOS 9 Search
//
//  Created by Davis Allie on 9/07/2015.
//  Copyright © 2015 Davis Allie. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    var detailItem: Show! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if self.nameLabel != nil && self.detailItem != nil {
            self.nameLabel.text = detailItem.name
            self.genreLabel.text = detailItem.genre
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .ShortStyle
            self.timeLabel.text = dateFormatter.stringFromDate(detailItem.time)
            
            let activity = NSUserActivity(activityType: "com.tutsplus.iOS-9-Search.displayShow")
            activity.userInfo = ["name": detailItem.name, "genre": detailItem.genre, "time": detailItem.time]
            activity.title = detailItem.name
            var keywords = detailItem.name.componentsSeparatedByString(" ")
            keywords.append(detailItem.genre)
            activity.keywords = Set(keywords)
            activity.eligibleForHandoff = false
            activity.eligibleForSearch = true
            //activity.eligibleForPublicIndexing = true
            //activity.expirationDate = NSDate()
            
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
            attributeSet.title = detailItem.name
            attributeSet.contentDescription = detailItem.genre + "\n" + dateFormatter.stringFromDate(detailItem.time)

            self.userActivity = activity
            self.userActivity?.becomeCurrent()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

