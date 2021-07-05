Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7273BC21A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGERNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:13:35 -0400
Received: from foss.arm.com ([217.140.110.172]:51222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhGERNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:13:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A23A66D;
        Mon,  5 Jul 2021 10:10:56 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9AA53F694;
        Mon,  5 Jul 2021 10:10:54 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [RFC PATCH v2 7/8] firmware: arm_scmi: Make smc transport use common completions
Date:   Mon,  5 Jul 2021 18:10:21 +0100
Message-Id: <20210705171022.25861-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705171022.25861-1-cristian.marussi@arm.com>
References: <20210705171022.25861-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a completion irq is available use it and delegate command completion
handling to the core SCMI completion mechanism.

If no completion irq is available revert to polling, using the core common
polling machinery.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/smc.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index bed5596c7209..cab1d0d50d8e 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -25,8 +25,6 @@
  * @shmem: Transmit/Receive shared memory area
  * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
  * @func_id: smc/hvc call function id
- * @irq: Optional; employed when platforms indicates msg completion by intr.
- * @tx_complete: Optional, employed only when irq is valid.
  */
 
 struct scmi_smc {
@@ -34,15 +32,13 @@ struct scmi_smc {
 	struct scmi_shared_mem __iomem *shmem;
 	struct mutex shmem_lock;
 	u32 func_id;
-	int irq;
-	struct completion tx_complete;
 };
 
 static irqreturn_t smc_msg_done_isr(int irq, void *data)
 {
 	struct scmi_smc *scmi_info = data;
 
-	complete(&scmi_info->tx_complete);
+	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
 
 	return IRQ_HANDLED;
 }
@@ -111,8 +107,9 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			dev_err(dev, "failed to setup SCMI smc irq\n");
 			return ret;
 		}
-		init_completion(&scmi_info->tx_complete);
-		scmi_info->irq = irq;
+	} else {
+		/* No completion interrupt available */
+		cinfo->needs_polling = true;
 	}
 
 	scmi_info->func_id = func_id;
@@ -142,25 +139,20 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 	struct arm_smccc_res res;
 
+	/*
+	 * Channel lock will be released only once response has been
+	 * surely fully retrieved, so after .mark_txdone()
+	 */
 	mutex_lock(&scmi_info->shmem_lock);
-
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
-	if (scmi_info->irq)
-		reinit_completion(&scmi_info->tx_complete);
-
 	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
-
-	if (scmi_info->irq)
-		wait_for_completion(&scmi_info->tx_complete);
-
-	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
-
-	mutex_unlock(&scmi_info->shmem_lock);
-
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
-	if (res.a0)
+	if (res.a0) {
+		mutex_unlock(&scmi_info->shmem_lock);
 		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
@@ -172,6 +164,13 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
 	shmem_fetch_response(scmi_info->shmem, xfer);
 }
 
+static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
+{
+	struct scmi_smc *scmi_info = cinfo->transport_info;
+
+	mutex_unlock(&scmi_info->shmem_lock);
+}
+
 static bool
 smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
@@ -185,6 +184,7 @@ static const struct scmi_transport_ops scmi_smc_ops = {
 	.chan_setup = smc_chan_setup,
 	.chan_free = smc_chan_free,
 	.send_message = smc_send_message,
+	.mark_txdone = smc_mark_txdone,
 	.fetch_response = smc_fetch_response,
 	.poll_done = smc_poll_done,
 };
-- 
2.17.1

