import mysql.connector
import math

def fetch_data(cursor, query, params=None):
    try:
        cursor.execute(query, params)
        result = cursor.fetchall()
        return result
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        exit()

def display_moves(pokemon, moves_dict):
    print(f"\nAvailable moves for {pokemon}:")
    for i, move in enumerate(moves_dict.keys(), 1):
        print(f"{i}. {move}")

def calculate_damage(move, category, atk, def_, spatk, spdef):
    if category == 'physical':
        return (move['powerr'] * atk) / def_
    elif category == 'special':
        return (move['powerr'] * spatk) / spdef
    else:
        print("Invalid move category.")
        exit()

def get_type_multiplier(cursor, attacking_type, defending_first_type, defending_second_type,atk_first_type, atk_second_type):
    query = "SELECT {} FROM typemultiplier WHERE attackingtype = %s".format(defending_first_type.lower())
    result_first_type = fetch_data(cursor, query, (attacking_type,))
    
    query = "SELECT {} FROM typemultiplier WHERE attackingtype = %s".format(defending_second_type.lower())
    result_second_type = fetch_data(cursor, query, (attacking_type,))

    # if result_first_type and result_second_type:
    #     return result_first_type[0][0] * result_second_type[0][0]
    # elif result_first_type:
    #     return result_first_type[0][0]
    # elif result_second_type:
    #     return result_second_type[0][0]
    # else:
    #     return 1.0  # Default multiplier if no type effectiveness is found

    if result_first_type and result_second_type:
        type_multiplier = result_first_type[0][0] * result_second_type[0][0]
    elif result_first_type:
        type_multiplier = result_first_type[0][0]
    elif result_second_type:
        type_multiplier = result_second_type[0][0]
    else:
        type_multiplier = 1.0  # Default multiplier if no type effectiveness is found

    # Check for Same Type Attack Bonus (STAB)
    if attacking_type == atk_first_type or attacking_type == atk_second_type:
        type_multiplier *= 1.5

    return type_multiplier

