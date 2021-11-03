NAME		=	push_swap

# --   Directory   -- #
OBJ_DIR     =	objs

OBJ_SUB_DIR =	array\
moves_utils\
engine\
engine/execution\
engine/ft_eval\
insts_utils\
stack_utils\
utils\
errors\
save_utils\

OBJ_TO_CREATE = $(addprefix $(OBJ_DIR)/, $(OBJ_SUB_DIR))

INC_DIR		=	inc

# --  Search All files in SRCS  -- #
SRC_DIR = src
SRCSS =	src/moves_utils/ft_erase_moves.c\
src/moves_utils/ft_create_moves.c\
src/moves_utils/ft_erase_move.c\
src/main.c\
src/engine/execution/ft_moves_on_stacks.c\
src/engine/ft_generation.c\
src/engine/ft_small_sort.c\
src/engine/ft_eval/ft_test_a.c\
src/engine/ft_eval/ft_is_bad_move.c\
src/engine/ft_eval/ft_impossible_inst.c\
src/engine/ft_eval/ft_test_inst.c\
src/engine/ft_eval/ft_find_and_execute.c\
src/engine/ft_eval/ft_test_b.c\
src/engine/ft_exec.c\
src/engine/ft_tests.c\
src/insts_utils/ft_print_insts.c\
src/insts_utils/ft_create_insts.c\
src/stack_utils/ft_clear_stack.c\
src/stack_utils/ft_stack_and_tabs.c\
src/stack_utils/ft_push_stack.c\
src/stack_utils/ft_copy_stack.c\
src/stack_utils/ft_print_stack.c\
src/stack_utils/ft_stack_count.c\
src/array/ft_memmove.c\
src/array/len_stack.c\
src/array/ft_quicksort.c\
src/utils/ft_atol.c\
src/utils/ft_str.c\
src/utils/ft_swap.c\
src/errors/ft_error.c\
src/errors/ft_free.c\
src/save_utils/ft_save_push_front.c\
src/save_utils/ft_save_size.c\
src/save_utils/ft_print_save.c\


SRCS = $(SRCSS:src/%.c=%.c)


# --  Redirection in OBJS  -- #
OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:%.c=%.o))

CC			=	clang
CFLAGS      =   -Wall -Wextra -Werror
STACK = 99 98 97 96 95 94 93 92 91 90
# STACK += 89 88 87 86 85 84 83 82 81 80 79 78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0

all : header
	@mkdir -p $(OBJ_TO_CREATE)
	@make $(NAME) --no-print-directory



git :
	git add --all
	git commit
	git push

get_src:
		@find src -type f -name "*.c" | tr "\n" "|" | sed -r 's/["|"]+/\\ \n/g'

run: all
	./$(NAME) $(STACK)

leaks: all
	 valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --leak-resolution=high --show-reachable=yes --trace-children=yes --verbose --log-file=valgrind.log ./push_swap 10 9 8 7 6 5

get_dir:
		@find src -type d | tr "\n" "|" | sed -r 's/["|"]+/\\ \n/g' | sed -e 's/src\///g'

header :
	@Headermaker src inc/prototypes.h -inc structs define

$(NAME): $(OBJS)
	@$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@$(CC) $(CFLAGS) -o $@ -c $< -I $(INC_DIR)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re