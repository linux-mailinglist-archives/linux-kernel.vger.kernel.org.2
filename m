Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6654F3E06E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhHDRoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:44:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:16631 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237345AbhHDRoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:44:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="193568042"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="193568042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 10:44:00 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="501307483"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 10:43:52 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1] driver: base: Add driver filter support
Date:   Wed,  4 Aug 2021 10:43:22 -0700
Message-Id: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Trust Domain Extensions (TDX) is a new Intel technology that
adds support for VMs to maintain confidentiality and integrity in the
presence of an untrusted VMM.

Given the VMM is an untrusted entity and the VMM presents emulated
hardware to the guest, a threat vector similar to Thunderclap [1] is
present. Also, for ease of deployment, it is useful to be able to use
the same kernel binary on host and guest, but that presents a wide
attack surface given the range of hardware supported in typical
builds. However, TDX guests only require a small number of drivers, a
number small enough to audit for Thunderclap style attacks, and the
rest can be disabled via policy. Add a mechanism to filter drivers
based on a "protected-guest trusted" indication.

An alternative solution is to disable untrusted drivers using a custom
kernel config for TDX, but such solution will break our goal of using
same kernel binary in guest/host or in standard OS distributions. So
it is not considered.

Driver filter framework adds support to filter drivers at boot
time by using platform specific allow list. This is a generic
solution that can be reused by TDX. Driver filter framework adds a
new hook (driver_allowed()) in driver_register() interface which
will update the "allowed" status of the driver based on platform
specific driver allow list or deny list. During driver bind process,
trusted status is used to determine whether to continue or deny the
bind process. If platform does not register any allow or deny list,
all devices will be allowed. Platforms can use wildcard like "ALL:ALL"
in bus_name and driver_name of filter node to allow or deny all
bus and drivers.

Per driver opt-in model is also considered as an alternative design
choice, but central allow or deny list is chosen because it is
easier to maintain and audit. Also, "driver self serve" might be
abused by mistake by driver authors cutting and pasting the code.

Also add an option in kernel command line and sysfs to update the
allowed or denied drivers list. Driver filter allowed status
can be read using following command.

cat /sys/bus/$bus/drivers/$driver/allowed

Details about TDX technology can be found in following link:

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

[1]: http://thunderclap.io/

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  15 ++
 drivers/base/Makefile                         |   2 +-
 drivers/base/base.h                           |   8 +
 drivers/base/bus.c                            |  34 +++
 drivers/base/filter.c                         | 217 ++++++++++++++++++
 include/linux/device/filter.h                 |  35 +++
 6 files changed, 310 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/filter.c
 create mode 100644 include/linux/device/filter.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 10776a743e74..2af8b60b227b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1399,6 +1399,21 @@
 			See Documentation/admin-guide/sysctl/net.rst for
 			fb_tunnels_only_for_init_ns
 
