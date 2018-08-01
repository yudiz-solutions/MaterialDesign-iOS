//
//  ViewController.swift
//  DemoMaterialDesign
//
//  Created by Yudiz Solutions Pvt. Ltd. on 28/07/18.
//  Copyright © 2018 Yudiz Solution Pvt Ltd. All rights reserved.
//

import UIKit
import MaterialComponents


/// Viewcontroller class
class ViewController: UIViewController {
    
    var textFieldControllerFloating: MDCTextInputControllerUnderline!
    var selectedTab: SelectedTab = .none
    var highlightController: MDCFeatureHighlightViewController!
    var welcomeButton: MDCButton! //Button for highlited view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSelectedData()
    }
}

// MARK: - Load UI
extension ViewController{
    
    func loadSelectedData(){
        self.title = selectedTab.setTitle
        switch selectedTab{
        case .textField:
            self.configureMultiLineTextField()
        case .button:
            self.configureButton()
        case .chipView:
            self.configureChipView()
        case .bottomView:
            self.configureBottomView()
        case .snackBar:
            self.configureSnackBar()
        case .tabBar:
            self.configureTabBar()
        case .slider:
            self.configureSlider()
        case .pageController:
            break
        case .spinner:
            self.configureActivityIndicator()
        case .highlightView:
            self.configureHighLightView()
        case .none:
            break
        }
    }
}


