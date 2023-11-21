//
//  ContentView.swift
//  Timer
//
//  Created by Samet Bugra Oktay on 22.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var timerValue: CGFloat = 1.0
    @State private var remainingTime: TimeInterval = 20.0
    let timerInterval: TimeInterval = 0.1
    @State private var isTimerRunning = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("Timer")
                .font(.largeTitle)
                .padding()

            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 10)
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0.0, to: timerValue)
                    .stroke(Color.blue, lineWidth: 10)
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 200, height: 200)

                Text(String(format: "%.0f", remainingTime))
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }

            HStack(spacing: 20) {
                Button(action: {
                    startTimer()
                }) {
                    Text("Start")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }

                Button(action: {
                    pauseTimer()
                }) {
                    Text("Pause")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(10)
                }

                Button(action: {
                    resetTimer()
                }) {
                    Text("Reset")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
    }

    private func startTimer() {
        guard !isTimerRunning else { return }
        isTimerRunning = true

        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation {
                timerValue -= CGFloat(timerInterval / remainingTime)
                remainingTime -= timerInterval

                if remainingTime <= 0 {
                    resetTimer()
                }
            }
        }
    }

    private func pauseTimer() {
        guard isTimerRunning else { return }
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func resetTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        timerValue = 1.0
        remainingTime = 20.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
