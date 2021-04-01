Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C85350F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhDAGyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:54:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:28103 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233530AbhDAGxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:38 -0400
IronPort-SDR: xUyd5jMC0jeydRZExMDjVmQ+qvycVBK9Ml8cKypzXiNsoBCY/7z/PWIZGT2w8TvrXwhgSrjedn
 3CDAFFbYkPug==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="188910798"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="188910798"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 23:53:38 -0700
IronPort-SDR: BD2fmedzq+p5Cvct2SGCdm8awQXATwpWKmKTWxxCus30gxc2sKbXVSQg2PxAqlVq+weKaCgvvH
 qf8YX6v1MKzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517218644"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 23:53:36 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] usb: typec: Organize the private headers properly
Date:   Thu,  1 Apr 2021 09:53:42 +0300
Message-Id: <20210401065347.4010-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
References: <20210401065347.4010-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a header file for each subsystem - the connector
class, alt mode bus and the class for the muxes.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/bus.c   |  2 ++
 drivers/usb/typec/bus.h   | 19 +---------
 drivers/usb/typec/class.c | 69 +++--------------------------------
 drivers/usb/typec/class.h | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/typec/mux.c   |  4 +--
 drivers/usb/typec/mux.h   | 21 +++++++++++
 6 files changed, 107 insertions(+), 84 deletions(-)
 create mode 100644 drivers/usb/typec/class.h
 create mode 100644 drivers/usb/typec/mux.h

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index e8ddb81cb6df4..7f3c9a8e2bf08 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -9,6 +9,8 @@
 #include <linux/usb/pd_vdo.h>
 
 #include "bus.h"
+#include "class.h"
+#include "mux.h"
 
 static inline int
 typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
index 8ba8112d2740d..56dec268d4dd9 100644
--- a/drivers/usb/typec/bus.h
+++ b/drivers/usb/typec/bus.h
@@ -4,9 +4,9 @@
 #define __USB_TYPEC_ALTMODE_H__
 
 #include <linux/usb/typec_altmode.h>
-#include <linux/usb/typec_mux.h>
 
 struct bus_type;
