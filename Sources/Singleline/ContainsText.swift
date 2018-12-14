//
// Created by Bruno Lopes on 2018-12-14.
// Copyright (c) 2018 SkeletonView. All rights reserved.
//

import Foundation
import UIKit

enum SkeletonTextAssociatedKeys {
    static var lineFillingPercent = "fillingPercent"
    static var skeletonLineHeight = "skeletonLineHeight"
}

protocol ContainsText {
    var lineFillingPercent: Int { get }
    var skeletonLineHeight: CGFloat? { get }
}

extension ContainsText {
    var lineFillingPercent: Int { return 100 }
    var skeletonLineHeight: CGFloat? { return nil }
}
