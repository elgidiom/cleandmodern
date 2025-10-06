FROM ruby:3.3-slim

ENV APP_HOME=/usr/src/app \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    JEKYLL_ENV=development

WORKDIR $APP_HOME

# Instalar dependencias necesarias para compilar gems
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libyaml-dev \
    libgmp-dev \
    libssl-dev \
 && rm -rf /var/lib/apt/lists/*

# Copiar Gemfiles y preinstalar
COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'test' \
 && bundle install --retry 3

# Copiar el resto del sitio
COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--watch", "--force_polling"]
