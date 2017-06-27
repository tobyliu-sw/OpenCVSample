//
//  OpenCVSample.m
//  OpenCVSample
//
//  Created by Pin-Chou Liu on 6/26/17.
//  Copyright © 2017 Pin-Chou Liu.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

#import "OpenCVSample-Bridging-Header.h"

/*
 * add a method convertToMat to UIImage class
 */
@interface UIImage (OpenCVWrapper)
- (void)convertToMat: (cv::Mat *)pMat;
@end

@implementation UIImage (OpenCVWrapper)
- (void)convertToMat: (cv::Mat *)pMat {
    if (self.imageOrientation == UIImageOrientationRight) {
        /*
         * When taking picture in portrait orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat);
        cv::rotate(*pMat, *pMat, cv::ROTATE_90_CLOCKWISE);
    } else if (self.imageOrientation == UIImageOrientationLeft) {
        /*
         * When taking picture in portrait upside-down orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait upside-down orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat);
        cv::rotate(*pMat, *pMat, cv::ROTATE_90_COUNTERCLOCKWISE);
    } else {
        /*
         * When taking picture in landscape orientation,
         * convert UIImage to OpenCV Matrix directly,
         * and then ONLY rotate OpenCV Matrix for landscape left-side-up orientation
         */
        UIImageToMat(self, *pMat);
        if (self.imageOrientation == UIImageOrientationDown) {
            cv::rotate(*pMat, *pMat, cv::ROTATE_180);
        }
    }
}
@end


/*
 *  class methods to execute OpenCV operations
 */
@implementation OpenCVWrapper : NSObject

+ (UIImage *)grayscaleImage:(UIImage *)image {
    cv::Mat mat;
    [image convertToMat: &mat];

    cv::Mat gray;
    if (mat.channels() > 1) {
        cv::cvtColor(mat, gray, CV_RGB2GRAY);
    } else {
        mat.copyTo(gray);
    }

    UIImage *grayImg = MatToUIImage(gray);
    return grayImg;
}

+ (UIImage *)gaussianBlurImage:(UIImage *)image {
    cv::Mat mat;
    [image convertToMat: &mat];

    cv::Mat gray, blur;
    if (mat.channels() > 1) {
        cv::cvtColor(mat, gray, CV_RGB2GRAY);
    } else {
        mat.copyTo(gray);
    }

    cv::GaussianBlur(gray, blur, cv::Size(5, 5), 3, 3);

    UIImage *blurImg = MatToUIImage(blur);
    return blurImg;
}

+ (UIImage *)cannyEdgeImage:(UIImage *)image {
    cv::Mat mat;
    [image convertToMat: &mat];

    cv::Mat gray, blur, edge;
    if (mat.channels() > 1) {
        cv::cvtColor(mat, gray, CV_RGB2GRAY);
    } else {
        mat.copyTo(gray);
    }

    cv::GaussianBlur(gray, blur, cv::Size(5, 5), 3, 3);

    cv::Canny(blur, edge, 20, 20 * 3, 3);

    UIImage *edgeImg = MatToUIImage(edge);
    return edgeImg;
}

@end
