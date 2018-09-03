//
//  MainViewController.swift
//  TDOuroboros
//
//  Created by michaeldai1006 on 09/03/2018.
//  Copyright (c) 2018 michaeldai1006. All rights reserved.
//

import UIKit
import TDOuroboros

class MainViewController: UIViewController {
    
    private var longPressGesture: UILongPressGestureRecognizer!
    private var numOfShapes: Int?
    private let shapes = [#imageLiteral(resourceName: "Star_Icon"): #imageLiteral(resourceName: "Star"), #imageLiteral(resourceName: "Oval_Icon"): #imageLiteral(resourceName: "Oval"), #imageLiteral(resourceName: "Polygon_Icon"): #imageLiteral(resourceName: "Polygon"), #imageLiteral(resourceName: "Triangle_Icon"): #imageLiteral(resourceName: "Triangle")]
    private var shapeIcons = [#imageLiteral(resourceName: "Star_Icon"), #imageLiteral(resourceName: "Oval_Icon"), #imageLiteral(resourceName: "Polygon_Icon"), #imageLiteral(resourceName: "Triangle_Icon")] { didSet{ performShapeAnimation() } }
    
    @IBOutlet weak var shapeImageView: UIImageView!
    @IBOutlet weak var shapeCollectionView: UICollectionView! { didSet { collectionViewSetup() } }
    
    override func viewDidLoad() { numOfShapes = shapeIcons.count }
    
    private func collectionViewSetup() {
        shapeCollectionView.delegate = self
        shapeCollectionView.dataSource = self
        
        // longPressGesture for drag and drop cell
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        shapeCollectionView.addGestureRecognizer(longPressGesture)
        
        // Collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: shapeCollectionView.frame.height,
                                 height: shapeCollectionView.frame.height)
        shapeCollectionView.collectionViewLayout = layout
    }
    
    private func performShapeAnimation() {
        if (shapeIcons.count == numOfShapes) {
            for i in 0..<numOfShapes! {
                TDTaskQueueManager.shared.enqueue { [weak self] in
                    self?.shapeImageView.image = self?.shapes[(self?.shapeIcons[i])!]
                    Animator.performJumpAnimation(forView: (self?.shapeImageView)!,
                                                  withDistance: 35.0,
                                                  withDuration: 1.0,
                                                  withDamping: 0.5,
                                                  withInitVelocity: 0.5,
                                                  withScale: 1.5,
                                                  complete: { TDTaskQueueManager.shared.taskCompleted() })
                }
            }
        }
    }
}

// MARK: shapeCollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Delegate DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapeIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shapeCollectionView.dequeueReusableCell(withReuseIdentifier: ShapeCollectionViewCell.id, for: indexPath) as! ShapeCollectionViewCell
        cell.shapeImageView?.image = shapeIcons[indexPath.row]
        return cell
    }
    
    // Drag and Drop
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        shapeIcons.insert(shapeIcons.remove(at: sourceIndexPath.item), at: destinationIndexPath.item)
    }
    
    @objc private func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = shapeCollectionView.indexPathForItem(at: gesture.location(in: shapeCollectionView)) else { break }
            shapeCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            shapeCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            shapeCollectionView.endInteractiveMovement()
        default:
            shapeCollectionView.cancelInteractiveMovement()
        }
    }
}
