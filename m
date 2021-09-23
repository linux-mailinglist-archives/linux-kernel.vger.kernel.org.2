Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351E6416192
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbhIWPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:00:35 -0400
Received: from foss.arm.com ([217.140.110.172]:35974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241916AbhIWPAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:00:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B503011FB;
        Thu, 23 Sep 2021 07:58:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9FD23F718;
        Thu, 23 Sep 2021 07:58:50 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 12/13] firmware: arm_scmi: Add sync_cmds_atomic_replies transport flag
Date:   Thu, 23 Sep 2021 15:58:01 +0100
Message-Id: <20210923145802.50938-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923145802.50938-1-cristian.marussi@arm.com>
References: <20210923145802.50938-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to let the transport signal to the core if its handling of sync
command implies that, after .send_message has returned successfully, the
requested command can be assumed to be fully and completely executed on
SCMI platform side so that any possible response value is already
immediately available to be retrieved by a .fetch_reponse: in other words
the polling phase can be skipped in such a case and the response values
accessed straight away.

Note that all of the above applies only when polling mode of operation was
selected by the core: if instead a completion IRQ was found to be available
the normal response processing path based on completions will still be
followed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- removed RFC tag
- consider sync_cmds_atomic_replies flag when deciding if polling is to be
  supported and .poll_done() is not provided.
- reviewed commit message
---
 drivers/firmware/arm_scmi/common.h |  8 ++++++
 drivers/firmware/arm_scmi/driver.c | 42 +++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index daba0791da55..4350f1b60e97 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -412,6 +412,13 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg_size: Maximum size of data per message that can be handled.
  * @force_polling: Flag to force this whole transport to use SCMI core polling
  *		   mechanism instead of completion interrupts even if available.
+ * @sync_cmds_atomic_replies: Flag to indicate that the transport assures
+ *			      synchronous-command messages are atomically
+ *			      completed on .send_message: no need to poll
+ *			      actively waiting for a response.
+ *			      Used by core internally only when polling is
+ *			      selected as a waiting for reply method: i.e.
+ *			      if a completion irq was found use that anyway.
  * @atomic_capable: Flag to indicate that this transport is assured not to sleep
  *		    on the TX path.
  * @atomic_enabled: Flag to indicate whether this @atomic_capable transport
@@ -425,6 +432,7 @@ struct scmi_desc {
 	int max_msg;
 	int max_msg_size;
 	const bool force_polling;
+	const bool sync_cmds_atomic_replies;
 	const bool atomic_capable;
 	const bool atomic_enabled;
 };
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0d5c015ba736..03356233b4f1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -814,13 +814,27 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 		}
 	} else {
 		/*
-		 * Poll on xfer using transport provided .poll_done();
-		 * assumes no completion interrupt was available.
+		 * Real polling is needed only if transport has NOT declared
+		 * itself to support synchronous commands replies.
 		 */
-		ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+		if (!info->desc->sync_cmds_atomic_replies) {
+			/*
+			 * Poll on xfer using transport provided .poll_done();
+			 * assumes no completion interrupt was available.
+			 */
+			ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+
+			spin_until_cond(scmi_xfer_done_no_timeout(cinfo,
+								  xfer, stop));
+			if (ktime_after(ktime_get(), stop)) {
+				dev_err(dev,
+					"timed out in resp(caller: %pS) - polling\n",
+					(void *)_RET_IP_);
+				ret = -ETIMEDOUT;
+			}
+		}
 
-		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-		if (ktime_before(ktime_get(), stop)) {
+		if (!ret) {
 			unsigned long flags;
 
 			/*
@@ -833,11 +847,6 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 				xfer->state = SCMI_XFER_RESP_OK;
 			}
 			spin_unlock_irqrestore(&xfer->lock, flags);
-		} else {
-			dev_err(dev,
-				"timed out in resp(caller: %pS) - polling\n",
-				(void *)_RET_IP_);
-			ret = -ETIMEDOUT;
 		}
 	}
 
@@ -864,7 +873,9 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	struct scmi_chan_info *cinfo;
 
 	/* Check for polling request on custom command xfers at first */
-	if (xfer->hdr.poll_completion && !info->desc->ops->poll_done) {
+	if (xfer->hdr.poll_completion &&
+	    !info->desc->ops->poll_done &&
+	    !info->desc->sync_cmds_atomic_replies) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
 		return -EINVAL;
@@ -1629,8 +1640,15 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	if (ret)
 		return ret;
 
+	/*
+	 * If polling mode was requested, check that the specific transport
+	 * supports it by providing a .poll_done callback unless such transport
+	 * has also declared itself to support synchronous command replies,
+	 * since in that case no real polling has to be performed.
+	 */
 	if (tx && (cinfo->no_completion_irq || info->desc->force_polling)) {
-		if (info->desc->ops->poll_done) {
+		if (info->desc->ops->poll_done ||
+		    info->desc->sync_cmds_atomic_replies) {
 			dev_info(dev,
 				 "Enabled polling mode TX channel - prot_id:%d\n",
 				 prot_id);
-- 
2.17.1

