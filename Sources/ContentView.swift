import SwiftUI
import Photos
import ImageIO

enum WallpaperCategory: String, CaseIterable, Identifiable {
    case phone = "手机"
    case ipad = "iPad"
    case mac = "Mac"
    var id: String { rawValue }

    var cellAspect: CGFloat {
        switch self {
        case .phone: return 9.0 / 16.0
        case .ipad: return 1.0
        case .mac: return 16.0 / 10.0
        }
    }

    var minCellWidth: CGFloat {
        switch self {
        case .phone: return 108
        case .ipad: return 128
        case .mac: return 158
        }
    }
}

struct Wallpaper: Identifiable, Hashable {
    let file: String
    let title: String
    var id: String { file }

    var url: URL? {
        Bundle.main.url(forResource: file, withExtension: "jpg")
            ?? Bundle.main.url(forResource: file, withExtension: "jpg", subdirectory: "Wallpapers")
    }

    func fullImage() -> UIImage? {
        guard let url else { return nil }
        return UIImage(contentsOfFile: url.path)
    }

    func thumbnail(maxPixel: Int = 480) -> UIImage? {
        guard let url,
              let src = CGImageSourceCreateWithURL(url as CFURL, nil) else { return nil }
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel,
            kCGImageSourceCreateThumbnailWithTransform: true
        ]
        guard let cg = CGImageSourceCreateThumbnailAtIndex(src, 0, options as CFDictionary) else { return nil }
        return UIImage(cgImage: cg)
    }
}

let phoneWallpapers: [Wallpaper] = [
    Wallpaper(file: "ios17_light", title: "iOS 17 · 浅色"),
    Wallpaper(file: "ios17_dark", title: "iOS 17 · 深色"),
    Wallpaper(file: "ios17_titanium_natural", title: "15 Pro · 原色钛"),
    Wallpaper(file: "ios17_titanium_blue", title: "15 Pro · 蓝钛"),
    Wallpaper(file: "ios17_titanium_black", title: "15 Pro · 黑钛"),
    Wallpaper(file: "ios17_sea_glass_blue", title: "iPhone 15 · 蓝"),
    Wallpaper(file: "ios17_sea_glass_green", title: "iPhone 15 · 绿"),
    Wallpaper(file: "ios16_clownfish", title: "iOS 16 · 小丑鱼"),
    Wallpaper(file: "ios16_wwdc22", title: "iOS 16 · WWDC22"),
    Wallpaper(file: "ios16_deep_purple", title: "14 Pro · 暗紫"),
    Wallpaper(file: "ios16_space_black", title: "14 Pro · 深空黑"),
    Wallpaper(file: "ios16_midnight", title: "iPhone 14 · 午夜"),
    Wallpaper(file: "ios16_yellow", title: "iPhone 14 · 黄色"),
    Wallpaper(file: "ios14_desert_peak_day", title: "iOS 14 · 沙漠昼"),
    Wallpaper(file: "ios14_desert_peak_night", title: "iOS 14 · 沙漠夜"),
    Wallpaper(file: "ios14_lake_day", title: "iOS 14 · 湖畔昼"),
    Wallpaper(file: "ios14_lake_night", title: "iOS 14 · 湖畔夜"),
    Wallpaper(file: "ios13_wwdc19_light", title: "iOS 13 · WWDC19 浅"),
    Wallpaper(file: "ios13_wwdc19_dark", title: "iOS 13 · WWDC19 深"),
    Wallpaper(file: "ios12_earth", title: "iOS 12 · 地球"),
    Wallpaper(file: "ios12_moon", title: "iOS 12 · 月球"),
    Wallpaper(file: "ios12_beach", title: "iOS 12 · 海滩"),
    Wallpaper(file: "ios12_wwdc18", title: "iOS 12 · WWDC18"),
    Wallpaper(file: "ios10_droplet_blue", title: "iOS 10 · 水滴蓝"),
    Wallpaper(file: "ios10_droplet_red", title: "iOS 10 · 水滴红"),
    Wallpaper(file: "ios9_mars", title: "iOS 9 · 火星"),
    Wallpaper(file: "ios9_feathers", title: "iOS 9 · 羽毛"),
    Wallpaper(file: "ios9_jupiter", title: "iOS 9 · 木星"),
    Wallpaper(file: "ios8_mountain_stars", title: "iOS 8 · 山与星"),
    Wallpaper(file: "ios8_earth", title: "iOS 8 · 地球")
]

let ipadWallpapers: [Wallpaper] = [
    Wallpaper(file: "ipad17_light", title: "iPadOS 17 · 浅色"),
    Wallpaper(file: "ipad17_dark", title: "iPadOS 17 · 深色"),
    Wallpaper(file: "ipad17_lake", title: "iPadOS 17 · 湖"),
    Wallpaper(file: "ipad16_wwdc22", title: "iPadOS 16 · WWDC22"),
    Wallpaper(file: "ipad16_lens_blue", title: "iPadOS 16 · 镜片蓝"),
    Wallpaper(file: "ipad16_lens_magenta", title: "iPadOS 16 · 镜片品红"),
    Wallpaper(file: "ipad14_desert_peak", title: "iPadOS 14 · 沙漠"),
    Wallpaper(file: "ipad14_lake", title: "iPadOS 14 · 湖畔"),
    Wallpaper(file: "ipad13_wwdc19_light", title: "iPadOS 13 · WWDC19 浅"),
    Wallpaper(file: "ipad13_wwdc19_dark", title: "iPadOS 13 · WWDC19 深"),
    Wallpaper(file: "ipad11_earth", title: "iOS 11 · 地球"),
    Wallpaper(file: "ipad11_moon", title: "iOS 11 · 月球"),
    Wallpaper(file: "ipad9_mars", title: "iOS 9 · 火星"),
    Wallpaper(file: "ipad9_flower_blue", title: "iOS 9 · 蓝花")
]

