//
//  LoginViewController.swift
//  BonVoya
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    /* 
    * username was made static in order to be accessible to any other class if necessary
    * A tradeoff is that any reference to a static variable must be preceded by the name of the view controller that it was declared in
    * In this case, it's LoginViewController, so you would have to type LoginViewController.username to access the value of "username"
     */
    static var username: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //usernameField will be selected and keyboard will be shown when this view controller is loaded
        usernameField.becomeFirstResponder()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        LoginViewController.username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: LoginViewController.username, password: password) { (user, error) in
            if user != nil { //if there exists a user in Parse database, go to dashboard
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else { //user not found in Parse databse
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    //Function to register user
    @IBAction func onRegister(_ sender: Any) {
        //Create PFUser object and attribute user&pass to the user
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success { //if successful login
                LoginViewController.username = user.username!
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else { //if login failed
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}
