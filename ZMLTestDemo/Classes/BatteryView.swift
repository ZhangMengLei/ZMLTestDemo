//
//  BatteryView.swift
//  NewStudios
//
//  Created by 张梦磊 on 2020/3/30.
//  Copyright © 2020 New Studios. All rights reserved.
//

import UIKit

class BatteryView: UIView {
    
    private var quantity: CGFloat
    private var state: UIDevice.BatteryState
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    @objc required init(state: UIDevice.BatteryState, quantity: Float, frame: CGRect) {
        self.quantity = CGFloat(quantity)
        self.state = state
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
    }
    
    override func draw(_ rect: CGRect) {
        if let layerArray = layer.sublayers {
            for object in layerArray {
                object.removeFromSuperlayer()
            }
        }
        
        layer.allowsGroupOpacity = false
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0.0, y: 0.0, width: frame.width - 5.0, height: frame.height), cornerRadius: 2.7)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.0
//        shapeLayer.lineJoin = .round
//        shapeLayer.lineCap = .round
        shapeLayer.path = path.cgPath
        shapeLayer.opacity = 0.35
        layer.addSublayer(shapeLayer)
        
        var battrryWidth: CGFloat
        //// 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown
        if quantity <= -1.0 {
            battrryWidth = frame.width - 9.0
        } else {
            battrryWidth = (frame.width - 9.0) * quantity
        }
        let batteryPath = UIBezierPath(roundedRect: CGRect(x: 2.0, y: 2.0, width: CGFloat(battrryWidth), height: frame.height - 4.0), cornerRadius: 1.3)
        let batteryLayer = CAShapeLayer()
        batteryLayer.strokeColor = UIColor.clear.cgColor
        if state == .charging {
            batteryLayer.fillColor = UIColor(red: 76.0 / 255.0, green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0).cgColor
        } else {
            batteryLayer.fillColor = UIColor.white.cgColor
        }
        batteryLayer.lineWidth = 1.0
//        batteryLayer.lineJoin = .round
//        batteryLayer.lineCap = .round
        batteryLayer.opacity = 1.0
        batteryLayer.path = batteryPath.cgPath
        layer.addSublayer(batteryLayer)
        
        let arrowPath = UIBezierPath()
        arrowPath.addArc(withCenter: CGPoint(x: frame.width - 5.0, y: frame.height / 2.0), radius: 2.8, startAngle: CGFloat(1.7 * Double.pi), endAngle: CGFloat(0.3 * Double.pi), clockwise: true)
        let arrowLayer = CAShapeLayer()
        arrowLayer.strokeColor = UIColor.clear.cgColor
        arrowLayer.fillColor = UIColor.white.cgColor
        arrowLayer.lineWidth = 1.0
//        batteryLayer.lineJoin = .round
//        arrowLayer.lineCap = .round
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.opacity = 0.35
        layer.addSublayer(arrowLayer)
        
        if state == .charging {
            let lightningLayer = CALayer()
            lightningLayer.frame = CGRect(x: 0.0, y: 0.0, width: frame.width - 5.0, height: frame.height)
            lightningLayer.contents = UIImage(named: "IconBatteryCharge")?.cgImage
//            lightningLayer.contentsGravity = .resizeAspect
            layer.addSublayer(lightningLayer)
        }
    }
}

// MARK: - Actions

extension BatteryView {
    @objc func updateBatteryInfo(state: UIDevice.BatteryState, quantity: Float) {
        self.quantity = CGFloat(quantity)
        self.state = state
        setNeedsDisplay()
    }
}
