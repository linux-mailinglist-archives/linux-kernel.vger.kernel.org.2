Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3057339DD67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFGNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:17596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhFGNQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:17 -0400
IronPort-SDR: pLAQcxNKA6gwSCzyA+k6f0rq8oMfRG1sY6VoZbXhg3FySiNxs5RqEy5cmm1arzFFO/GVsyU4OH
 6NZQf9A4qteQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265773983"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265773983"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:25 -0700
IronPort-SDR: FpZ1FvGeOm6FXn4ByAUud7BHNXflla4ZULBicygVPDwbq1uzhM3jdYXpKLXdA4lHjwxHOsARQt
 Hxm/zMJUFgpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881880"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:23 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] usb: typec: ucsi: Add poll worker for alternate modes
Date:   Mon,  7 Jun 2021 16:14:38 +0300
Message-Id: <20210607131442.20121-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WIP.

The alternate modes are now checked by polling them. That
make's it possible to drop the huge delay for command
completion timeout that we now have at least in the UCSI
ACPI driver. The delay was causing other problems as
the driver can't do anything for the connector until the
command completes.

In practice this is a "better" workaround for the problem
where the firmware (PPM) does not return BUSY when it should
with some commands.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 104 +++++++++++++++++++++++++++++++---
 drivers/usb/typec/ucsi/ucsi.h |   1 +
 2 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a8e0e31dcddf5..d41147b3b6e8a 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -191,6 +191,62 @@ int ucsi_resume(struct ucsi *ucsi)
 EXPORT_SYMBOL_GPL(ucsi_resume);
 /* -------------------------------------------------------------------------- */
 
+struct ucsi_work {
+	struct work_struct work;
+	unsigned int count;
+	struct ucsi_connector *con;
+	int (*cb)(struct ucsi_connector *);
+};
+
+static void ucsi_poll_worker(struct work_struct *work)
+{
+	struct ucsi_work *uwork = container_of(work, struct ucsi_work, work);
+	struct ucsi_connector *con = uwork->con;
+	int ret;
+
+	mutex_lock(&con->lock);
+
+	if (!con->partner) {
+		mutex_unlock(&con->lock);
+		kfree(uwork);
+		return;
+	}
+
+	ret = uwork->cb(con);
+
+	if (uwork->count-- && (ret == -EBUSY || ret == -ETIMEDOUT))
+		queue_work(con->wq, &uwork->work);
+	else
+		kfree(uwork);
+
+	mutex_unlock(&con->lock);
+}
+
+static int ucsi_partner_task(struct ucsi_connector *con,
+			     int (*cb)(struct ucsi_connector *),
+			     int retries)
+{
+	struct ucsi_work *uwork;
+
+	if (!con->partner)
+		return 0;
+
+	uwork = kzalloc(sizeof(*uwork), GFP_KERNEL);
+	if (!uwork)
+		return -ENOMEM;
+
+	INIT_WORK(&uwork->work, ucsi_poll_worker);
+	uwork->count = retries;
+	uwork->con = con;
+	uwork->cb = cb;
+
+	queue_work(con->wq, &uwork->work);
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+
 void ucsi_altmode_update_active(struct ucsi_connector *con)
 {
 	const struct typec_altmode *altmode = NULL;
@@ -544,6 +600,25 @@ static void ucsi_get_src_pdos(struct ucsi_connector *con, int is_partner)
 	con->num_pdos += ret / sizeof(u32);
 }
 
+static int ucsi_check_altmodes(struct ucsi_connector *con)
+{
+	int ret;
+
+	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP);
+	if (ret && ret != -ETIMEDOUT)
+		dev_err(con->ucsi->dev,
+			"con%d: failed to register partner alt modes (%d)\n",
+			con->num, ret);
+
+	/* Ignoring the errors in this case. */
+	if (con->partner_altmode[0]) {
+		ucsi_altmode_update_active(con);
+		return 0;
+	}
+
+	return ret;
+}
+
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 {
 	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
@@ -651,14 +726,7 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 		dev_err(con->ucsi->dev, "con:%d: failed to set usb role:%d\n",
 			con->num, u_role);
 
-	/* Can't rely on Partner Flags field. Always checking the alt modes. */
-	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP);
-	if (ret)
-		dev_err(con->ucsi->dev,
-			"con%d: failed to register partner alternate modes\n",
-			con->num);
-	else
-		ucsi_altmode_update_active(con);
+	ucsi_partner_task(con, ucsi_check_altmodes, 30);
 }
 
 static void ucsi_handle_connector_change(struct work_struct *work)
@@ -1046,8 +1114,18 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	enum typec_accessory *accessory = cap->accessory;
 	enum usb_role u_role = USB_ROLE_NONE;
 	u64 command;
+	char *name;
 	int ret;
 
+	name = kasprintf(GFP_KERNEL, "%s-con%d", dev_name(ucsi->dev), con->num);
+	if (!name)
+		return -ENOMEM;
+
+	con->wq = create_singlethread_workqueue(name);
+	kfree(name);
+	if (!con->wq)
+		return -ENOMEM;
+
 	INIT_WORK(&con->work, ucsi_handle_connector_change);
 	init_completion(&con->complete);
 	mutex_init(&con->lock);
@@ -1183,6 +1261,12 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	fwnode_handle_put(cap->fwnode);
 out_unlock:
 	mutex_unlock(&con->lock);
+
+	if (ret && con->wq) {
+		destroy_workqueue(con->wq);
+		con->wq = NULL;
+	}
+
 	return ret;
 }
 
@@ -1253,6 +1337,8 @@ static int ucsi_init(struct ucsi *ucsi)
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		typec_unregister_port(con->port);
 		con->port = NULL;
 	}
@@ -1374,6 +1460,8 @@ void ucsi_unregister(struct ucsi *ucsi)
 		ucsi_unregister_altmodes(&ucsi->connector[i],
 					 UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(&ucsi->connector[i]);
+		if (ucsi->connector[i].wq)
+			destroy_workqueue(ucsi->connector[i].wq);
 		typec_unregister_port(ucsi->connector[i].port);
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cee666790907e..d10b8c24435af 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -317,6 +317,7 @@ struct ucsi_connector {
 	struct mutex lock; /* port lock */
 	struct work_struct work;
 	struct completion complete;
+	struct workqueue_struct *wq;
 
 	struct typec_port *port;
 	struct typec_partner *partner;
-- 
2.30.2

