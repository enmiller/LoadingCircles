//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


class LoadingCircle : CAShapeLayer {
    init(bounds: CGRect, center: CGPoint, lineWidth: CGFloat, strokeColor: CGColorRef, path: CGPathRef, strokeStart: CGFloat, strokeEnd: CGFloat) {
        super.init()

        self.bounds = bounds
        self.position = center
        self.strokeColor = strokeColor
        self.fillColor = UIColor.clearColor().CGColor
        self.lineWidth = lineWidth
        self.path = path
        self.strokeStart = strokeStart
        self.strokeEnd = strokeEnd
    }

    func addStrokeAnimation(withStartToValue startValue: CGFloat, endToValue endValue: CGFloat, duration: CFTimeInterval, startTimingFunction: CAMediaTimingFunction? = nil, endTimingFunction: CAMediaTimingFunction? = nil, repeatCount: Float) {
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.timingFunction = startTimingFunction
        startAnimation.toValue = startValue
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.timingFunction = endTimingFunction
        endAnimation.toValue = endValue

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [startAnimation, endAnimation]
        animationGroup.duration = duration
        animationGroup.repeatCount = repeatCount
        self.addAnimation(animationGroup, forKey: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// Creates the holder view
let v = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 300.0))
v.backgroundColor = UIColor.darkGrayColor()
XCPlaygroundPage.currentPage.liveView = v

// Defines the bounds constants
let width = CGRectGetWidth(v.bounds)
let height = CGRectGetHeight(v.bounds)

// Defines the loading paths
let outerPath = UIBezierPath(
    arcCenter: CGPoint(x: width/2, y: height/2),
    radius: (width/2) - 5.0,
    startAngle: 0,
    endAngle: CGFloat(2 * M_PI),
    clockwise: true
)
let middlePath = UIBezierPath(
    arcCenter: CGPoint(x: width/2, y: height/2),
    radius: (width/2) - (width/6),
    startAngle: 0,
    endAngle: CGFloat(2 * M_PI),
    clockwise: true
)
let innerPath = UIBezierPath(
    arcCenter: CGPoint(x: width/2, y: height/2),
    radius: (width/2) - (width/4),
    startAngle: 0,
    endAngle: CGFloat(2 * M_PI),
    clockwise: true
)

// Defines the outermost loading circle
let outerLayer = LoadingCircle(
    bounds: v.bounds,
    center: v.center,
    lineWidth: 4.0,
    strokeColor: UIColor.redColor().CGColor,
    path: outerPath.CGPath,
    strokeStart: 0.0,
    strokeEnd: 0.0
)
outerLayer.addStrokeAnimation(withStartToValue: 1.0, endToValue: 1.0, duration: 2.25, startTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), repeatCount: HUGE)

// Defines the middle loading circle
let middleLayer = LoadingCircle(
    bounds: v.bounds,
    center: v.center,
    lineWidth: 4.0,
    strokeColor: UIColor.greenColor().CGColor,
    path: middlePath.CGPath,
    strokeStart: 1.0,
    strokeEnd: 1.0
)
middleLayer.addStrokeAnimation(withStartToValue: 0.0, endToValue: 0.0, duration: 1.75, endTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), repeatCount: HUGE)


// Defines the inner loading circle
let innerLayer = LoadingCircle(
    bounds: v.bounds,
    center: v.center,
    lineWidth: 4.0,
    strokeColor: UIColor.blueColor().CGColor,
    path: innerPath.CGPath,
    strokeStart: 0.0,
    strokeEnd: 0.0
)
innerLayer.addStrokeAnimation(withStartToValue: 1.0, endToValue: 1.0, duration: 1.0, startTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn), repeatCount: HUGE)

v.layer.addSublayer(outerLayer)
v.layer.addSublayer(middleLayer)
v.layer.addSublayer(innerLayer)
