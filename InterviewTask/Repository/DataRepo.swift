//
//  DataRepo.swift
//  InterviewTask
//
//  Created by Vaibhav Sadana on 11/07/23.
//

import Foundation
import UIKit
class DataRepo {
    
    //MARK: call api
    func callAPI(urlStr:String, completion: @escaping(DataModel)->Void) {
        if let url = URL(string: urlStr) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            let session = URLSession.shared.dataTask(with: urlRequest) { data, res, err in
                do {
                    let dataModelObj = try JSONDecoder().decode(DataModel.self, from: data ?? Data())
                    completion(dataModelObj)
                }
                catch (let err) {
                    print(err)
                }
            }
            session.resume()
        }
    }
    
    //MARK: load image
    func loadImage(urlStr:String,completion : @escaping(UIImage?)->Void) {
        let session = URLSession(configuration: .default)
        if let url = URL(string: urlStr) {
            // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                // The download has finished.
                if let e = error {
                    print("Error downloading cat picture: \(e)")
                } else {
                    // No errors found.
                    // It would be weird if we didn't have a response, so check for that too.
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            // Finally convert that Data into an image and do what you wish with it.
                            completion( UIImage(data: imageData))
                            // Do something with your image.
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
            }
            downloadPicTask.resume()
        }
    }
    
}
