//
//  MangaListCellView.swift
//  Aidoku (iOS)
//
//  Created by Skitty on 12/22/21.
//

import SwiftUI
import Kingfisher

struct MangaListCell: View {
    
    @State var manga: Manga
    
    var body: some View {
        NavigationLink {
            MangaView(manga: manga)
        } label: {
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    KFImage(URL(string: manga.thumbnailURL ?? ""))
                        .resizable()
                        .frame(width: 2/3*120, height: 120)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.quaternaryFill, lineWidth: 1))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(manga.title ?? "Unknown Title")
                            .foregroundColor(.label)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
//                        Text(manga.author ?? "Unknown Author")
//                            .foregroundColor(.secondary)
//                            .multilineTextAlignment(.leading)
//                            .lineLimit(1)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.tertiaryFill)
                }
                .padding(.horizontal)
                Divider()
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading, 2/3*120)
                    .padding(.trailing)
            }
            .onAppear {
                Task {
                    if manga.thumbnailURL == nil {
                        manga = (try! await SourceManager.shared.source(for: manga.provider)?.getMangaDetails(manga: manga)) ?? manga
                    }
                }
            }
        }
    }
}
