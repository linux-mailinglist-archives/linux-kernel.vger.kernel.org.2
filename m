Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79923C5E31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhGLOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:22:17 -0400
Received: from foss.arm.com ([217.140.110.172]:55994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235022AbhGLOWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:22:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 323071FB;
        Mon, 12 Jul 2021 07:19:25 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8283F774;
        Mon, 12 Jul 2021 07:19:21 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: [PATCH v6 08/17] firmware: arm_scmi: Add priv parameter to scmi_rx_callback
Date:   Mon, 12 Jul 2021 15:18:24 +0100
Message-Id: <20210712141833.6628-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712141833.6628-1-cristian.marussi@arm.com>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new opaque void *priv parameter to scmi_rx_callback which can be
optionally provided by the transport layer when invoking scmi_rx_callback
and that will be passed back to the transport layer in xfer->priv.

This can be used by transports that needs to keep track of their specific
data structures together with the valid xfers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h  |  4 +++-
 drivers/firmware/arm_scmi/driver.c  | 17 ++++++++++++-----
 drivers/firmware/arm_scmi/mailbox.c |  2 +-
 drivers/firmware/arm_scmi/smc.c     |  3 ++-
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 9efebe1406d2..5707789de66c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -153,6 +153,7 @@ struct scmi_msg {
  *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
  *	      (Missing synchronous response is assumed OK and ignored)
  * @lock: A spinlock to protect state and busy fields.
+ * @priv: A pointer for transport private usage.
  */
 struct scmi_xfer {
 	int transfer_id;
@@ -173,6 +174,7 @@ struct scmi_xfer {
 	int state;
 	/* A lock to protect state and busy fields */
 	spinlock_t lock;
+	void *priv;
 };
 
 /*
@@ -389,7 +391,7 @@ extern const struct scmi_desc scmi_mailbox_desc;
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
 /* shmem related declarations */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 5ef33d692670..dc14bc63cb43 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -593,7 +593,8 @@ static inline void scmi_xfer_state_update(struct scmi_xfer *xfer)
 	}
 }
 
-static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
+static void scmi_handle_notification(struct scmi_chan_info *cinfo,
+				     u32 msg_hdr, void *priv)
 {
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
@@ -611,6 +612,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
+	if (priv)
+		xfer->priv = priv;
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -625,7 +628,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	info->desc->ops->clear_channel(cinfo);
 }
 
-static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
+static void scmi_handle_response(struct scmi_chan_info *cinfo,
+				 u32 msg_hdr, void *priv)
 {
 	struct scmi_xfer *xfer;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
@@ -642,6 +646,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
 		xfer->rx.len = info->desc->max_msg_size;
 
+	if (priv)
+		xfer->priv = priv;
 	info->desc->ops->fetch_response(cinfo, xfer);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
@@ -663,6 +669,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
  *
  * @cinfo: SCMI channel info
  * @msg_hdr: Message header
+ * @priv: Transport specific private data.
  *
  * Processes one received message to appropriate transfer information and
  * signals completion of the transfer.
@@ -670,17 +677,17 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
  * NOTE: This function will be invoked in IRQ context, hence should be
  * as optimal as possible.
  */
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
 {
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
 
 	switch (msg_type) {
 	case MSG_TYPE_NOTIFICATION:
-		scmi_handle_notification(cinfo, msg_hdr);
+		scmi_handle_notification(cinfo, msg_hdr, priv);
 		break;
 	case MSG_TYPE_COMMAND:
 	case MSG_TYPE_DELAYED_RESP:
-		scmi_handle_response(cinfo, msg_hdr);
+		scmi_handle_response(cinfo, msg_hdr, priv);
 		break;
 	default:
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index e3dcb58314ae..e09eb12bf421 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -43,7 +43,7 @@ static void rx_callback(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem));
+	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
 }
 
 static bool mailbox_chan_available(struct device *dev, int idx)
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index bed5596c7209..4effecc3bb46 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -154,7 +154,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	if (scmi_info->irq)
 		wait_for_completion(&scmi_info->tx_complete);
 
-	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
+	scmi_rx_callback(scmi_info->cinfo,
+			 shmem_read_header(scmi_info->shmem), NULL);
 
 	mutex_unlock(&scmi_info->shmem_lock);
 
-- 
2.17.1

