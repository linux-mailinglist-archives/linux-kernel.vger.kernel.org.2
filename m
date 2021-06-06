Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C73739D1CC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhFFWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:15:10 -0400
Received: from foss.arm.com ([217.140.110.172]:46342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhFFWPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:15:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DAE931B;
        Sun,  6 Jun 2021 15:13:16 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15FD43F719;
        Sun,  6 Jun 2021 15:13:13 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH 04/10] firmware: arm_scmi: Add support for atomic transports
Date:   Sun,  6 Jun 2021 23:12:26 +0100
Message-Id: <20210606221232.33768-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606221232.33768-1-cristian.marussi@arm.com>
References: <20210606221232.33768-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An SCMI transport can declare itself as .atomic_capable in order to signal
to the SCMI core that all its transmit path can be executed in atomic
context: the core as a consequence will take care not to sleep to in the
corresponding rx path while waiting for a response or a delayed response.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
---
 drivers/firmware/arm_scmi/common.h |   1 +
 drivers/firmware/arm_scmi/driver.c | 144 +++++++++++++++++++++++------
 2 files changed, 119 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 8f4e6ebfc0ef..42cf1c79c096 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -333,6 +333,7 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  *		   mechanism instead of completion interrupts even if available.
  */
 struct scmi_desc {
+	bool atomic_capable;
 	const struct scmi_transport_ops *ops;
 	int max_rx_timeout_ms;
 	int max_msg;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c11ff49f6b62..276b729f2f43 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -360,6 +360,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 		info->desc->ops->clear_channel(cinfo);
 		complete(xfer->async_done);
 	} else {
+		/*
+		 * This same xfer->done completion is used in atomic mode as a
+		 * flag for polling.
+		 */
 		complete(&xfer->done);
 	}
 }
@@ -410,8 +414,6 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
-#define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
-
 static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 				      struct scmi_xfer *xfer, ktime_t stop)
 {
@@ -421,6 +423,79 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 	       ktime_after(ktime_get(), stop);
 }
 
+static bool xfer_complete_or_timeout(struct completion *done, ktime_t stop)
+{
+	return try_wait_for_completion(done) || ktime_after(ktime_get(), stop);
+}
+
+static int spin_for_completion_timeout(struct completion *done, int timeout_ms)
+{
+	ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+
+	spin_until_cond(xfer_complete_or_timeout(done, stop));
+	if (ktime_after(ktime_get(), stop))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+/**
+ * scmi_wait_for_message_response  - An helper to group all the possible ways of
+ * waiting for a synchronous message response.
+ *
+ * @cinfo: SCMI channel info
+ * @xfer: Reference to the transfer being waited for.
+ *
+ * Chooses waiting strategy (sleep-waiting vs busy-waiting) depending on flags
+ * configuration like xfer->hdr.poll_completion and scmi_desc.atomic.capable.
+ *
+ * Return: 0 on Success, error otherwise.
+ */
+static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
+					  struct scmi_xfer *xfer)
+{
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct device *dev = info->dev;
+	int ret = 0, timeout_ms = info->desc->max_rx_timeout_ms;
+
+	if (!xfer->hdr.poll_completion) {
+		if (!info->desc->atomic_capable) {
+			if (!wait_for_completion_timeout(&xfer->done,
+							 msecs_to_jiffies(timeout_ms))) {
+				dev_err(dev, "timed out in resp(caller: %pS)\n",
+					(void *)_RET_IP_);
+				ret = -ETIMEDOUT;
+			}
+		} else {
+			/* Poll on xfer->done waiting for completion by interrupt */
+			ret = spin_for_completion_timeout(&xfer->done,
+							  timeout_ms);
+			if (ret)
+				dev_err(dev,
+					"timed out in resp(caller: %pS) - atomic\n",
+					(void *)_RET_IP_);
+		}
+	} else {
+		/*
+		 * Poll on xfer using transport provided .poll_done();
+		 * assumes no completion interrupt was available.
+		 */
+		ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
+
+		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
+		if (ktime_after(ktime_get(), stop)) {
+			dev_err(dev,
+				"timed out in resp(caller: %pS) - polling\n",
+				(void *)_RET_IP_);
+			ret = -ETIMEDOUT;
+		} else {
+			info->desc->ops->fetch_response(cinfo, xfer);
+		}
+	}
+
+	return ret;
+}
+
 /**
  * do_xfer() - Do one transfer
  *
@@ -435,7 +510,6 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		   struct scmi_xfer *xfer)
 {
 	int ret;
-	int timeout;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct device *dev = info->dev;
@@ -467,25 +541,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		return ret;
 	}
 
-	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
-
-		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
-
-		if (ktime_before(ktime_get(), stop))
-			info->desc->ops->fetch_response(cinfo, xfer);
-		else
-			ret = -ETIMEDOUT;
-	} else {
-		/* And we wait for the response. */
-		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
-			dev_err(dev, "timed out in resp(caller: %pS)\n",
-				(void *)_RET_IP_);
-			ret = -ETIMEDOUT;
-		}
-	}
-
+	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status)
 		ret = scmi_to_linux_errno(xfer->hdr.status);
 
