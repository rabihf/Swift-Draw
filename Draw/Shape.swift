//
//  Shape.swift
//  Draw
//
//  Created by Rabih Fawaz on 5/5/21.
//

import UIKit

class Shape: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func draw(_ rect: CGRect) {
        // Drawing layer
        // drawLayer()
        
        // Drawing code heart
        drawHeart()
        
    }
    
    fileprivate func drawHeart() {
        let path = UIBezierPath()

        path.lineWidth = 0.5
        UIColor.systemRed.setFill()
        UIColor.black.setStroke()

        let t: Double = deg2rad(35)
        
        path.addArc(withCenter: CGPoint(x: frame.height * 1 / 4,
                                        y: frame.height / 4),
                    radius: CGFloat(frame.height / 4),
                    startAngle: CGFloat(deg2rad(180) - t),
                    endAngle: CGFloat(deg2rad(360.0)),
                    clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: frame.height * 3 / 4 ,
                                        y: frame.height / 4),
                    radius: CGFloat(frame.height / 4),
                    startAngle: CGFloat(deg2rad(180.0)),
                    endAngle: CGFloat(deg2rad(360.0) + t),
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: frame.height / 2, y: frame.height))
        path.close()
        
        path.fill()
        path.stroke()
    }

    fileprivate func drawLayer() {
        let path = UIBezierPath()

        // Draw horizontal line in the middle
        path.move(to: CGPoint(x: 0, y: frame.height / 2))
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.height / 2))
        
        // Draw vertical line in the middle
        path.move(to: CGPoint(x: frame.width / 2, y: 0))
        path.addLine(to: CGPoint(x: frame.width / 2, y: frame.maxY))
        
        
        UIColor.systemRed.setFill()
        UIColor.black.setStroke()
        path.lineWidth = 0.5
        path.stroke()
    }
    
}




func deg2rad(_ number: Double) -> Double {
    return number * .pi / 180
}

func rad2deg(_ number: Double) -> Double {
    return number * 180 / .pi
}
