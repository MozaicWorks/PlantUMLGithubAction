FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install default-jre-headless graphviz fonts-roboto wget

RUN wget -O /tmp/plantuml.jar "https://github.com/plantuml/plantuml/releases/download/v1.2022.6/plantuml-1.2022.6.jar"
RUN cp /tmp/plantuml.jar /usr/local/lib/ 
RUN echo "#!/bin/sh -l\n" \
		 "java -jar /usr/local/lib/plantuml.jar \"\$@\"\n" > /usr/local/bin/plantuml
RUN chmod u+x /usr/local/bin/plantuml
VOLUME "/diagrams"

ENTRYPOINT ["plantuml"]

CMD [ "/diagrams/*.puml -o out/" ]
