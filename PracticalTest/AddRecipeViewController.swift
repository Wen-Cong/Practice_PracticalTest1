//
//  AddRecipeViewController.swift
//  PracticalTest
//
//  Created by Yeo Wen Cong on 10/12/20.
//

import Foundation
import UIKit

class AddRecipeViewController: UIViewController{
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtPreparationTime: UITextField!
    
    @IBOutlet weak var txtIngredient1: UITextField!
    
    @IBOutlet weak var txtIngredient2: UITextField!
    
    @IBOutlet weak var txtIngredient3: UITextField!
    
    @IBOutlet weak var txtIngredient4: UITextField!
    
    @IBOutlet weak var txtIngredient5: UITextField!
    
    let recipeController:RecipeController = RecipeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        let title = txtTitle.text
        let preparationTime = txtPreparationTime.text
        
        if (title == "" || preparationTime == ""){
            let alertView = UIAlertController(title: "Empty Field", message: "Please populate the title and preparation time.", preferredStyle: UIAlertController.Style.alert)
            
            alertView.addAction(UIAlertAction(title: "Noted", style: UIAlertAction.Style.default, handler: {_ in /*TO-DO*/}))
            
            self.present(alertView, animated: true, completion: nil)
        }
        else{
            let ingredients:[String?] = [txtIngredient1.text, txtIngredient2.text, txtIngredient3.text,
                                         txtIngredient4.text, txtIngredient5.text]
            var ingredientsIsEmpty:Bool = true
            
            for i in ingredients{
                if(i != ""){
                    ingredientsIsEmpty = false
                    break
                }
            }
            
            if(ingredientsIsEmpty){
                let alertView = UIAlertController(title: "Empty Field", message: "Please add at least 1 ingredient for this recipe.", preferredStyle: UIAlertController.Style.alert)
                
                alertView.addAction(UIAlertAction(title: "Noted", style: UIAlertAction.Style.default, handler: {_ in /*TO-DO*/}))
                
                self.present(alertView, animated: true, completion: nil)
            }
            else{
                var ingredientList:[Ingredient] = []
                for i in ingredients{
                    if(i != ""){
                        ingredientList.append(Ingredient(name: i!))
                    }
                }
                
                //Save Recipe to core data
                let recipe = Recipe(name: title!, time: Int16(preparationTime!)!)
                recipeController.AddRecipe(newRecipe: recipe, newIngredientList: ingredientList)
                
                //Alert user for successful added object
                let alertView = UIAlertController(title: "Recipe Added!", message: "The recipe has been successfully added.", preferredStyle: UIAlertController.Style.alert)
                
                alertView.addAction(UIAlertAction(title: "Noted", style: UIAlertAction.Style.default, handler: {_ in /*TO-DO*/}))
                
                self.present(alertView, animated: true, completion: nil)
            }
            
        }
    }
    
}
