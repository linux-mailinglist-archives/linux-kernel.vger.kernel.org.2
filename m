Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BDE39DD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFGNQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:16:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:17596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFGNQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:16:20 -0400
IronPort-SDR: EsSwBZPwVOnRhC18zdMXUSJZYtnHTfrYYNlhgzyUrGtJGXRM/YaZyl6SItixAPqUdelBopqSry
 0O7kC/cIhrIg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265773995"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265773995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 06:14:28 -0700
IronPort-SDR: d1xIPnGhVugxh0dThFVEoTGPZciorHsMAomRTUqDhB0/jQDAlWcw5vAmx5Zni2i5uo7NeIbvoq
 A2FNc8rxEMdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551881921"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2021 06:14:27 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/7] usb: typec: ucsi: Process every connector change as unique connector state
Date:   Mon,  7 Jun 2021 16:14:40 +0300
Message-Id: <20210607131442.20121-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will change the Connector Change event handler function
so that it will only read the connector status and store it
as a unique state, queue a job where it's actually
processed, and then acknowledge the event immediately. That
routine will not do anything else from now on.

That will make sure we don't loose any of the reported
connector states even if they are reported while the driver
is still processing the previous ones.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 177 ++++++++++++----------------------
 drivers/usb/typec/ucsi/ucsi.h |   2 -
 2 files changed, 61 insertions(+), 118 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index d41147b3b6e8a..a4123f77d1f16 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -49,11 +49,16 @@ static int ucsi_acknowledge_command(struct ucsi *ucsi)
 static int ucsi_acknowledge_connector_change(struct ucsi *ucsi)
 {
 	u64 ctrl;
+	int ret;
 
 	ctrl = UCSI_ACK_CC_CI;
 	ctrl |= UCSI_ACK_CONNECTOR_CHANGE;
 
-	return ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	mutex_lock(&ucsi->ppm_lock);
+	ret = ucsi->ops->sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
+	mutex_unlock(&ucsi->ppm_lock);
+
+	return ret;
 }
 
 static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
@@ -729,118 +734,26 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 	ucsi_partner_task(con, ucsi_check_altmodes, 30);
 }
 
-static void ucsi_handle_connector_change(struct work_struct *work)
+struct ucsi_con_event {
+	struct work_struct work;
+	struct ucsi_connector *con;
+	struct ucsi_connector_status status;
+};
+
+static void ucsi_connector_work(struct work_struct *work)
 {
-	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
-						  work);
+	struct ucsi_con_event *event = container_of(work, struct ucsi_con_event, work);
+	struct ucsi_connector *con = event->con;
 	struct ucsi *ucsi = con->ucsi;
-	struct ucsi_connector_status pre_ack_status;
-	struct ucsi_connector_status post_ack_status;
 	enum typec_role role;
 	enum usb_role u_role = USB_ROLE_NONE;
-	u16 inferred_changes;
-	u16 changed_flags;
-	u64 command;
 	int ret;
 
 	mutex_lock(&con->lock);
 
