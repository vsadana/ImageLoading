//
//  DataViewModel.swift
//  InterviewTask
//
//  Created by Vaibhav Sadana on 11/07/23.
//

import Foundation
import UIKit

class DataViewModel {

    //variables
    var dataObjObservable : Observable<DataModel> =  Observable(DataModel())
    var imageObjObservable : Observable<UIImage?> =  Observable(UIImage())

    //MARK: call api
    func callAPI(repoObj: DataRepo?, urlStr:String) {
        repoObj?.callAPI(urlStr: urlStr,completion: { modelObj in
            self.dataObjObservable.value = modelObj
        })
    }
    
    //MARK: install image
    func installImage(repoObj: DataRepo?,url:String) {
        repoObj?.loadImage(urlStr: url, completion: { image in
            self.imageObjObservable.value = image
        })
    }
}
