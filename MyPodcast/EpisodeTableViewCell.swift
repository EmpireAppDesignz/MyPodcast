//
//  EpisodeTableViewCell.swift
//  MyPodcast
//
//  Created by Eric Rosas on 12/20/16.
//  Copyright © 2016 EmpireAppDesignz. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell
{
    var episode: Episode! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        titleLabel.text = episode.title
        //UIImage of "duc" is located in Assets.xcassets folder
        authorImageView.image = UIImage(named: "duc")
        descriptionLabel.text = episode.description
        createdAtLabel.text = "Pejman Ghadimi | \(episode.createdAt!)"
        
        if let thumbnailURL = episode.thumbnailURL {
            let networkService = NetworkService(url: thumbnailURL)
            networkService.downloadImage({ (imageData) in
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async(execute: {
                    self.thumbnailImageView.image = image
                })
            })
        }
    }
    
    // takes time to download stuff from the Internet
    //  | MAIN (UI)  | download  | upload  |share
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
}
