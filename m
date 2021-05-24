Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B838F624
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhEXXRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:17:21 -0400
Received: from foss.arm.com ([217.140.110.172]:49064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhEXXRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:17:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C792F6D;
        Mon, 24 May 2021 16:15:46 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 058A93F73D;
        Mon, 24 May 2021 16:15:44 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 4/4] firmware: arm_scmi: Introduce delegated xfers support
Date:   Tue, 25 May 2021 00:15:03 +0100
Message-Id: <20210524231503.34924-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210524231503.34924-1-cristian.marussi@arm.com>
References: <20210524231503.34924-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce optional support for delegated xfers allocation.

An SCMI transport can optionally declare to support delegated xfers and
then use a few helper functions exposed by the core SCMI transport layer to
query the core for existing in-flight transfers matching a provided message
header or alternatively and transparently obtain a brand new xfer to handle
a freshly received notification message.
In both cases the obtained xfer is uniquely mapped into a specific xfer
through the means of the message header acting as key.

In this way such a transport can properly store its own transport specific
payload into the xfer uniquely associated to the message header before
even calling into the core scmi_rx_callback() in the usual way, so that
the transport specific message envelope structures can be freed early
and there is no more need to keep track of their status till the core
fully processes the xfer to completion or times out.

The scmi_rx_callbak() does not need to be modified to carry additional
transport-specific ancillary data related to such message envelopes since
an unique natural association is established between the xfer and the
related message header.

Existing transports that do not need anything of the above will continue
to work as before without any change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  14 +++
 drivers/firmware/arm_scmi/driver.c | 132 ++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index aba8f1efdd2b..d89b3b3a8c05 100644
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
@@ -154,6 +156,9 @@ struct scmi_msg {
  * @rx: Receive message, the buffer should be pre-allocated to store
  *	message. If request-ACK protocol is used, we can reuse the same
  *	buffer for the rx path as we use for the tx path.
+ * @rx_raw_len: A field which can be optionally used by a specific transport
+ *		to save transport specific message length
+ *		It is not used by the SCMI transport core
  * @done: command message transmit completion event
  * @async_done: pointer to delayed response message received event completion
  * @users: A refcount to track the active users for this xfer
@@ -165,6 +170,7 @@ struct scmi_xfer {
 	struct scmi_msg_hdr hdr;
 	struct scmi_msg tx;
 	struct scmi_msg rx;
+	size_t rx_raw_len;
 	struct completion done;
 	struct completion *async_done;
 	refcount_t users;
@@ -349,12 +355,16 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg: Maximum number of messages that can be pending
  *	simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @support_xfers_delegation: A flag to indicate if the described transport
+ *			      will handle delegated xfers, so the core can
+ *			      derive proper related assumptions.
  */
 struct scmi_desc {
 	const struct scmi_transport_ops *ops;
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
+	bool support_xfers_delegation;
 };
 
 extern const struct scmi_desc scmi_mailbox_desc;
@@ -383,4 +393,8 @@ void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
 
+int scmi_transfer_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr,
+			  struct scmi_xfer **xfer);
+void scmi_transfer_release(struct scmi_chan_info *cinfo,
+			   struct scmi_xfer *xfer);
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ab975c74cab1..08f52f53e14c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -433,6 +433,124 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
 	return xfer ?: ERR_PTR(-EINVAL);
 }
 
