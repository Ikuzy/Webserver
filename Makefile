PURPLE    = \033[0;35m
BLUE      = \033[0;34m
GREEN     = \033[0;32m
RED       = \033[0;31m
YELLOW    = \033[0;33m
RESET     = \033[0m

NAME = WebServer

SRC = $(shell find . -maxdepth 1 -name "*.cpp")
OBJ = $(SRC:.cpp=.o)

CXX = c++ -std=c++98 -Wall -Wextra -Werror

all: $(NAME)

$(NAME): $(OBJ)
	@mkdir -p www/AI-Chat/chat_sessions www/Upload www/swp
	@$(MAKE) --no-print-directory -C www/AI-Chat/ all
	@echo "$(GREEN)🔧 Creating The WebServer...$(RESET)"
	@$(CXX) $(OBJ) -o $(NAME)

clean:
	@$(MAKE) --no-print-directory -C www/AI-Chat/ clean
	@echo "$(YELLOW)🧹 Cleaning All Object files...$(RESET)"
	@rm -rf $(OBJ)

fclean: clean
	@$(MAKE) --no-print-directory -C www/AI-Chat/ fclean
	@echo "$(RED)🧹 Cleaning Everything...$(RESET)"
	@rm -rf $(NAME)

re: fclean all

.PHONY: all clean fclean re
.SECONDARY: $(OBJ)