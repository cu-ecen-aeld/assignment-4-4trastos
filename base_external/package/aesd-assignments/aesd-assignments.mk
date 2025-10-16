##############################################################
#
# AESD-ASSIGNMENTS Buildroot package
#
##############################################################

AESD_ASSIGNMENTS_VERSION = main
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-4trastos.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) -C $(@D)/finder-app CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)"
endef

# Instalación de scripts y archivos de configuración
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Crear directorios necesarios
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf/
	
	# Instalar archivos de configuración
	if [ -f "$(@D)/conf/username.txt" ]; then \
		$(INSTALL) -m 0644 $(@D)/conf/username.txt $(TARGET_DIR)/etc/finder-app/conf/; \
	else \
		echo "testuser" > $(TARGET_DIR)/etc/finder-app/conf/username.txt; \
	fi
	
	if [ -f "$(@D)/conf/assignment.txt" ]; then \
		$(INSTALL) -m 0644 $(@D)/conf/assignment.txt $(TARGET_DIR)/etc/finder-app/conf/; \
	else \
		echo "assignment4" > $(TARGET_DIR)/etc/finder-app/conf/assignment.txt; \
	fi
	
	# Instalar binarios en /bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/bin/
	
	# Instalar scripts de test
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin/
endef

$(eval $(generic-package))