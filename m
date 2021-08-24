Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAE3F5FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhHXOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:01:28 -0400
Received: from foss.arm.com ([217.140.110.172]:36300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhHXOBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:01:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB791143B;
        Tue, 24 Aug 2021 07:00:31 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490FD3F766;
        Tue, 24 Aug 2021 07:00:30 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 11/12] [RFC] firmware: arm_scmi: Add sync_cmds_atomic_replies transport flag
Date:   Tue, 24 Aug 2021 14:59:40 +0100
Message-Id: <20210824135941.38656-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824135941.38656-1-cristian.marussi@arm.com>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A flag is added to let the transport signal the core that its handling of
synchronous command messages implies that, after .send_message has returned
successfully, the requested command can be assumed to be fully and
completely executed on SCMI platform side so that any possible response
value is already immediately available to be retrieved by a .fetch_reponse:
in other words the polling phase can be skipped in such a case and the
response values accessed straight away.

Note that all of the above applies only when polling mode of operation was
selected by the core: if instead a completion IRQ was found to be available
the normal response processing path based on completions will still be
followed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  8 ++++++++
 drivers/firmware/arm_scmi/driver.c | 29 +++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4ab310c2eae5..2ce6b38d1270 100644
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
  */
@@ -423,6 +430,7 @@ struct scmi_desc {
 	int max_msg;
 	int max_msg_size;
 	bool force_polling;
+	bool sync_cmds_atomic_replies;
 	bool atomic_capable;
 };
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 852baac0e614..e17285f11ce3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -809,14 +809,24 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 					(void *)_RET_IP_);
 		}
 	} else {
-		/*
-		 * Poll on xfer using transport provided .poll_done();
-		 * assumes no completion interrupt was available.
-		 */
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
@@ -829,11 +839,6 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
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
 
-- 
2.17.1

