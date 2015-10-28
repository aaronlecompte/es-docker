FROM elasticsearch:1.7

RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/2.7.1

RUN /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head

RUN /usr/share/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf/v1.5.8

RUN mkdir /datastore && chown elasticsearch:elasticsearch /datastore

RUN set -ex \
	&& for path in \
		/datastore/elasticsearch/data \
		/datastore/elasticsearch/logs \
		/datastore/elasticsearch/tmp \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done


VOLUME /datastore

# Add default config file
ADD elasticsearch.yml /usr/share/elasticsearch/config/
