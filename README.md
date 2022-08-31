# buttons
_In this workshop we've created custom animated button class inherited from UIView class._

Using custom class MBButton you can customize your button appearance.

## Configure buttons attributes

| Attribute   | Description |
| ----------- | ----------- |
| Title       | The button’s title. You can specify a button’s title as a plain string       |
| TitleColor  | You can specify the color of button's title with UIColor        |
| BorderType      | You can specify button's border appearance with one of enum cases: **.noborder** - when button has no borders, **.border((color: CGColor, width: Int))** - to specify border's appearance       |
| Image       | The button’s foreground image. Typically, you use template images for a button’s foreground, but you may specify any image in your Xcode project.       | 
| Shadow       | The offset, color, radius and opacity of the button’s shadow       |
| BackgroundFill       | You can specify button background with one of enum cases: .color, .gradient or .image.       |
| CornersType       | Specify which coreners should be rounded.       |

## Event handling

**onTapAction**: (() -> Void)?

**onSwipeAction**: (() -> Void)?

## Technologies
- [x] Swift 5.6
- [x] MVC
- [x] UIKit


https://user-images.githubusercontent.com/95095076/187729289-8e232cf2-e992-45f6-8400-3affa321efe0.mp4

