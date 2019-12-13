//
//  SegmentVC.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/6.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI
import UIKit

struct SegmentVC: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    func makeUIViewController(context _: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context _: Context) {
        pageViewController.setViewControllers(
            [controllers[0]], direction: .forward, animated: true
        )
    }
}