// MARK: - Extension for configure different material component.
extension ViewController {
    
    
    ///  This method set up the multiline text field.
    func configureMultiLineTextField(){
        let textFieldFloating = MDCMultilineTextField(frame: CGRect(x: 20, y: 150, width: view.frame.size.width - 40, height: 40))
        textFieldFloating.textView?.delegate = self
        textFieldFloating.placeholder = "Enter UserName"
        textFieldFloating.expandsOnOverflow = false
        textFieldFloating.clearButtonMode = .never
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating)
        textFieldControllerFloating.characterCountMax = 15
        textFieldControllerFloating.floatingPlaceholderActiveColor = UIColor.lightGray
        textFieldControllerFloating.errorColor = .red
        view.addSubview(textFieldFloating)
    }
    
    
    /// This method set up the chip view.
    func configureChipView(){
        //Simple chip view
        let chipView = MDCChipView()
        chipView.frame = CGRect(x: 20, y: 150, width: 120, height: 40)
        chipView.titleLabel.text = "Simple Chip"
        chipView.setTitleColor(UIColor.red, for: .selected)
        self.view.addSubview(chipView)
        
        //Chip view with image
        let chipView1 = MDCChipView()
        chipView1.sizeToFit()
        chipView1.frame = CGRect(x: 20, y: 220, width: 180, height: 40)
        chipView1.titleLabel.text = "Chip With Image"
        chipView1.setTitleColor(UIColor.red, for: .selected)
        chipView1.addTarget(self, action: #selector(chipViewTapped(_:)), for: .touchUpInside)
        self.view.addSubview(chipView1)
    }
    
    /// Chip view action
    ///
    /// - Parameter sender: MDCChipView
    @objc func chipViewTapped(_ sender: MDCChipView){
        sender.imageView.image = UIImage(named: "Favorite")
        sender.imagePadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    /// This method set up the button.
    func configureButton(){
        let button = MDCButton()
        button.frame.size = CGSize(width: 100, height: 40)
        button.center = CGPoint(x: view.center.x, y: 160)
        button.setTitle("Button", for: .normal)
        button.setElevation(ShadowElevation(rawValue: 6), for: .normal) // For add shadow on button.
        view.addSubview(button)
        
        let floatyButton = MDCFloatingButton()
        floatyButton.frame.size = CGSize(width: 40, height: 40)
        floatyButton.center = CGPoint(x: view.center.x, y: 240)
        floatyButton.setImage(UIImage(named: "Favorite"), for: .normal)
        floatyButton.backgroundColor = .white
        floatyButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        floatyButton.addTarget(self, action: #selector(btnFloatingButtonTapped(floatingButton:)), for: .touchUpInside)
        view.addSubview(floatyButton)
    }
    
    /// Floating button tap action
    ///
    /// - Parameter floatingButton: MDCFloatingButton
    @objc func btnFloatingButtonTapped(floatingButton: MDCFloatingButton){
        floatingButton.collapse(true) {
            floatingButton.expand(true, completion: nil)
        }
    }
    
    /// This method set up the bottom view.
    func configureBottomView(){
        let bottomLayout = self.navigationController!.bottomLayoutGuide.length
        let bottomView = MDCBottomNavigationBar()
        bottomView.frame = CGRect(x: 0, y: view.frame.height - 49 - bottomLayout, width: view.frame.width, height: 49 + bottomLayout)
        bottomView.items = [
            UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), tag: 0),
            UITabBarItem(title: "Message", image: #imageLiteral(resourceName: "Email"), tag: 1),
            UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "Favorite"), tag: 2),
            UITabBarItem(title: "Calls", image: #imageLiteral(resourceName: "calls"), tag: 3),
            UITabBarItem(title: "More", image: #imageLiteral(resourceName: "more"), tag: 4)
        ]
        bottomView.selectedItem = bottomView.items.first
        bottomView.alignment = .centered
        view.addSubview(bottomView)
    }
    
    /// This method set up the snack bar(Bottom toast)
    func configureSnackBar() {
        let message = MDCSnackbarMessage()
        message.text = "This is a SnackBar Toast"
        let action = MDCSnackbarMessageAction()
        let actionHandler = { () in
            let answerMessage = MDCSnackbarMessage()
            answerMessage.text = "Fascinating"
            MDCSnackbarManager.show(answerMessage)
        }
        action.handler = actionHandler
        action.title = "ok"
        message.action = action
        MDCSnackbarManager.show(message)
    }
    
    /// This method set up the tab bar
    func configureTabBar() {
        let tabBar = MDCTabBar(frame: CGRect(x: 0, y: navigationController!.navigationBar.frame.height + navigationController!.navigationBar.frame.origin.y , width: view.frame.width, height: 50))
        tabBar.items = [
            UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), tag: 0),
            UITabBarItem(title: "Message", image: #imageLiteral(resourceName: "Email"), tag: 1),
            UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "Favorite"), tag: 2),
            UITabBarItem(title: "Calls", image: #imageLiteral(resourceName: "calls"), tag: 3),
            UITabBarItem(title: "More", image: #imageLiteral(resourceName: "more"), tag: 4)
        ]
        tabBar.selectedItem = tabBar.items.first
        tabBar.alignment = .center
        tabBar.itemAppearance = .titledImages
        tabBar.barTintColor = .white
        tabBar.selectedItemTintColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.selectionIndicatorTemplate = IndicatorTemplate()
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        view.addSubview(tabBar)
    }
    
    /// This method set up the slider
    func configureSlider() {
        let slider = MDCSlider()
        slider.shouldDisplayDiscreteValueLabel = true
        slider.isEnabled = true
        slider.numberOfDiscreteValues = 5
        slider.frame = CGRect(x: 50, y: 150, width: view.frame.width - 100, height: 27)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.inkColor = .black
        slider.isThumbHollowAtStart = true
        slider.addTarget(self, action: #selector(didChangeSliderValue), for: .valueChanged)
        view.addSubview(slider)
    }
    
    /// Slider value change action
    ///
    /// - Parameter sender: MDCSlider
    @objc func didChangeSliderValue(_ sender: MDCSlider){
        sender.isStatefulAPIEnabled = true
        sender.setThumbColor(.red, for: .selected)
    }
    
    /// This methos set up the activity indicator.
    func configureActivityIndicator() {
        let activityIndicator = MDCActivityIndicator()
        activityIndicator.sizeToFit()
        activityIndicator.progress = 0.4
        activityIndicator.cycleColors = [.blue, .red, .green]
        activityIndicator.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 100, height: 100)
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    /// This method set up welcome button for highlight view.
    func configureHighLightView() {
        welcomeButton = MDCButton()
        welcomeButton.frame = CGRect(x: 0, y: 80, width: 120, height: 40)
        welcomeButton.center = view.center
        welcomeButton.setTitle("Welcome", for: .normal)
        welcomeButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        view.addSubview(welcomeButton)
        
        let showButton = MDCButton()
        showButton.frame = CGRect(x: 30, y: view.frame.height - 80, width: view.frame.width - 60, height: 40)
        showButton.setTitle("SHOW FEATURE HIGHLIGHT", for: .normal)
        showButton.addTarget(self, action: #selector(btnWelComeTapped(button:)), for: .touchUpInside)
        showButton.setElevation(ShadowElevation(rawValue: 6), for: .normal)
        view.addSubview(showButton)
    }
    
    /// Button action for show highlighted view on welcome button.
    ///
    /// - Parameter button: MDCButton
    @objc func btnWelComeTapped(button: MDCButton){
        highlightController = MDCFeatureHighlightViewController(highlightedView: welcomeButton, completion: nil)
        highlightController.bodyColor = .white
        highlightController.titleColor = .white
        highlightController.titleText = "Welcome Sir!"
        highlightController.bodyText = "Highlighted view for highlight particular UI of screen"
        highlightController.outerHighlightColor =
            UIColor.black.withAlphaComponent(kMDCFeatureHighlightOuterHighlightAlpha)
        present(highlightController, animated: true, completion: nil)
    }
    
}

// MARK: - Chip delegate
extension ViewController: MDCChipFieldDelegate {
    
    func chipField(_ chipField: MDCChipField, didAddChip chip: MDCChipView) {
        
    }
}


// MARK: - textView delegate
extension ViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let txt = textView.text.trimmingCharacters(in: .whitespaces)
        textFieldControllerFloating.isFloatingEnabled = !txt.isEmpty
    }
}

/// Class for custom tab bat indicator
class IndicatorTemplate: NSObject, MDCTabBarIndicatorTemplate {
    func indicatorAttributes(
        for context: MDCTabBarIndicatorContext
        ) -> MDCTabBarIndicatorAttributes {
        let attributes = MDCTabBarIndicatorAttributes()
        // Outset frame, round corners, and stroke.
        let indicatorFrame = context.contentFrame.insetBy(dx: -8, dy: -4)
        let path = UIBezierPath(roundedRect: indicatorFrame, cornerRadius: 4)
        attributes.path = path.stroked(withWidth: 2)
        return attributes
    }
}

// MARK: - Extension for stroked
extension UIBezierPath {
    /// Returns a copy of the path, stroked with the given line width.
    func stroked(withWidth width: CGFloat) -> UIBezierPath {
        let strokedPath = cgPath.copy(
            strokingWithWidth: width,
            lineCap: .butt,
            lineJoin: .miter,
            miterLimit: 0)
        return UIBezierPath(cgPath: strokedPath)
    }
}
