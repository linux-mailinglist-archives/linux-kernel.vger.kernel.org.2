Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C133D464
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhCPMy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:54:56 -0400
Received: from foss.arm.com ([217.140.110.172]:38132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233451AbhCPMup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB47F169C;
        Tue, 16 Mar 2021 05:50:44 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33D73F792;
        Tue, 16 Mar 2021 05:50:42 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 38/38] firmware: arm_scmi: add dynamic scmi devices creation
Date:   Tue, 16 Mar 2021 12:49:03 +0000
Message-Id: <20210316124903.35011-39-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having added the support for SCMI protocols as modules in order to let
vendors extend the SCMI core with their own additions it seems odd to
then force SCMI drivers built on top to use a static device table to
declare their devices since this way any new SCMI drivers addition
would need the core SCMI device table to be updated too.

Remove the static core device table and let SCMI drivers to simply declare
which device/protocol pair they need at initialization time: the core will
then take care to generate such devices dynamically during platform
initialization or at module loading time, as long as the requested
underlying protocol is defined in the DT.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
v4 --> v5
- using klist instead of custom lists
v3 --> v4
- add a few comments
---
 drivers/firmware/arm_scmi/bus.c    |  30 +++
 drivers/firmware/arm_scmi/common.h |   5 +
 drivers/firmware/arm_scmi/driver.c | 310 +++++++++++++++++++++++++----
 3 files changed, 311 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index aadf2da21561..784cf0027da3 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -51,6 +51,31 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+static int scmi_match_by_id_table(struct device *dev, void *data)
