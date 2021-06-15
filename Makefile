THEME_PATH := user/themes/afj

# We use git-subrepo to handle sub-trees
# and avoid the usual git submodules hiccups

.PHONY: subrepo-clean theme-pull theme-push user-pull user-push

subrepo-clean:
	git subrepo clean --ALL

user-pull: subrepo-clean
	git subrepo pull $(THEME_PATH)

user-push: subrepo-clean
	git subrepo push $(THEME_PATH)

theme-pull: subrepo-clean
	git subrepo pull $(THEME_PATH)

theme-push: subrepo-clean
	git subrepo push $(THEME_PATH)
