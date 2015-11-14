VERSION = 1.0
FIREFOX_VERSION = 41
BUILD_DIR = build
XPI_TARGET = firefox-kwallet5-$(VERSION).xpi
TARBAL_TARGET = firefox-kwallet5-$(VERSION).tar.gz
XPI_DIR = xpi
ARCH := $(shell uname -m)
# Update the ARCH variable so that the Mozilla architectures are used
ARCH := $(shell echo ${ARCH} | sed 's/i686/x86/')
LIBNAME = libkwallet5_$(ARCH).so
SOURCE = $(BUILD_DIR)/libkwallet5.so
TARGET_DIR = $(XPI_DIR)/components

build: clean lib copy archive

archive: $(XPI_TARGET)

copy: $(SOURCE)
	cp $(SOURCE) $(TARGET_DIR)/$(LIBNAME)

$(XPI_TARGET):
	sed -i 's/<em:version>.*<\/em:version>/<em:version>$(VERSION)<\/em:version>/' $(XPI_DIR)/install.rdf
#	sed -i 's/<em:minVersion>.*<\/em:minVersion>/<em:minVersion>$(FIREFOX_VERSION).0<\/em:minVersion>/' $(XPI_DIR)/install.rdf
	sed -i 's/<em:maxVersion>.*<\/em:maxVersion>/<em:maxVersion>$(FIREFOX_VERSION)\.\*<\/em:maxVersion>/' $(XPI_DIR)/install.rdf
	rm -f $(XPI_TARGET)
	cd $(XPI_DIR) && find . \( ! -regex '.*/\..*' \) | zip ../$(XPI_TARGET) -@

lib:
	mkdir $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake ../library && make

tarbal: clean
	cd .. && tar cvfz $(TARBAL_TARGET) --transform='s,firefox-kwallet5,kwallet5@guillermo.molina,' --exclude $(BUILD_DIR) --exclude '.*'  --exclude '*.so' --exclude '*.xpi' firefox-kwallet5

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(TARGET_DIR)/$(LIBNAME)
	rm -f $(XPI_TARGET)

