# Usando uma imagem do ruby 
FROM ruby:2.5.0-slim


MAINTAINER Bruno Batista <brunobatista@gmail.com>

# Instalando dependências
RUN apt-get update && \
    apt-get install -y gnupg build-essential wget unzip sudo curl \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get -y install google-chrome-stable


#============================================
# Chrome webdriver
#============================================
# can specify versions by CHROME_DRIVER_VERSION
# Latest released version will be used by default
#============================================
#ARG CHROME_DRIVER_VERSION="latest"
#RUN CD_VERSION=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE); else echo $CHROME_DRIVER_VERSION; fi) \
#  && echo "Using chromedriver version: "$CD_VERSION \
#  && curl -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/CD_VERSION/chromedriver_linux64.zip && sudo unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/;
  #&& rm -rf /opt/selenium/chromedriver \
  #&& unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  #&& rm /tmp/chromedriver_linux64.zip \
  #&& mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CD_VERSION \
  #&& chmod 755 /opt/selenium/chromedriver-$CD_VERSION \
  #&& sudo ln -fs /opt/selenium/chromedriver-$CD_VERSION /usr/bin/chromedriver

ARG CHROME_DRIVER_VERSION="latest"
RUN CD_VERSION=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE); else echo $CHROME_DRIVER_VERSION; fi) \
&& echo "Using chromedriver version: "$CD_VERSION \
&& rm -rf ~/chromedriver \
&& wget -N http://chromedriver.storage.googleapis.com/$CD_VERSION/chromedriver_linux64.zip -P ~/ \
&& unzip ~/chromedriver_linux64.zip -d ~/ \
&& rm ~/chromedriver_linux64.zip \
&& sudo mv -f ~/chromedriver /usr/local/bin \
&& sudo chown root:root /usr/local/bin\
&& sudo chmod 0755 /usr/local/bin



# Generating a default config during build time
#RUN /opt/bin/generate_config > /opt/selenium/config.json

ENV APP_HOME /app \
    HOME /root
# Criando a pasta app
WORKDIR $APP_HOME
# Copiando o Gemfile pra pasta app
COPY Gemfile* $APP_HOME/
# Intalando as gems
RUN bundle install
# Copiando o projeto para pasta app
COPY . $APP_HOME
# Colocando o comando default
CMD bundle exec cucumber
