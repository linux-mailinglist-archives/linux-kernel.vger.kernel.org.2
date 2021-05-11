Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E86379B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhEKAaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:19 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:11265 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhEKA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 2F58BA1A3A;
        Tue, 11 May 2021 02:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=7Jt8AOTWNRzk
        362lP6M1btJnyfFLS/lTS2EN5YBOQTs=; b=lSFeSHdYmpAVbER7oNQMYUeE14KA
        rsQLvVY9E7eq5p3r6/duMDKZyuZI1TIa0hTrACrswWOTV54CVqtqpYKr6045I8IA
        Apxj1P+GUIvdsZFJuW21Tp7kj1X14n38kMRRGCWPCNU1NiUfMGzCJ5MW2JpjHWiJ
        S7sZFj09Qs1Qpkc6tD6a2AZq3TD8SQ1UMD/Kkvoi9HEHhDMqASuvXrLWzzFD1mgv
        fXaqC1ttp0Xw+M43g6pmvuYzVkIaihkhY2AawTeY/DrqKtOssisCBYY8KRkFSWZW
        vA8Nkq3nenR3kfGPb1uR552aGoGcqjGCqP14Nwu3M7L3tq5gv1iWMbipKA==
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
Subject: [RFC PATCH v3 12/12] firmware: arm_scmi: Handle races between core and transport
Date:   Tue, 11 May 2021 02:20:40 +0200
Message-ID: <20210511002040.802226-13-peter.hilber@opensynergy.com>
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

Introduce additional state and locks to handle race conditions in the
core-transport interaction. These race conditions become more relevant
with the new virtio transport, which may time out more often, especially
in the case of misconfigurations.

The races involve the transport calling scmi_rx_callback() and a second
function. The following race conditions are addressed:

- concurrent not delayed and delayed response (or inverted order)
- belated response to timed out message corrupts new message
- mixing up of responses if the same command is repeated after timeout

The implementation is not yet complete, as when the wait_after_timeout
transport option is set and a not delayed response returns an error
after timeout, the core would wait endlessly for any corresponding
delayed response (marked with TODO in the code).

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  34 ++++++-
 drivers/firmware/arm_scmi/driver.c | 153 ++++++++++++++++++++++-------
 drivers/firmware/arm_scmi/virtio.c |   1 +
 3 files changed, 150 insertions(+), 38 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index bada06cfd33d..bdb9796ea1a3 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -123,6 +123,29 @@ struct scmi_msg {
 	size_t len;
 };
 
+/**
+ * struct scmi_xfer_state - Message flow state
+ *
+ * @done: command message transmit completion event
+ * @async_done: pointer to delayed response message received event completion
+ * @wait_response: Waiting for the (not delayed) response.
+ * @wait_delayed: Waiting for the delayed response.
+ * @wait_after_timeout: Message timed out for core, but transport will
+ * 			eventually submit the response. Cannot reuse the
+ * 			scmi_xfer as long as this is set.
+ * @put_wait: wait_after_timeout was set when we were trying to put the
+ * 	      message, so we wait for the transport to present the response
+ * 	      before actually releasing the message.
+ */
+struct scmi_xfer_state {
+	struct completion done;
+	struct completion *async_done;
+	u8 wait_response;
+	u8 wait_delayed;
+	u8 wait_after_timeout;
+	u8 put_wait;
+};
+
 /**
  * struct scmi_xfer - Structure representing a message flow
  *
@@ -132,16 +155,16 @@ struct scmi_msg {
  * @rx: Receive message, the buffer should be pre-allocated to store
  *	message. If request-ACK protocol is used, we can reuse the same
  *	buffer for the rx path as we use for the tx path.
- * @done: command message transmit completion event
- * @async_done: pointer to delayed response message received event completion
+ * @state: Message flow state
+ * @lock: Protects access to message while transport may access it
  */
 struct scmi_xfer {
 	int transfer_id;
 	struct scmi_msg_hdr hdr;
 	struct scmi_msg tx;
 	struct scmi_msg rx;
-	struct completion done;
-	struct completion *async_done;
+	struct scmi_xfer_state state;
+	spinlock_t lock;
 };
 
 struct scmi_xfer_ops;
@@ -333,6 +356,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *	be pending simultaneously in the system. May be overridden by the
  *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @wait_after_timeout: On response timeout, don't reuse scmi_xfer until