+{
+	struct scmi_device *sdev = to_scmi_dev(dev);
+	struct scmi_device_id *id_table = data;
+
+	return sdev->protocol_id == id_table->protocol_id &&
+		!strcmp(sdev->name, id_table->name);
+}
+
+struct scmi_device *scmi_child_dev_find(struct device *parent,
+					int prot_id, const char *name)
+{
+	struct scmi_device_id id_table;
+	struct device *dev;
+
+	id_table.protocol_id = prot_id;
+	id_table.name = name;
+
+	dev = device_find_child(parent, &id_table, scmi_match_by_id_table);
+	if (!dev)
+		return NULL;
+
+	return to_scmi_dev(dev);
+}
+
 const struct scmi_protocol *scmi_protocol_get(int protocol_id)
 {
 	const struct scmi_protocol *proto;
@@ -114,6 +139,10 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 {
 	int retval;
 
+	retval = scmi_protocol_device_request(driver->id_table);
+	if (retval)
+		return retval;
+
 	driver->driver.bus = &scmi_bus_type;
 	driver->driver.name = driver->name;
 	driver->driver.owner = owner;
@@ -130,6 +159,7 @@ EXPORT_SYMBOL_GPL(scmi_driver_register);
 void scmi_driver_unregister(struct scmi_driver *driver)
 {
 	driver_unregister(&driver->driver);
+	scmi_protocol_device_unrequest(driver->id_table);
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);
 
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 762dd5419700..228bf4a71d23 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -309,6 +309,11 @@ struct scmi_transport_ops {
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
+int scmi_protocol_device_request(const struct scmi_device_id *id_table);
+void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table);
+struct scmi_device *scmi_child_dev_find(struct device *parent,
+					int prot_id, const char *name);
+
 /**
  * struct scmi_desc - Description of SoC integration
  *
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c25c20c150dc..66eb3f0e5daf 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -56,6 +57,14 @@ static DEFINE_MUTEX(scmi_list_mutex);
 /* Track the unique id for the transfers for debug & profiling purpose */
 static atomic_t transfer_last_id;
 
+static DEFINE_IDR(scmi_requested_devices);
+static DEFINE_MUTEX(scmi_requested_devices_mtx);
+
+struct scmi_requested_dev {
+	const struct scmi_device_id *id_table;
+	struct list_head node;
+};
+
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
  *
@@ -113,6 +122,8 @@ struct scmi_protocol_instance {
  * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
+ * @active_protocols: IDR storing device_nodes for protocols actually defined
+ *		      in the DT and confirmed as implemented by fw.
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
@@ -130,6 +141,7 @@ struct scmi_info {
 	/* Ensure mutual exclusive access to protocols instance array */
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
+	struct idr active_protocols;
 	void *notify_priv;
 	struct list_head node;
 	int users;
@@ -935,6 +947,13 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
 	WARN_ON(ret);
 }
 
+static inline
+struct scmi_handle *scmi_handle_get_from_info_unlocked(struct scmi_info *info)
+{
+	info->users++;
+	return &info->handle;
+}
+
 /**
  * scmi_handle_get() - Get the SCMI handle for a device
  *
@@ -956,8 +975,7 @@ struct scmi_handle *scmi_handle_get(struct device *dev)
 	list_for_each(p, &scmi_list) {
 		info = list_entry(p, struct scmi_info, node);
 		if (dev->parent == info->dev) {
-			handle = &info->handle;
-			info->users++;
+			handle = scmi_handle_get_from_info_unlocked(info);
 			break;
 		}
 	}
@@ -1100,63 +1118,268 @@ scmi_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
 	return ret;
 }
 
-static inline void
-scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
-			    int prot_id, const char *name)
+/**
+ * scmi_get_protocol_device  - Helper to get/create an SCMI device.
+ *
+ * @np: A device node representing a valid active protocols for the referred
+ * SCMI instance.
+ * @info: The referred SCMI instance for which we are getting/creating this
+ * device.
+ * @prot_id: The protocol ID.
+ * @name: The device name.
+ *
+ * Referring to the specific SCMI instance identified by @info, this helper
+ * takes care to return a properly initialized device matching the requested
+ * @proto_id and @name: if device was still not existent it is created as a
+ * child of the specified SCMI instance @info and its transport properly
+ * initialized as usual.
+ */
+static inline struct scmi_device *
+scmi_get_protocol_device(struct device_node *np, struct scmi_info *info,
+			 int prot_id, const char *name)
 {
 	struct scmi_device *sdev;
 
+	/* Already created for this parent SCMI instance ? */
+	sdev = scmi_child_dev_find(info->dev, prot_id, name);
+	if (sdev)
+		return sdev;
+
+	pr_debug("Creating SCMI device (%s) for protocol %x\n", name, prot_id);
+
 	sdev = scmi_device_create(np, info->dev, prot_id, name);
 	if (!sdev) {
 		dev_err(info->dev, "failed to create %d protocol device\n",
 			prot_id);
-		return;
+		return NULL;
 	}
 
 	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
 		dev_err(&sdev->dev, "failed to setup transport\n");
 		scmi_device_destroy(sdev);
-		return;
+		return NULL;
 	}
 
+	return sdev;
+}
+
+static inline void
+scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
+			    int prot_id, const char *name)
+{
+	struct scmi_device *sdev;
+
+	sdev = scmi_get_protocol_device(np, info, prot_id, name);
+	if (!sdev)
+		return;
+
 	/* setup handle now as the transport is ready */
 	scmi_set_handle(sdev);
 }
 
-#define MAX_SCMI_DEV_PER_PROTOCOL	2
-struct scmi_prot_devnames {
-	int protocol_id;
-	char *names[MAX_SCMI_DEV_PER_PROTOCOL];
-};
+/**
+ * scmi_create_protocol_devices  - Create devices for all pending requests for
+ * this SCMI instance.
+ *
+ * @np: The device node describing the protocol
+ * @info: The SCMI instance descriptor
+ * @prot_id: The protocol ID
+ *
+ * All devices previously requested for this instance (if any) are found and
+ * created by scanning the proper @&scmi_requested_devices entry.
+ */
+static void scmi_create_protocol_devices(struct device_node *np,
+					 struct scmi_info *info, int prot_id)
+{
+	struct list_head *phead;
 
-static struct scmi_prot_devnames devnames[] = {
-	{ SCMI_PROTOCOL_POWER,  { "genpd" },},
-	{ SCMI_PROTOCOL_SYSTEM, { "syspower" },},
-	{ SCMI_PROTOCOL_PERF,   { "cpufreq" },},
-	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
-	{ SCMI_PROTOCOL_SENSOR, { "hwmon", "iiodev" },},
-	{ SCMI_PROTOCOL_RESET,  { "reset" },},
-	{ SCMI_PROTOCOL_VOLTAGE,  { "regulator" },},
-};
+	mutex_lock(&scmi_requested_devices_mtx);
+	phead = idr_find(&scmi_requested_devices, prot_id);
+	if (phead) {
+		struct scmi_requested_dev *rdev;
 
-static inline void
-scmi_create_protocol_devices(struct device_node *np, struct scmi_info *info,
-			     int prot_id)
+		list_for_each_entry(rdev, phead, node)
+			scmi_create_protocol_device(np, info, prot_id,
+						    rdev->id_table->name);
+	}
+	mutex_unlock(&scmi_requested_devices_mtx);
+}
+
+/**
+ * scmi_protocol_device_request  - Helper to request a device
+ *
+ * @id_table: A protocol/name pair descriptor for the device to be created.
+ *
+ * This helper let an SCMI driver request specific devices identified by the
+ * @id_table to be created for each active SCMI instance.
+ *
+ * The requested device name MUST NOT be already existent for any protocol;
+ * at first the freshly requested @id_table is annotated in the IDR table
+ * @scmi_requested_devices, then a matching device is created for each already
+ * active SCMI instance. (if any)
+ *
+ * This way the requested device is created straight-away for all the already
+ * initialized(probed) SCMI instances (handles) and it remains also annotated
+ * as pending creation if the requesting SCMI driver was loaded before some
+ * SCMI instance and related transports were available: when such late instance
+ * is probed, its probe will take care to scan the list of pending requested
+ * devices and create those on its own (see @scmi_create_protocol_devices and
+ * its enclosing loop)
+ *
+ * Return: 0 on Success
+ */
+int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 {
-	int loop, cnt;
+	int ret = 0;
+	unsigned int id = 0;
+	struct list_head *head, *phead = NULL;
+	struct scmi_requested_dev *rdev;
+	struct scmi_info *info;
 
-	for (loop = 0; loop < ARRAY_SIZE(devnames); loop++) {
-		if (devnames[loop].protocol_id != prot_id)
-			continue;
+	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
+		 id_table->name, id_table->protocol_id);
+
+	/*
+	 * Search for the matching protocol rdev list and then search
+	 * of any existent equally named device...fails if any duplicate found.
+	 */
+	mutex_lock(&scmi_requested_devices_mtx);
+	idr_for_each_entry(&scmi_requested_devices, head, id) {
+		if (!phead) {
+			/* A list found registered in the IDR is never empty */
+			rdev = list_first_entry(head, struct scmi_requested_dev,
+						node);
+			if (rdev->id_table->protocol_id ==
+			    id_table->protocol_id)
+				phead = head;
+		}
+		list_for_each_entry(rdev, head, node) {
+			if (!strcmp(rdev->id_table->name, id_table->name)) {
+				pr_err("Ignoring duplicate request [%d] %s\n",
+				       rdev->id_table->protocol_id,
+				       rdev->id_table->name);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	/*
+	 * No duplicate found for requested id_table, so let's create a new
+	 * requested device entry for this new valid request.
+	 */
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	rdev->id_table = id_table;
+
+	/*
+	 * Append the new requested device table descriptor to the head of the
+	 * related protocol list, eventually creating such head if not already
+	 * there.
+	 */
+	if (!phead) {
+		phead = kzalloc(sizeof(*phead), GFP_KERNEL);
+		if (!phead) {
+			kfree(rdev);
+			ret = -ENOMEM;
+			goto out;
+		}
+		INIT_LIST_HEAD(phead);
+
+		ret = idr_alloc(&scmi_requested_devices, (void *)phead,
+				id_table->protocol_id,
+				id_table->protocol_id + 1, GFP_KERNEL);
+		if (ret != id_table->protocol_id) {
+			pr_err("Failed to save SCMI device - ret:%d\n", ret);
+			kfree(rdev);
+			kfree(phead);
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = 0;
+	}
+	list_add(&rdev->node, phead);
+
+	/*
+	 * Now effectively create and initialize the requested device for every
+	 * already initialized SCMI instance which has registered the requested
+	 * protocol as a valid active one: i.e. defined in DT and supported by
+	 * current platform FW.
+	 */
+	mutex_lock(&scmi_list_mutex);
+	list_for_each_entry(info, &scmi_list, node) {
+		struct device_node *child;
+
+		child = idr_find(&info->active_protocols,
+				 id_table->protocol_id);
+		if (child) {
+			struct scmi_device *sdev;
+
+			sdev = scmi_get_protocol_device(child, info,
+							id_table->protocol_id,
+							id_table->name);
+			/* Set handle if not already set: device existed */
+			if (sdev && !sdev->handle)
+				sdev->handle =
+					scmi_handle_get_from_info_unlocked(info);
+		} else {
+			dev_err(info->dev,
+				"Failed. SCMI protocol %d not active.\n",
+				id_table->protocol_id);
+		}
+	}
+	mutex_unlock(&scmi_list_mutex);
+
+out:
+	mutex_unlock(&scmi_requested_devices_mtx);
 
-		for (cnt = 0; cnt < ARRAY_SIZE(devnames[loop].names); cnt++) {
-			const char *name = devnames[loop].names[cnt];
+	return ret;
+}
 
-			if (name)
-				scmi_create_protocol_device(np, info, prot_id,
-							    name);
+/**
+ * scmi_protocol_device_unrequest  - Helper to unrequest a device
+ *
+ * @id_table: A protocol/name pair descriptor for the device to be unrequested.
+ *
+ * An helper to let an SCMI driver release its request about devices; note that
+ * devices are created and initialized once the first SCMI driver request them
+ * but they destroyed only on SCMI core unloading/unbinding.
+ *
+ * The current SCMI transport layer uses such devices as internal references and
+ * as such they could be shared as same transport between multiple drivers so
+ * that cannot be safely destroyed till the whole SCMI stack is removed.
+ * (unless adding further burden of refcounting.)
+ */
+void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
+{
+	struct list_head *phead;
+
+	pr_debug("Unrequesting SCMI device (%s) for protocol %x\n",
+		 id_table->name, id_table->protocol_id);
+
+	mutex_lock(&scmi_requested_devices_mtx);
+	phead = idr_find(&scmi_requested_devices, id_table->protocol_id);
+	if (phead) {
+		struct scmi_requested_dev *victim, *tmp;
+
+		list_for_each_entry_safe(victim, tmp, phead, node) {
+			if (!strcmp(victim->id_table->name, id_table->name)) {
+				list_del(&victim->node);
+				kfree(victim);
+				break;
+			}
+		}
+
+		if (list_empty(phead)) {
+			idr_remove(&scmi_requested_devices,
+				   id_table->protocol_id);
+			kfree(phead);
 		}
 	}
+	mutex_unlock(&scmi_requested_devices_mtx);
 }
 
 static int scmi_probe(struct platform_device *pdev)
@@ -1181,6 +1404,7 @@ static int scmi_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&info->node);
 	idr_init(&info->protocols);
 	mutex_init(&info->protocols_mtx);
+	idr_init(&info->active_protocols);
 
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
@@ -1233,6 +1457,19 @@ static int scmi_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		/*
+		 * Save this valid DT protocol descriptor amongst
+		 * @active_protocols for this SCMI instance/
+		 */
+		ret = idr_alloc(&info->active_protocols, child,
+				prot_id, prot_id + 1, GFP_KERNEL);
+		if (ret != prot_id) {
+			dev_err(dev, "SCMI protocol %d already activated. Skip\n",
+				prot_id);
+			continue;
+		}
+
+		of_node_get(child);
 		scmi_create_protocol_devices(child, info, prot_id);
 	}
 
@@ -1246,9 +1483,10 @@ void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id)
 
 static int scmi_remove(struct platform_device *pdev)
 {
-	int ret = 0;
+	int ret = 0, id;
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct idr *idr = &info->tx_idr;
+	struct device_node *child;
 
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
@@ -1266,6 +1504,10 @@ static int scmi_remove(struct platform_device *pdev)
 	idr_destroy(&info->protocols);
 	mutex_unlock(&info->protocols_mtx);
 
+	idr_for_each_entry(&info->active_protocols, child, id)
+		of_node_put(child);
+	idr_destroy(&info->active_protocols);
+
 	/* Safe to free channels since no more users */
 	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
 	idr_destroy(&info->tx_idr);
-- 
2.17.1

