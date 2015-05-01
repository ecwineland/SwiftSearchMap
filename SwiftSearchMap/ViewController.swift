//
//  ViewController.swift
//  SwiftSearchMap
//
//  Created by Evan Wineland on 5/1/15.
//  Copyright (c) 2015 Evan Wineland. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBAction func searchOnValueChanged(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        searchInMap()
    }
    
    let initialLocation = CLLocation(latitude: 40.4397, longitude: -79.9950)
    let searchRadius: CLLocationDistance = 3000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        searchInMap()
    }
    
    func searchInMap() {
        // 1
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex)
        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        // 3
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler {
            (response: MKLocalSearchResponse!, error: NSError!) in
            
            for item in response.mapItems as! [MKMapItem] {
                self.addPinToMapView(item.name, latitude: item.placemark.location.coordinate.latitude, longitude: item.placemark.location.coordinate.longitude)
            }
        }     
    }
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MyAnnotation(coordinate: location, title: title)
        
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

