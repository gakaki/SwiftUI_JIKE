//
//  ChatView.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text("聊天").fontWeight(.bold).padding(.leading, CGFloat(45.0))
                            Spacer()
                            Image("discovery_icon")
                                .padding(.horizontal, CGFloat(15.0))
                        }
                        .padding(.top, CGFloat(10.0))
                        Divider()
                    }

                    List {
                        Section(header: VStack {
                            ChatCell(item: ChatItem(id: 1000, imgName: "chat_box", title: "招呼", subTitle: "和XX等人的9999个招呼"))
                                .offset(x: CGFloat(0), y: 4)
                                .padding(.horizontal, 18)
                            Divider()
                                .offset(x: CGFloat(0), y: 3)
                        }
                        .frame(width: SCREENWIDTH, height: CGFloat(75), alignment: .leading)
                        .background(Color.white)
                        .offset(x: CGFloat(0), y: -6)) {
                            ForEach(DataMgr.shared.chatList, id: \.id) { item in
                                NavigationLink(destination: TestView()) {
                                    ChatCell(item: item)
                                }
                            }
                        }
                    }
                    .background(Color.white)
                    .padding(.top, CGFloat(-8.0))
                    .listStyle(GroupedListStyle())
                }
                .navigationBarTitle(Text("聊天"))
                .navigationBarHidden(true)
            }
        }
    }
}

#if DEBUG
    struct ChatView_Previews: PreviewProvider {
        static var previews: some View {
            ChatView()
        }
    }
#endif
