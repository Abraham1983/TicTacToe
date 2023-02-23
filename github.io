# Tic-Tac-Toe Game in Python

import random

def draw_board(board):
    print(board[0] + '|' + board[1] + '|' + board[2])
    print('-+-+-')
    print(board[3] + '|' + board[4] + '|' + board[5])
    print('-+-+-')
    print(board[6] + '|' + board[7] + '|' + board[8])

def input_player_letter():
    letter = ''
    while not (letter == 'X' or letter == 'O'):
        print("Do you want to be X or O?")
        letter = input().upper()
    if letter == 'X':
        return ['X', 'O']
    else:
        return ['O', 'X']

def who_goes_first():
    if random.randint(0, 1) == 0:
        return 'computer'
    else:
        return 'player'

def make_move(board, letter, move):
    board[move] = letter

def is_winner(board, letter):
    return ((board[0] == letter and board[1] == letter and board[2] == letter) or
            (board[3] == letter and board[4] == letter and board[5] == letter) or
            (board[6] == letter and board[7] == letter and board[8] == letter) or
            (board[0] == letter and board[3] == letter and board[6] == letter) or
            (board[1] == letter and board[4] == letter and board[7] == letter) or
            (board[2] == letter and board[5] == letter and board[8] == letter) or
            (board[0] == letter and board[4] == letter and board[8] == letter) or
            (board[2] == letter and board[4] == letter and board[6] == letter))

def get_board_copy(board):
    return [x for x in board]

def is_space_free(board, move):
    return board[move] == ' '

def get_player_move(board):
    move = ''
    while move not in '0 1 2 3 4 5 6 7 8'.split() or not is_space_free(board, int(move)):
        print("What is your next move? (0-8)")
        move = input()
    return int(move)

def choose_random_move_from_list(board, moves_list):
    possible_moves = []
    for i in moves_list:
        if is_space_free(board, i):
            possible_moves.append(i)
    if len(possible_moves) != 0:
        return random.choice(possible_moves)
    else:
        return None

def get_computer_move(board, computer_letter):
    if computer_letter == 'X':
        player_letter = 'O'
    else:
        player_letter = 'X'

    for i in range(0, 9):
        copy = get_board_copy(board)
        if is_space_free(copy, i):
            make_move(copy, computer_letter, i)
            if is_winner(copy, computer_letter):
                return i

    for i in range(0, 9):
        copy = get_board_copy(board)
        if is_space_free(copy, i):
            make_move(copy, player_letter, i)
            if is_winner(copy, player_letter):
                return i

    move = choose_random_move_from_list(board, [0, 2, 6, 8])
    
    if move != None:
        return move

    if is_space_free(board, 4):
        return 4

    return choose_random_move_from_list(board, [1, 3, 5, 7])

def is_board_full(board):
    for i in range(0, 9):
        if is_space_free(board, i):
            return False
    return True

# Main game loop
print('Welcome to Tic-Tac-Toe!')

while True:
    the_board = [' '] * 9
    player_letter, computer_letter = input_player_letter()
    turn = who_goes_first()
    print('The ' + turn + ' will go first.')
    game_is_playing = True

    while game_is_playing:
        if turn == 'player':
            draw_board(the_board)
            move = get_player_move(the_board)
            make_move(the_board, player_letter, move)

            if is_winner(the_board, player_letter):
                draw_board(the_board)
                print('Hooray! You have won the game!')
                game_is_playing = False
            else:
                if is_board_full(the_board):
                    draw_board(the_board)
                    print('The game is a tie!')
                    break
                else:
                    turn = 'computer'

        else:
            move = get_computer_move(the_board, computer_letter)
            make_move(the_board, computer_letter, move)

            if is_winner(the_board, computer_letter):
                draw_board(the_board)
                print('The computer has beaten you! You lose.')
                game_is_playing = False
            else:
                if is_board_full(the_board):
                    draw_board(the_board)
                    print('The game is a tie!')
                    break
                else:
                    turn = 'player'

    print('Do you want to play again? (yes or no)')
    if not input().lower().startswith('y'):
        break
