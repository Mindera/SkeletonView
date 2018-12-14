//
//  UIView+Frame.swift
//  SkeletonView-iOS
//
//  Created by Juanpe Catalán on 06/11/2017.
//  Copyright © 2017 SkeletonView. All rights reserved.
//

import UIKit

// MARK: Frame
extension UIView {
    
    var maxBoundsEstimated: CGRect {
        var origin: CGPoint = .zero

        if let maxHeightOverride = maxHeightOverride {
            origin.y = (maxHeightOverride - maxHeightEstimated) / 2
        }

        if let parentStackView = (superview as? UIStackView) {
            switch parentStackView.alignment {
            case .trailing:
                origin.x = maxWidthEstimated
            default:
                break
            }
        }

        return CGRect(origin: origin, size: maxSizeEstimated)
    }
    
    var maxSizeEstimated: CGSize {
        return CGSize(width: maxWidthEstimated, height: maxHeightOverride ?? maxHeightEstimated)
    }
    
    var maxWidthEstimated: CGFloat {
        var fill = 100
        if let multiLineView = self as? ContainsMultilineText, multiLineView.numLines == 1,
           let textView = self as? ContainsText {
            fill = textView.lineFillingPercent
        }

        let constraintsWidth = nonContentSizeLayoutConstraints.filter({ $0.firstAttribute == NSLayoutConstraint.Attribute.width })
        return max(between: frame.size.width, andConstantsOf: constraintsWidth) * (CGFloat(fill) / 100.0)
    }
    
    var maxHeightEstimated: CGFloat {
        let constraintsHeight = nonContentSizeLayoutConstraints.filter({ $0.firstAttribute == NSLayoutConstraint.Attribute.height })
        return max(between: frame.size.height, andConstantsOf: constraintsHeight)
    }

    var maxHeightOverride: CGFloat? {
        guard let multiLineView = self as? ContainsMultilineText, multiLineView.numLines == 1,
              let textView = self as? ContainsText,
              let lineHeight = textView.skeletonLineHeight else {
            return nil
        }
        return lineHeight
    }

    private func max(between value: CGFloat, andConstantsOf constraints: [NSLayoutConstraint]) -> CGFloat {
        let max = constraints.reduce(value, { max, constraint in
            var tempMax = max
            if constraint.constant > tempMax { tempMax = constraint.constant }
            return tempMax
        })
        return max
    }
    
    var nonContentSizeLayoutConstraints: [NSLayoutConstraint] {
        return constraints.filter({ "\(type(of: $0))" != "NSContentSizeLayoutConstraint" })
    }
}
