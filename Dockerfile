FROM lambci/lambda:build-python3.6
LABEL maintainer="patrick@wagonride.co"

RUN pip install pipenv

  # See: https://github.com/pypa/pipenv/issues/1586#issuecomment-413597222
RUN python -m pip install git+git://github.com/pypa/pipenv.git@541b87abd5baa1b6528ab5938fc275b6e982d7e0
ENV PIPENV_VENV_IN_PROJECT 1

WORKDIR /app

COPY . /app
  # See: https://github.com/pypa/pipenv/issues/2924
RUN bash -c 'pipenv install pip==18.0'


COPY . /app

ENV DJANGO_COLORS "light"
ENV GRAPHQL_ENDPOINT "http://localhost:8080/gq"

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
