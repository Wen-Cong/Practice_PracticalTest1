//
//  RecipeController.swift
//  PracticalTest
//
//  Created by Yeo Wen Cong on 10/12/20.
//

import CoreData
import UIKit

class RecipeController{
    
    func AddRecipe(newRecipe:Recipe, newIngredientList:[Ingredient]) {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Add recipe into core data
        let recipeEntity = NSEntityDescription.entity(forEntityName: "CDRecipe", in: context)!
        let recipe = NSManagedObject(entity: recipeEntity, insertInto: context)
        
        recipe.setValue(newRecipe.name, forKey: "name")
        recipe.setValue(newRecipe.preparationTime, forKey: "preparationTime")
        
        
        //Add ingredients into core data
        let ingredientEntity = NSEntityDescription.entity(forEntityName: "CDIngredient", in: context)!
        var ingredientNSList:[NSManagedObject] = []
        
        for i in newIngredientList{
            let ingredient = NSManagedObject(entity: ingredientEntity, insertInto: context)
            
            ingredient.setValue(i.name, forKey: "name")
            //ingredient.setValue(NSMutableSet(object: recipe), forKey: "recipes")
            
            ingredientNSList.append(ingredient)
        }
        
        let ingredientSet:NSMutableSet = NSMutableSet(array: ingredientNSList)

        recipe.setValue(ingredientSet, forKey: "ingredients")
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Unable to save recipe. \(error). \(error.userInfo)")
        }
    }
    
    func RetriveAllRecipes() -> [Recipe]{
        
        var recipeNSList:[NSManagedObject] = []
        var recipes:[Recipe] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRecipe")
        
        do{
            recipeNSList = try context.fetch(fetchRequest)
            
            for i in recipeNSList{
                let title = i.value(forKey: "name") as! String
                let time = i.value(forKey: "preparationTime") as! Int16
                recipes.append(Recipe(name: title, time: time))
            }
            
        }catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return recipes
    }
    
    func RetriveIngredientByRecipe(recipe:Recipe) -> [Ingredient] {
        
        var ingredientNSSet:NSMutableSet = NSMutableSet()
        var ingredients:[Ingredient] = []
        var recipeList:[NSManagedObject] = []
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDRecipe")
        fetchRequest.predicate = NSPredicate(format: "name = %@", recipe.name)
        
        do{
            recipeList = try context.fetch(fetchRequest)
            let recipeNS:NSManagedObject = recipeList[0]
            
            ingredientNSSet = recipeNS.value(forKey: "ingredients") as! NSMutableSet

            for ingredient in ingredientNSSet.allObjects as! [CDIngredient]{
                let ingredientName = ingredient.name!
                ingredients.append(Ingredient(name: ingredientName))
            }
            
        }catch let error as NSError{
            print("Unable to retrive ingredients. \(error). \(error.userInfo)")
        }
        
        return ingredients
    }
    
    /*func AddIngredientToRecipe(newIngredient:Ingredient){
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CDIngredient", in: context)!
        let ingredient = NSManagedObject(entity: entity, insertInto: context)
        
    }*/
    
}
