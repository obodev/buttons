//
//  ViewController.swift
//  MBButton
//
//  Created by obo.dev on 27.08.2022.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var label: UILabel!
  @IBOutlet private weak var button: MBButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupSubviews()
  }
  
  private func setupSubviews() {
//    button.backgroundFill = .color(.red)
//    button.backgroundFill = .gradient((start: 0.0,
//                                       end: 1.0,
//                                       firstColor: .red,
//                                       secondColor: .green,
//                                       vectorStart: CGPoint(x: 0.0, y: 0.0),
//                                       vectorEnd: CGPoint(x: 1.0, y: 1.0)))
    button.backgroundFill = .image(UIImage(named: "bg") ?? UIImage())
    
    button.cornersType = .roundedAll(20)
    
    button.shadow = (color: .black, radius: 5, opacity: 0.6, offset: CGSize(width: 1, height: 1))
    button.title = "Push me harder and harder and harder"
    button.titleColor = .white
    
    button.borderType = .border((color: .orange, width: 5))
    
    button.onTapAction = { [weak self] in
      guard let self = self else { return }
      self.label.text = "Button was tapped"
    }
    
    button.onSwipeAction = { [weak self] in
      guard let self = self else { return }
      self.label.text = "Swiped!!!"
      self.button.title = "ASSAAS"
      self.view.backgroundColor = .red
    }
    
    button.image = UIImage(systemName: "house")
  }

}
