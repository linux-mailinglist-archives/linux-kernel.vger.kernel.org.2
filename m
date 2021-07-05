Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7203BBE70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhGEOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:53:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhGEOxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:53:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979F631B;
        Mon,  5 Jul 2021 07:50:42 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35E643F694;
        Mon,  5 Jul 2021 07:50:39 -0700 (PDT)
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
Subject: [PATCH v5 08/15] firmware: arm_scmi: Introduce optional support for delegated xfers
Date:   Mon,  5 Jul 2021 15:49:07 +0100
Message-Id: <20210705144914.35094-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705144914.35094-1-cristian.marussi@arm.com>
References: <20210705144914.35094-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SCMI transports allow for more parallelism while handling SCMI
messages and as a result may have more complex inner workings than shared
memory based transports and they could need to maintain additional
transport-specific state information and data about the ongoing transfers.
Using the current SCMI core transport layer interface, additional effort
would be needed to keep such states and data in sync with the SCMI core.

Allow an SCMI transport to optionally declare to be using delegated xfers
so that it can use a few SCMI core helper functions to query the core early
on in the RX path for any valid existing in-flight transfers matching a
specific message header or, alternatively, to transparently obtain a brand
new dedicated xfer to handle a notification message.

In both cases the obtained xfer can be uniquely mapped to a specific xfer,
assured to be valid, through the means of the message header sequence
number acting as key.

In this way such a transport can save its own transport specific envelope
into a private reference associated with the xfer before calling into the
core scmi_rx_callback() in the usual way.

The scmi_rx_callback() does not need to be modified to carry additional
transport-specific ancillary data related to such message envelopes since
an unique natural association is established between the xfer and the
related message header.

