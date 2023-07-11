//
//  ViewController.swift
//  InterviewTask
//
//  Created by Vaibhav Sadana on 11/07/23.
//

import UIKit

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //variables
    var songData : DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callAPIToFetchData()
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.collectionViewLayout = layout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
 
    func layout () -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing  = 10
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }

    //MARK: call api to fetch the data
    func callAPIToFetchData(){
        let vm = DataViewModel()
        vm.dataObjObservable.observe(on: self) { modelObj in
            self.songData =  modelObj
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        vm.callAPI(repoObj: DataRepo(), urlStr: "https://itunes.apple.com/search?term=adele")
    }
}

//MARK: - extension for collection view
extension  ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songData?.resultCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        if let data = songData?.results {
            cell.configure(data: data[indexPath.row])
        }
        return cell
    }
}