+struct typec_mux;
 
 struct altmode {
 	unsigned int			id;
@@ -28,24 +28,7 @@ struct altmode {
 
 extern struct bus_type typec_bus;
 extern const struct device_type typec_altmode_dev_type;
-extern const struct device_type typec_port_dev_type;
 
 #define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
-#define is_typec_port(_dev_) (_dev_->type == &typec_port_dev_type)
-
-extern struct class typec_mux_class;
-
-struct typec_switch {
-	struct device dev;
-	typec_switch_set_fn_t set;
-};
-
-struct typec_mux {
-	struct device dev;
-	typec_mux_set_fn_t set;
-};
-
-#define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
-#define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
 
 #endif /* __USB_TYPEC_ALTMODE_H__ */
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 45f0bf65e9aba..5fa279a96b6ef 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -6,74 +6,15 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
-#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/usb/pd_vdo.h>
+#include <linux/usb/typec_mux.h>
 
 #include "bus.h"
-
-struct typec_plug {
-	struct device			dev;
-	enum typec_plug_index		index;
-	struct ida			mode_ids;
-	int				num_altmodes;
-};
-
-struct typec_cable {
-	struct device			dev;
-	enum typec_plug_type		type;
-	struct usb_pd_identity		*identity;
-	unsigned int			active:1;
-	u16				pd_revision; /* 0300H = "3.0" */
-};
-
-struct typec_partner {
-	struct device			dev;
-	unsigned int			usb_pd:1;
-	struct usb_pd_identity		*identity;
-	enum typec_accessory		accessory;
-	struct ida			mode_ids;
-	int				num_altmodes;
-	u16				pd_revision; /* 0300H = "3.0" */
-	enum usb_pd_svdm_ver		svdm_version;
-};
-
-struct typec_port {
-	unsigned int			id;
-	struct device			dev;
-	struct ida			mode_ids;
-
-	int				prefer_role;
-	enum typec_data_role		data_role;
-	enum typec_role			pwr_role;
-	enum typec_role			vconn_role;
-	enum typec_pwr_opmode		pwr_opmode;
-	enum typec_port_type		port_type;
-	struct mutex			port_type_lock;
-
-	enum typec_orientation		orientation;
-	struct typec_switch		*sw;
-	struct typec_mux		*mux;
-
-	const struct typec_capability	*cap;
-	const struct typec_operations   *ops;
-};
-
-#define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
-#define to_typec_plug(_dev_) container_of(_dev_, struct typec_plug, dev)
-#define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
-#define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
-
-static const struct device_type typec_partner_dev_type;
-static const struct device_type typec_cable_dev_type;
-static const struct device_type typec_plug_dev_type;
-
-#define is_typec_partner(_dev_) (_dev_->type == &typec_partner_dev_type)
-#define is_typec_cable(_dev_) (_dev_->type == &typec_cable_dev_type)
-#define is_typec_plug(_dev_) (_dev_->type == &typec_plug_dev_type)
+#include "class.h"
 
 static DEFINE_IDA(typec_index_ida);
 static struct class *typec_class;
@@ -726,7 +667,7 @@ static void typec_partner_release(struct device *dev)
 	kfree(partner);
 }
 
-static const struct device_type typec_partner_dev_type = {
+const struct device_type typec_partner_dev_type = {
 	.name = "typec_partner",
 	.groups = typec_partner_groups,
 	.release = typec_partner_release,
@@ -941,7 +882,7 @@ static const struct attribute_group *typec_plug_groups[] = {
 	NULL
 };
 
-static const struct device_type typec_plug_dev_type = {
+const struct device_type typec_plug_dev_type = {
 	.name = "typec_plug",
 	.groups = typec_plug_groups,
 	.release = typec_plug_release,
@@ -1089,7 +1030,7 @@ static void typec_cable_release(struct device *dev)
 	kfree(cable);
 }
 
-static const struct device_type typec_cable_dev_type = {
+const struct device_type typec_cable_dev_type = {
 	.name = "typec_cable",
 	.groups = typec_cable_groups,
 	.release = typec_cable_release,
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
new file mode 100644
index 0000000000000..d414be58d122e
--- /dev/null
+++ b/drivers/usb/typec/class.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_CLASS__
+#define __USB_TYPEC_CLASS__
+
+#include <linux/device.h>
+#include <linux/usb/typec.h>
+
+struct typec_mux;
+struct typec_switch;
+
+struct typec_plug {
+	struct device			dev;
+	enum typec_plug_index		index;
+	struct ida			mode_ids;
+	int				num_altmodes;
+};
+
+struct typec_cable {
+	struct device			dev;
+	enum typec_plug_type		type;
+	struct usb_pd_identity		*identity;
+	unsigned int			active:1;
+	u16				pd_revision; /* 0300H = "3.0" */
+};
+
+struct typec_partner {
+	struct device			dev;
+	unsigned int			usb_pd:1;
+	struct usb_pd_identity		*identity;
+	enum typec_accessory		accessory;
+	struct ida			mode_ids;
+	int				num_altmodes;
+	u16				pd_revision; /* 0300H = "3.0" */
+	enum usb_pd_svdm_ver		svdm_version;
+};
+
+struct typec_port {
+	unsigned int			id;
+	struct device			dev;
+	struct ida			mode_ids;
+
+	int				prefer_role;
+	enum typec_data_role		data_role;
+	enum typec_role			pwr_role;
+	enum typec_role			vconn_role;
+	enum typec_pwr_opmode		pwr_opmode;
+	enum typec_port_type		port_type;
+	struct mutex			port_type_lock;
+
+	enum typec_orientation		orientation;
+	struct typec_switch		*sw;
+	struct typec_mux		*mux;
+
+	const struct typec_capability	*cap;
+	const struct typec_operations   *ops;
+};
+
+#define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
+#define to_typec_plug(_dev_) container_of(_dev_, struct typec_plug, dev)
+#define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
+#define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
+
+extern const struct device_type typec_partner_dev_type;
+extern const struct device_type typec_cable_dev_type;
+extern const struct device_type typec_plug_dev_type;
+extern const struct device_type typec_port_dev_type;
+
+#define is_typec_partner(dev) ((dev)->type == &typec_partner_dev_type)
+#define is_typec_cable(dev) ((dev)->type == &typec_cable_dev_type)
+#define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
+#define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
+
+extern struct class typec_mux_class;
+
+#endif /* __USB_TYPEC_CLASS__ */
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index cf720e944aaaa..9da22ae3006c9 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -13,9 +13,9 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
-#include <linux/usb/typec_mux.h>
 
-#include "bus.h"
+#include "class.h"
+#include "mux.h"
 
 static bool dev_name_ends_with(struct device *dev, const char *suffix)
 {
diff --git a/drivers/usb/typec/mux.h b/drivers/usb/typec/mux.h
new file mode 100644
index 0000000000000..4fd9426ee44f6
--- /dev/null
+++ b/drivers/usb/typec/mux.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_MUX__
+#define __USB_TYPEC_MUX__
+
+#include <linux/usb/typec_mux.h>
+
+struct typec_switch {
+	struct device dev;
+	typec_switch_set_fn_t set;
+};
+
+struct typec_mux {
+	struct device dev;
+	typec_mux_set_fn_t set;
+};
+
+#define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
+#define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
+
+#endif /* __USB_TYPEC_MUX__ */
-- 
2.30.2

