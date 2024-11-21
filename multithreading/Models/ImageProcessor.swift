//
//  ImageProcessor.swift
//  multithreading
//
//  Created by Damir Rakhmatullin on 21.11.24.
//
import Foundation
import UIKit

class ImageProcessor {
    private let localImages: [UIImage]
    private var processedImages = [UIImage]()
    weak var mainViewController: MainViewController?
    
    
    init(images: [UIImage]) {
        self.localImages = images
    }

    
    func processImages(parallelMode: Bool) {
        if parallelMode {
            DispatchQueue.concurrentPerform(iterations: localImages.count) { index in
                self.processImage(at: index)
            }
        } else {
            let operationQueue = OperationQueue()
            operationQueue.maxConcurrentOperationCount = 1
            
            let completionOperation = BlockOperation { [weak self] in
                DispatchQueue.main.async {
                    guard let processedImages = self?.processedImages else { return }
                    self?.mainViewController?.updateCollectionView(updatedImages: processedImages)
                }
            }
            
            for (index, _) in localImages.enumerated() {
                let operation = BlockOperation(block: { [weak self] in
                    self?.processImage(at: index)
                })
                operationQueue.addOperation(operation)
                
                operation.completionBlock = {
                    completionOperation.cancel()
                }
            }
            
            operationQueue.addOperation(completionOperation)
        }
        
        DispatchQueue.main.async {
            self.mainViewController?.updateCollectionView(updatedImages: self.processedImages)
        }
    }
    
    private func processImage(at index: Int) {
        let image = localImages[index]
        
        let filterName = getRandomFilterName()
        print(filterName)
        guard let filteredImage = applyFilter(image: image, filterName: filterName) else { return }
        
        processedImages.append(filteredImage)
        print(">>>", localImages.count, ">>>", processedImages.count, ">>>" , processedImages.count + localImages.count)
    }
    
    private func getRandomFilterName() -> String {
        return "CIPhotoEffect" + Array(arrayLiteral: "Chrome", "Mono", "Noir", "Process", "Transfer", "Unsharp").shuffled()[0]
    }
    
    private func applyFilter(image: UIImage, filterName: String) -> UIImage? {
        let filter = CIFilter(name: filterName)
        guard let ciInput = CIImage(image: image) else { return nil }
        filter?.setValue(ciInput, forKey: kCIInputImageKey)
        
        guard let outputImage = filter?.outputImage else { return nil }
        guard let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }

}
