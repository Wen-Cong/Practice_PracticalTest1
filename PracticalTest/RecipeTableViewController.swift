//
//  RecipeTableViewController.swift
//  PracticalTest
//
//  Created by Yeo Wen Cong on 10/12/20.
//

import Foundation
import UIKit

class RecipeTableViewController: UITableViewController{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let recipeController:RecipeController = RecipeController()
    var recipes:[Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipes = recipeController.RetriveAllRecipes()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recipes = recipeController.RetriveAllRecipes()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var ingredientString = "Ingredients:"
        let recipe = recipes[indexPath.row]
        let ingredients:[Ingredient] = recipeController.RetriveIngredientByRecipe(recipe: recipe)
        
        for i in ingredients{
            let formatString_ingredient = " [\(i.name)]"
            ingredientString += formatString_ingredient
        }
        
        cell.textLabel!.text = "\(recipe.name) (\(recipe.preparationTime) mins)"
        cell.detailTextLabel!.text = ingredientString
        
        return cell
    }
}
