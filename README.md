# Site de l'association Française de Jonglerie

## Pour les éditeurs

Il suffit de se connecter à [l'interface d'administration du
site](https://afj.trevien.ovh/admin) puis d'utiliser l'interface graphique pour
modifier les contenus et la configuration.

Les modifications seront automatiquement sauvegardées dans le dépôt git
@team-afj/user.

N'hésitez pas à [ouvrir une issue](https://github.com/team-afj/grav/issues) ou
signaler sur Slack lorsque vous rencontrez un problème ou si une fonctionnalité
manque comme par exemple la possibilité d'ajouter un bouton dans une page.

## Pour les développeurs

Le dépôt @team-afj/grav est le seul avec lequel les contributeurs ont besoin
d'intéragir. Il contient le dossier `user` et le thème qui sont intégrés de
manière transparente avec des git subtrees.

### Organisation des dépôts
- @team-afj/grav-theme-afj contient le code du thème. Il s'agit d'un fork du
  thème par défaut de grav, Duark (@getgrav/quark).

- @team-afj/grav-user correspond au dossier `user` d'une installation de Grav. Ce
  dossier est automatiquement synchronisé avec le dossier `user` du site en
  production (voir section sur `git-sync`). Le thème @team-afj/grav-theme-afj
  est inclus dans le dossier `themes` de ce dépôt (sous la forme d'un *git
  subtree*).

- @team-afj/grav est le camp de base pour les développeurs. Il s'agit d'un fork
  de @getgrav/grav qui inclut, sous la forme d'un git subtree, le dépôt
  @team-afj/grav-user (et donc également le thème).

### Développement local avec `ddev`

Le moyen le plus simple de développer localement d'utiliser l'outil
`ddev` qui se charge de lancer un serveur dans un containeur docker.

- Installez `ddev` en suivant [les instructions du site
  officiel](https://ddev.readthedocs.io/en/latest/)
- Executez `ddev start` depuis le répertoire racine du dépot git

Plus d'infos dans la [doc de Grav](https://learn.getgrav.org/17/webservers-hosting/local-development-with-ddev).

### Le Thème Afj

Dans le dossier `user/themes/afj` et synchronisé (de temps en temps) vers
@team-afj/grav-theme-afj.

Il s'agit d'un fork du thème de base Quark de Grav. J'ai décidé d'utiliser le
même framework CSS qu'eux: https://picturepan2.github.io/spectre/

Les styles sont écris en `scss` dans le dossier du même nom. La commande `yarn
build` permet de les compiler, et `yarn dev` de faire de même automatiquement.

### Le plugin Event-list

Dans le dossier `user/plugin/event-list`, pour l'instant il n'a pas sont propre
sous-repo.

Il permet d'afficher une liste d'évènements à venir à partir d'un fichier ICAL.
Il nécéssite un peu de nettoyage / linting et il manque la possibilité de
synchroniser automatiquement le fichier ICAL.

### git subrepo

Afin d'éviter les nombreux pièges liés aux *git submodules*, l'imbrication des
dépôts est faite à l'aide de l'outil [git
subrepo](https://github.com/ingydotnet/git-subrepo) (qui lui même utilise les
*subtree* de git).

Pour les développeurs travaillant sur @team-afj/grav cela est complètement transparent !
### git-sync

Le plugin officiel de Grav `git-sync` permet de maintenir la synchronisation
dans les deux sens entre le contenu du dépôt @team-afj/user avec les
modifications faites dans l'interface d'administration.

Pour des raisons de sécurité la configuration de ce plugin n'est *pas*
synchronisée automatiquement (elle contient des identifiants GitHub) et doit
donc être *attentivement* re-faite lors d'une nouvelle installation de Grav.

Il faut *surtout ne pas utiliser l'assistant de configuration "Wizard"* qui se
lance lors de l'installation du plugin car il ne permet pas de configurer toutes
les options avant la première synchronisation. Il faut "Annuler"/"Cancel" le
wizard puis rentrer manuellement la configuration complète (le .gitignore étant
particulièrement important pour éviter que des fichiers de configuration
sensibles ne soient uploadés sur le dépôt public).

Voici la liste des options de configuration a utiliser avant la première
synchronisation:
- `Hosting`: Github
- `Git User`: Jonglobot
- `Git Password or token`: `<jonglobot's personnal token>`
- `Git repository`: https://github.com/team-afj/grav-user.git
- `Repository branch`: main
- `Web hook`: /_git-sync-03a024a935ff
- `Use webhook secret`: `<the webhook secret>`
- `What to synchronize`: Pages, Themes, Plugins and Config
- `gitignore`:
   ```
   security.yaml
   git-sync.yaml
   versions.yaml
   !.gitignore
   !.gitkeep
   ```



Ci-dessous, le README de Grav.


# ![](https://avatars1.githubusercontent.com/u/8237355?v=2&s=50) Grav

[![PHPStan](https://img.shields.io/badge/PHPStan-enabled-brightgreen.svg?style=flat)](https://github.com/phpstan/phpstan)
[![SensioLabsInsight](https://insight.sensiolabs.com/projects/cfd20465-d0f8-4a0a-8444-467f5b5f16ad/mini.png)](https://insight.sensiolabs.com/projects/cfd20465-d0f8-4a0a-8444-467f5b5f16ad)
[![Discord](https://img.shields.io/discord/501836936584101899.svg?logo=discord&colorB=728ADA&label=Discord%20Chat)](https://chat.getgrav.org)
 [![PHP Tests](https://github.com/getgrav/grav/workflows/PHP%20Tests/badge.svg?branch=develop)](https://github.com/getgrav/grav/actions?query=workflow%3A%22PHP+Tests%22) [![OpenCollective](https://opencollective.com/grav/backers/badge.svg)](#backers) [![OpenCollective](https://opencollective.com/grav/sponsors/badge.svg)](#sponsors)

Grav is a **Fast**, **Simple**, and **Flexible**, file-based Web-platform.  There is **Zero** installation required.  Just extract the ZIP archive, and you are already up and running.  It follows similar principles to other flat-file CMS platforms, but has a different design philosophy than most. Grav comes with a powerful **Package Management System** to allow for simple installation and upgrading of plugins and themes, as well as simple updating of Grav itself.

The underlying architecture of Grav is designed to use well-established and _best-in-class_ technologies to ensure that Grav is simple to use and easy to extend. Some of these key technologies include:

* [Twig Templating](https://twig.sensiolabs.org/): for powerful control of the user interface
* [Markdown](https://en.wikipedia.org/wiki/Markdown): for easy content creation
* [YAML](https://yaml.org): for simple configuration
* [Parsedown](https://parsedown.org/): for fast Markdown and Markdown Extra support
* [Doctrine Cache](https://www.doctrine-project.org/projects/doctrine-orm/en/latest/reference/caching.html): layer for performance
* [Pimple Dependency Injection Container](https://pimple.sensiolabs.org/): for extensibility and maintainability
* [Symfony Event Dispatcher](https://symfony.com/doc/current/components/event_dispatcher/introduction.html): for plugin event handling
* [Symfony Console](https://symfony.com/doc/current/components/console/introduction.html): for CLI interface
* [Gregwar Image Library](https://github.com/Gregwar/Image): for dynamic image manipulation

# Requirements

- PHP 7.3.6 or higher. Check the [required modules list](https://learn.getgrav.org/basics/requirements#php-requirements)
- Check the [Apache](https://learn.getgrav.org/basics/requirements#apache-requirements) or [IIS](https://learn.getgrav.org/basics/requirements#iis-requirements) requirements

# Documentation

The full documentation can be found from [learn.getgrav.org](https://learn.getgrav.org).

# QuickStart

These are the options to get Grav:

### Downloading a Grav Package

You can download a **ready-built** package from the [Downloads page on https://getgrav.org](https://getgrav.org/downloads)

### With Composer

You can create a new project with the latest **stable** Grav release with the following command:

```
$ composer create-project getgrav/grav ~/webroot/grav
```

### From GitHub

1. Clone the Grav repository from [https://github.com/getgrav/grav]() to a folder in the webroot of your server, e.g. `~/webroot/grav`. Launch a **terminal** or **console** and navigate to the webroot folder:
   ```
   $ cd ~/webroot
   $ git clone https://github.com/getgrav/grav.git
   ```

2. Install the **plugin** and **theme dependencies** by using the [Grav CLI application](https://learn.getgrav.org/advanced/grav-cli) `bin/grav`:
   ```
   $ cd ~/webroot/grav
   $ bin/grav install
   ```

Check out the [install procedures](https://learn.getgrav.org/basics/installation) for more information.

# Adding Functionality

You can download [plugins](https://getgrav.org/downloads/plugins) or [themes](https://getgrav.org/downloads/themes) manually from the appropriate tab on the [Downloads page on https://getgrav.org](https://getgrav.org/downloads), but the preferred solution is to use the [Grav Package Manager](https://learn.getgrav.org/advanced/grav-gpm) or `GPM`:

```
$ bin/gpm index
```

This will display all the available plugins and then you can install one or more with:

```
$ bin/gpm install <plugin/theme>
```

# Updating

To update Grav you should use the [Grav Package Manager](https://learn.getgrav.org/advanced/grav-gpm) or `GPM`:

```
$ bin/gpm selfupgrade
```

To update plugins and themes:

```
$ bin/gpm update
```

## Upgrading from older version

* [Upgrading to Grav 1.7](https://learn.getgrav.org/16/advanced/grav-development/grav-17-upgrade-guide)
* [Upgrading to Grav 1.6](https://learn.getgrav.org/16/advanced/grav-development/grav-16-upgrade-guide)
* [Upgrading from Grav <1.6](https://learn.getgrav.org/16/advanced/grav-development/grav-15-upgrade-guide)

# Contributing
We appreciate any contribution to Grav, whether it is related to bugs, grammar, or simply a suggestion or improvement! Please refer to the [Contributing guide](CONTRIBUTING.md) for more guidance on this topic.

## Security issues
If you discover a possible security issue related to Grav or one of its plugins, please email the core team at contact@getgrav.org and we'll address it as soon as possible.

# Getting Started

* [What is Grav?](https://learn.getgrav.org/basics/what-is-grav)
* [Install](https://learn.getgrav.org/basics/installation) Grav in few seconds
* Understand the [Configuration](https://learn.getgrav.org/basics/grav-configuration)
* Take a peek at our available free [Skeletons](https://getgrav.org/downloads/skeletons)
* If you have questions, jump on our [Discord Chat Server](https://chat.getgrav.org)!
* Have fun!

# Exploring More

* Have a look at our [Basic Tutorial](https://learn.getgrav.org/basics/basic-tutorial)
* Dive into more [advanced](https://learn.getgrav.org/advanced) functions
* Learn about the [Grav CLI](https://learn.getgrav.org/cli-console/grav-cli)
* Review examples in the [Grav Cookbook](https://learn.getgrav.org/cookbook)
* More [Awesome Grav Stuff](https://github.com/getgrav/awesome-grav)

# Backers
Support Grav with a monthly donation to help us continue development. [[Become a backer](https://opencollective.com/grav#backer)]

<img src="https://opencollective.com/grav/tiers/backers.svg?avatarHeight=36&width=600" />

# Sponsors
Become a sponsor and get your logo on our README on Github with a link to your site. [[Become a sponsor](https://opencollective.com/grav#sponsor)]

<img src="https://opencollective.com/grav/tiers/sponsors.svg?avatarHeight=36&width=600" />

# License

See [LICENSE](LICENSE.txt)


[gitflow-model]: http://nvie.com/posts/a-successful-git-branching-model/
[gitflow-extensions]: https://github.com/nvie/gitflow

# Running Tests

First install the dev dependencies by running `composer install` from the Grav root.

Then `composer test` will run the Unit Tests, which should be always executed successfully on any site.
Windows users should use the `composer test-windows` command.
You can also run a single unit test file, e.g. `composer test tests/unit/Grav/Common/AssetsTest.php`

To run phpstan tests, you should run:

* `composer phpstan` for global tests
* `composer phpstan-framework` for more strict tests
* `composer phpstan-plugins` to test all installed plugins
