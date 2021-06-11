Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98A3A4742
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhFKRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:02:48 -0400
Received: from foss.arm.com ([217.140.110.172]:35626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKRCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:02:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD0ED6E;
        Fri, 11 Jun 2021 10:00:48 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B78BB3F719;
        Fri, 11 Jun 2021 10:00:45 -0700 (PDT)
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
Subject: [PATCH v4 07/16] firmware: arm_scmi: Add op to override max message #
Date:   Fri, 11 Jun 2021 17:59:28 +0100
Message-Id: <20210611165937.701-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
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

[ Peter: Adapted patch for submission to upstream. ]

Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  9 ++++++--
 drivers/firmware/arm_scmi/driver.c | 34 ++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4666777019fa..253a218fe16a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -319,6 +319,9 @@ struct scmi_chan_info {
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
+ * @get_max_msg: Optional callback to provide max_msg dynamically
+ * 	@return: Maximum number of messages for the channel type (tx or rx)
+ * 		 that can be pending simultaneously in the system
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -331,6 +334,7 @@ struct scmi_transport_ops {
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
+	unsigned int (*get_max_msg)(bool tx, struct scmi_chan_info *base_cinfo);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
@@ -358,8 +362,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *	  after SCMI core removal.
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
- * @max_msg: Maximum number of messages that can be pending
- *	simultaneously in the system
+ * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
+ *	be pending simultaneously in the system. May be overridden by the
+ *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
  * @support_xfers_delegation: A flag to indicate if the described transport
  *			      will handle delegated xfers, so the core can
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 371d3804cd79..fdd711d85498 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -75,6 +75,7 @@ struct scmi_requested_dev {
  *	Index of this bitmap table is also used for message
  *	sequence identifier.
  * @xfer_lock: Protection for message allocation
+ * @max_msg: Maximum number of messages that can be pending
  * @last_token: A counter to use as base to generate for monotonically
  *		increasing tokens.
  * @free_xfers: A free list for available to use xfers. It is initialized with
@@ -86,6 +87,7 @@ struct scmi_requested_dev {
 struct scmi_xfers_info {
 	unsigned long *xfer_alloc_table;
 	spinlock_t xfer_lock;
+	int max_msg;
 	atomic_t last_token;
 	struct hlist_head free_xfers;
 	DECLARE_HASHTABLE(pending_xfers, SCMI_PENDING_XFERS_HT_ORDER_SZ);
@@ -1310,18 +1312,25 @@ int scmi_handle_put(const struct scmi_handle *handle)
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
-	if (WARN_ON(!desc->max_msg || desc->max_msg > MSG_TOKEN_MAX)) {
+	if (WARN_ON(!info->max_msg || info->max_msg > MSG_TOKEN_MAX)) {
 		dev_err(dev,
 			"Invalid max_msg %d. Maximum messages supported %ld.\n",
-			desc->max_msg, MSG_TOKEN_MAX);
+			info->max_msg, MSG_TOKEN_MAX);
 		return -EINVAL;
 	}
 
@@ -1339,7 +1348,7 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	 * attach all of them to the free list
 	 */
 	INIT_HLIST_HEAD(&info->free_xfers);
-	for (i = 0; i < desc->max_msg; i++) {
+	for (i = 0; i < info->max_msg; i++) {
 		xfer = devm_kzalloc(dev, sizeof(*xfer), GFP_KERNEL);
 		if (!xfer)
 			return -ENOMEM;
@@ -1364,10 +1373,21 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 
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
2.17.1

