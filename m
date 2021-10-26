Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B153B43B496
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhJZOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:46:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:13764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236884AbhJZOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253467456"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253467456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="635200393"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2021 07:34:09 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] usb: typec: ucsi: Add support for PD cdev
Date:   Tue, 26 Oct 2021 17:33:51 +0300
Message-Id: <20211026143352.78387-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interim.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/Makefile |   2 +-
 drivers/usb/typec/ucsi/pd-dev.c | 125 ++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.c   |  37 +++++++---
 drivers/usb/typec/ucsi/ucsi.h   |   7 ++
 4 files changed, 161 insertions(+), 10 deletions(-)
 create mode 100644 drivers/usb/typec/ucsi/pd-dev.c

diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index 8a8eb5cb8e0f0..097af32468f96 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -3,7 +3,7 @@ CFLAGS_trace.o				:= -I$(src)
 
 obj-$(CONFIG_TYPEC_UCSI)		+= typec_ucsi.o
 
-typec_ucsi-y				:= ucsi.o
+typec_ucsi-y				:= ucsi.o pd-dev.o
 
 typec_ucsi-$(CONFIG_TRACING)		+= trace.o
 
diff --git a/drivers/usb/typec/ucsi/pd-dev.c b/drivers/usb/typec/ucsi/pd-dev.c
new file mode 100644
index 0000000000000..3c03d3d859198
--- /dev/null
+++ b/drivers/usb/typec/ucsi/pd-dev.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UCSI USB Power Delivery Device
+ *
+ * Copyright (C) 2021, Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include "ucsi.h"
+
+static struct ucsi_connector *pd_dev_to_connector(const struct pd_dev *dev);
+
+static int ucsi_pd_get_objects(const struct pd_dev *dev, struct pd_message *msg)
+{
+	struct ucsi_connector *con = pd_dev_to_connector(dev);
+	int partner = dev == &con->pd_partner_dev;
+	int ret = -ENOTTY;
+
+	mutex_lock(&con->lock);
+
+	if (le16_to_cpu(msg->header) & PD_HEADER_EXT_HDR)
+		goto err;
+
+	switch (pd_header_type_le(msg->header)) {
+	case PD_DATA_SOURCE_CAP:
+		ret = ucsi_read_pdos(con, partner, 1, msg->payload);
+		if (ret < 0)
+			goto err;
+
+		msg->header = PD_HEADER_LE(PD_DATA_SOURCE_CAP, 0, 0, 0, 0, ret);
+		break;
+	case PD_DATA_REQUEST:
+		msg->header = PD_HEADER_LE(PD_DATA_REQUEST, 0, 0, 0, 0, 1);
+		msg->payload[0] = con->status.request_data_obj;
+		break;
+	case PD_DATA_SINK_CAP:
+		ret = ucsi_read_pdos(con, partner, 0, msg->payload);
+		if (ret < 0)
+			goto err;
+
+		msg->header = PD_HEADER_LE(PD_DATA_SINK_CAP, 0, 0, 0, 0, ret);
+		break;
+	default:
+		goto err;
+	}
+
+	ret = 0;
+err:
+	mutex_unlock(&con->lock);
+
+	return ret;
+}
+
+/*
+ * This function is here just as an example for now.
+ */
+static int ucsi_pd_submit(const struct pd_dev *dev, struct pd_message *msg)
+{
+	struct ucsi_connector *con = pd_dev_to_connector(dev);
+	int ret;
+
+	mutex_lock(&con->lock);
+
+	switch (pd_header_type_le(msg->header)) {
+	case PD_CTRL_GET_SOURCE_CAP:
+		ret = ucsi_read_pdos(con, 1, 1, msg->payload);
+		if (ret < 0)
+			goto err;
+
+		msg->header = PD_HEADER_LE(PD_DATA_SOURCE_CAP, 0, 0, 0, 0, ret);
+		break;
+	case PD_CTRL_GET_SINK_CAP:
+		ret = ucsi_read_pdos(con, 1, 0, msg->payload);
+		if (ret < 0)
+			goto err;
+
+		msg->header = PD_HEADER_LE(PD_DATA_SINK_CAP, 0, 0, 0, 0, ret);
+		break;
+	default:
+		ret = -ENOTTY;
+		goto err;
+	}
+
+	ret = 0;
+err:
+	mutex_unlock(&con->lock);
+
+	return ret;
+}
+
+static const struct pd_ops ucsi_pd_partner_ops = {
+	.get_message = ucsi_pd_get_objects,
+	.submit = ucsi_pd_submit,
+};
+
+static struct pd_info ucsi_pd_partner_info = {
+	.specification_revision = 2,
+	.ctrl_msgs_supported = BIT(PD_CTRL_GET_SOURCE_CAP) |
+			       BIT(PD_CTRL_GET_SINK_CAP),
+};
+
+static const struct pd_ops ucsi_pd_port_ops = {
+	.get_message = ucsi_pd_get_objects,
+};
+
+static struct pd_info ucsi_pd_port_info = {
+	.specification_revision = 2,
+};
+
+static struct ucsi_connector *pd_dev_to_connector(const struct pd_dev *dev)
+{
+	if (dev->info == &ucsi_pd_port_info)
+		return container_of(dev, struct ucsi_connector, pd_port_dev);
+	if (dev->info == &ucsi_pd_partner_info)
+		return container_of(dev, struct ucsi_connector, pd_partner_dev);
+	return NULL;
+}
+
+void ucsi_init_pd_dev(struct ucsi_connector *con)
+{
+	con->pd_port_dev.info = &ucsi_pd_port_info;
+	con->pd_port_dev.ops = &ucsi_pd_port_ops;
+	con->pd_partner_dev.info = &ucsi_pd_partner_info;
+	con->pd_partner_dev.ops = &ucsi_pd_partner_ops;
+}
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 6aa28384f77f1..e9e6d7608bdaf 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -557,7 +557,7 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
 	}
 }
 
