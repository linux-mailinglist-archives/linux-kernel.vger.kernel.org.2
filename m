Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1834FED0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhCaK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:59:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:21337 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235121AbhCaK7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:02 -0400
IronPort-SDR: BzGBvQJCJtxYKvpys6V9wDyKfDFo6NR8Dlgrr58pBav3FIxmBc+6PQ1TORP7Lkjynw2lwrjZUg
 XAHEwScVLlgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="277160541"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="277160541"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 03:59:01 -0700
IronPort-SDR: uMp5cZWzqjQ5tML07eFg+QT4IRES0/wzAtkWBgCohCN86+LNY5N2bl4j7/myzms+ZvRVkBv+EA
 dOCT8YnkU1Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="516844095"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 03:59:00 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] usb: typec: Port mapping utility
Date:   Wed, 31 Mar 2021 13:59:05 +0300
Message-Id: <20210331105908.67066-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331105908.67066-1-heikki.krogerus@linux.intel.com>
References: <20210331105908.67066-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding functions that can be used to link/unlink ports -
USB ports, TBT3/USB4 ports, DisplayPorts and so on - to
the USB Type-C connectors they are attached to inside a
system. The symlink that is created for the port device is
named "connector".

Initially only ACPI is supported. ACPI port object shares
the _PLD (Physical Location of Device) with the USB Type-C
connector that it's attached to.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/Makefile      |   2 +-
 drivers/usb/typec/class.c       |   7 +-
 drivers/usb/typec/class.h       |   9 ++
 drivers/usb/typec/port-mapper.c | 219 ++++++++++++++++++++++++++++++++
 include/linux/usb/typec.h       |  13 ++
 5 files changed, 248 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/typec/port-mapper.c

diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index a820e6e8c1ffc..1e1868832b8d8 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -3,7 +3,7 @@
 CFLAGS_tps6598x.o		:= -I$(src)
 
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o
+typec-y				:= class.o mux.o bus.o port-mapper.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index d3e1002386357..ff199e2d26c7b 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -18,7 +18,7 @@
 
 static DEFINE_IDA(typec_index_ida);
 
-static struct class typec_class = {
+struct class typec_class = {
 	.name = "typec",
 	.owner = THIS_MODULE,
 };
@@ -1601,6 +1601,7 @@ static void typec_release(struct device *dev)
 	ida_destroy(&port->mode_ids);
 	typec_switch_put(port->sw);
 	typec_mux_put(port->mux);
+	free_pld(port->pld);
 	kfree(port->cap);
 	kfree(port);
 }
@@ -1983,6 +1984,8 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
+	mutex_init(&port->port_list_lock);
+	INIT_LIST_HEAD(&port->port_list);
 
 	port->id = id;
 	port->ops = cap->ops;
