//
//  CollectionViewCell.swift
//  InterviewTask
//
//  Created by Vaibhav Sadana on 11/07/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //outlets
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data: DataResult) {
        lblDescription.text = data.description
        lblTitle.text = data.primaryGenreName
        
        let vmObj = DataViewModel()
        vmObj.imageObjObservable.observe(on: self) { image in
            DispatchQueue.main.async {
                self.imgHeader.image = image
            }
        }
        vmObj.installImage(repoObj: DataRepo(), url: data.artworkUrl100 ?? "")
    }
}
