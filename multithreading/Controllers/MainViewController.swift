//
//  MainViewController.swift
//  multithreading
//
//  Created by Damir Rakhmatullin on 21.11.24.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var mainView: MainView = MainView(frame: .zero)
    var dataManager = DataManager()
    var imageProcessor: ImageProcessor?
    var collectionViewDataSource = MainVIewCollectionDataSource()
   
    override func loadView() {
        let imageProcessor = ImageProcessor(images: collectionViewDataSource.dataSource)
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainViewController = self
        mainView.configureDataSource(dataSource: collectionViewDataSource)
        
//
//        let originalImage = UIImage(named: "kitten")!
//        let filteredImage = dataManager.applyFilter(image: originalImage, filterName: "CIPhotoEffectChrome")
//        collectionViewDataSource.dataSource.append(originalImage)
//        collectionViewDataSource.dataSource.append(filteredImage)
//        mainView.configureDataSource(dataSource: collectionViewDataSource)

        
        
        // Do any additional setup after loading the view.
    }
    
    func startEval() {
        print("starting!!!")
    }
    
    func stopEval() {
        print("stop it!!")
    }
    
    func handleSegmentedControlSelection(selectedIndex: Int) {
        
        switch selectedIndex {
        case 0:
            imageProcessor?.processImages(parallelMode: false)
            print("not paralel")
            self.mainView.collectionView.reloadData()
        case 1:
            imageProcessor?.processImages(parallelMode: true)
            print("multithreading")
            self.mainView.collectionView.reloadData()
        default :
            break
        }
    }
    
    func updateCollectionView(updatedImages: [UIImage]) {
        DispatchQueue.main.async {
            self.collectionViewDataSource.dataSource += updatedImages
            self.mainView.collectionView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
