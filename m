Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2184333D45F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCPMyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:54:35 -0400
Received: from foss.arm.com ([217.140.110.172]:38118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233439AbhCPMun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:50:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB971692;
        Tue, 16 Mar 2021 05:50:42 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 714F73F792;
        Tue, 16 Mar 2021 05:50:40 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 37/38] firmware: arm_scmi: add protocol modularization support
Date:   Tue, 16 Mar 2021 12:49:02 +0000
Message-Id: <20210316124903.35011-38-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend SCMI protocols accounting mechanism to address possible module
usage and add the support to possibly define new protocols as loadable
modules.

Keep Standard protocols built into the SCMI core.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v6 --> v7
- rename used IDR scmi_available_protocols => scmi_protocols
- reworks to fit into refactored scmi_get_protocol_instance()
- renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
- added missing .owner to voltage.c
---
 drivers/firmware/arm_scmi/base.c    |  2 ++
 drivers/firmware/arm_scmi/bus.c     | 11 ++++++++++-
 drivers/firmware/arm_scmi/clock.c   |  2 ++
 drivers/firmware/arm_scmi/common.h  |  4 ++++
 drivers/firmware/arm_scmi/driver.c  | 17 +++++++++++++----
 drivers/firmware/arm_scmi/perf.c    |  2 ++
 drivers/firmware/arm_scmi/power.c   |  2 ++
 drivers/firmware/arm_scmi/reset.c   |  2 ++
 drivers/firmware/arm_scmi/sensors.c |  2 ++
 drivers/firmware/arm_scmi/system.c  |  2 ++
 drivers/firmware/arm_scmi/voltage.c |  2 ++
 include/linux/scmi_protocol.h       | 12 ++++++++++++
 12 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 0d28f0f825b6..de416f9e7921 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications BASE - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -373,6 +374,7 @@ static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_base = {
 	.id = SCMI_PROTOCOL_BASE,
+	.owner = NULL,
 	.instance_init = &scmi_base_protocol_init,
 	.ops = NULL,
 	.events = &base_protocol_events,
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 992d50e10111..aadf2da21561 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -56,7 +56,7 @@ const struct scmi_protocol *scmi_protocol_get(int protocol_id)
 	const struct scmi_protocol *proto;
 
 	proto = idr_find(&scmi_protocols, protocol_id);
-	if (!proto) {
+	if (!proto || !try_module_get(proto->owner)) {
 		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
 		return NULL;
 	}
@@ -66,6 +66,15 @@ const struct scmi_protocol *scmi_protocol_get(int protocol_id)
 	return proto;
 }
 
+void scmi_protocol_put(int protocol_id)
+{
+	const struct scmi_protocol *proto;
+
+	proto = idr_find(&scmi_protocols, protocol_id);
+	if (proto)
+		module_put(proto->owner);
+}
+
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 827cf25fc122..35b56c8ba0c0 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018-2021 ARM Ltd.
  */
 
+#include <linux/module.h>
 #include <linux/sort.h>
 
 #include "common.h"
@@ -367,6 +368,7 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_clock = {
 	.id = SCMI_PROTOCOL_CLOCK,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_clock_protocol_init,
 	.ops = &clk_proto_ops,
 };
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c093f332cdcd..762dd5419700 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
@@ -214,6 +215,7 @@ typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
 /**
  * struct scmi_protocol  - Protocol descriptor
  * @id: Protocol ID.
+ * @owner: Module reference if any.
  * @instance_init: Mandatory protocol initialization function.
  * @instance_deinit: Optional protocol de-initialization function.
  * @ops: Optional reference to the operations provided by the protocol and
@@ -222,6 +224,7 @@ typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
  */
 struct scmi_protocol {
 	const u8				id;
+	struct module				*owner;
 	const scmi_prot_init_ph_fn_t		instance_init;
 	const scmi_prot_init_ph_fn_t		instance_deinit;
 	const void				*ops;
@@ -257,6 +260,7 @@ void __exit scmi_##name##_unregister(void)			\
 }
 
 const struct scmi_protocol *scmi_protocol_get(int protocol_id);
+void scmi_protocol_put(int protocol_id);
 
 int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
 void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 563a64131035..c25c20c150dc 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -660,7 +660,8 @@ scmi_revision_area_get(const struct scmi_protocol_handle *ph)
  *
  * Context: Assumes to be called with @protocols_mtx already acquired.
  * Return: A reference to a freshly allocated and initialized protocol instance
- *	   or ERR_PTR on failure.
+ *	   or ERR_PTR on failure. On failure the @proto reference is at first
+ *	   put using @scmi_protocol_put() before releasing all the devres group.
  */
 static struct scmi_protocol_instance *
 scmi_alloc_init_protocol_instance(struct scmi_info *info,
@@ -673,8 +674,10 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 
 	/* Protocol specific devres group */
 	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
-	if (!gid)
+	if (!gid) {
+		scmi_protocol_put(proto->id);
 		goto out;
+	}
 
 	pi = devm_kzalloc(handle->dev, sizeof(*pi), GFP_KERNEL);
 	if (!pi)
@@ -718,6 +721,8 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	return pi;
 
 clean:
+	/* Take care to put the protocol module's owner before releasing all */
+	scmi_protocol_put(proto->id);
 	devres_release_group(handle->dev, gid);
 out:
 	return ERR_PTR(ret);
@@ -732,7 +737,9 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
  * instance, allocate and initialize all the needed structures while handling
  * resource allocation with a dedicated per-protocol devres subgroup.
  *
- * Return: A reference to an initialized protocol instance or error on failure.
+ * Return: A reference to an initialized protocol instance or error on failure:
+ *	   in particular returns -EPROBE_DEFER when the desired protocol could
+ *	   NOT be found.
  */
 static struct scmi_protocol_instance * __must_check
 scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
@@ -753,7 +760,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 		if (proto)
 			pi = scmi_alloc_init_protocol_instance(info, proto);
 		else
-			pi = ERR_PTR(-ENODEV);
+			pi = ERR_PTR(-EPROBE_DEFER);
 	}
 	mutex_unlock(&info->protocols_mtx);
 
@@ -804,6 +811,8 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 
 		idr_remove(&info->protocols, protocol_id);
 
+		scmi_protocol_put(protocol_id);
+
 		devres_release_group(handle->dev, gid);
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
 			protocol_id);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 059d6214f93b..f4cd5193b961 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scmi_protocol.h>
