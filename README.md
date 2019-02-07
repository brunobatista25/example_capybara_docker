## Getting Started ##

### Enter in folder ###
Access folder project
```
cd project_example_for_gitlab
```

### Installing gems ###
To install gems type:
```shell
bundle install
```

### Drivers: ###
Install and include in PATH
- [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/)

### Run tests in DEV with Chrome###
Type this in the tests folder:
```shell
bundle exec cucumber  -p ci -p html -p headless -p dev
```

### Run tests in DEV with headless###
Type this in the tests folder:
```shell
bundle exec cucumber  -p ci -p html -p headless -p dev
```

### Run tests in HMG with Chrome###
Type this in the tests folder:
```shell
bundle exec cucumber -p pretty -p html -p no_headless -p hmg
```

### Run tests in HMG with headless###
Type this in the tests folder:
```shell
bundle exec cucumber -p ci -p html -p headless -p hmg
```
