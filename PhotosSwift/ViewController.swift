//
//  ViewController.swift
//  PhotosSwift
//
//  Created by Ricardo Reyes on 7/12/14.
//  Copyright (c) 2014 iOS Coding Lab. All rights reserved.
//

import UIKit
import Dispatch

class ViewController: UIViewController, UICollectionViewDataSource
{
    @IBOutlet var collectionView : UICollectionView
    
    var plist: NSArray = []
    var photos: NSMutableArray = []
    var downloadedPhotos: NSMutableArray = []
    
    let queue: dispatch_queue_t = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("URLs", ofType: "plist")
        plist = NSArray(contentsOfFile: path)
        
        for i in 0..plist.count
        {
            let url = NSURL(string: plist[i] as NSString)
            let photo = Photo(url: url)
            
            photos.addObject(photo)
            
            dispatch_async(queue,
                {
                    let image = photo.download(photo.myUrl)
                    self.downloadedPhotos.addObject(image)
                    
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            self.collectionView.reloadData()
                        })
                })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return downloadedPhotos.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        let photo = downloadedPhotos[indexPath.item] as UIImage
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as PhotoCollectionViewCell
        cell.imageView.image = photo
        return cell
    }

}

