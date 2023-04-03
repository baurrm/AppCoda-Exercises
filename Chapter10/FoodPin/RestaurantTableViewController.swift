//
//  RestaurantTableViewController.swift
//  RestaurantTableViewController
//
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    enum Section {
        case all
    }
        
    var restaurantIsFavourite = Array(repeating: false, count: 21)
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
        
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
//MARK:    Fill the TableView with data
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        
        let cellIdentifier = "favouritecell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                
                cell.nameLabel.text = restaurantName
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
//                if self.restaurantIsFavourite[indexPath.row] {
//                    cell.heartImageView.isHidden = false
//                } else {
//                    cell.heartImageView.isHidden = true
//                }
//                cell.accessoryType = self.restaurantIsFavourite[indexPath.row] ? .checkmark : .none
                cell.heartImageView.isHidden = self.restaurantIsFavourite[indexPath.row] ? false : true
                
                return cell
            }
        )
        
        return dataSource
    }
    
//MARK:     Selection of the Raw inside TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        Creation of the option menu
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
//        Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        Add action to the menu
        optionMenu.addAction(cancelAction)
//        Display the menu
        present(optionMenu, animated: true, completion: nil)
        
//        Reserve table action
//        Create a handler with alertmessage and action
        let reserveActionHandler = { (action: UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertMessage, animated: true, completion: nil)
        }
//        Create an action and add it to the menu
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)
        
//        Favourtie action Handler (Add and Remove)
        let favouriteActionHandler = { (action: UIAlertAction) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            if self.restaurantIsFavourite[indexPath.row] == false {
                cell.heartImageView.isHidden = false
                self.restaurantIsFavourite[indexPath.row] = true
            } else {
                cell.heartImageView.isHidden = true
                self.restaurantIsFavourite[indexPath.row] = false
            }
//            cell.heartImageView.isHidden = self.restaurantIsFavourite[indexPath.row]
//
//            self.restaurantIsFavourite[indexPath.row] = self.restaurantIsFavourite[indexPath.row] ? false : true
        }
//        Mark as favourite action
        let favouriteAction = UIAlertAction(title: "Mark as favourite", style: .default, handler: favouriteActionHandler)
//        Remove from favourites action
        let removeFavouriteAction = UIAlertAction(title: "Remove from favourites", style: .default, handler: favouriteActionHandler)
        if self.restaurantIsFavourite[indexPath.row] == false {
            optionMenu.addAction(favouriteAction)
        } else {
            optionMenu.addAction(removeFavouriteAction)
        }
        
//            Deselect the Row, remove the grey grid after selection
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
