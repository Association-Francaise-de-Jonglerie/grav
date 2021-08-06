USER_PATH := user
THEME_PATH := $(USER_PATH)/themes/afj

# We use git-subrepo to handle sub-trees
# and avoid the usual git submodules hiccups

.PHONY: subrepo-clean theme-pull theme-push user-pull user-push

subrepo-clean:
	git subrepo clean --ALL

user-pull:
	git subrepo pull $(USER_PATH)

user-push:
	git subrepo push $(USER_PATH)

theme-pull:
	git subrepo pull $(THEME_PATH)

theme-push:
	git subrepo push $(THEME_PATH)
