//
//  EpisodesTableViewController.swift
//  MyPodcast
//
//  Created by Eric Rosas on 12/20/16.
//  Copyright © 2016 EmpireAppDesignz. All rights reserved.
//

import UIKit
import SafariServices

class EpisodesTableViewController: UITableViewController
{
    var episodes = [Episode]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        episodes = Episode.downloadAllEpisodes()
        self.tableView.reloadData()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Episode Cell", for: indexPath) as! EpisodeTableViewCell
        let episode = episodes[indexPath.row]
        
        cell.episode = episode
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let episode = episodes[indexPath.row]
        let safariVC = SFSafariViewController(url: episode.url!)
        
        self.present(safariVC, animated: true, completion: nil)
    }
    
    // MARK: - Target / Action
    
    @IBAction func fullBlogDidTap(sender: AnyObject)
    {
        let url = URL(string: "http://www.secretentourage.com/page/1/")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        
        }
    }
    
}
