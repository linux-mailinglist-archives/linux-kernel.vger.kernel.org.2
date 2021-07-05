Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87743BC214
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGERNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:13:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhGERNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:13:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050901042;
        Mon,  5 Jul 2021 10:10:43 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352973F694;
        Mon,  5 Jul 2021 10:10:41 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH v2 1/8] firmware: arm_scmi: Add configurable polling mode for transports
Date:   Mon,  5 Jul 2021 18:10:15 +0100
Message-Id: <20210705171022.25861-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705171022.25861-1-cristian.marussi@arm.com>
References: <20210705171022.25861-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI communications along TX channels can optionally be provided of a
completion interrupt; when such interrupt is not available, command
transactions should rely on polling, where the SCMI core takes care to
repeatedly evaluates the transport-specific .poll_done() function to
determine if a request was completed or timed out.

Such mechanism is already present and working on a single transfer base:
SCMI protocols can indeed enable hdr.poll_completion on specific commands
ahead of each transfer and cause that transaction to be handled with
polling.

Introduce a couple of flags to be able to enforce such polling behaviour
globally at will:

 - scmi_desc.force_polling: to statically switch the whole transport to
 			    polling mode.

 - scmi_chan_info.needs_polling: to switch a single channel dynamically to
 				 polling mode if at runtime is determined
				 that no completion interrupt was available
				 for such channel.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 10 ++++++++++
 drivers/firmware/arm_scmi/driver.c | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 61f1d7e1742b..eb45f2dced03 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -320,11 +320,18 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
  * @dev: Reference to device in the SCMI hierarchy corresponding to this
  *	 channel
  * @handle: Pointer to SCMI entity handle
+ * @needs_polling: Flag to indicate that this channel has no completion
+ *		   interrupt mechanism, so it needs SCMI core to poll, using
+ *		   .poll_done(), to determine when a command has completed.
+ *		   This can be dynamically set by transports at run-time inside
+ *		   their provided .chan_setup() when they determine no
+ *		   completion interrupt is available.
  * @transport_info: Transport layer related information
  */
 struct scmi_chan_info {
 	struct device *dev;
 	struct scmi_handle *handle;
+	bool needs_polling;
 	void *transport_info;
 };
 
@@ -386,6 +393,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @using_xfers_delegation: A flag to indicate if the described transport will
  *			    handle delegated xfers, so the core can derive
  *			    proper related assumptions.
+ * @force_polling: Flag to force this whole transport to use SCMI core polling
+ *		   mechanism instead of completion interrupts even if available.
  */
 struct scmi_desc {
 	int (*init)(void);
@@ -395,6 +404,7 @@ struct scmi_desc {
 	int max_msg;
 	int max_msg_size;
 	bool using_xfers_delegation;
+	bool force_polling;
 };
 
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 218901492229..d1814c58f4ba 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -816,6 +816,15 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
 
 	scmi_xfer_state_update(xfer);
 
+	/* Discard unexpected messages when polling is active. */
+	if (xfer->hdr.type != MSG_TYPE_DELAYED_RESP &&
+	    xfer->hdr.poll_completion) {
+		WARN_ON_ONCE(1);
+		dev_dbg(cinfo->dev,
+			"Completion IRQ received but using polling. Ignore.\n");
+		return;
+	}
+
 	/* rx.len could be shrunk in the sync do_xfer, so reset to maxsz */
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
 		xfer->rx.len = info->desc->max_msg_size;
@@ -929,6 +938,9 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	if (unlikely(!cinfo))
 		return -EINVAL;
 
+	if (info->desc->force_polling || cinfo->needs_polling)
+		xfer->hdr.poll_completion = true;
+
 	trace_scmi_xfer_begin(xfer->transfer_id, xfer->hdr.id,
 			      xfer->hdr.protocol_id, xfer->hdr.seq,
 			      xfer->hdr.poll_completion);
@@ -1643,6 +1655,11 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	if (ret)
 		return ret;
 
+	if (tx && (cinfo->needs_polling || info->desc->force_polling))
+		dev_info(dev,
+			 "Enabled polling mode for TX channel - prot_id:%d\n",
+			 prot_id);
+
 idr_alloc:
 	ret = idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
 	if (ret != prot_id) {
-- 
2.17.1

