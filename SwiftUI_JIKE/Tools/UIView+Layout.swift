//
//  UIView+Constraint.swift
//  FlyReader
//
//  Created by ying on 17/5/5.
//  Copyright © 2017年 ying.com. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //
    var width: CGFloat {
        get {
            return frame.size.width
        }

        set(width) {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }

    var height: CGFloat {
        get {
            return frame.size.height
        }

        set(height) {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }

    var size: CGSize {
        get {
            return frame.size
        }

        set(size) {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }

    var origin: CGPoint {
        get {
            return frame.origin
        }

        set(origin) {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }

    var left: CGFloat {
        get {
            return frame.origin.x
        }

        set(left) {
            var frame = self.frame
            frame.origin.x = left
            self.frame = frame
        }
    }

    var topF: CGFloat {
        get {
            return frame.origin.y
        }

        set(topF) {
            var frame = self.frame
            frame.origin.y = topF
            self.frame = frame
        }
    }

    var right: CGFloat {
        get {
            return left + frame.size.width
        }

        set(right) {
            var frame = self.frame
            frame.origin.x = right - self.frame.size.width
            self.frame = frame
        }
    }

    var bottom: CGFloat {
        get {
            return topF + frame.size.height
        }
        set(bottom) {
            var frame = self.frame
            frame.origin.y = bottom - self.frame.size.height
            self.frame = frame
        }
    }

    var centerX: CGFloat {
        get {
            return center.x
        }

        set(centerX) {
            var center = self.center
            center.x = centerX
            self.center = center
        }
    }

    var centerY: CGFloat {
        get {
            return center.y
        }

        set(centerY) {
            var center = self.center
            center.y = centerY
            self.center = center
        }
    }

    //
    func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }

    //
    func setCorner(cornerRadius radius: CGFloat) {
        if radius > 0.0 {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        } else {
            layer.cornerRadius = 0.0
            layer.masksToBounds = false
        }
    }

    // eg:redView.setCorner(cornerRadius: 20, cornerAspect:[UIRectCorner.topLeft,UIRectCorner.bottomLeft])
    func setCorner(cornerRadius radius: CGFloat, cornerAspect corner: UIRectCorner) {
        let bezierpath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = bezierpath.cgPath
        self.layer.mask = layer
    }
}

extension UIView {
    func circleView(cornerRadius: CGFloat) -> UIView? {
        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            var path: UIBezierPath
            if let color = self.backgroundColor {
                context.setLineWidth(1)
                context.setFillColor(color.cgColor)
                context.setStrokeColor(color.cgColor)
            }

            if frame.size.width == frame.size.height {
                if cornerRadius == frame.size.width / 2 {
                    path = UIBezierPath(arcCenter: center, radius: cornerRadius, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: true)
                } else {
                    path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
                }
            } else {
                path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            }
            draw(rect)
            context.addPath(path.cgPath)
            context.drawPath(using: .fillStroke)
            context.clip()
            // 从上下文上获取剪裁后的照片
            guard let uncompressedImage = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return nil
            }
            // 关闭上下文
            UIGraphicsEndImageContext()
            let view = UIView()
            view.backgroundColor = UIColor.clear
            view.frame = frame
            view.addSubview(UIImageView(image: uncompressedImage))
            return view
        } else {
            return nil
        }
    }
}
