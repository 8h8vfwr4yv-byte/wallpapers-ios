# 壁纸 Wallpapers（iOS App）

内置苹果官方壁纸精选的 iOS 应用：按 **手机 / iPad / Mac** 三个分类浏览，网格预览、全屏左右滑动、一键保存到相册（再从相册设为墙纸）。带应用图标。

- 壁纸来源（网上档案）：iPhone/iPad 来自 GitHub 上最完整的公开档案 [SniperGER/iOS-Wallpapers](https://github.com/SniperGER/iOS-Wallpapers)（“An archive of every iOS wallpaper officially released by Apple”，收录到 iOS 17）；Mac 来自 [LAYTAT/macOS-Wallpapers](https://github.com/LAYTAT/macOS-Wallpapers)（Cheetah 到 Tahoe 的历代默认壁纸）。
- 内容（v1.1，共 61 张）：
  - **手机 30 张**：iOS 17 默认与 15 Pro 钛金属系列、iOS 16 小丑鱼与 14 Pro 系列、iOS 14 沙漠/湖畔昼夜、iOS 13/12 的 WWDC 与地球月球、iOS 10 水滴、iOS 9 火星/羽毛/木星、iOS 8 山与星等。
  - **iPad 14 张**：iPadOS 17 默认与湖、iPadOS 16 WWDC22 与镜片系列、iPadOS 14 沙漠/湖畔、iPadOS 13 WWDC19、iOS 11 地球/月球、iOS 9 火星/蓝花。
  - **Mac 17 张**：从 Leopard（10.5 极光）到 Tahoe（macOS 26）的每一代默认壁纸，包括 Mavericks 海浪、Snow Leopard 雪豹、Mojave、Big Sur、Sonoma、Sequoia 等；为控制体积，统一缩到 2560 像素宽。
- 均为官方原图（部分早期的是苹果的方形母版原图，未做裁剪；个别老壁纸是苹果专有 CgBI 格式 PNG，已无损转码）。
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
