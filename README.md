# 壁纸 Wallpapers（iOS App）

内置苹果官方壁纸精选的 iOS 应用：网格浏览、全屏左右滑动预览、一键保存到相册（再从相册设为墙纸）。

- 壁纸来源：GitHub 上最完整的公开档案 [SniperGER/iOS-Wallpapers](https://github.com/SniperGER/iOS-Wallpapers)（“An archive of every iOS wallpaper officially released by Apple”）。该档案收录到 iOS 17 为止。
- 本 App 首版精选 30 张：iOS 17 默认与 15 Pro 钛金属系列、iOS 16 小丑鱼与 14 Pro 系列、iOS 14 沙漠/湖畔昼夜、iOS 13/12 的 WWDC 与地球月球、iOS 10 水滴、iOS 9 火星/羽毛/木星、iOS 8 山与星等。均为官方原图（部分早期的是苹果的方形母版原图，未做裁剪）。
- 说明：苹果全部官方壁纸（iOS + macOS + watchOS 历代）有数千张、总体积数 GB，无法全部塞进一个 IPA；后续可按年代分批往这个 App 里加。

## 构建

GitHub Actions 使用 Xcode 27.2 / iOS 27.2 SDK（`xcode-27` runner）构建未签名 IPA，最低系统 iOS 26.0。

本地构建需要 macOS + Xcode + XcodeGen：

```bash
brew install xcodegen
xcodegen generate
xcodebuild -project Wallpapers.xcodeproj -scheme Wallpapers -sdk iphoneos CODE_SIGNING_ALLOWED=NO build
```

## 安装

用 AltStore / SideStore 安装 `Wallpapers.ipa`（会用你的 Apple ID 重新签名）。
