Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1445983E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhKVXKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:10:48 -0500
Received: from foss.arm.com ([217.140.110.172]:46244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhKVXKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:10:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB9D152B;
        Mon, 22 Nov 2021 15:07:23 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6EC03F5A1;
        Mon, 22 Nov 2021 15:07:21 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 11/16] firmware: arm_scmi: Add support for atomic transports
Date:   Mon, 22 Nov 2021 23:06:35 +0000
Message-Id: <20211122230640.1345-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122230640.1345-1-cristian.marussi@arm.com>
References: <20211122230640.1345-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI transport can be configured as .atomic_enabled in order to signal
to the SCMI core that all its TX path is executed in atomic context.

When a specific platform configuration had properly configured such a
transport as .atomic_enabled, the SCMI core will also take care not to
sleep in the corresponding RX path while waiting for a response.

Asynchronous commands should not be used in an atomic context and as such
a warning is emitted if polling was requested for an asynchronous command.

Add also a method to check if, from the SCMI drivers, the underlying SCMI
transport is configured to support atomic transaction of SCMI commands.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- removed atomic_capable
- fully relying on transport polling capabilities
- removed polling/atomic support for delayed_reponse and WARN
- merged with is_transport_atomic() patch
- is_transport_atomic() now considers polling_capable and
  atomic_enabled flags
v4 --> v5
- added .atomic_enabled flag to decide wheter to enable atomic mode or not
  for atomic_capable transports
- reviewed commit message
---
 drivers/firmware/arm_scmi/common.h |  4 +++
 drivers/firmware/arm_scmi/driver.c | 49 ++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h      |  8 +++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index bf25f0e89c78..97a65d5fbb1d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -419,6 +419,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *			      Used by core internally only when polling is
  *			      selected as a waiting for reply method: i.e.
  *			      if a completion irq was found use that anyway.
+ * @atomic_enabled: Flag to indicate that this transport, which is assured not
+ *		    to sleep anywhere on the TX path, can be used in atomic mode
+ *		    when requested.
  */
 struct scmi_desc {
 	int (*transport_init)(void);
@@ -429,6 +432,7 @@ struct scmi_desc {
 	int max_msg_size;
 	const bool force_polling;
 	const bool sync_cmds_atomic_replies;
+	const bool atomic_enabled;
 };
 
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8c04632f3ba3..7d6e97d7a077 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -907,6 +907,20 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
  * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
+ * Using asynchronous commands in atomic/polling mode should be avoided since
+ * it could cause long busy-waiting here, so WARN if polling mode is detected
+ * for this command transaction since upper layers should refrain from issuing
+ * such kind of requests.
+ *
+ * The only other option would have been to refrain from using any asynchronous
+ * command even if made available, when an atomic transport is detected, and
+ * instead forcibly use the synchronous version (thing that can be easily
+ * attained at the protocol layer), but this would also have led to longer
+ * stalls of the channel for synchronous commands and possibly timeouts.
+ * (in other words there is usually a good reason if a platform provides an
+ *  asynchronous version of a command and we should prefer to use it...just not
+ *  in atomic/polling mode)
+ *
  * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
  *	return corresponding error, else if all goes well, return 0.
  */
@@ -918,12 +932,23 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 
 	xfer->async_done = &async_response;
 
+	/*
+	 * Delayed responses are not pollable, an async command should
+	 * not have been used when requiring an atomic/poll context.
+	 * (and Async + IgnoreDelayedResponses are sent via do_xfer)
+	 */
+	WARN_ON(xfer->hdr.poll_completion);
+
 	ret = do_xfer(ph, xfer);
 	if (!ret) {
-		if (!wait_for_completion_timeout(xfer->async_done, timeout))
+		if (!wait_for_completion_timeout(xfer->async_done, timeout)) {
+			dev_err(ph->dev,
+				"timed out in delayed resp(caller: %pS)\n",
+				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
-		else if (xfer->hdr.status)
+		} else if (xfer->hdr.status) {
 			ret = scmi_to_linux_errno(xfer->hdr.status);
+		}
 	}
 
 	xfer->async_done = NULL;
@@ -1357,6 +1382,21 @@ static void scmi_devm_protocol_put(struct scmi_device *sdev, u8 protocol_id)
 	WARN_ON(ret);
 }
 
+/**
+ * scmi_is_transport_atomic  - Method to check if underlying transport for an
+ * SCMI instance is configured as atomic.
+ *
+ * @handle: A reference to the SCMI platform instance.
+ *
+ * Return: True if transport is configured as atomic
+ */
+static bool scmi_is_transport_atomic(const struct scmi_handle *handle)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	return info->desc->atomic_enabled && info->polling_capable;
+}
+
 static inline
 struct scmi_handle *scmi_handle_get_from_info_unlocked(struct scmi_info *info)
 {
@@ -1903,6 +1943,7 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->version = &info->version;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
+	handle->is_transport_atomic = scmi_is_transport_atomic;
 
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
@@ -1921,6 +1962,10 @@ static int scmi_probe(struct platform_device *pdev)
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
+	if (info->desc->atomic_enabled && !info->polling_capable)
+		dev_err(dev,
+			"Transport is not polling capable. Atomic mode not supported.\n");
+
 	/*
 	 * Trigger SCMI Base protocol initialization.
 	 * It's mandatory and won't be ever released/deinit until the
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 80e781c51ddc..9f895cb81818 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -612,6 +612,13 @@ struct scmi_notify_ops {
  * @devm_protocol_get: devres managed method to acquire a protocol and get specific
  *		       operations and a dedicated protocol handler
  * @devm_protocol_put: devres managed method to release a protocol
+ * @is_transport_atomic: method to check if the underlying transport for this
+ *			 instance handle is configured to support atomic
+ *			 transactions for commands.
+ *			 Some users of the SCMI stack in the upper layers could
+ *			 be interested to know if they can assume SCMI
+ *			 command transactions associated to this handle will
+ *			 never sleep and act accordingly.
  * @notify_ops: pointer to set of notifications related operations
  */
 struct scmi_handle {
@@ -622,6 +629,7 @@ struct scmi_handle {
 		(*devm_protocol_get)(struct scmi_device *sdev, u8 proto,
 				     struct scmi_protocol_handle **ph);
 	void (*devm_protocol_put)(struct scmi_device *sdev, u8 proto);
+	bool (*is_transport_atomic)(const struct scmi_handle *handle);
 
 	const struct scmi_notify_ops *notify_ops;
 };
-- 
2.17.1