@@ -909,6 +910,7 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_perf = {
 	.id = SCMI_PROTOCOL_PERF,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_perf_protocol_init,
 	.ops = &perf_proto_ops,
 	.events = &perf_protocol_events,
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index e0987f0a8fb2..ad2ab080f344 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications POWER - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -312,6 +313,7 @@ static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_power = {
 	.id = SCMI_PROTOCOL_POWER,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_power_protocol_init,
 	.ops = &power_proto_ops,
 	.events = &power_protocol_events,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 48b487302db8..9bf2478ec6d1 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications RESET - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -324,6 +325,7 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_reset = {
 	.id = SCMI_PROTOCOL_RESET,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_reset_protocol_init,
 	.ops = &reset_proto_ops,
 	.events = &reset_protocol_events,
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 935c4b08829d..2c88aa221559 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
 
 #include <linux/bitfield.h>
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -990,6 +991,7 @@ static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_sensors = {
 	.id = SCMI_PROTOCOL_SENSOR,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_sensors_protocol_init,
 	.ops = &sensor_proto_ops,
 	.events = &sensor_protocol_events,
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 3631a9f94d27..e5175ef73b40 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "SCMI Notifications SYSTEM - " fmt
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -130,6 +131,7 @@ static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_system = {
 	.id = SCMI_PROTOCOL_SYSTEM,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_system_protocol_init,
 	.ops = NULL,
 	.events = &system_protocol_events,
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index 364bc14aa5fe..a5048956a0be 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020-2021 ARM Ltd.
  */
 
+#include <linux/module.h>
 #include <linux/scmi_protocol.h>
 
 #include "common.h"
@@ -371,6 +372,7 @@ static int scmi_voltage_protocol_init(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_protocol scmi_voltage = {
 	.id = SCMI_PROTOCOL_VOLTAGE,
+	.owner = THIS_MODULE,
 	.instance_init = &scmi_voltage_protocol_init,
 	.ops = &voltage_proto_ops,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b80496d519f3..79d0a1237e6c 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -704,6 +704,18 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 #define module_scmi_driver(__scmi_driver)	\
 	module_driver(__scmi_driver, scmi_register, scmi_unregister)
 
+/**
+ * module_scmi_protocol() - Helper macro for registering a scmi protocol
+ * @__scmi_protocol: scmi_protocol structure
+ *
+ * Helper macro for scmi drivers to set up proper module init / exit
+ * functions.  Replaces module_init() and module_exit() and keeps people from
+ * printing pointless things to the kernel log when their driver is loaded.
+ */
+#define module_scmi_protocol(__scmi_protocol)	\
+	module_driver(__scmi_protocol,		\
+		      scmi_protocol_register, scmi_protocol_unregister)
+
 struct scmi_protocol;
 int scmi_protocol_register(const struct scmi_protocol *proto);
 void scmi_protocol_unregister(const struct scmi_protocol *proto);
-- 
2.17.1