-	/*
-	 * Some/many PPMs have an issue where all fields in the change bitfield
-	 * are cleared when an ACK is send. This will causes any change
-	 * between GET_CONNECTOR_STATUS and ACK to be lost.
-	 *
-	 * We work around this by re-fetching the connector status afterwards.
-	 * We then infer any changes that we see have happened but that may not
-	 * be represented in the change bitfield.
-	 *
-	 * Also, even though we don't need to know the currently supported alt
-	 * modes, we run the GET_CAM_SUPPORTED command to ensure the PPM does
-	 * not get stuck in case it assumes we do.
-	 * Always do this, rather than relying on UCSI_CONSTAT_CAM_CHANGE to be
-	 * set in the change bitfield.
-	 *
-	 * We end up with the following actions:
-	 *  1. UCSI_GET_CONNECTOR_STATUS, store result, update unprocessed_changes
-	 *  2. UCSI_GET_CAM_SUPPORTED, discard result
-	 *  3. ACK connector change
-	 *  4. UCSI_GET_CONNECTOR_STATUS, store result
-	 *  5. Infere lost changes by comparing UCSI_GET_CONNECTOR_STATUS results
-	 *  6. If PPM reported a new change, then restart in order to ACK
-	 *  7. Process everything as usual.
-	 *
-	 * We may end up seeing a change twice, but we can only miss extremely
-	 * short transitional changes.
-	 */
-
-	/* 1. First UCSI_GET_CONNECTOR_STATUS */
-	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(ucsi, command, &pre_ack_status,
-				sizeof(pre_ack_status));
-	if (ret < 0) {
-		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
-			__func__, ret);
-		goto out_unlock;
-	}
-	con->unprocessed_changes |= pre_ack_status.change;
-
-	/* 2. Run UCSI_GET_CAM_SUPPORTED and discard the result. */
-	command = UCSI_GET_CAM_SUPPORTED;
-	command |= UCSI_CONNECTOR_NUMBER(con->num);
-	ucsi_send_command(con->ucsi, command, NULL, 0);
-
-	/* 3. ACK connector change */
-	ret = ucsi_acknowledge_connector_change(ucsi);
-	clear_bit(EVENT_PENDING, &ucsi->flags);
-	if (ret) {
-		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
-		goto out_unlock;
-	}
-
-	/* 4. Second UCSI_GET_CONNECTOR_STATUS */
-	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(ucsi, command, &post_ack_status,
-				sizeof(post_ack_status));
-	if (ret < 0) {
-		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
-			__func__, ret);
-		goto out_unlock;
-	}
-
-	/* 5. Inferre any missing changes */
-	changed_flags = pre_ack_status.flags ^ post_ack_status.flags;
-	inferred_changes = 0;
-	if (UCSI_CONSTAT_PWR_OPMODE(changed_flags) != 0)
-		inferred_changes |= UCSI_CONSTAT_POWER_OPMODE_CHANGE;
-
-	if (changed_flags & UCSI_CONSTAT_CONNECTED)
-		inferred_changes |= UCSI_CONSTAT_CONNECT_CHANGE;
-
-	if (changed_flags & UCSI_CONSTAT_PWR_DIR)
-		inferred_changes |= UCSI_CONSTAT_POWER_DIR_CHANGE;
-
-	if (UCSI_CONSTAT_PARTNER_FLAGS(changed_flags) != 0)
-		inferred_changes |= UCSI_CONSTAT_PARTNER_CHANGE;
-
-	if (UCSI_CONSTAT_PARTNER_TYPE(changed_flags) != 0)
-		inferred_changes |= UCSI_CONSTAT_PARTNER_CHANGE;
-
-	/* Mask out anything that was correctly notified in the later call. */
-	inferred_changes &= ~post_ack_status.change;
-	if (inferred_changes)
-		dev_dbg(ucsi->dev, "%s: Inferred changes that would have been lost: 0x%04x\n",
-			__func__, inferred_changes);
-
-	con->unprocessed_changes |= inferred_changes;
-
-	/* 6. If PPM reported a new change, then restart in order to ACK */
-	if (post_ack_status.change)
-		goto out_unlock;
-
-	/* 7. Continue as if nothing happened */
-	con->status = post_ack_status;
-	con->status.change = con->unprocessed_changes;
-	con->unprocessed_changes = 0;
+	trace_ucsi_connector_change(con->num, &event->status);
+	con->status = event->status;
+	kfree(event);
 
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
@@ -898,17 +811,49 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_PARTNER_CHANGE)
 		ucsi_partner_change(con);
 
-	trace_ucsi_connector_change(con->num, &con->status);
+	mutex_unlock(&con->lock);
+}
 
-out_unlock:
-	if (test_and_clear_bit(EVENT_PENDING, &ucsi->flags)) {
-		schedule_work(&con->work);
-		mutex_unlock(&con->lock);
-		return;
+/*
+ * We can not read the connector status in ucsi_connector_change() function
+ * below because there may be already a command pending. This work is scheduled
+ * separately only because of that.
+ *
+ * This function must finish fast so we do not loose the next events. Every
+ * event will have a separate job queued for it in the connector specific
+ * workqueue. That way the next event can be generated safely before the
+ * previous ones are fully processed.
+ */
+static void ucsi_handle_connector_change(struct work_struct *work)
+{
+	struct ucsi_connector *con = container_of(work, struct ucsi_connector, work);
+	struct ucsi_connector_status status;
+	struct ucsi_con_event *event;
+	u64 command;
+	int ret;
+
+	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &status, sizeof(status));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CONNECTOR_STATUS failed (%d)\n", ret);
+		goto out_ack;
 	}
 
-	clear_bit(EVENT_PROCESSING, &ucsi->flags);
-	mutex_unlock(&con->lock);
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		goto out_ack;
+
+	INIT_WORK(&event->work, ucsi_connector_work);
+	event->status = status;
+	event->con = con;
+	queue_work(con->wq, &event->work);
+
+out_ack:
+	clear_bit(EVENT_PENDING, &con->ucsi->flags);
+
+	ret = ucsi_acknowledge_connector_change(con->ucsi);
+	if (ret)
+		dev_err(con->ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
 }
 
 /**
@@ -925,10 +870,10 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 		return;
 	}
 
-	set_bit(EVENT_PENDING, &ucsi->flags);
+	if (test_and_set_bit(EVENT_PENDING, &ucsi->flags))
+		return;
 
-	if (!test_and_set_bit(EVENT_PROCESSING, &ucsi->flags))
-		schedule_work(&con->work);
+	schedule_work(&con->work);
 }
 EXPORT_SYMBOL_GPL(ucsi_connector_change);
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index d10b8c24435af..280f1e1bda2c9 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -300,7 +300,6 @@ struct ucsi {
 #define EVENT_PENDING	0
 #define COMMAND_PENDING	1
 #define ACK_PENDING	2
-#define EVENT_PROCESSING	3
 };
 
 #define UCSI_MAX_SVID		5
@@ -327,7 +326,6 @@ struct ucsi_connector {
 
 	struct typec_capability typec_cap;
 
-	u16 unprocessed_changes;
 	struct ucsi_connector_status status;
 	struct ucsi_connector_capability cap;
 	struct power_supply *psy;
-- 
2.30.2