+/**
+ * scmi_xfer_acquire  -  Helper to lookup and acquire an xfer
+ *
+ * @minfo: Pointer to Tx/Rx Message management info based on channel type
+ * @xfer_id: Token ID to lookup in @pending_xfers
+ *
+ * When a valid xfer is found for the provided @xfer_id, reference counting is
+ * properly updated.
+ *
+ * Return: A valid @xfer on Success or error otherwise.
+ */
+static struct scmi_xfer *
+scmi_xfer_acquire(struct scmi_xfers_info *minfo, u16 xfer_id)
+{
+	unsigned long flags;
+	struct scmi_xfer *xfer;
+
+	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
+	if (!IS_ERR(xfer))
+		refcount_inc(&xfer->users);
+	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+
+	return xfer;
+}
+
+/**
+ * scmi_transfer_acquire  -  Lookup for an existing xfer or freshly allocate a
+ * new one depending on the type of the message
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @msg_hdr: A pointer to the message header to lookup.
+ * @xfer: A reference to the pre-existent or freshly allocated xfer
+ *	  associated with the provided *msg_hdr.
+ *
+ * This function can be used by transports supporting delegated xfers to obtain
+ * a valid @xfer associated with the provided @msg_hdr param.
+ *
+ * The nature of the resulting @xfer depends on the type of message specified in
+ * @msg_hdr:
+ *  - for responses and delayed responses a pre-existent/pre-allocated in-flight
+ *    xfer descriptor will be returned (properly refcounted)
+ *  - for notifications a brand new xfer will be allocated; in this case the
+ *    provided message header sequence number will also be mangled to match
+ *    the token in the freshly allocated xfer: this is needed to establish a
+ *    link between the picked xfer and the msg_hdr that will be subsequently
+ *    passed back via usual scmi_rx_callback().
+ *
+ * Return: 0 if a valid xfer is returned in @xfer, error otherwise.
+ */
+int scmi_transfer_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr,
+			  struct scmi_xfer **xfer)
+{
+	u8 msg_type;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+
+	if (!xfer || !msg_hdr || !info->desc->support_xfers_delegation)
+		return -EINVAL;
+
+	msg_type = MSG_XTRACT_TYPE(*msg_hdr);
+	switch (msg_type) {
+	case MSG_TYPE_COMMAND:
+	case MSG_TYPE_DELAYED_RESP:
+		/* Grab an existing xfer for xfer_id */
+		*xfer = scmi_xfer_acquire(&info->tx_minfo,
+					  MSG_XTRACT_TOKEN(*msg_hdr));
+		break;
+	case MSG_TYPE_NOTIFICATION:
+		/* Get a brand new RX xfer */
+		*xfer = scmi_xfer_get(cinfo->handle, &info->rx_minfo);
+		if (!IS_ERR(*xfer)) {
+			/* Save original msg_hdr and fix sequence number */
+			(*xfer)->hdr.saved_hdr = *msg_hdr;
+			*msg_hdr &= ~MSG_TOKEN_ID_MASK;
+			*msg_hdr |= FIELD_PREP(MSG_TOKEN_ID_MASK,
+					       (*xfer)->hdr.seq);
+		}
+		break;
+	default:
+		*xfer = ERR_PTR(-EINVAL);
+		break;
+	}
+
+	if (IS_ERR(*xfer)) {
+		dev_err(cinfo->dev,
+			"Failed to acquire a valid xfer for hdr:0x%X\n",
+			*msg_hdr);
+		return PTR_ERR(*xfer);
+	}
+
+	/* Fix xfer->hdr.type with actual msg_hdr carried type */
+	unpack_scmi_header(*msg_hdr, &((*xfer)->hdr));
+
+	return 0;
+}
+
+/**
+ * scmi_transfer_release  - Release an previously acquired xfer
+ *
+ * @cinfo: A reference to the channel descriptor.
+ * @xfer: A reference to the xfer to release.
+ */
+void scmi_transfer_release(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct scmi_xfers_info *minfo;
+
+	if (!xfer || !info->desc->support_xfers_delegation)
+		return;
+
+	if (xfer->hdr.type == MSG_TYPE_NOTIFICATION)
+		minfo = &info->rx_minfo;
+	else
+		minfo = &info->tx_minfo;
+
+	__scmi_xfer_put(minfo, xfer);
+}
+
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
 	struct scmi_xfer *xfer;
@@ -442,7 +560,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	ktime_t ts;
 
 	ts = ktime_get_boottime();
-	xfer = scmi_xfer_get(cinfo->handle, minfo);
+
+	if (!info->desc->support_xfers_delegation)
+		xfer = scmi_xfer_get(cinfo->handle, minfo);
+	else
+		xfer = scmi_xfer_acquire(minfo, MSG_XTRACT_TOKEN(msg_hdr));
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
 			PTR_ERR(xfer));
@@ -450,8 +572,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		return;
 	}
 
-	unpack_scmi_header(msg_hdr, &xfer->hdr);
 	scmi_dump_header_dbg(dev, &xfer->hdr);
+
+	if (!info->desc->support_xfers_delegation)
+		unpack_scmi_header(msg_hdr, &xfer->hdr);
+
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
@@ -497,7 +622,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 			xfer_id);
 		info->desc->ops->clear_channel(cinfo);
 		/* It was unexpected, so nobody will clear the xfer if not us */
-		__scmi_xfer_put(minfo, xfer);
+		if (!info->desc->support_xfers_delegation) //XXX ??? Really
+			__scmi_xfer_put(minfo, xfer);
 		return;
 	}
 
-- 
2.17.1

