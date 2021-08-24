Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E373F5FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhHXOB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:01:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237754AbhHXOBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:01:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129141435;
        Tue, 24 Aug 2021 07:00:30 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E693F766;
        Tue, 24 Aug 2021 07:00:28 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 10/12] [RFC] firmware: arm_scmi: Make smc transport atomic
Date:   Tue, 24 Aug 2021 14:59:39 +0100
Message-Id: <20210824135941.38656-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824135941.38656-1-cristian.marussi@arm.com>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute mutex usages with busy-waiting and declare smc transport as
.atomic_capable.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/smc.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index adaa40df3855..c13edaace8a3 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -14,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/processor.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -23,14 +25,15 @@
  *
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
- * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
+ * @inflight: Atomic flag to protect access to Tx/Rx shared memory area
  * @func_id: smc/hvc call function id
  */
 
 struct scmi_smc {
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
-	struct mutex shmem_lock;
+#define INFLIGHT_NONE	MSG_TOKEN_MAX
+	atomic_t inflight;
 	u32 func_id;
 };
 
@@ -114,7 +117,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 
 	scmi_info->func_id = func_id;
 	scmi_info->cinfo = cinfo;
-	mutex_init(&scmi_info->shmem_lock);
+	atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
 	cinfo->transport_info = scmi_info;
 
 	return 0;
@@ -133,6 +136,15 @@ static int smc_chan_free(int id, void *p, void *data)
 	return 0;
 }
 
+static bool smc_xfer_inflight(struct scmi_xfer *xfer, atomic_t *inflight)
+{
+	int ret;
+
+	ret = atomic_cmpxchg(inflight, INFLIGHT_NONE, xfer->hdr.seq);
+
+	return ret == INFLIGHT_NONE;
+}
+
 static int smc_send_message(struct scmi_chan_info *cinfo,
 			    struct scmi_xfer *xfer)
 {
@@ -140,17 +152,18 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	struct arm_smccc_res res;
 
 	/*
-	 * Channel lock will be released only once response has been
+	 * Channel will be released only once response has been
 	 * surely fully retrieved, so after .mark_txdone()
 	 */
-	mutex_lock(&scmi_info->shmem_lock);
+	spin_until_cond(smc_xfer_inflight(xfer, &scmi_info->inflight));
+
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
 	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-		mutex_unlock(&scmi_info->shmem_lock);
+		atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
 		return -EOPNOTSUPP;
 	}
 
@@ -169,7 +182,7 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	mutex_unlock(&scmi_info->shmem_lock);
+	atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
 }
 
 static bool
@@ -195,4 +208,5 @@ const struct scmi_desc scmi_smc_desc = {
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
 	.max_msg_size = 128,
+	.atomic_capable = true,
 };
-- 
2.17.1

