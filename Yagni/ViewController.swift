//
//  ViewController.swift
//  Yagni
//
//  Created by Daval Cato on 10/29/17.
//  Copyright © 2017 Daval Cato. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    private let largeCellId = "largeCellId"
    
    var appCategories: [AppCategory]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCategory.fetchFeaturedApps { (appCategories) -> () in
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        
        
        self.collectionView?.backgroundColor = UIColor.white
        
        self.collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        self.self.collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: "largeCellId")
            
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if indexPath.item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
                cell.appCategory = appCategories?[indexPath.item]
                
                return cell
                
            }
        
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!
        CategoryCell
        
         cell.appCategory = appCategories?[indexPath.item]
        
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
            
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160.0)
        }
        
        return CGSize(width: view.frame.width, height: 230)
       }

   }
    
    class LargeCategoryCell: CategoryCell {
        
    }
    
}

