try:
    connection = mysql.connector.connect(
        host="localhost",
        user="root",
        password="lessgoo25",
        database="deep"
    )
    cursor = connection.cursor(buffered=True)

    # Player 1
    #print("\nPlayer 1:")
    '''available_teams = ['trying1', 'testing2']
    chosen_team_player1 = input(f"Player 1, choose a team ({', '.join(available_teams)}): ").lower()
    if chosen_team_player1 not in available_teams:
        print("Invalid team choice.")
        exit()'''
    #chosen_team_player1 ='trying3'
    flag=0
    # Player 1 chooses a Pokémon
    team_table_name_player1 = "currentteam1"
    cursor.execute(f"SELECT DISTINCT namee FROM Pokemonlist WHERE namee IN (SELECT pokemon FROM {team_table_name_player1})")
    result_player1 = cursor.fetchall()
    if result_player1:
        available_pokemon_player1 = [row[0] for row in result_player1]
    else:
        print(f"No Pokémon found in the team.")
        exit()

    chosen_pokemon_player1 = input(f"Player 1, choose a Pokémon ({', '.join(available_pokemon_player1)}): ").lower()
    print("\n")

    # Player 2
    '''
    print("\nPlayer 2:")
    chosen_team_player2 = input(f"Player 2, choose a team ({', '.join(available_teams)}): ").lower()
    if chosen_team_player2 not in available_teams:
        print("Invalid team choice.")
        exit()'''
    #chosen_team_player2='testing2'

    # Player 2 chooses a Pokémon
    team_table_name_player2 = "currentteam2"
    cursor.execute(f"SELECT DISTINCT namee FROM Pokemonlist WHERE namee IN (SELECT pokemon FROM {team_table_name_player2})")
    result_player2 = cursor.fetchall()
    if result_player2:
        available_pokemon_player2 = [row[0] for row in result_player2]
    else:
        print(f"No Pokémon found in the team.")
        exit()

    chosen_pokemon_player2 = input(f"Player 2, choose a Pokémon ({', '.join(available_pokemon_player2)}): ").lower()
    print("\n")

    while(flag==0):


        # Player 1 chooses moves
        cursor.execute(f"SELECT movename, powerr, category, typee FROM Moves WHERE movename IN (SELECT move1 FROM {team_table_name_player1} WHERE pokemon = '{chosen_pokemon_player1}' UNION SELECT move2 FROM {team_table_name_player1} WHERE pokemon = '{chosen_pokemon_player1}' UNION SELECT move3 FROM {team_table_name_player1} WHERE pokemon = '{chosen_pokemon_player1}' UNION SELECT move4 FROM {team_table_name_player1} WHERE pokemon = '{chosen_pokemon_player1}')")
        result_player1 = cursor.fetchall()
        if result_player1:
            moves_dict_player1 = {row[0]: {'powerr': row[1], 'category': row[2], 'typee': row[3]} for row in result_player1}
        else:
            print(f"No moves found for {chosen_pokemon_player1} in the team.")
            exit()

        # Display available moves for Player 1
        print("Player 1:")
        display_moves(chosen_pokemon_player1, moves_dict_player1)

        # Player 1 chooses a move
        chosen_move_index_player1 = int(input("Player 1, choose a move (1-4): ")) - 1
        chosen_move_player1 = list(moves_dict_player1.keys())[chosen_move_index_player1]
        print("\n")

        

        

        # Player 2 chooses moves
        cursor.execute(f"SELECT movename, powerr, category, typee FROM Moves WHERE movename IN (SELECT move1 FROM {team_table_name_player2} WHERE pokemon = '{chosen_pokemon_player2}' UNION SELECT move2 FROM {team_table_name_player2} WHERE pokemon = '{chosen_pokemon_player2}' UNION SELECT move3 FROM {team_table_name_player2} WHERE pokemon = '{chosen_pokemon_player2}' UNION SELECT move4 FROM {team_table_name_player2} WHERE pokemon = '{chosen_pokemon_player2}')")
        result_player2 = cursor.fetchall()
        if result_player2:
            moves_dict_player2 = {row[0]: {'powerr': row[1], 'category': row[2], 'typee': row[3]} for row in result_player2}
        else:
            print(f"No moves found for {chosen_pokemon_player2} in the team.")
            exit()

        # Display available moves for Player 2
        print("Player 2:")
        display_moves(chosen_pokemon_player2, moves_dict_player2)

        # Player 2 chooses a move
        chosen_move_index_player2 = int(input("Player 2, choose a move (1-4): ")) - 1
        chosen_move_player2 = list(moves_dict_player2.keys())[chosen_move_index_player2]

        # Print chosen moves for both players
        print("\nChosen moves:")
        print(f"Player 1 - {chosen_pokemon_player1}: {chosen_move_player1}")
        print(f"Player 2 - {chosen_pokemon_player2}: {chosen_move_player2}")

        # Fetch Pokémon stats for damage calculation
        stats_query_player1 = f"SELECT atk, def, spatk, spdef, firsttype, secondtype FROM Pokemonlist WHERE namee = '{chosen_pokemon_player1}'"
        stats_query_player2 = f"SELECT atk, def, spatk, spdef, firsttype, secondtype FROM Pokemonlist WHERE namee = '{chosen_pokemon_player2}'"

        stats_player1 = fetch_data(cursor, stats_query_player1)
        stats_player2 = fetch_data(cursor, stats_query_player2)

        #health1=cursor.execute(f"SELECT health FROM currentteam1 WHERE pokemon='{chosen_pokemon_player1}'")
        #health2=cursor.execute(f"SELECT health FROM currentteam2 WHERE pokemon='{chosen_pokemon_player2}'")

        health1=fetch_data(cursor,f"SELECT health FROM currentteam1 WHERE pokemon='{chosen_pokemon_player1}'")
        health2=fetch_data(cursor,f"SELECT health FROM currentteam2 WHERE pokemon='{chosen_pokemon_player2}'")

        #print("trying to print health")
        # health1=str(health1)
        # health1=health1[2:-3]
        #health1=int(health1)
        health1 = health1[0][0]
        health2=health2[0][0]
        

        if not stats_player1 or not stats_player2:
            print(f"No stats found for {chosen_pokemon_player1} or {chosen_pokemon_player2}.")
            exit()

        atk_player1, def_player1, spatk_player1, spdef_player1, first_type_player1, second_type_player1 = stats_player1[0]
        atk_player2, def_player2, spatk_player2, spdef_player2, first_type_player2, second_type_player2 = stats_player2[0]

        # Calculate damage for both players
        type_multiplier_player1 = get_type_multiplier(cursor, moves_dict_player1[chosen_move_player1]['typee'], first_type_player2, second_type_player2,first_type_player1, second_type_player1)
        type_multiplier_player2 = get_type_multiplier(cursor, moves_dict_player2[chosen_move_player2]['typee'], first_type_player1, second_type_player1,first_type_player2, second_type_player2)

        print(type_multiplier_player1)
        print(type_multiplier_player2)

        damage_player1 = math.floor(calculate_damage(moves_dict_player1[chosen_move_player1], moves_dict_player1[chosen_move_player1]['category'], atk_player1, def_player2, spatk_player1, spdef_player2) * type_multiplier_player1)
        damage_player2 = math.floor(calculate_damage(moves_dict_player2[chosen_move_player2], moves_dict_player2[chosen_move_player2]['category'], atk_player2, def_player1, spatk_player2, spdef_player1) * type_multiplier_player2)

        print("\nDamage calculation:")
        print(f"Player 1 deals {damage_player1} damage to Player 2's {chosen_pokemon_player2}")
        print(f"Player 2 deals {damage_player2} damage to Player 1's {chosen_pokemon_player1}\n")

        health1=health1-damage_player2
        health2=health2-damage_player1

        if (health1<0):
            health1=0
        
        if(health2<0):
            health2=0

        print(f"Remaining health of {chosen_pokemon_player1} is {health1}")
        print(f"Remaining health of {chosen_pokemon_player2} is {health2}\n")
        cursor.execute(f"UPDATE currentteam1 SET health={health1} WHERE currentteam1.pokemon='{chosen_pokemon_player1}';")
        cursor.execute(f"UPDATE currentteam2 SET health={health2} WHERE currentteam2.pokemon='{chosen_pokemon_player2}';")

        if(health1<=0):
            print(f"{chosen_pokemon_player1} has fainted!")
            cursor.execute(f"DELETE FROM currentteam1 WHERE pokemon='{chosen_pokemon_player1}';")
            
            cursor.execute(f"SELECT DISTINCT namee FROM Pokemonlist WHERE namee IN (SELECT pokemon FROM {team_table_name_player1})")
            result_player1 = cursor.fetchall()
            if result_player1:
                available_pokemon_player1 = [row[0] for row in result_player1]

                chosen_pokemon_player1 = input(f"Player 1, choose your next Pokémon ({', '.join(available_pokemon_player1)}): ").lower()
                print("\n")

            else:
                print(f"No Pokémon found in the team.")
                flag=2

            
            
            #cursor.execute(f"DELETE FROM currentteam1;")

        if(health2<=0):
            print(f"{chosen_pokemon_player2} has fainted!")
            cursor.execute(f"DELETE FROM currentteam2 WHERE pokemon='{chosen_pokemon_player2}';")

            cursor.execute(f"SELECT DISTINCT namee FROM Pokemonlist WHERE namee IN (SELECT pokemon FROM {team_table_name_player2})")
            result_player2 = cursor.fetchall()
            if result_player2:
                available_pokemon_player2 = [row[0] for row in result_player2]


                chosen_pokemon_player2 = input(f"Player 2, choose your next Pokémon ({', '.join(available_pokemon_player2)}): ").lower()
                print("\n")

            else:
                print(f"No Pokémon found in the team.")
                flag=1

            
            
            #cursor.execute(f"DELETE FROM currentteam2;")


        cursor.execute(f"SELECT pokemon FROM {team_table_name_player2}")
        newdb = cursor.fetchall()
        if(newdb==[]):
            flag=1

        cursor.execute(f"SELECT pokemon FROM {team_table_name_player1}")
        newdb = cursor.fetchall()
        if(flag==1 and newdb==[]):
            flag=3
        elif(newdb==[]):
            flag=2
        
        if(flag!=0):
            if(flag==3):
                print("The match was a draw")
            elif(flag==1 or flag==2):
                print("\nTHE WINNER IS PLAYER",flag)
            print("Game Over")
            exit(0)

finally:
    cursor.close()
    connection.close()
