Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F927379B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhEKA3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:29:49 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:21798 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhEKA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:44 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 4A792A1A25;
        Tue, 11 May 2021 02:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=wYfvrsc5PO1a
        Vt2cRGcaZm71OUBsPX7ZwvdHqdDVxsM=; b=FmCILYo4aAtl/aI2pFU9aDzCGjS+
        JgqG/bWbOXlh5DxrXKObppb8B1s0xBLKkF/3+GJlRGor8+WO74yoomdWJqjpLQT4
        7SrlbkmPxwqKrmsJxhoYaEXnDVji0wPiEjW2qUYLHYG17j1wd8z9UivmZpAdI7ql
        VW6XvOuNtJMKyVU7IlWJZUOkWzP04QlSui3JPt95scIkywZht8MungUQzVbJwoXr
        eyNiCM0WnLHW6Kn7h9aCwhuHxv8v28JRFAqjNqIctM8kqBWn3/eobc3UzSWnd+4/
        ZF/k5Wz+I3LRtvmKcpwzuLmpZgKZMTvVoa3Goda7lY/LW2kuB12NF7fcpQ==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH v3 03/12] firmware: arm_scmi: Add op to override max message #
Date:   Tue, 11 May 2021 02:20:31 +0200
Message-ID: <20210511002040.802226-4-peter.hilber@opensynergy.com>
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

From: Igor Skalkin <igor.skalkin@opensynergy.com>

The number of simultaneously pending messages that the upcoming
scmi-virtio transport can support depends on the virtio device (SCMI
platform) and can differ for each channel. (The scmi-virtio transport
does only have one tx and at most 1 rx channel.)

Add an optional transport op so that scmi-virtio can report the actual
max message # for each channel type. Respect these new limits.

Reflect that the limit in struct scmi_desc is now only a default any
more.

Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
[ Peter: Adapted patch for submission to upstream. ]
Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  9 ++++--
 drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 961a3c63cc42..13be8dedcd6b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -286,6 +286,9 @@ struct scmi_chan_info {
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
+ * @get_max_msg: Optional callback to provide max_msg dynamically
+ * 	@return: Maximum number of messages for the channel type (tx or rx)
+ * 		 that can be pending simultaneously in the system
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -298,6 +301,7 @@ struct scmi_transport_ops {
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
+	unsigned int (*get_max_msg)(bool tx, struct scmi_chan_info *base_cinfo);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
@@ -319,8 +323,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
- * @max_msg: Maximum number of messages that can be pending
- *	simultaneously in the system
+ * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
+ *	be pending simultaneously in the system. May be overridden by the
+ *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 471c5de827c1..b7271f8fd1c7 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -73,11 +73,13 @@ struct scmi_requested_dev {
  *	Index of this bitmap table is also used for message
  *	sequence identifier.
  * @xfer_lock: Protection for message allocation
+ * @max_msg: Maximum number of messages that can be pending
  */
 struct scmi_xfers_info {
 	struct scmi_xfer *xfer_block;
 	unsigned long *xfer_alloc_table;
 	spinlock_t xfer_lock;
+	int max_msg;
 };
 
 /**
@@ -224,13 +226,11 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	u16 xfer_id;
 	struct scmi_xfer *xfer;
 	unsigned long flags, bit_pos;
-	struct scmi_info *info = handle_to_scmi_info(handle);
 
 	/* Keep the locked section as small as possible */
 	spin_lock_irqsave(&minfo->xfer_lock, flags);
-	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
-				      info->desc->max_msg);
-	if (bit_pos == info->desc->max_msg) {
+	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table, minfo->max_msg);
+	if (bit_pos == minfo->max_msg) {
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -1013,32 +1013,39 @@ int scmi_handle_put(const struct scmi_handle *handle)
 }
 
 static int __scmi_xfer_info_init(struct scmi_info *sinfo,
-				 struct scmi_xfers_info *info)
+				 struct scmi_xfers_info *info,
+				 bool tx,
+				 struct scmi_chan_info *base_cinfo)
 {
 	int i;
 	struct scmi_xfer *xfer;
 	struct device *dev = sinfo->dev;
 	const struct scmi_desc *desc = sinfo->desc;
 
+	info->max_msg = desc->max_msg;
+
+	if (desc->ops->get_max_msg)
+		info->max_msg =	desc->ops->get_max_msg(tx, base_cinfo);
+
 	/* Pre-allocated messages, no more than what hdr.seq can support */
-	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
+	if (WARN_ON(info->max_msg >= MSG_TOKEN_MAX)) {
 		dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
-			desc->max_msg, MSG_TOKEN_MAX);
+			info->max_msg, MSG_TOKEN_MAX);
 		return -EINVAL;
 	}
 
-	info->xfer_block = devm_kcalloc(dev, desc->max_msg,
+	info->xfer_block = devm_kcalloc(dev, info->max_msg,
 					sizeof(*info->xfer_block), GFP_KERNEL);
 	if (!info->xfer_block)
 		return -ENOMEM;
 
-	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(desc->max_msg),
+	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(info->max_msg),
 					      sizeof(long), GFP_KERNEL);
 	if (!info->xfer_alloc_table)
 		return -ENOMEM;
 
 	/* Pre-initialize the buffer pointer to pre-allocated buffers */
-	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
+	for (i = 0, xfer = info->xfer_block; i < info->max_msg; i++, xfer++) {
 		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
 					    GFP_KERNEL);
 		if (!xfer->rx.buf)
@@ -1055,10 +1062,21 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 
 static int scmi_xfer_info_init(struct scmi_info *sinfo)
 {
-	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
+	int ret;
+	struct scmi_chan_info *base_tx_cinfo;
+	struct scmi_chan_info *base_rx_cinfo;
+
+	base_tx_cinfo = idr_find(&sinfo->tx_idr, SCMI_PROTOCOL_BASE);
+	if (unlikely(!base_tx_cinfo))
+		return -EINVAL;
+
+	ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo, true,
+				    base_tx_cinfo);
 
-	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
-		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
+	base_rx_cinfo = idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE);
+	if (!ret && base_rx_cinfo)
+		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo, false,
+					    base_rx_cinfo);
 
 	return ret;
 }
-- 
2.25.1


