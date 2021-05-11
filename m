Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F251B379B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhEKA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:29:51 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:26881 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhEKA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:44 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 3D911A1A32;
        Tue, 11 May 2021 02:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=/5Dxcbib2uhu
        l8GgPx/VJRtYLOF11009NaDVvtRbKkg=; b=ZeN6OTiYGFHRcbQZmlEyWwXZybUo
        J3X0++xambBLe+GJ+VSQ8qmpUE7x97am3+9Gh3bHPPHXpJPVWpB7Rl9EEuGnchcY
        MLPHkrdVnCNDoP55fS2pZw9BT0sDMglxLPjgZNu+tI0svX9bOxyG/p2bprfHjTV/
        Xr5phJJhWRymwbiT23Fai5395Px8DRZRP0YrjxNIw70q0kag6zYZIPrmDHJc339s
        4u1xpa73CjqfFF15zz4rr0SKh77wKXhZp2S3TuNUw5mHf7Qf86IiQULED0kpDHwW
        KNH6O05SlpEyCy7d+MEk24pIOPPSepzdF3cC1tTRJC+ZmtrjL20SJFylAg==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH v3 07/12] firmware: arm_scmi: Add msg_handle to some transport ops
Date:   Tue, 11 May 2021 02:20:35 +0200
Message-ID: <20210511002040.802226-8-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming virtio transport may xfer several SCMI messages in parallel
on a channel. But the transport ops which fetch messages lack
information through which a transport can determine which of several
messages the core intends to address. The virtio transport should not
rely on the current implementation details of the core to deduce the
message.

Disambiguate this by having the transport pass an opaque message handle
to scmi_rx_callback(), which the transport will then use in the message
fetching transport ops to identify which message to address. Do not
address how to handle the polling mechanism for now.

The existing transports can just ignore the message handle.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h  |  8 ++++----
 drivers/firmware/arm_scmi/driver.c  | 20 +++++++++++---------
 drivers/firmware/arm_scmi/mailbox.c |  7 ++++---
 drivers/firmware/arm_scmi/smc.c     |  5 +++--
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 9488c682a51d..5ab2ea0f7db2 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -310,9 +310,9 @@ struct scmi_transport_ops {
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
 	void (*fetch_response)(struct scmi_chan_info *cinfo,
-			       struct scmi_xfer *xfer);
-	void (*fetch_notification)(struct scmi_chan_info *cinfo,
-				   size_t max_len, struct scmi_xfer *xfer);
+			       struct scmi_xfer *xfer, void *msg_handle);
+	void (*fetch_notification)(struct scmi_chan_info *cinfo, size_t max_len,
+				   struct scmi_xfer *xfer, void *msg_handle);
 	void (*clear_channel)(struct scmi_chan_info *cinfo);
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
@@ -350,7 +350,7 @@ extern const struct scmi_desc scmi_smc_desc;
 
 int scmi_set_transport_info(struct device *dev, void *transport_info);
 void *scmi_get_transport_info(struct device *dev);
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *msg_handle);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
 /* shmem related declarations */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 581b6c9b3781..cc27978b4bea 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -272,7 +272,8 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
-static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
+static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr,
+				     void *msg_handle)
 {
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
@@ -292,7 +293,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	unpack_scmi_header(msg_hdr, &xfer->hdr);
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
-					    xfer);
+					    xfer, msg_handle);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
 
@@ -305,8 +306,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	info->desc->ops->clear_channel(cinfo);
 }
 
-static void scmi_handle_response(struct scmi_chan_info *cinfo,
-				 u16 xfer_id, u8 msg_type)
+static void scmi_handle_response(struct scmi_chan_info *cinfo, u16 xfer_id,
+				 u8 msg_type, void *msg_handle)
 {
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
@@ -339,7 +340,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 
-	info->desc->ops->fetch_response(cinfo, xfer);
+	info->desc->ops->fetch_response(cinfo, xfer, msg_handle);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
@@ -365,18 +366,19 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
  * NOTE: This function will be invoked in IRQ context, hence should be
  * as optimal as possible.
  */
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
+void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr,
+		      void *msg_handle)
 {
 	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
 
 	switch (msg_type) {
 	case MSG_TYPE_NOTIFICATION:
-		scmi_handle_notification(cinfo, msg_hdr);
+		scmi_handle_notification(cinfo, msg_hdr, msg_handle);
 		break;
 	case MSG_TYPE_COMMAND:
 	case MSG_TYPE_DELAYED_RESP:
-		scmi_handle_response(cinfo, xfer_id, msg_type);
+		scmi_handle_response(cinfo, xfer_id, msg_type, msg_handle);
 		break;
 	default:
 		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
@@ -490,7 +492,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
 
 		if (ktime_before(ktime_get(), stop))
-			info->desc->ops->fetch_response(cinfo, xfer);
+			info->desc->ops->fetch_response(cinfo, xfer, NULL);
 		else
 			ret = -ETIMEDOUT;
 	} else {
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 4626404be541..584d7dcde2eb 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -43,7 +43,7 @@ static void rx_callback(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem));
+	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
 }
 
 static bool mailbox_chan_available(struct device *dev, int idx)
@@ -151,7 +151,7 @@ static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 }
 
 static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
-				   struct scmi_xfer *xfer)
+				   struct scmi_xfer *xfer, void *msg_handle)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
@@ -159,7 +159,8 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
 }
 
 static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
-				       size_t max_len, struct scmi_xfer *xfer)
+				       size_t max_len, struct scmi_xfer *xfer,
+				       void *msg_handle)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index fcbe2677f84b..507107d1a4ad 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -151,7 +151,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	if (scmi_info->irq)
 		wait_for_completion(&scmi_info->tx_complete);
 
-	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
+	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem),
+			 NULL);
 
 	mutex_unlock(&scmi_info->shmem_lock);
 
@@ -162,7 +163,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 }
 
 static void smc_fetch_response(struct scmi_chan_info *cinfo,
-			       struct scmi_xfer *xfer)
+			       struct scmi_xfer *xfer, void *msg_handle)
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-- 
2.25.1


