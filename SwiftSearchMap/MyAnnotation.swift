//
//  MyAnnotation.swift
//  SwiftSearchMap
//
//  Created by Evan Wineland on 5/1/15.
//  Copyright (c) 2015 Evan Wineland. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String!
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}
