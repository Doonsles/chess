require "./chess_piece.rb"

class Pawn < ChessPiece
  #curently does not allow first move of two spaces for a pawn

  def is_legal?(old_pos, new_pos)
    return false if Board::off_board?(new_pos)
    is_legal_step?(old_pos, new_pos) || is_legal_capture?(old_pos, new_pos)
  end

  def is_legal_step?(old_pos, new_pos)
    #only move one forward
    if self.color == :white
      if new_pos[0] == old_pos[0] - 1 && new_pos[1] == old_pos[1]
        return true
      end
    else
      if new_pos[0] == old_pos[0] + 1 && new_pos[1] == old_pos[1]
        return true
      end
    end
    false
  end

  def is_legal_capture?(old_pos, new_pos)
    return false if @board.squares[new_pos[0]][new_pos[1]] == nil ||
     @board.squares[new_pos[0]][new_pos[1]].color == self.color

    if self.color == :white
      if (new_pos[0] == old_pos[0] - 1) &&
        (new_pos[1] == old_pos[1] - 1 || new_pos[1] == old_pos[1] + 1)
        return true
      end
    else
      if (new_pos[0] == old_pos[0] + 1) &&
        (new_pos[1] == old_pos[1] - 1 || new_pos[1] == old_pos[1] + 1)
        return true
      end
    end
    false
  end

  def possible_moves(loc)
    possible_moves = []
    if self.color == :white
      possible_moves << [loc[0]-1, loc[1]-1] if is_legal?(loc, [loc[0]-1, loc[1]-1])
      possible_moves << [loc[0]-1, loc[1]+1] if is_legal?(loc, [loc[0]-1, loc[1]+1])
    else # black marches down
      possible_moves << [loc[0]+1, loc[1]-1] if is_legal?(loc, [loc[0]+1, loc[1]-1])
      possible_moves << [loc[0]+1, loc[1]+1] if is_legal?(loc, [loc[0]+1, loc[1]+1])
    end
    possible_moves
  end
end