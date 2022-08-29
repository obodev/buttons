//
//  MBButton.swift
//  MBButton
//
//  Created by obo.dev on 27.08.2022.
//

import UIKit

enum CornersType {
  case square
  case roundedAll(Double)
  case selectedCorners((radius: Double, corners: CACornerMask))
}

enum BackgroundFill {
  case color(UIColor)
  case gradient((start: NSNumber, end: NSNumber, firstColor: UIColor, secondColor: UIColor, vectorStart: CGPoint, vectorEnd: CGPoint))
  case image(UIImage)
}

enum BorderType {
  case noborder
  case border((color: UIColor, width: CGFloat))
}

final class MBButton: UIView {
  
  private var tapGestureRecognizer: UITapGestureRecognizer?
  private var swipegestureRecognizer: UISwipeGestureRecognizer?
  
  var backgroundFill: BackgroundFill? {
    didSet {
      switch backgroundFill {
        case .color(let color): backgroundColor = color
        case .gradient(let gradient): applyGradient(gradient)
        case .image(let image): applyImage(image)
        default: break
      }
    }
  }
  
  var cornersType: CornersType? {
    didSet {
      switch cornersType {
        case .square:
          break
        case .roundedAll(let cornerRadius):
          layer.cornerRadius = cornerRadius
          gradientLayer.cornerRadius = cornerRadius
          bgImageView.layer.cornerRadius = cornerRadius
        case .selectedCorners(let corners):
          layer.cornerRadius = corners.radius
          layer.maskedCorners = corners.corners
          gradientLayer.cornerRadius = corners.radius
          gradientLayer.maskedCorners = corners.corners
          bgImageView.layer.cornerRadius = corners.radius
          bgImageView.layer.maskedCorners = corners.corners
        default:
          break
      }
    }
  }
  
  private let gradientLayer = CAGradientLayer()
  
  var shadow: (color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize)? {
    didSet {
      if let shadow = shadow {
        setupShadow(shadow)
      }
    }
  }
  
  var onTapAction: (() -> Void)?
  var onSwipeAction: (() -> Void)?
  
  private let textlabel = UILabel()
  
  var title: String? {
    didSet {
      textlabel.text = title
    }
  }
  
  var titleColor: UIColor? {
    didSet {
      textlabel.textColor = titleColor
    }
  }
  
  var borderType: BorderType? {
    didSet {
      switch borderType {
        case .noborder: break
        case .border(let params):
          layer.borderColor = params.color.cgColor
          layer.borderWidth = params.width
        default: break
      }
    }
  }
  
  var image: UIImage? {
    didSet {
      imageView.image = image
      layoutIfNeeded()
    }
  }
  
  private let imageView = UIImageView()
  private let bgImageView = UIImageView()
  
  override init(frame: CGRect) { super.init(frame: frame); setup() }
  required init?(coder: NSCoder) { super.init(coder: coder); setup() }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    bgImageView.frame = bounds
    bgImageView.clipsToBounds = true
    
    if image == nil {
      imageView.frame = CGRect.zero
      textlabel.frame = CGRect(x: bounds.width / 2 - textlabel.intrinsicContentSize.width / 2,
                               y: bounds.height / 2 - textlabel.intrinsicContentSize.height / 2,
                               width: textlabel.intrinsicContentSize.width,
                               height: textlabel.intrinsicContentSize.height)
    } else {
      imageView.frame = CGRect(x: 8,
                               y: 8,
                               width: bounds.height - 16,
                               height: bounds.height - 16)
      textlabel.frame = CGRect(x: imageView.frame.maxX + 8,
                               y: bounds.height / 2 - textlabel.intrinsicContentSize.height / 2,
                               width: bounds.width - 24 - imageView.frame.width,
                               height: textlabel.intrinsicContentSize.height)
    }
  }
                             
}

private extension MBButton {
  
  private func setup() {
    setupLayout()
    setupTapGestureRecognizer()
    setupSwipeGestureRecogniozer()
  }
  
  private func setupLayout() {
    layer.cornerCurve = .continuous
    
    imageView.contentMode = .scaleAspectFit
    bgImageView.isHidden = true
    bgImageView.contentMode = .scaleAspectFill
    
    addSubview(bgImageView)
    addSubview(textlabel)
    addSubview(imageView)
  }
  
  private func setupShadow(_ params: (color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize)) {
    layer.shadowColor = params.color.cgColor
    layer.shadowOpacity = params.opacity
    layer.shadowOffset = params.offset
    layer.shadowRadius = params.radius
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
  
  private func setupTapGestureRecognizer() {
    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
    
    if let tg = tapGestureRecognizer {
      addGestureRecognizer(tg)
    }
  }
  
  private func setupSwipeGestureRecogniozer() {
    swipegestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
    swipegestureRecognizer?.direction = .right
    
    if let sg = swipegestureRecognizer {
      addGestureRecognizer(sg)
    }
  }
  
  private func applyGradient(_ params: (start: NSNumber, end: NSNumber, firstColor: UIColor, secondColor: UIColor, vectorStart: CGPoint, vectorEnd: CGPoint)) {
    gradientLayer.colors = [params.firstColor.cgColor, params.secondColor.cgColor]
    gradientLayer.locations = [params.start, params.end]
    gradientLayer.frame = bounds
    
    gradientLayer.startPoint = params.vectorStart
    gradientLayer.endPoint = params.vectorEnd
    
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  private func applyImage(_ image: UIImage) {
    bgImageView.isHidden = false
    bgImageView.image = image
  }
  
}

private extension MBButton {
  
  @objc private func onTap() {
    print("onTap triggered")
    pop()
    onTapAction?()
  }
  
  @objc private func onSwipe() {
    print("onSwipe triggered")
    onSwipeAction?()
  }
  
}

private extension MBButton {
  
  private func pop() {
    UIView.animate(withDuration: 0.11, delay: 0.0, options: .curveEaseOut) {
      self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
    } completion: { completed in
      if completed {
        UIView.animate(withDuration: 0.11, delay: 0.0, options: .curveEaseIn, animations: {
          self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
      }
    }
  }
  
}
