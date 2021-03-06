//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by Masahiko Sato on 2018/08/05.
//  Copyright © 2018年 sato. All rights reserved.
//

import Foundation

public class AppSettings {
    // MARK: - Keys
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
    
    // MARK: - Static Properties
    public static let shared = AppSettings()
    
    // MARK: - Instance Properties
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Instance Methods
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
    
    // MARK: - Object Lifecycle
    private init() { }
}

// MARK: - QuestionStrategyType
public enum QuestionStrategyType: Int {
    public static let allCaces: [QuestionStrategyType] = [.random, .sequential]
    
    case random, sequential
    
    // MARK: - Instance Methods
    public func title() -> String {
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        }
    }
    
    public func questionStrategy(
        for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        case .sequential:
            return SequentialQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        }
    }
}