let macWallpapers: [Wallpaper] = [
    Wallpaper(file: "mac_tahoe", title: "Tahoe · macOS 26"),
    Wallpaper(file: "mac_sequoia", title: "Sequoia · macOS 15"),
    Wallpaper(file: "mac_sonoma", title: "Sonoma · macOS 14"),
    Wallpaper(file: "mac_ventura", title: "Ventura · macOS 13"),
    Wallpaper(file: "mac_monterey", title: "Monterey · macOS 12"),
    Wallpaper(file: "mac_bigsur", title: "Big Sur · macOS 11"),
    Wallpaper(file: "mac_catalina", title: "Catalina · 10.15"),
    Wallpaper(file: "mac_mojave_day", title: "Mojave · 10.14"),
    Wallpaper(file: "mac_highsierra", title: "High Sierra · 10.13"),
    Wallpaper(file: "mac_sierra", title: "Sierra · 10.12"),
    Wallpaper(file: "mac_elcapitan", title: "El Capitan · 10.11"),
    Wallpaper(file: "mac_yosemite", title: "Yosemite · 10.10"),
    Wallpaper(file: "mac_mavericks", title: "Mavericks · 海浪 10.9"),
    Wallpaper(file: "mac_mountainlion", title: "Mountain Lion · 10.8"),
    Wallpaper(file: "mac_lion", title: "Lion · 星云 10.7"),
    Wallpaper(file: "mac_snowleopard", title: "Snow Leopard · 雪豹 10.6"),
    Wallpaper(file: "mac_leopard", title: "Leopard · 极光 10.5")
]

func wallpapers(for category: WallpaperCategory) -> [Wallpaper] {
    switch category {
    case .phone: return phoneWallpapers
    case .ipad: return ipadWallpapers
    case .mac: return macWallpapers
    }
}

struct ContentView: View {
    @State private var category: WallpaperCategory = .phone
    @State private var selected: Wallpaper?

    private var list: [Wallpaper] { wallpapers(for: category) }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("分类", selection: $category) {
                    ForEach(WallpaperCategory.allCases) { c in
                        Text(c.rawValue).tag(c)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: category.minCellWidth), spacing: 12)], spacing: 16) {
                        ForEach(list) { wp in
                            Button {
                                selected = wp
                            } label: {
                                VStack(spacing: 6) {
                                    ThumbView(wallpaper: wp)
                                        .aspectRatio(category.cellAspect, contentMode: .fill)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    Text(wp.title)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("苹果官方壁纸")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Text("\(category.rawValue) · 共 \(list.count) 张官方原图")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .fullScreenCover(item: $selected) { start in
                DetailPager(list: list, start: start) {
                    selected = nil
                }
            }
        }
    }
}

struct ThumbView: View {
    let wallpaper: Wallpaper
    @State private var image: UIImage?

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.12)
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .task {
            if image == nil {
                image = await Task.detached(priority: .utility) {
                    wallpaper.thumbnail()
                }.value
            }
        }
    }
}

struct DetailPager: View {
    let list: [Wallpaper]
    let start: Wallpaper
    let onClose: () -> Void
    @State private var index: Int
    @State private var saved = false
    @State private var saving = false

    init(list: [Wallpaper], start: Wallpaper, onClose: @escaping () -> Void) {
        self.list = list
        self.start = start
        self.onClose = onClose
        _index = State(initialValue: list.firstIndex(of: start) ?? 0)
    }

    private var current: Wallpaper { list[index] }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            TabView(selection: $index) {
                ForEach(Array(list.enumerated()), id: \.element.id) { i, wp in
                    FullImageView(wallpaper: wp)
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onChange(of: index) { _, _ in saved = false }

            VStack {
                HStack {
                    Spacer()
                    Button {
                        onClose()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.subheadline.weight(.bold))
                            .padding(10)
                    }
                    .buttonStyle(.glass)
                    .clipShape(Circle())
                }
                .padding()

                Spacer()

                VStack(spacing: 12) {
                    Text(current.title)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .shadow(radius: 4)

                    HStack(spacing: 12) {
                        if let url = current.url {
                            ShareLink(item: url) {
                                Label("分享", systemImage: "square.and.arrow.up")
                            }
                            .buttonStyle(.glass)
                        }

                        Button {
                            save()
                        } label: {
                            if saved {
                                Label("已存入相册", systemImage: "checkmark")
                            } else if saving {
                                Label("保存中…", systemImage: "hourglass")
                            } else {
                                Label("保存到相册", systemImage: "square.and.arrow.down")
                            }
                        }
                        .buttonStyle(.glassProminent)
                        .disabled(saving || saved)
                    }
                    .padding(.bottom, 8)

                    Text("保存后到相册打开图片 → 分享 → 用作墙纸，即可设为锁屏/主屏幕")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 20)
                }
            }
        }
    }

    private func save() {
        guard let image = current.fullImage() else { return }
        saving = true
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            guard status == .authorized || status == .limited else {
                DispatchQueue.main.async { saving = false }
                return
            }
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            } completionHandler: { success, _ in
                DispatchQueue.main.async {
                    saving = false
                    saved = success
                }
            }
        }
    }
}

struct FullImageView: View {
    let wallpaper: Wallpaper
    @State private var image: UIImage?

    var body: some View {
        ZStack {
            Color.black
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .tint(.white)
            }
        }
        .task {
            if image == nil {
                image = await Task.detached(priority: .userInitiated) {
                    wallpaper.fullImage()
                }.value
            }
        }
    }
}
