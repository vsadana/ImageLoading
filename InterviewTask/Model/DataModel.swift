//
//  DataModel.swift
//  InterviewTask
//
//  Created by Vaibhav Sadana on 11/07/23.
//

import Foundation

struct DataModel : Decodable {
    let resultCount : Int?
    let results : [DataResult]?
    
    init(){
        resultCount = nil
        results = nil
    }
}

struct DataResult : Decodable {
    let artworkUrl100,description,collectionName,primaryGenreName,collectionCensoredName : String?
}
