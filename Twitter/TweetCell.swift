//
//  TweetCell.swift
//  Twitter
//
//  Created by Joey Singer on 2/23/17.
//  Copyright © 2017 Joey Singer. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetButtonOutlet: UIButton!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    var retweeted = false
    var favorited = false
    var tweetID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(tweet: Tweet) {
        tweetID = tweet.id!
        
        tweetLabel.text = tweet.text!
        nameLabel.text = tweet.name!
        screenNameLabel.text = "@\(tweet.screenName!)"
        profileImageView.setImageWith(tweet.profileImageUrl!)
        timeStampLabel.text = calculateTimeStamp(timeTweetPostedAgo: (tweet.timestamp?.timeIntervalSinceNow)!)
        retweetCountLabel.text = "\(tweet.retweetCount)"
        favoriteCountLabel.text = "\(tweet.favoritesCount)"
    }
    
    // All credit for this method goes to David Wayman, slack @dwayman
    func calculateTimeStamp(timeTweetPostedAgo: TimeInterval) -> String {
        // Turn timeTweetPostedAgo into seconds, minutes, hours, days, or years
        var rawTime = Int(timeTweetPostedAgo)
        var timeAgo: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
        // Figure out time ago
        if (rawTime <= 60) { // SECONDS
            timeAgo = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) { // MINUTES
            timeAgo = rawTime/60
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) { // HOURS
            timeAgo = rawTime/60/60
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) { // DAYS
            timeAgo = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) { // YEARS
            timeAgo = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(timeAgo)\(timeChar)"
    }
    
    @IBAction func retweetButton(_ sender: Any) {
        
        if retweeted == false {
            retweetButtonOutlet.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            retweetCountLabel.text = "\(Int(retweetCountLabel.text!)! + 1)"
            retweeted = true
        } else {
            retweetButtonOutlet.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            retweetCountLabel.text = "\(Int(retweetCountLabel.text!)! - 1)"
            retweeted = false
        }
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        if favorited == false {
            favoriteButtonOutlet.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! + 1)"
            favorited = true
        } else {
            favoriteButtonOutlet.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
            favoriteCountLabel.text = "\(Int(favoriteCountLabel.text!)! - 1)"
            favorited = false
        }
    }
}