@@ -507,7 +563,7 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
 	xfer->rx.len = info->desc->max_msg_size;
 }
 
-#define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
+#define SCMI_DRESP_TIMEOUT	(2 * MSEC_PER_SEC)
 
 /**
  * do_xfer_with_response() - Do one transfer and wait until the delayed
@@ -516,14 +572,33 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
  * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
+ * Avois sleeping in favour of busy-waiting if the underlying transport was
+ * declared as .atomic_capable.
+ *
+ * Note that using asynchronous commands when running on top of atomic
+ * transports should be avoided since it could cause long busy-waiting here,
+ * but, once a transport is declared atomic, upper layers using the SCMI stack
+ * can freely make assumptions about the 'non-sleeping' nature of the stack
+ * (e.g. Clock framework) and it cannot be excluded that asynchronous commands
+ * could be exposed by the platform and so used.
+ *
+ * The only other option would have been to refrain from using any asynchronous
+ * command even if made available, when an atomic transport is detected, and
+ * instead forcibly use the synchronous version (thing that can be easily
+ * attained at the protocol layer), but this would also have led to longer
+ * stalls of the channel for synchronous commands and possibly timeouts.
+ * (in other words there is usually a good reason if a platform provides an
+ *  asynchronous version of a command and we should prefer to use it)
+ *
  * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
  *	return corresponding error, else if all goes well, return 0.
  */
 static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 				 struct scmi_xfer *xfer)
 {
-	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
+	int ret, timeout = msecs_to_jiffies(SCMI_DRESP_TIMEOUT);
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	DECLARE_COMPLETION_ONSTACK(async_response);
 
 	xfer->hdr.protocol_id = pi->proto->id;
@@ -531,8 +606,25 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 	xfer->async_done = &async_response;
 
 	ret = do_xfer(ph, xfer);
-	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
-		ret = -ETIMEDOUT;
+	if (!ret) {
+		if (!info->desc->atomic_capable) {
+			if (!wait_for_completion_timeout(xfer->async_done,
+							 timeout)) {
+				dev_err(ph->dev,
+					"timed out in delayed resp(caller: %pS)\n",
+					(void *)_RET_IP_);
+				ret = -ETIMEDOUT;
+			}
+		} else {
+			ret = spin_for_completion_timeout(xfer->async_done,
+							  SCMI_DRESP_TIMEOUT);
+		}
+
+		if (ret)
+			dev_err(ph->dev,
+				"timed out in delayed resp(caller: %pS) - atomic\n",
+				(void *)_RET_IP_);
+	}
 
 	xfer->async_done = NULL;
 	return ret;
-- 
2.17.1