Existing transports that do not need anything of the above will continue
to work as before without any change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  13 ++
 drivers/firmware/arm_scmi/driver.c | 189 ++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 2620a2303c0c..fb3770b165ca 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -80,6 +80,7 @@ struct scmi_msg_resp_prot_version {
  * @status: Status of the transfer once it's complete
  * @poll_completion: Indicate if the transfer needs to be polled for
  *	completion or interrupt mode is used
+ * @saved_hdr: A copy of the original msg_hdr
  */
 struct scmi_msg_hdr {
 	u8 id;
@@ -88,6 +89,7 @@ struct scmi_msg_hdr {
 	u16 seq;
 	u32 status;
 	bool poll_completion;
+	u32 saved_hdr;
 };
 
 /**
@@ -152,6 +154,7 @@ struct scmi_msg {
  *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
  *	      (Missing synchronous response is assumed OK and ignored)
  * @lock: A spinlock to protect state and busy fields.
+ * @priv: A pointer for transport private usage.
  */
 struct scmi_xfer {
 	int transfer_id;
@@ -171,6 +174,7 @@ struct scmi_xfer {
 #define SCMI_XFER_DRESP_OK	2
 	int state;
 	spinlock_t lock;
+	void *priv;
 };
 
 /*
@@ -372,6 +376,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg: Maximum number of messages that can be pending
  *	simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @using_xfers_delegation: A flag to indicate if the described transport will
+ *			    handle delegated xfers, so the core can derive
+ *			    proper related assumptions.
  */
 struct scmi_desc {
 	int (*init)(void);
@@ -380,6 +387,7 @@ struct scmi_desc {
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
+	bool using_xfers_delegation;
 };
 
 extern const struct scmi_desc scmi_mailbox_desc;
@@ -407,4 +415,9 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
+
+int scmi_transfer_lookup(struct scmi_chan_info *cinfo, u32 *msg_hdr,
+			 struct scmi_xfer **xfer);
+void scmi_transfer_release(struct scmi_chan_info *cinfo,
+			   struct scmi_xfer *xfer);
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0efb26c6492e..c1ff0e84f72d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -377,6 +377,22 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	return xfer;
 }
 
+/**
+ * __scmi_xfer_get  - Increment xfer refcount
+ *
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
+ * @xfer: message to be acquired
+ */
+static void
+__scmi_xfer_get(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	refcount_inc(&xfer->users);
+	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+}
+
 /**
  * __scmi_xfer_put() - Release a message
  *
@@ -592,24 +608,185 @@ static inline void scmi_xfer_state_update(struct scmi_xfer *xfer)
 	}
 }
 
-static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
+/**
+ * scmi_xfer_notif_acquire  - Returns a valid xfer for notification processing
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @msg_hdr: A pointer to the message header to lookup.
+ *
+ * A brand new notification xfer is picked and initialized: msg_hdr is then
+ * mangled to match the monotonically increasing sequence number xfer->hdr.seq
+ * since it will be used as an index to refer back to this xfer later in the
+ * RX path (inside scmi_rx_callback()). Original msg_hdr is saved into
+ * xfer->saved_hdr.
+ */
+static inline struct scmi_xfer *
+scmi_xfer_notif_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr)
+{
+	struct scmi_xfer *xfer;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+
+	/* Get a brand new RX xfer if none found already allocated */
+	xfer = scmi_xfer_get(cinfo->handle, &info->rx_minfo, true);
+	if (!IS_ERR(xfer)) {
+		/* Get hold of this freshly allocated xfer */
+		__scmi_xfer_get(&info->rx_minfo, xfer);
+		/* Populate xfer->hdr, updates type too. */
+		unpack_scmi_header(*msg_hdr, &xfer->hdr);
+		/* Fix sequence number in msg_hdr since it is used as index */
+		xfer->hdr.saved_hdr = *msg_hdr;
+		*msg_hdr &= ~MSG_TOKEN_ID_MASK;
+		*msg_hdr |= FIELD_PREP(MSG_TOKEN_ID_MASK, xfer->hdr.seq);
+	}
+
+	return xfer;
+}
+
+/**
+ * scmi_transfer_lookup  -  Search for an xfer matching the provided msg_hdr
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @msg_hdr: A pointer to the message header to lookup.
+ * @xfer: On success holds a reference to the valid xfer.
+ *
+ * Lookup works as follows depending on message type in @msg_hdr:
+ *
+ *  - for commands a pre-existent @xfer is returned if determined to be valid
+ *    i.e.:
+ *	- associated with the sequence number in @msg_hdr
+ *	- whose current xfer->state is congruent with the msg type in @msg_hdr
+ *
+ *  - for notifications:
+ *	- a new @xfer is picked and initialized
+ *
+ * Returned @xfer is:
+ *  - guaranteed to represent a valid transfer (sequence number not stale)
+ *  - refcounted properly
+ *  - exclusively acquired (for commands xfers only) till released cleanly by
+ *    @scmi_transfer_release in order to exclude races between concurrently
+ *    received responses and delayed responses for the same messages on distinct
+ *    channels.
+ *
+ * Used only by transports using delegated xfers.
+ *
+ * Return: 0 if a valid xfer is returned in @xfer, error otherwise.
+ */
+int scmi_transfer_lookup(struct scmi_chan_info *cinfo, u32 *msg_hdr,
+			 struct scmi_xfer **xfer)
+{
+	u8 msg_type;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+
+	if (!xfer || !msg_hdr || !info->desc->using_xfers_delegation)
+		return -EINVAL;
+
+	msg_type = MSG_XTRACT_TYPE(*msg_hdr);
+
+	switch (msg_type) {
+	case MSG_TYPE_COMMAND:
+	case MSG_TYPE_DELAYED_RESP:
+		/* Grab an existing valid xfer matching xfer_id (if any) */
+		*xfer = scmi_xfer_command_acquire(cinfo, *msg_hdr);
+		break;
+	case MSG_TYPE_NOTIFICATION:
+		/* Allocate a new xfer and mangle msg_hdr to match hdr.seq_num */
+		*xfer = scmi_xfer_notif_acquire(cinfo, msg_hdr);
+		break;
+	default:
+		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
+		return -EINVAL;
+	}
+
+	if (IS_ERR(*xfer)) {
+		int ret = PTR_ERR(*xfer);
+
+		dev_err(cinfo->dev,
+			"Failed to acquire a valid xfer HDR:0x%X - ret:%d\n",
+			*msg_hdr, ret);
+
+		*xfer = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * scmi_transfer_release  - Release a previously acquired xfer
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @xfer: A reference to the xfer to release.
+ *
+ * Used only by transports using delegated xfers.
+ */
+void scmi_transfer_release(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+
+	if (!xfer || !info->desc->using_xfers_delegation)
+		return;
+
+	if (xfer->hdr.type == MSG_TYPE_NOTIFICATION)
+		__scmi_xfer_put(&info->rx_minfo, xfer);
+	else
+		scmi_xfer_command_release(info, xfer);
+}
+
+/**
+ * scmi_xfer_notif_lookup_or_acquire  - Helper to lookup a notification xfer
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @msg_hdr: A pointer to the message header to lookup.
+ *
+ * This is called by scmi_rx_callback to get hold of an xfer to be used for
+ * notification processing.
+ *
+ * When no delegated xfers are used by the transport this simply returns a
+ * freshly allocated xfer to be filled with notification data as usual.
+ *
+ * If instead delegated xfers are used by the undierlying transport, this simply
+ * lookups the already allocated and initialized xfer.
+ */
+static inline struct scmi_xfer *
+scmi_xfer_notif_lookup_or_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
 	struct scmi_xfer *xfer;
-	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->rx_minfo;
+
+	if (!info->desc->using_xfers_delegation) {
+		xfer = scmi_xfer_get(cinfo->handle, minfo, false);
+		if (!IS_ERR(xfer))
+			/* Populate xfer->hdr, updates type too. */
+			unpack_scmi_header(msg_hdr, &xfer->hdr);
+	} else {
+		unsigned long flags;
+		u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
+
+		spin_lock_irqsave(&minfo->xfer_lock, flags);
+		xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
+		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+	}
+
+	return xfer;
+}
+
+static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
+{
+	struct scmi_xfer *xfer;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	ktime_t ts;
 
 	ts = ktime_get_boottime();
-	xfer = scmi_xfer_get(cinfo->handle, minfo, false);
+	xfer = scmi_xfer_notif_lookup_or_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
-		dev_err(dev, "failed to get free message slot (%ld)\n",
+		dev_err(cinfo->dev,
+			"failed to lookup notification message (%ld)\n",
 			PTR_ERR(xfer));
 		info->desc->ops->clear_channel(cinfo);
 		return;
 	}
 
-	unpack_scmi_header(msg_hdr, &xfer->hdr);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -619,7 +796,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
 			   MSG_TYPE_NOTIFICATION);
 
-	__scmi_xfer_put(minfo, xfer);
+	__scmi_xfer_put(&info->rx_minfo, xfer);
 
 	info->desc->ops->clear_channel(cinfo);
 }
-- 
2.17.1

