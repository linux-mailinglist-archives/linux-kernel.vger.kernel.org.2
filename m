Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF69B3A4745
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhFKRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:02:54 -0400
Received: from foss.arm.com ([217.140.110.172]:35652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKRCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:02:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91384143D;
        Fri, 11 Jun 2021 10:00:53 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204AA3F719;
        Fri, 11 Jun 2021 10:00:49 -0700 (PDT)
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
Subject: [PATCH v4 08/16] [RFC][REWORK] firmware: arm_scmi: Add op to override max message #
Date:   Fri, 11 Jun 2021 17:59:29 +0100
Message-Id: <20210611165937.701-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
References: <20210611165937.701-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring core scmi_xfer_info_init routines to account for transport
specific maximum number of pending messages.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  6 ++--
 drivers/firmware/arm_scmi/driver.c | 52 ++++++++++++++++++------------
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 253a218fe16a..6b8d388fcf74 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -320,8 +320,8 @@ struct scmi_chan_info {
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
  * @get_max_msg: Optional callback to provide max_msg dynamically
- * 	@return: Maximum number of messages for the channel type (tx or rx)
- * 		 that can be pending simultaneously in the system
+ *		 Returns the maximum number of messages for the channel type
+ *		 (tx or rx) that can be pending simultaneously in the system
  * @send_message: Callback to send a message
  * @mark_txdone: Callback to mark tx as done
  * @fetch_response: Callback to fetch response
@@ -334,7 +334,7 @@ struct scmi_transport_ops {
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
 	int (*chan_free)(int id, void *p, void *data);
-	unsigned int (*get_max_msg)(bool tx, struct scmi_chan_info *base_cinfo);
+	unsigned int (*get_max_msg)(struct scmi_chan_info *base_cinfo);
 	int (*send_message)(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer);
 	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fdd711d85498..041a9e008cbf 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1312,20 +1312,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
 }
 
 static int __scmi_xfer_info_init(struct scmi_info *sinfo,
-				 struct scmi_xfers_info *info,
-				 bool tx,
-				 struct scmi_chan_info *base_cinfo)
+				 struct scmi_xfers_info *info)
 {
 	int i;
 	struct scmi_xfer *xfer;
 	struct device *dev = sinfo->dev;
 	const struct scmi_desc *desc = sinfo->desc;
 
-	info->max_msg = desc->max_msg;
-
-	if (desc->ops->get_max_msg)
-		info->max_msg =	desc->ops->get_max_msg(tx, base_cinfo);
-
 	/* Pre-allocated messages, no more than what hdr.seq can support */
 	if (WARN_ON(!info->max_msg || info->max_msg > MSG_TOKEN_MAX)) {
 		dev_err(dev,
@@ -1371,23 +1364,42 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 	return 0;
 }
 
+static int scmi_channels_max_msg_configure(struct scmi_info *sinfo)
+{
+	const struct scmi_desc *desc = sinfo->desc;
+
+	if (!desc->ops->get_max_msg) {
+		sinfo->tx_minfo.max_msg = desc->max_msg;
+		sinfo->rx_minfo.max_msg = desc->max_msg;
+	} else {
+		struct scmi_chan_info *base_cinfo;
+
+		base_cinfo = idr_find(&sinfo->tx_idr, SCMI_PROTOCOL_BASE);
+		if (!base_cinfo)
+			return -EINVAL;
+
+		sinfo->tx_minfo.max_msg = desc->ops->get_max_msg(base_cinfo);
+
+		base_cinfo = idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE);
+		if (base_cinfo)
+			sinfo->rx_minfo.max_msg =
+				desc->ops->get_max_msg(base_cinfo);
+	}
+
+	return 0;
+}
+
 static int scmi_xfer_info_init(struct scmi_info *sinfo)
 {
 	int ret;
-	struct scmi_chan_info *base_tx_cinfo;
-	struct scmi_chan_info *base_rx_cinfo;
 
-	base_tx_cinfo = idr_find(&sinfo->tx_idr, SCMI_PROTOCOL_BASE);
-	if (unlikely(!base_tx_cinfo))
-		return -EINVAL;
-
-	ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo, true,
-				    base_tx_cinfo);
+	ret = scmi_channels_max_msg_configure(sinfo);
+	if (ret)
+		return ret;
 
-	base_rx_cinfo = idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE);
-	if (!ret && base_rx_cinfo)
-		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo, false,
-					    base_rx_cinfo);
+	ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
+	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
+		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
 
 	return ret;
 }
-- 
2.17.1

