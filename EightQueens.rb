class Box
    def initialize(x,y)
        @x = x
        @y = y
        @isQueen = false
    end

    def getx
        @x
    end

    def gety
        @y
    end

    def isQueen
        @isQueen
    end

    def yesQueen
        @isQueen = true
    end

    def notQueen
        @isQueen = false
    end

    def whatch
        if isQueen()
            print "[X]"
        else
            print "[ ]"
        end
    end

    def string
        print "[x:#{@x} - y:#{@y}]"
    end

    def horver(chessboard)
        res = false
        for i in 1...9
            if chessboard[@x][i].isQueen() || chessboard[i][@y].isQueen()
                res = true
            end
        end
        return res
    end

    def diagonals(chessboard)
        numx = @x
        numy = @y
        res = false
        while true
            if numx == 1 || numy == 1
                break
            end
            numx = numx - 1;
            numy = numy - 1;
        end
        for i in 1...9
            if chessboard[numx][numy].isQueen()
                res = true
            end    
            if numx == 8 || numy == 8
                break
            end
            numx = numx + 1
            numy = numy + 1
        end
        numx = @x
        numy = @y
        while true
            if numx == 8 || numy == 1
                break
            end
            numx = numx + 1
            numy = numy - 1
        end
        while true
            if chessboard[numx][numy].isQueen()
                res = true
                break
            end
            if numx == 1 || numy == 8
                break
            end
            numx = numx - 1
            numy = numy + 1
        end
        return res
    end

    def jacke(chessboard)
        res = false
        if horver(chessboard) || diagonals(chessboard)
            res = true
        end
        return res
    end
end

class ChessBoard
    def initialize()
        @chessboard = []
        complete()
        @queenlist = []
    end

    def complete()
        for i in 1...9
            res = []
            for j in 1...9
                res[j] = Box.new(i,j)
            end
            @chessboard[i] = res
        end
    end

    def whatch() 
        for i in 1...9
            for j in 1...9
                print get(i,j).whatch()
            end
            print "\n"
        end
    end

    def get(i,j)
        @chessboard[i][j]
    end

    def queens()
        i = 1
        conta = 0
        while i != 9
            j = 1
            aux = 0
            while j != 9
                if !get(i,j).jacke(@chessboard)
                    get(i,j).yesQueen()
                    @queenlist.push(get(i,j))
                    aux+= 1
                end
                j=j+1
            end
            if aux == 0
                i = i - 1
                right(@queenlist.last)
                i = @queenlist.size
            end
            conta+=1
            print "#{conta}-----------\n"
            i+=1
            whatch()
        end
    end

    def right(object)
        object.notQueen()
        @queenlist.pop()
        res = false
        for j in (object.gety()+1)...9
            if !get(object.getx(),j).jacke(@chessboard)
                get(object.getx(),j).yesQueen()
                @queenlist.push(get(object.getx(),j))
                res = true
            end
        end
        if res == false
            right(@queenlist.last)
        end    
    end    
end



chess = ChessBoard.new()
chess.queens()