//
//  ReportView.swift
//  NanoChallengeMichelle
//
//  Created by Michelle Alexandra on 13/05/22.
//

import SwiftUI

struct ReportView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var reportListVM:ReportListViewModel
    
    @FetchRequest(entity: ReportList.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)]) var fetchedReportList:FetchedResults<ReportList>
    
    @State private var addView = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    
                    if fetchedReportList.isEmpty {
                        Image("emptyPie").resizable().aspectRatio(contentMode: .fit).frame(width: 300, height: 300)
                        Text("What are you waiting for?").font(.system(size: 17)).multilineTextAlignment(.center).foregroundColor(Color(.secondaryLabel)).padding()
                    }else{
                        MediumPieView(values: [Double(totalBiayaMakanan()), Double(totalBiayaService()), Double(totalBiayaPajak()),Double(totalDiskon())], colors: [Color("Red"), Color("Orange"), Color("Yellow"), Color("Green")], backgroundColor: .clear).frame(height: 360).padding()
                    }
                    
                    
                    
                    Text("Summary").bold().font(.system(size: 20)).padding()

                    HStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("Red"))
                            .frame(width: 15, height: 15).padding(.leading)
                        Text("Total Biaya Makanan").padding()
                        Spacer()
                        Text("\(Int(totalBiayaMakanan()))").padding().lineLimit(1).multilineTextAlignment(.leading)
                    }
                    HStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("Orange"))
                            .frame(width: 15, height: 15).padding(.leading)
                        Text("Total Biaya Service").padding()
                        Spacer()
                        Text("\(Int(totalBiayaService()))").padding().lineLimit(1).multilineTextAlignment(.leading)
                    }
                    HStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("Yellow"))
                            .frame(width: 15, height: 15).padding(.leading)
                        Text("Total Biaya Pajak").padding()
                        Spacer()
                        Text("\(Int(totalBiayaPajak()))").padding().lineLimit(1).multilineTextAlignment(.leading)
                    }
                    HStack{
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color("Green"))
                            .frame(width: 15, height: 15).padding(.leading)
                        Text("Total Discount").padding()
                        Spacer()
                        Text("\(Int(totalDiskon()))").padding().lineLimit(1).multilineTextAlignment(.leading)
                    }
                    
                    
                    .sheet(isPresented: $addView){
                        AddReportView(addView: $addView)
                    }
                    .toolbar{
                        Button(action: {
                            reportListVM.reportListjenisMakanan = ""
                            reportListVM.reportListNamaMakanan = ""
                            reportListVM.reportListBiayaMakanan = 0
                            reportListVM.reportListBiayaService = 0
                            reportListVM.reportListBiayaPajak = 0
                            reportListVM.reportListDiskon = 0
                            reportListVM.reportListNotes = ""
                            reportListVM.reportListItem = nil
                            addView.toggle()
                        }, label: {
                            Label("Add Item",systemImage: "plus")
                        })
                    }
                    .navigationTitle("Report")
                }
            }
        }
    }
    private func totalBiayaMakanan() -> Int32 {
            var ttlBiayaMakanan : Int32 = 0
            for item in fetchedReportList {
                ttlBiayaMakanan += item.biayaMakanan
            }
            print("Total Biaya Makanan: \(ttlBiayaMakanan)")
            return ttlBiayaMakanan
        }
    
    private func totalBiayaService() -> Int32{
        var ttlBiayaService : Int32 = 0
        for item in fetchedReportList {
            ttlBiayaService += item.biayaService
        }
        print("Total Biaya Service: \(ttlBiayaService)")
        return ttlBiayaService
    }
    private func totalBiayaPajak() -> Int32{
        var ttlBiayaPajak : Int32 = 0
        for item in fetchedReportList {
            ttlBiayaPajak += item.biayaPajak
        }
        print("Total Biaya Pajak: \(ttlBiayaPajak)")
        return ttlBiayaPajak
    }
    private func totalDiskon() -> Int32{
        var ttlDiskon : Int32 = 0
        for item in fetchedReportList {
            ttlDiskon += item.diskon
        }
        print("Total Diskon: \(ttlDiskon)")
        return ttlDiskon
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
