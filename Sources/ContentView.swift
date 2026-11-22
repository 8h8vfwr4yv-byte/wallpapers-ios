import SwiftUI
import Photos
import ImageIO

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

let wallpapers: [Wallpaper] = [
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

struct ContentView: View {
    @State private var selected: Wallpaper?

    private let columns = [GridItem(.adaptive(minimum: 108), spacing: 12)]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(wallpapers) { wp in
                        Button {
                            selected = wp
                        } label: {
                            VStack(spacing: 6) {
                                ThumbView(wallpaper: wp)
                                    .aspectRatio(9 / 16, contentMode: .fill)
                                    .frame(minHeight: 160)
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
            .navigationTitle("苹果官方壁纸")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Text("共 \(wallpapers.count) 张 · iOS 8 – iOS 17 官方原图")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .fullScreenCover(item: $selected) { start in
                DetailPager(start: start) {
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
    let start: Wallpaper
    let onClose: () -> Void
    @State private var index: Int
    @State private var saved = false
    @State private var saving = false

    init(start: Wallpaper, onClose: @escaping () -> Void) {
        self.start = start
        self.onClose = onClose
        _index = State(initialValue: wallpapers.firstIndex(of: start) ?? 0)
    }

    private var current: Wallpaper { wallpapers[index] }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            TabView(selection: $index) {
                ForEach(Array(wallpapers.enumerated()), id: \.element.id) { i, wp in
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