-static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
+static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner, int source,
 			 u32 *pdos, int offset, int num_pdos)
 {
 	struct ucsi *ucsi = con->ucsi;
@@ -568,7 +568,7 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
 	command |= UCSI_GET_PDOS_PARTNER_PDO(is_partner);
 	command |= UCSI_GET_PDOS_PDO_OFFSET(offset);
 	command |= UCSI_GET_PDOS_NUM_PDOS(num_pdos - 1);
-	command |= UCSI_GET_PDOS_SRC_PDOS;
+	command |= source ? UCSI_GET_PDOS_SRC_PDOS : 0;
 	ret = ucsi_send_command(ucsi, command, pdos + offset,
 				num_pdos * sizeof(u32));
 	if (ret < 0 && ret != -ETIMEDOUT)
@@ -579,27 +579,43 @@ static int ucsi_get_pdos(struct ucsi_connector *con, int is_partner,
 	return ret;
 }
 
-static int ucsi_get_src_pdos(struct ucsi_connector *con)
+int ucsi_read_pdos(struct ucsi_connector *con, int partner, int source, u32 *pdos)
 {
+	u32 pdo[PDO_MAX_OBJECTS];
+	int num_pdos;
 	int ret;
 
 	/* UCSI max payload means only getting at most 4 PDOs at a time */
-	ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
+	ret = ucsi_get_pdos(con, partner, source, pdo, 0, UCSI_MAX_PDOS);
 	if (ret < 0)
 		return ret;
 
-	con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
-	if (con->num_pdos < UCSI_MAX_PDOS)
-		return 0;
+	num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
+	if (num_pdos < UCSI_MAX_PDOS)
+		goto done;
 
 	/* get the remaining PDOs, if any */
-	ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
+	ret = ucsi_get_pdos(con, partner, source, pdo, UCSI_MAX_PDOS,
 			    PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
 	if (ret < 0)
 		return ret;
 
-	con->num_pdos += ret / sizeof(u32);
+	num_pdos += ret / sizeof(u32);
+done:
+	memcpy(pdos, pdo, num_pdos * sizeof(pdo));
+
+	return num_pdos;
+}
+
+static int ucsi_get_src_pdos(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_read_pdos(con, 0, 1, con->src_pdos);
+	if (ret < 0)
+		return ret;
 
+	con->num_pdos = ret;
 	ucsi_port_psy_changed(con);
 
 	return 0;
@@ -671,6 +687,7 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 	}
 
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
+	desc.pd_dev = &con->pd_partner_dev;
 
 	partner = typec_register_partner(con->port, &desc);
 	if (IS_ERR(partner)) {
@@ -1038,6 +1055,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	mutex_init(&con->lock);
 	con->num = index + 1;
 	con->ucsi = ucsi;
+	ucsi_init_pd_dev(con);
 
 	/* Delay other interactions with the con until registration is complete */
 	mutex_lock(&con->lock);
@@ -1077,6 +1095,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	cap->fwnode = ucsi_find_fwnode(con);
 	cap->driver_data = con;
 	cap->ops = &ucsi_ops;
+	cap->pd_dev = &con->pd_port_dev;
 
 	ret = ucsi_register_port_psy(con);
 	if (ret)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 280f1e1bda2c9..1da97ddedf363 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/pd_dev.h>
 #include <linux/usb/role.h>
 
 /* -------------------------------------------------------------------------- */
@@ -335,6 +336,9 @@ struct ucsi_connector {
 	int num_pdos;
 
 	struct usb_role_switch *usb_role_sw;
+
+	struct pd_dev pd_port_dev;
+	struct pd_dev pd_partner_dev;
 };
 
 int ucsi_send_command(struct ucsi *ucsi, u64 command,
@@ -343,6 +347,9 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
 void ucsi_altmode_update_active(struct ucsi_connector *con);
 int ucsi_resume(struct ucsi *ucsi);
 
+void ucsi_init_pd_dev(struct ucsi_connector *con);
+int ucsi_read_pdos(struct ucsi_connector *con, int partner, int source, u32 *pdos);
+
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 int ucsi_register_port_psy(struct ucsi_connector *con);
 void ucsi_unregister_port_psy(struct ucsi_connector *con);
-- 
2.33.0