+	filter_deny_drivers=
+	filter_allow_drivers=[KNL]
+			Format: bus:driver
+			Override the default driver filter allowed or blocked
+			list. Multiple drivers can be specified, separated by
+			comma. Multiple bus/driver combinations can be
+			specified separated by semicolon. For example to allow
+			the e1000 driver use filter_allow_drivers=pci:e1000. To
+			allow all drivers in pci use
+			filter_allow_drivers=pci:ALL. Similarly to deny e1000
+			driver, use filter_deny_drivers=pci:e1000.
+			Also note that, driver allow list is searched first. If
+			an entry exist in allow list, deny list will not be
+			searched.
+
 	floppy=		[HW]
 			See Documentation/admin-guide/blockdev/floppy.rst.
 
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index ef8e44a7d288..d06b698e2796 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -6,7 +6,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
-			   swnode.o
+			   swnode.o filter.o
 obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 404db83ee5ec..1c4c19cab670 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -61,6 +61,8 @@ struct driver_private {
 	struct klist_node knode_bus;
 	struct module_kobject *mkobj;
 	struct device_driver *driver;
+	/* Used by driver filter framework to cache allowed status */
+	bool allowed;
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
@@ -144,6 +146,9 @@ extern void device_set_deferred_probe_reason(const struct device *dev,
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
+	if (!drv->p->allowed)
+		return 0;
+
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 extern bool driver_allows_async_probing(struct device_driver *drv);
@@ -202,3 +207,6 @@ int devtmpfs_delete_node(struct device *dev);
 static inline int devtmpfs_create_node(struct device *dev) { return 0; }
 static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 #endif
+
+bool driver_allowed(struct device_driver *drv);
+bool driver_filter_enabled(void);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 1f6b4bd61056..85fb4063459f 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -583,6 +583,28 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+static ssize_t allowed_store(struct device_driver *drv, const char *buf,
+			     size_t count)
+{
+	int ret;
+	bool status;
+
+	ret = kstrtobool(buf, &status);
+	if (ret)
+		return ret;
+
+	drv->p->allowed = status;
+
+	return count;
+}
+
+static ssize_t allowed_show(struct device_driver *drv, char *buf)
+{
+	return sysfs_emit(buf, "%s:%s %d\n", drv->bus ? drv->bus->name : "NULL",
+			  drv->name, drv->p->allowed);
+}
+static DRIVER_ATTR_RW(allowed);
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -607,6 +629,7 @@ int bus_add_driver(struct device_driver *drv)
 	klist_init(&priv->klist_devices, NULL, NULL);
 	priv->driver = drv;
 	drv->p = priv;
+	drv->p->allowed = driver_allowed(drv);
 	priv->kobj.kset = bus->p->drivers_kset;
 	error = kobject_init_and_add(&priv->kobj, &driver_ktype, NULL,
 				     "%s", drv->name);
@@ -626,6 +649,15 @@ int bus_add_driver(struct device_driver *drv)
 		printk(KERN_ERR "%s: uevent attr (%s) failed\n",
 			__func__, drv->name);
 	}
+
+	if (driver_filter_enabled()) {
+		error = driver_create_file(drv, &driver_attr_allowed);
+		if (error) {
+			printk(KERN_ERR "%s: allowed attr (%s) failed\n",
+			       __func__, drv->name);
+		}
+	}
+
 	error = driver_add_groups(drv, bus->drv_groups);
 	if (error) {
 		/* How the hell do we get out of this pickle? Give up */
@@ -670,6 +702,8 @@ void bus_remove_driver(struct device_driver *drv)
 		remove_bind_files(drv);
 	driver_remove_groups(drv, drv->bus->drv_groups);
 	driver_remove_file(drv, &driver_attr_uevent);
+	if (driver_filter_enabled())
+		driver_remove_file(drv, &driver_attr_allowed);
 	klist_remove(&drv->p->knode_bus);
 	pr_debug("bus: '%s': remove driver %s\n", drv->bus->name, drv->name);
 	driver_detach(drv);
diff --git a/drivers/base/filter.c b/drivers/base/filter.c
new file mode 100644
index 000000000000..772e947ba933
--- /dev/null
+++ b/drivers/base/filter.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * filter.c - Add driver filter framework.
+ *
+ * Implements APIs required for registering platform specific
+ * driver filter.
+ *
+ * Copyright (c) 2021 Intel Corporation
+ */
+
+#define pr_fmt(fmt) "filter: " fmt
+
+#include <linux/init.h>
+#include <linux/device/filter.h>
+#include <linux/acpi.h>
+#include <linux/protected_guest.h>
+
+#include "base.h"
+
+#define MAX_FILTER_NODES 10
+#define MAX_CMDLINE_LEN  500
+
+/* Buffer used by command line parser */
+static char allowed_drivers[MAX_CMDLINE_LEN];
+static char denied_drivers[MAX_CMDLINE_LEN];
+
+/* List of filter nodes for command line parser */
+static struct drv_filter_node allowed_nodes[MAX_FILTER_NODES];
+static struct drv_filter_node denied_nodes[MAX_FILTER_NODES];
+
+/* Driver allow list */
+static LIST_HEAD(driver_allow_list);
+/* Driver deny list */
+static LIST_HEAD(driver_deny_list);
+
+/* Protects driver_filter_list add/read operations*/
+static DEFINE_SPINLOCK(driver_filter_lock);
+
+/*
+ * Compares the driver name with given filter node.
+ *
+ * Return true if driver name matches with filter node.
+ */
+static bool match_driver(struct device_driver *drv,
+			 struct drv_filter_node *node)
+{
+	const char *n;
+	int len;
+
+	/* Make sure input entries are valid */
+	if (!drv || !node || !drv->bus)
+		return false;
+
+	/* If bus_name and drv_list matches "ALL", return true */
+	if (!strcmp(node->bus_name, "ALL") && !strcmp(node->drv_list, "ALL"))
+		return true;
+
+	/*
+	 * Since next step involves bus specific comparison, make
+	 * sure the bus name matches with filter node. If not
+	 * return false.
+	 */
+	if (strcmp(node->bus_name, drv->bus->name))
+		return false;
+
+	/* If allow list is "ALL", allow all */
+	if (!strcmp(node->drv_list, "ALL"))
+		return true;
+
+	for (n = node->drv_list; *n; n += len) {
+		if (*n == ',')
+			n++;
+		len = strcspn(n, ",");
+		if (!strncmp(drv->name, n, len) && drv->name[len] == 0)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * driver_allowed() - Check whether given driver is allowed or not
+ *		      based on platform specific driver filter list.
+ */
+bool driver_allowed(struct device_driver *drv)
+{
+	bool status = true;
+	struct drv_filter_node *node;
+
+	spin_lock(&driver_filter_lock);
+
+	/*
+	 * Check whether the driver is allowed using platform
+	 * registered allow list.
+	 */
+	list_for_each_entry(node, &driver_allow_list, list) {
+		if (match_driver(drv, node)) {
+			status = true;
+			goto done;
+		}
+	}
+
+	/*
+	 * Check whether the driver is denied using platform
+	 * registered deny list.
+	 */
+	list_for_each_entry(node, &driver_deny_list, list) {
+		if (match_driver(drv, node)) {
+			status = false;
+			break;
+		}
+	}
+
+done:
+	pr_debug("bus:%s driver:%s %s\n", drv->bus ? drv->bus->name : "null",
+		 drv->name, status ? "allowed" : "denied");
+
+	spin_unlock(&driver_filter_lock);
+
+	return status;
+}
+
+bool driver_filter_enabled(void)
+{
+	return !list_empty(&driver_allow_list) ||
+		!list_empty(&driver_deny_list);
+}
+
+/*
+ * Helper function for filter node validity checks and
+ * adding filter node to allow or deny list.
+ */
+static int add_node_to_list(struct drv_filter_node *node,
+			    struct list_head *flist)
+{
+	/* If filter node is NULL, return error */
+	if (!node)
+		return -EINVAL;
+
+	/* Make sure node input is valid */
+	if (!node->bus_name || !node->drv_list)
+		return -EINVAL;
+
+	spin_lock(&driver_filter_lock);
+
+	list_add_tail(&node->list, flist);
+
+	spin_unlock(&driver_filter_lock);
+
+	return 0;
+}
+
+int register_filter_allow_node(struct drv_filter_node *node)
+{
+	return add_node_to_list(node, &driver_allow_list);
+}
+
+int register_filter_deny_node(struct drv_filter_node *node)
+{
+	return add_node_to_list(node, &driver_deny_list);
+}
+
+static __init void add_custom_driver_filter(char *p, bool allow)
+{
+	struct drv_filter_node *n;
+	int j = 0;
+	char *k;
+
+	while ((k = strsep(&p, ";")) != NULL) {
+		if (j >= MAX_FILTER_NODES) {
+			pr_err("Driver filter nodes exceed MAX_FILTER_NODES\n");
+			break;
+		}
+
+		if (allow)
+			n = &allowed_nodes[j++];
+		else
+			n = &denied_nodes[j++];
+
+		n->bus_name = strsep(&k, ":");
+
+		n->drv_list = p;
+
+		if (allow)
+			register_filter_allow_node(n);
+		else
+			register_filter_deny_node(n);
+	}
+}
+
+/* Command line option to update driver allow list */
+static int __init setup_allowed_drivers(char *buf)
+{
+	if (strlen(buf) >= MAX_CMDLINE_LEN)
+		pr_warn("Allowed list exceeds %d chars\n", MAX_CMDLINE_LEN);
+
+	strscpy(allowed_drivers, buf, MAX_CMDLINE_LEN);
+
+	add_custom_driver_filter(allowed_drivers, 1);
+
+	return 0;
+}
+__setup("filter_allow_drivers=", setup_allowed_drivers);
+
+/* Command line option to update driver deny list */
+static int __init setup_denied_drivers(char *buf)
+{
+	if (strlen(buf) >= MAX_CMDLINE_LEN)
+		pr_warn("Allowed list exceeds %d chars\n", MAX_CMDLINE_LEN);
+
+	strscpy(denied_drivers, buf, MAX_CMDLINE_LEN);
+
+	add_custom_driver_filter(denied_drivers, 0);
+
+	return 0;
+}
+__setup("filter_deny_drivers=", setup_denied_drivers);
diff --git a/include/linux/device/filter.h b/include/linux/device/filter.h
new file mode 100644
index 000000000000..a7510aa4642f
--- /dev/null
+++ b/include/linux/device/filter.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * filter.h - Driver filter specific header
+ *
+ * Copyright (c) 2021 Intel Corporation
+ *
+ */
+
+#ifndef _DEVICE_FILTER_H_
+#define _DEVICE_FILTER_H_
+
+#include <linux/device/bus.h>
+#include <linux/device/driver.h>
+#include <linux/device.h>
+
+/**
+ * struct drv_filter_node - driver filter node
+ *
+ * @bus_name		: Name of the bus.
+ * @drv_list		: Driver names for allow or deny list.
+ *
+ * Passing ALL in bus_name and drv_list will allow or
+ * deny all drivers.
+ */
+struct drv_filter_node {
+	const char *bus_name;
+	const char *drv_list;
+	struct list_head list;
+};
+
+/* Register platform specific allow list */
+int register_filter_allow_node(struct drv_filter_node *node);
+/* Register platform specific deny list */
+int register_filter_deny_node(struct drv_filter_node *node);
+#endif
-- 
2.25.1

