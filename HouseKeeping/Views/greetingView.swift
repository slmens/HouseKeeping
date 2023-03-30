//
//  greetingView.swift
//  HouseKeeping
//
//  Created by Selim Enes  Ağca on 29.03.2023.
//

import SwiftUI
import FirebaseAuth

struct greetingView: View {
    var body: some View {
        logIn()
    }
}














struct logIn:View{
    @State private var choosenPath = true
    @State private var email = ""
    @State private var password = ""
    @State private var alertTitle = ""
    @State private var alertShow = false
    @State private var alertMessage = ""
    @State private var customerShow = false
    var body: some View{
            VStack{
                Picker("Login", selection: $choosenPath) {
                    Text("Log In").tag(true)
                    Text("Sign In").tag(false)
                }
                .pickerStyle(.segmented)
                .padding()
                
                if choosenPath{
                    //login
                    TextField("Please enter your email", text: self.$email)
                        .textfieldUI()
                    TextField("Please enter your password", text: self.$password)
                        .textfieldUI()
                    Button {
                        userLogIn()
                    } label: {
                        Text("Submit")
                    }
                    
                    NavigationLink("a", destination: customerMainView().navigationBarBackButtonHidden(true), isActive: $customerShow)
                        .hidden()
                        
                    
                }else{
                    //signin
                    TextField("Please enter your email", text: self.$email)
                        .textfieldUI()
                    TextField("Please enter your password", text: self.$password)
                        .textfieldUI()
                    Button {
                        createUser()
                    } label: {
                        Text("Submit")
                    }
                    
                    NavigationLink("a", destination: customerMainView().navigationBarBackButtonHidden(true), isActive: $customerShow)
                        .hidden()
                        

                }
                
                Spacer()
                
                NavigationLink {
                    BringerCreatePage()
                } label: {
                    Text("Wanna be bringer?")
                }

            }
            .alert(alertTitle, isPresented: $alertShow) {
                Button("OK"){}
            }message: {
                Text(alertMessage)
            }
            .navigationTitle("House Keeping")
            
        }
        
    
    func createUser(){
        if email != "" && password != ""{
            Auth.auth().createUser(withEmail: email, password: password) { auth, error in
                if error != nil{
                    self.alertShow = true
                    self.alertTitle = "Can't create user"
                    self.alertMessage = error?.localizedDescription ?? "Try again"
                }else{
                    customerShow = true
                }
            }
        }
    }
    func userLogIn(){
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email, password: password) { auth, error in
                if error != nil{
                    self.alertShow = true
                    self.alertTitle = "Can't log in"
                    self.alertMessage = error?.localizedDescription ?? "Try again"
                }else{
                    print("success login")
                    customerShow = true
                }
            }
        }
        
    }
}

    
    
       




extension View{
    func textfieldUI() -> some View {
        self
            .padding()
            .background(Color(red: 0, green: 1, blue: 0, opacity: 0.15))
            .foregroundColor(.black)
            .cornerRadius(15)
            .padding(.horizontal)
    }
}

struct greetingView_Previews: PreviewProvider {
    static var previews: some View {
        greetingView()
    }
}