+ * 			transport eventually returns response.
  */
 struct scmi_desc {
 	int (*init)(void);
@@ -341,6 +366,7 @@ struct scmi_desc {
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
+	u8 wait_after_timeout;
 };
 
 #ifdef CONFIG_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a31187385470..51f6799cc8ab 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -72,13 +72,13 @@ struct scmi_requested_dev {
  * @xfer_alloc_table: Bitmap table for allocated messages.
  *	Index of this bitmap table is also used for message
  *	sequence identifier.
- * @xfer_lock: Protection for message allocation
+ * @alloc_lock: Protection for message allocation
  * @max_msg: Maximum number of messages that can be pending
  */
 struct scmi_xfers_info {
 	struct scmi_xfer *xfer_block;
 	unsigned long *xfer_alloc_table;
-	spinlock_t xfer_lock;
+	spinlock_t alloc_lock;
 	int max_msg;
 };
 
@@ -230,20 +230,20 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	unsigned long flags, bit_pos;
 
 	/* Keep the locked section as small as possible */
-	spin_lock_irqsave(&minfo->xfer_lock, flags);
+	spin_lock_irqsave(&minfo->alloc_lock, flags);
 	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table, minfo->max_msg);
 	if (bit_pos == minfo->max_msg) {
-		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+		spin_unlock_irqrestore(&minfo->alloc_lock, flags);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(bit_pos, minfo->xfer_alloc_table);
-	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+	spin_unlock_irqrestore(&minfo->alloc_lock, flags);
 
 	xfer_id = bit_pos;
 
 	xfer = &minfo->xfer_block[xfer_id];
 	xfer->hdr.seq = xfer_id;
-	reinit_completion(&xfer->done);
+	reinit_completion(&xfer->state.done);
 	xfer->transfer_id = atomic_inc_return(&transfer_last_id);
 
 	return xfer;
@@ -255,21 +255,27 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
  * @minfo: Pointer to Tx/Rx Message management info based on channel type
  * @xfer: message that was reserved by scmi_xfer_get
  *
- * This holds a spinlock to maintain integrity of internal data structures.
+ * For the Tx channel, call this with the xfer lock held.
+ * This uses the xfer table spinlock to maintain integrity of internal data
+ * structures.
  */
 static void
 __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 {
 	unsigned long flags;
 
-	/*
-	 * Keep the locked section as small as possible
-	 * NOTE: we might escape with smp_mb and no lock here..
-	 * but just be conservative and symmetric.
-	 */
-	spin_lock_irqsave(&minfo->xfer_lock, flags);
-	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
-	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
+	if (xfer->state.wait_after_timeout) {
+		xfer->state.put_wait = true;
+	} else {
+		/*
+		 * Keep the locked section as small as possible
+		 * NOTE: we might escape with smp_mb and no lock here..
+		 * but just be conservative and symmetric.
+		 */
+		spin_lock_irqsave(&minfo->alloc_lock, flags);
+		clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
+		spin_unlock_irqrestore(&minfo->alloc_lock, flags);
+	}
 }
 
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr,
@@ -313,6 +319,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u16 xfer_id,
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->tx_minfo;
+	unsigned long flags;
 
 	/* Are we even expecting this? */
 	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
@@ -322,25 +329,65 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u16 xfer_id,
 	}
 
 	xfer = &minfo->xfer_block[xfer_id];
+
+	spin_lock_irqsave(&xfer->lock, flags);
+
 	/*
 	 * Even if a response was indeed expected on this slot at this point,
 	 * a buggy platform could wrongly reply feeding us an unexpected
-	 * delayed response we're not prepared to handle: bail-out safely
+	 * response we're not prepared to handle: bail-out safely
 	 * blaming firmware.
 	 */