@@ -2024,6 +2027,8 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	port->pld = get_pld(&port->dev);
+
 	return port;
 }
 EXPORT_SYMBOL_GPL(typec_register_port);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index d414be58d122e..52294f7020a8b 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -54,6 +54,11 @@ struct typec_port {
 
 	const struct typec_capability	*cap;
 	const struct typec_operations   *ops;
+
+	struct list_head		port_list;
+	struct mutex			port_list_lock; /* Port list lock */
+
+	void				*pld;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
@@ -72,5 +77,9 @@ extern const struct device_type typec_port_dev_type;
 #define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
 
 extern struct class typec_mux_class;
+extern struct class typec_class;
+
+void *get_pld(struct device *dev);
+void free_pld(void *pld);
 
 #endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/port-mapper.c b/drivers/usb/typec/port-mapper.c
new file mode 100644
index 0000000000000..5bee7a97242fe
--- /dev/null
+++ b/drivers/usb/typec/port-mapper.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Type-C Connector Class Port Mapping Utility
+ *
+ * Copyright (C) 2021, Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/usb.h>
+#include <linux/usb/typec.h>
+
+#include "class.h"
+
+struct port_node {
+	struct list_head list;
+	struct device *dev;
+	void *pld;
+};
+
+static int acpi_pld_match(const struct acpi_pld_info *pld1,
+			  const struct acpi_pld_info *pld2)
+{
+	if (!pld1 || !pld2)
+		return 0;
+
+	/*
+	 * To speed things up, first checking only the group_position. It seems
+	 * to often have the first unique value in the _PLD.
+	 */
+	if (pld1->group_position == pld2->group_position)
+		return !memcmp(pld1, pld2, sizeof(struct acpi_pld_info));
+
+	return 0;
+}
+
+void *get_pld(struct device *dev)
+{
+#ifdef CONFIG_ACPI
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	if (!has_acpi_companion(dev))
+		return NULL;
+
+	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	return pld;
+#else
+	return NULL;
+#endif
+}
+
+void free_pld(void *pld)
+{
+#ifdef CONFIG_ACPI
+	ACPI_FREE(pld);
+#endif
+}
+
+static int __link_port(struct typec_port *con, struct port_node *node)
+{
+	int ret;
+
+	ret = sysfs_create_link(&node->dev->kobj, &con->dev.kobj, "connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&con->dev.kobj, &node->dev->kobj,
+				dev_name(node->dev));
+	if (ret) {
+		sysfs_remove_link(&node->dev->kobj, "connector");
+		return ret;
+	}
+
+	list_add_tail(&node->list, &con->port_list);
+
+	return 0;
+}
+
+static int link_port(struct typec_port *con, struct port_node *node)
+{
+	int ret;
+
+	mutex_lock(&con->port_list_lock);
+	ret = __link_port(con, node);
+	mutex_unlock(&con->port_list_lock);
+
+	return ret;
+}
+
+static void __unlink_port(struct typec_port *con, struct port_node *node)
+{
+	sysfs_remove_link(&con->dev.kobj, dev_name(node->dev));
+	sysfs_remove_link(&node->dev->kobj, "connector");
+	list_del(&node->list);
+}
+
+static void unlink_port(struct typec_port *con, struct port_node *node)
+{
+	mutex_lock(&con->port_list_lock);
+	__unlink_port(con, node);
+	mutex_unlock(&con->port_list_lock);
+}
+
+static struct port_node *create_port_node(struct device *port)
+{
+	struct port_node *node;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	node->dev = get_device(port);
+	node->pld = get_pld(port);
+
+	return node;
+}
+
+static void remove_port_node(struct port_node *node)
+{
+	put_device(node->dev);
+	free_pld(node->pld);
+	kfree(node);
+}
+
+static int connector_match(struct device *dev, const void *data)
+{
+	const struct port_node *node = data;
+
+	if (!is_typec_port(dev))
+		return 0;
+
+	return acpi_pld_match(to_typec_port(dev)->pld, node->pld);
+}
+
+static struct device *find_connector(struct port_node *node)
+{
+	if (!node->pld)
+		return NULL;
+
+	return class_find_device(&typec_class, NULL, node, connector_match);
+}
+
+/**
+ * typec_link_port - Link a port to its connector
+ * @port: The port device
+ *
+ * Find the connector of @port and create symlink named "connector" for it.
+ * Returns 0 on success, or errno in case of a failure.
+ *
+ * NOTE. The function increments the reference count of @port on success.
+ */
+int typec_link_port(struct device *port)
+{
+	struct device *connector;
+	struct port_node *node;
+	int ret = 0;
+
+	node = create_port_node(port);
+	if (IS_ERR(node))
+		return PTR_ERR(node);
+
+	connector = find_connector(node);
+	if (!connector)
+		goto remove_node;
+
+	ret = link_port(to_typec_port(connector), node);
+	if (ret)
+		goto put_connector;
+
+	return 0;
+
+put_connector:
+	put_device(connector);
+remove_node:
+	remove_port_node(node);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(typec_link_port);
+
+static int port_match_and_unlink(struct device *connector, void *port)
+{
+	struct port_node *node;
+	struct port_node *tmp;
+	int ret = 0;
+
+	if (!is_typec_port(connector))
+		return 0;
+
+	mutex_lock(&to_typec_port(connector)->port_list_lock);
+	list_for_each_entry_safe(node, tmp, &to_typec_port(connector)->port_list, list) {
+		ret = node->dev == port;
+		if (ret) {
+			unlink_port(to_typec_port(connector), node);
+			remove_port_node(node);
+			put_device(connector);
+			break;
+		}
+	}
+	mutex_unlock(&to_typec_port(connector)->port_list_lock);
+
+	return ret;
+}
+
+/**
+ * typec_unlink_port - Unlink port from its connector
+ * @port: The port device
+ *
+ * Removes the symlink "connector" and decrements the reference count of @port.
+ */
+void typec_unlink_port(struct device *port)
+{
+	class_for_each_device(&typec_class, NULL, port, port_match_and_unlink);
+}
+EXPORT_SYMBOL_GPL(typec_unlink_port);
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 91b4303ca305c..e2714722b0c95 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -298,4 +298,17 @@ int typec_find_port_data_role(const char *name);
 void typec_partner_set_svdm_version(struct typec_partner *partner,
 				    enum usb_pd_svdm_ver svdm_version);
 int typec_get_negotiated_svdm_version(struct typec_port *port);
+
+#if IS_REACHABLE(CONFIG_TYPEC)
+int typec_link_port(struct device *port);
+void typec_unlink_port(struct device *port);
+#else
+static inline int typec_link_port(struct device *port)
+{
+	return 0;
+}
+
+static inline void typec_unlink_port(struct device *port) { }
+#endif
+
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.30.2

