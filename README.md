## OpenCVSample

[OpenCVSample](https://github.com/toby-liu-os/OpenCVSample) is an iOS app which contains an OpenCV wrapper file OpenCVSample.mm for integrating OpenCV APIs into iOS swift project.


### System environment

1. macOS Sierra Version 10.12.5
2. Xcode Version 8.3.3 (installed from App Store)
3. [OpenCV 3.2 framework](https://sourceforge.net/projects/opencvlibrary/files/opencv-ios/3.2.0/opencv-3.2.0-ios-framework.zip/download) (downloaded from OpenCV website)

### Build steps

1. git clone this project
2. download OpenCV 3.2 framework zip file and unzip it
3. copy the unzipped file opencv2.framework to OpenCVSample/OpenCVSample
4. build the project in Xcode


### Tested devices

1. iPhone 7 plus with iOS 10.2


### Features

- Support convert image to grayscale image
- Support blur image by Gaussian Blur function
- Support detect edges by Canny Edge function


### Notes

- To hide the warnings of "Documentation Issue", set the option "Documentation Comments" to "No" in "Build Settings" page.
