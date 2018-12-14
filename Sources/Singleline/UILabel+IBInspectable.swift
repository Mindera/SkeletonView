//  Copyright © 2017 SkeletonView. All rights reserved.

import UIKit

public extension UILabel {

    @IBInspectable
    var fillPercent: Int {
        get { return lineFillingPercent }
        set { lineFillingPercent = min(newValue, 100) }
    }

    @IBInspectable
    var skeletonHeight: CGFloat {
        get { return skeletonLineHeight ?? 0 }
        set { skeletonLineHeight = newValue > 0 ? newValue : nil }
    }
}

extension UILabel: ContainsText {
    var lineFillingPercent: Int {
        get { return ao_get(pkey: &SkeletonTextAssociatedKeys.lineFillingPercent) as? Int ?? SkeletonAppearance.default.lineFillPercent }
        set { ao_set(newValue, pkey: &SkeletonTextAssociatedKeys.lineFillingPercent) }
    }

    var skeletonLineHeight: CGFloat? {
        get { return ao_get(pkey: &SkeletonTextAssociatedKeys.skeletonLineHeight) as? CGFloat }
        set { ao_setOptional(newValue, pkey: &SkeletonTextAssociatedKeys.skeletonLineHeight) }
    }
}
