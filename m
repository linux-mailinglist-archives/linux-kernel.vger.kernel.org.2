Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E9382BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhEQMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:17:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:59149 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234022AbhEQMRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:17:04 -0400
IronPort-SDR: Xug4CixnJT4K8mQ9WetsZHdsu8+w/n2cRaKlwUn03iy+nCUbJXIGe7+fQiy8fh7GXE/5n2s2e+
 fNN/IKbubhNg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="221484801"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208,223";a="221484801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:15:34 -0700
IronPort-SDR: H0Q0lUZpdpw/QPZL7MrvfEI5+sNeT7P57DrRHcmbKtn4Puag6gAUWp9aumvPHB5HDY27JsT/fg
 MJvmH/7IC22g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208,223";a="540393425"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2021 05:15:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 May 2021 15:15:31 +0300
Date:   Mon, 17 May 2021 15:15:31 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Berg <bberg@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
Message-ID: <YKJeYzIgvL/soGgw@kuha.fi.intel.com>
References: <20210516040953.622409-1-bjorn.andersson@linaro.org>
 <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uh6xwqwzdpkpZFYF"
Content-Disposition: inline
In-Reply-To: <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uh6xwqwzdpkpZFYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, May 17, 2021 at 01:03:12PM +0300, Heikki Krogerus wrote:
> On Sat, May 15, 2021 at 09:09:53PM -0700, Bjorn Andersson wrote:
> > It's possible that the interrupt handler for the UCSI driver signals a
> > connector changes after the handler clears the PENDING bit, but before
> > it has sent the acknowledge request. The result is that the handler is
> > invoked yet again, to ack the same connector change.
> > 
> > At least some versions of the Qualcomm UCSI firmware will not handle the
> > second - "spurious" - acknowledgment gracefully. So make sure to not
> > clear the pending flag until the change is acknowledged.
> > 
> > Any connector changes coming in after the acknowledgment, that would
> > have the pending flag incorrectly cleared, would afaict be covered by
> > the subsequent connector status check.
> > 
> > Fixes: 217504a05532 ("usb: typec: ucsi: Work around PPM losing change information")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> I'm OK with this if Bejamin does not see any problems with it. I'll
> wait for his comments before giving my reviewed-by tag.
> 
> That workaround (commit 217504a05532) is unfortunately too fragile.
> I'm going to now separate the processing of the connector state from
> the event handler (interrupt handler). That way we should be fairly
> sure we don't loose any of the connector states even if an event is
> generated while we are still in the middle of processing the previous
> one(s), and at the same time be sure that we also don't confuse the
> firmware.
> 
> So the event handler shall after that only read the connector status,
> schedule the unique job where it's processed and ACK the event.
> Nothing else.

Seems to be straightforward to implement. I'm attaching the patch I
made for that. I think it should actually also remove the problem you
are seeing. Can you test it?

thanks,

-- 
heikki

--uh6xwqwzdpkpZFYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-ucsi-Process-every-connector-change-as-uni.patch"

From d3d2e0cbd7a278e235050294af25259aabb2c7c2 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Mon, 17 May 2021 14:58:22 +0300
Subject: [PATCH] usb: typec: ucsi: Process every connector change as unique
 connector state

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
 drivers/usb/typec/ucsi/ucsi.c | 197 ++++++++++++++--------------------
 drivers/usb/typec/ucsi/ucsi.h |   3 +-
 2 files changed, 82 insertions(+), 118 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 1d8b7df59ff49..1dac2e6325870 100644
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
@@ -656,118 +661,26 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 		ucsi_altmode_update_active(con);
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
-	clear_bit(EVENT_PENDING, &ucsi->flags);
-	ret = ucsi_acknowledge_connector_change(ucsi);
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
 
@@ -825,17 +738,49 @@ static void ucsi_handle_connector_change(struct work_struct *work)
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
@@ -852,10 +797,10 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
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
 
@@ -1041,8 +986,18 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 	enum typec_accessory *accessory = cap->accessory;
 	enum usb_role u_role = USB_ROLE_NONE;
 	u64 command;
+	char *name;
 	int ret;
 
+	name = kasprintf(GFP_KERNEL, "%s-port%d", dev_name(ucsi->dev), index);
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
@@ -1178,6 +1133,12 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
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
 
@@ -1248,6 +1209,8 @@ static int ucsi_init(struct ucsi *ucsi)
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		typec_unregister_port(con->port);
 		con->port = NULL;
 	}
@@ -1369,6 +1332,8 @@ void ucsi_unregister(struct ucsi *ucsi)
 		ucsi_unregister_altmodes(&ucsi->connector[i],
 					 UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(&ucsi->connector[i]);
+		if (ucsi->connector[i].wq)
+			destroy_workqueue(ucsi->connector[i].wq);
 		typec_unregister_port(ucsi->connector[i].port);
 	}
 
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cee666790907e..280f1e1bda2c9 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -300,7 +300,6 @@ struct ucsi {
 #define EVENT_PENDING	0
 #define COMMAND_PENDING	1
 #define ACK_PENDING	2
-#define EVENT_PROCESSING	3
 };
 
 #define UCSI_MAX_SVID		5
@@ -317,6 +316,7 @@ struct ucsi_connector {
 	struct mutex lock; /* port lock */
 	struct work_struct work;
 	struct completion complete;
+	struct workqueue_struct *wq;
 
 	struct typec_port *port;
 	struct typec_partner *partner;
@@ -326,7 +326,6 @@ struct ucsi_connector {
 
 	struct typec_capability typec_cap;
 
-	u16 unprocessed_changes;
 	struct ucsi_connector_status status;
 	struct ucsi_connector_capability cap;
 	struct power_supply *psy;
-- 
2.30.2


--uh6xwqwzdpkpZFYF--