-	if (unlikely(msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done)) {
-		dev_err(dev,
-			"Delayed Response for %d not expected! Buggy F/W ?\n",
-			xfer_id);
-		info->desc->ops->clear_channel(cinfo);
-		/* It was unexpected, so nobody will clear the xfer if not us */
-		__scmi_xfer_put(minfo, xfer);
-		return;
+	if (msg_type == MSG_TYPE_COMMAND) {
+		if (xfer->state.wait_response) {
+			xfer->state.wait_response = false;
+			/*
+			 * TODO: In case of an error response, we should ensure
+			 * that we cancel waiting for the delayed response.
+			 */
+		} else {
+			spin_unlock_irqrestore(&xfer->lock, flags);
+			dev_err(dev,
+				"Response for %d not expected! Buggy F/W?\n",
+				xfer_id);
+			return;
+		}
+	} else /* msg_type == MSG_TYPE_DELAYED_RESP */ {
+		if (xfer->state.wait_delayed) {
+			xfer->state.wait_delayed = false;
+		} else {
+			dev_err(dev,
+				"Delayed Response for %d not expected! Buggy F/W?\n",
+				xfer_id);
+			info->desc->ops->clear_channel(cinfo);
+
+			/* It was unexpected, so nobody will clear the xfer if not us */
+			__scmi_xfer_put(minfo, xfer);
+			spin_unlock_irqrestore(&xfer->lock, flags);
+			return;
+		}
 	}
 
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 
-	info->desc->ops->fetch_response(cinfo, xfer, msg_handle);
+	if (xfer->state.wait_after_timeout && !xfer->state.wait_response &&
+	    !xfer->state.wait_delayed) {
+		xfer->state.wait_after_timeout = false;
+		if (xfer->state.put_wait) {
+			__scmi_xfer_put(minfo, xfer);
+			spin_unlock_irqrestore(&xfer->lock, flags);
+			return;
+		}
+	}
+
+	if (xfer->state.async_done && msg_type == MSG_TYPE_COMMAND &&
+	    !xfer->state.wait_delayed) {
+		dev_dbg(dev,
+			"Ignoring not delayed response for %d, which was received after delayed response\n",
+			xfer_id);
+	} else {
+		info->desc->ops->fetch_response(cinfo, xfer, msg_handle);
+	}
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
@@ -348,10 +395,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u16 xfer_id,
 
 	if (msg_type == MSG_TYPE_DELAYED_RESP) {
 		info->desc->ops->clear_channel(cinfo);
-		complete(xfer->async_done);
+		complete(xfer->state.async_done);
 	} else {
-		complete(&xfer->done);
+		complete(&xfer->state.done);
 	}
+
+	spin_unlock_irqrestore(&xfer->lock, flags);
 }
 
 /**
@@ -434,8 +483,11 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
 {
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 	struct scmi_info *info = handle_to_scmi_info(pi->handle);
+	unsigned long flags;
 
+	spin_lock_irqsave(&xfer->lock, flags);
 	__scmi_xfer_put(&info->tx_minfo, xfer);
+	spin_unlock_irqrestore(&xfer->lock, flags);
 }
 
 #define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
@@ -468,6 +520,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct device *dev = info->dev;
 	struct scmi_chan_info *cinfo;
+	unsigned long flags;
 
 	/*
 	 * Re-instate protocol id here from protocol handle so that cannot be
@@ -480,6 +533,16 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	if (unlikely(!cinfo))
 		return -EINVAL;
 
+	spin_lock_irqsave(&xfer->lock, flags);
+	if (xfer->state.wait_after_timeout) {
+		spin_unlock_irqrestore(&xfer->lock, flags);
+		return -EBUSY;
+	}
+
+	xfer->state.wait_response = true;
+	xfer->state.wait_delayed = !!xfer->state.async_done;
+	spin_unlock_irqrestore(&xfer->lock, flags);
+
 	trace_scmi_xfer_begin(xfer->transfer_id, xfer->hdr.id,
 			      xfer->hdr.protocol_id, xfer->hdr.seq,
 			      xfer->hdr.poll_completion);
@@ -502,7 +565,14 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	} else {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
+		if (!wait_for_completion_timeout(&xfer->state.done, timeout)) {
+			if (info->desc->wait_after_timeout) {
+				spin_lock_irqsave(&xfer->lock, flags);
+				if (xfer->state.wait_response ||
+				    xfer->state.wait_delayed)
+					xfer->state.wait_after_timeout = true;
+				spin_unlock_irqrestore(&xfer->lock, flags);
+			}
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
@@ -547,17 +617,27 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 {
 	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	const struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	DECLARE_COMPLETION_ONSTACK(async_response);
+	unsigned long flags;
 
 	xfer->hdr.protocol_id = pi->proto->id;
 
-	xfer->async_done = &async_response;
+	xfer->state.async_done = &async_response;
 
 	ret = do_xfer(ph, xfer);
-	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
+	if (!ret &&
+	    !wait_for_completion_timeout(xfer->state.async_done, timeout)) {
+		if (info->desc->wait_after_timeout) {
+			spin_lock_irqsave(&xfer->lock, flags);
+			if (xfer->state.wait_delayed)
+				xfer->state.wait_after_timeout = true;
+			spin_unlock_irqrestore(&xfer->lock, flags);
+		}
 		ret = -ETIMEDOUT;
+	}
 
-	xfer->async_done = NULL;
+	xfer->state.async_done = NULL;
 	return ret;
 }
 
@@ -604,6 +684,10 @@ static int xfer_get_init(const struct scmi_protocol_handle *ph,
 	xfer->hdr.id = msg_id;
 	xfer->hdr.protocol_id = pi->proto->id;
 	xfer->hdr.poll_completion = false;
+	xfer->state.wait_response = false;
+	xfer->state.wait_delayed = false;
+	xfer->state.wait_after_timeout = false;
+	xfer->state.put_wait = false;
 
 	*p = xfer;
 
@@ -1085,7 +1169,7 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	if (!info->xfer_alloc_table)
 		return -ENOMEM;
 
-	/* Pre-initialize the buffer pointer to pre-allocated buffers */
+	/* Pre-initialize the buffer pointer to pre-allocated buffers etc. */
 	for (i = 0, xfer = info->xfer_block; i < info->max_msg; i++, xfer++) {
 		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
 					    GFP_KERNEL);
@@ -1093,10 +1177,11 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 			return -ENOMEM;
 
 		xfer->tx.buf = xfer->rx.buf;
-		init_completion(&xfer->done);
+		init_completion(&xfer->state.done);
+		spin_lock_init(&xfer->lock);
 	}
 
-	spin_lock_init(&info->xfer_lock);
+	spin_lock_init(&info->alloc_lock);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 20972adf6dc7..3db3c629778c 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -520,4 +520,5 @@ const struct scmi_desc scmi_virtio_desc = {
 	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
 	.max_msg = 0, /* overridden by virtio_get_max_msg() */
 	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+	.wait_after_timeout = true,
 };
-- 
2.25.1


