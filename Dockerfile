FROM jupyter/scipy-notebook

ENV JUPYTER_ENABLE_LAB yes
ENV HOME=/home/jovyan
WORKDIR $HOME

COPY --chown=${NB_UID}:${NB_GID} startup/. .ipython/profile_default/startup/
COPY --chown=${NB_UID}:${NB_GID} ./themes.jupyterlab-settings .jupyter/lab/user-settings/@jupyterlab/apputils-extension/

COPY --chown=${NB_UID}:${NB_GID} ./requirements.txt .
RUN pip install --quiet --no-cache-dir 'flake8==3.9.2' -r requirements.txt
RUN rm ./requirements.txt

RUN pip install jupyterthemes
RUN jupyter labextension install @telamonian/theme-darcula
RUN jupyter labextension enable @telamonian/theme-darcula