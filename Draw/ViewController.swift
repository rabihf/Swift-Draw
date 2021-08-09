//
//  ViewController.swift
//  Draw
//
//  Created by Rabih Fawaz on 5/5/21.
//

import UIKit

class ViewController: UIViewController {
//    let logoSize = CGSize(width: 230, height: 240)
    var logoSize = CGSize()
    let logoImage = UIImage(named: "Logo")

    var logoView = UIImageView()
    var boxView = UIImageView()
    var shapeView = Shape()
    var sliderLabel = UILabel()
    var slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView() {
        view.backgroundColor = .systemTeal
        logoSize = CGSize(width: (logoImage?.size.width)!, height: (logoImage?.size.height)!)

        setupLogo()
        setupBox()
        setupShape()
        setupSlider()
    }
    
    fileprivate func setupLogo() {
        let origin = CGPoint(x: view.frame.midX - (logoSize.width / 2), y: 70)
        let size = logoSize
        let logoRect = CGRect(origin: origin, size: size)
        logoView = UIImageView(frame: logoRect)
        
        view.addSubview(logoView)
        logoView.image = logoImage

    }
    
    fileprivate func setupBox() {
        // Draws a rectangle below the image with same size
        let boxSize = logoSize
        let boxRect = CGRect(origin: CGPoint(x: logoView.frame.minX, y: logoView.frame.maxY), size: boxSize)
        boxView = UIImageView(frame: boxRect)
        view.addSubview(boxView)
        let image = drawCustomImage(size: boxSize)
        boxView.image = image
    }
    
    fileprivate func setupShape() {
        // Draws the triangle from Shape
        let shapeSize = logoSize
        let shapeRect = CGRect(origin: CGPoint(x: logoView.frame.minX, y: boxView.frame.maxY), size: shapeSize)
        shapeView = Shape(frame: shapeRect )

        view.addSubview(shapeView)
        shapeView.isOpaque = false
    }
    
    fileprivate func setupSlider() {
        
        let x = view.bounds.minX
        let width = view.bounds.width
        let margin = CGFloat(50)
        let rect = CGRect(x: x + margin, y: 40, width: width - 2 * margin, height: 30)
        slider = UISlider(frame: rect)
        view.addSubview(slider)
        
        sliderLabel = UILabel(frame: CGRect(x: x + 20, y: 40, width: 50, height: 30))
        view.addSubview(sliderLabel)
        slider.minimumValue = 1
        slider.maximumValue = Float(view.bounds.width)
        slider.value = slider.maximumValue
        sliderLabel.text = String(Int(slider.value / Float(view.bounds.width) * 100))
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        slider.isContinuous = true
        slider.tintColor = .systemRed
                
        
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        let sliderValue: Float = sender.value / Float(view.bounds.width)
        sliderLabel.text = String(Int(sliderValue * 100))
        let transform = CGAffineTransform(scaleX: CGFloat(sliderValue), y:CGFloat(sliderValue))
        logoView.transform = transform
        boxView.transform = transform
        shapeView.transform = transform
    }
    
    fileprivate func drawCustomImage(size: CGSize) -> UIImage {
        // Setup our context
        let bounds = CGRect(origin: .zero, size: size)
        let opaque = false
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        let context = UIGraphicsGetCurrentContext()!

        // Setup complete, do drawing here
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(2)

        context.stroke(bounds)

        context.beginPath()
        context.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        context.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        context.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        context.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        context.strokePath()

        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
