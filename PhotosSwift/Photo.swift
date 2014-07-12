//
//  Photo.swift
//  PhotosSwift
//
//  Created by Ricardo Reyes on 7/12/14.
//  Copyright (c) 2014 iOS Coding Lab. All rights reserved.
//

import UIKit
import Foundation

class Photo: NSObject
{
    var myUrl: NSURL
    
    init(url: NSURL)
    {
        self.myUrl = url
    }
    
    func download(url: NSURL) -> UIImage
    {
        let downloadedData = NSData(contentsOfURL: url)
        let image = UIImage(data: downloadedData)
        
        return image
    }
}