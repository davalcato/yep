//
//  Models.swift
//  Yagni
//
//  Created by Daval Cato on 11/3/17.
//  Copyright © 2017 Daval Cato. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(completionHandler: @escaping ([AppCategory]) -> ()) {
        
          let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
//          let urlString = "https://www.statsallday.com/appstore/featured"
        
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? error as Any)
                return
            }
            
            do {
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String: AnyObject]
                
                var appCategories = [AppCategory]()
                
                for dict in json ["categories"] as! [[String: AnyObject]] {
                    let appCategory = AppCategory()
                    appCategory.setValuesForKeys(dict)
                    appCategories.append(appCategory)
                    
                }
                
                print(appCategories)
                
                DispatchQueue.main.async { ()
                    completionHandler(appCategories)
                    
                }
              print(appCategories)
                
            } catch let err {
                print(err)
            }
            
        }.resume()
        
    }
    
    static func sampleAppCategories() -> [AppCategory] {
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Fall New Look"
        
        var apps = [App]()
        
        // Logic
        let frozenApp = App()
        frozenApp.name = "Accessories you NEED"
        frozenApp.imageName = "frozen"
        frozenApp.category = "ACCESSORIES"
        frozenApp.price = NSNumber(value: 48.99)
        apps.append(frozenApp)
        
        bestNewAppsCategory.apps = apps
        
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Styles"
        
        var bestNewGamesApps = [App]()
        
        let telepaintApp = App()
        telepaintApp.name = "Shop Shai this fall"
        telepaintApp.category = "NOW TRENDING"
        telepaintApp.imageName = "telepaint"
        telepaintApp.price = NSNumber(value: 19.99)
        
        bestNewGamesApps.append(telepaintApp)
        
        bestNewGamesCategory.apps = bestNewGamesApps
        
        return [bestNewAppsCategory, bestNewGamesCategory]
        

    }
    
}
class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}






































