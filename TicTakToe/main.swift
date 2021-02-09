
struct TicTakToe {
    
    var field = Array(repeating: Symbol.Nothing, count: 9)
    
        
    func indexForColumn(column: Int, andRow row: Int) -> Int {
        return (row * 3) + column
    }
    
    func indexIsValid(_ x: Int, _ y: Int) -> Bool{
        return 0...2 ~= x && 0...2 ~= y
    }
    
    func isGameOver() -> Bool {

        let sumFirstHorizont = field[0].rawValue + field[1].rawValue + field[2].rawValue
        let sumSecondHorizont = field[3].rawValue + field[4].rawValue + field[5].rawValue
        let sumThirtyHorizont = field[6].rawValue + field[7].rawValue + field[8].rawValue
        
//        print(sumFirstHorizont,sumSecondHorizont,sumThirtyHorizont)
        
        if sumFirstHorizont == 15 || sumSecondHorizont == 15 || sumThirtyHorizont == 15 {
            print("Победа ноликов по горизонтали")
            return true
        } else if sumFirstHorizont == 3 || sumSecondHorizont == 3 || sumThirtyHorizont == 3 {
            print("Победа крестиков по горизонтали")
            return true
        }
        
        let sumFirstVertical = field[0].rawValue + field[3].rawValue + field[6].rawValue
        let sumSecondVertical = field[1].rawValue + field[4].rawValue + field[7].rawValue
        let sumThirtyVertical = field[2].rawValue + field[5].rawValue + field[8].rawValue
        
//        print(sumFirstVertical, sumSecondVertical, sumThirtyVertical)
        
        if sumFirstVertical == 15 || sumSecondVertical == 15 || sumThirtyVertical == 15 {
            print("Победа ноликов по вертикали")
            return true
        } else if sumFirstVertical == 3 || sumSecondVertical == 3 || sumThirtyVertical == 3 {
            print("Победа крестиков по вертикали")
            return true
        }
        
        let sumMainDiagonal = field[0].rawValue + field[4].rawValue + field[8].rawValue
        let sumSecondDiagonal = field[2].rawValue + field[4].rawValue + field[6].rawValue
//        print(sumMainDiagonal, sumSecondDiagonal)
       
        if sumMainDiagonal == 15 || sumSecondDiagonal == 15 {
            print("Победа ноликов по диагонали")
            return true
        } else if sumMainDiagonal == 3 || sumSecondDiagonal == 3  {
            print("Победа крестиков по диагонали")
            return true
        }
        
        
        //field.filter({$0.rawValue == 0}).count
        
        let result = field.reduce(0) {$0 + $1.rawValue}
        
        if result == 25 {
            print("Ничья")
            return true
        }
        
       return false
    }
    
    subscript(x: Int , y: Int) -> Symbol? {
        get {
            if indexIsValid(x, y) {
                let index = indexForColumn(column: x, andRow: y)
                return field[index]
            }
            return nil
            
        }
        set {
            let index = indexForColumn(column: x, andRow: y)
            if indexIsValid(x, y) && field[index] == .Nothing {
                field[index] = newValue ?? .Nothing
            } else {
                print("Нельзя установить значение для x:\(x) y: \(y)")
            }
        }
    }
    
    
    func printField() {
        var printLine : String = ""
        print("   0   1   2")
        
        for index in 0..<field.count {
            
            if index % 3 == 0 {
                printLine += String(index / 3) + " "
            }
            
            switch field[index] {
            case .Cross:
                printLine += " \u{274c} "
            case .Zero:
                printLine += " \u{2b55} "
            default:
                printLine += " \u{3030} "
            }
            if (index + 1) % 3 == 0 {
                printLine += "\n"
            }
        }
    
        print("\(printLine) ")
    }
    
    
    enum Symbol : Int {
        case Nothing = 0
        case Cross = 1
        case Zero = 5
    }
}

var tictaktoe = TicTakToe()
tictaktoe.printField()


var step = TicTakToe.Symbol.Cross


while !tictaktoe.isGameOver() {
    print("Ход \(step == .Cross ? "Крестиков \u{274c}" : "Ноликов \u{2b55}" )")
    
    print("Выберите ряд:")
    let y = Int(readLine() ?? "") ?? -1
    print("Выберите колонку:")
    let x = Int(readLine() ?? "") ?? -1
    
    
    tictaktoe[x,y] = step
    step = step == .Cross ? .Zero : .Cross
    
    tictaktoe.printField()
}





