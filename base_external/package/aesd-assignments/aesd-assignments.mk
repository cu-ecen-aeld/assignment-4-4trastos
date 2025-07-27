##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# Versión/commit específico o 'master' para la última versión
AESD_ASSIGNMENTS_VERSION = 'master'

# URL del repositorio SSH (asegúrate de usar tu nombre de usuario)
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
    $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin
    
    $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin
    $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
    
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/finder-app/conf
    $(INSTALL) -m 0644 $(@D)/finder-app/conf/assignment.txt $(TARGET_DIR)/etc/finder-app/conf/
    $(INSTALL) -m 0644 $(@D)/finder-app/conf/username.txt $(TARGET_DIR)/etc/finder-app/conf/
    
    $(if $(wildcard $(@D)/server/aesdsocket), \
        $(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin, \
    )
endef

$(eval $(generic-package))