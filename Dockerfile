FROM debian:jessie

ENV LANG en_US.UTF-8
RUN apt-get update
RUN echo  "deb http://e-tobi.net/vdr-experimental jessie backports vdr-multipatch base" > /etc/apt/sources.list.d/e-tobi.list
RUN echo  "deb-src http://e-tobi.net/vdr-experimental jessie backports vdr-multipatch base" >> /etc/apt/sources.list.d/e-tobi.list
RUN gpg --keyserver keyring.debian.org --recv-keys 041390BC
RUN gpg --armor --export 041390BC | apt-key add -
RUN apt-get update

RUN apt-get install -y vdr vdr-plugin-dummydevice vdr-plugin-epgsearch vdr-plugin-femon vdr-plugin-live vdr-plugin-markad vdr-plugin-satip vdr-plugin-restfulapi vdr-plugin-xineliboutput vdr-plugin-vnsiserver vdr-plugin-streamdev-server vdr-plugin-xvdr w-scan nvram-wakeup

RUN echo "0.0.0.0/0" >> /etc/vdr/plugins/streamdevhosts.conf
RUN echo "0.0.0.0/0" >> /etc/vdr/svdrphosts.conf
RUN echo "0.0.0.0/0" >> /etc/vdr/plugins/vnsi-server/allowed_hosts.conf
RUN echo "0.0.0.0/0" >> /etc/vdr/plugins/xvdr/allowed_hosts.conf

#RUN sed -i -e '/UpdateChannels =/ s/= .*/= 0/' /etc/vdr/setup.conf

RUN ln -s /etc/vdr/plugins/vnsi-server /etc/vdr/plugins/vnsiserver
RUN ln -s /var/lib/vdr/plugins/vnsi-server /var/lib/vdr/plugins/vnsiserver

RUN mkdir /video

ADD setup.conf.default /etc/vdr/setup.conf
ADD channels.conf.example /var/lib/vdr/channels.conf
ADD runvdr /runvdr
CMD /runvdr
