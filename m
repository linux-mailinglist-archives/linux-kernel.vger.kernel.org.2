Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B4416191
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbhIWPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:00:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241873AbhIWPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:00:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93E6F12FC;
        Thu, 23 Sep 2021 07:58:50 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E20F3F718;
        Thu, 23 Sep 2021 07:58:48 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 11/13] firmware: arm_scmi: Add atomic mode support to smc transport
Date:   Thu, 23 Sep 2021 15:58:00 +0100
Message-Id: <20210923145802.50938-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210923145802.50938-1-cristian.marussi@arm.com>
References: <20210923145802.50938-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute mutex usages with busy-waiting and declare smc transport as
.atomic_capable.

Add a Kernel configuration option to enable SCMI SMC transport atomic
mode operation and leave it as default disabled.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- removed RFC tag
- add CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE option
- add .atomic_enable support
- make atomic_capable dependent on
  CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
- make also usage of mutexes vs busy-waiting dependent on
  CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
---
 drivers/firmware/arm_scmi/Kconfig | 14 ++++++
 drivers/firmware/arm_scmi/smc.c   | 74 ++++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 0bea0c4d9db1..b74e687c08d8 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -76,6 +76,20 @@ config ARM_SCMI_TRANSPORT_SMC
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on SMC, answer Y.
 
+config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+	bool "Enable atomic mode for SCMI SMC transport"
+	depends on ARM_SCMI_TRANSPORT_SMC
+	help
+	  Enable atomic mode of operation for SCMI SMC based transport.
+
+	  If you want the SCMI SMC based transport to operate in atomic
+	  mode, avoiding any kind of sleeping behaviour on the TX path,
+	  answer Y.
+	  Enabling atomic mode operations allows any SCMI driver using this
+	  transport to operate in atomic context too, at the price of using
+	  a number of busy-waiting primitives all over instead.
+	  If unsure say N.
+
 config ARM_SCMI_TRANSPORT_VIRTIO
 	bool "SCMI transport based on VirtIO"
 	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index adaa40df3855..22c573458719 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -14,6 +15,9 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+#include <linux/processor.h>
+#endif
 #include <linux/slab.h>
 
 #include "common.h"
@@ -23,14 +27,22 @@
  *
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
- * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
+ * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
+ *		Used when NOT operating in atomic mode.
+ * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
+ *	      Used when operating in atomic mode.
  * @func_id: smc/hvc call function id
  */
 
 struct scmi_smc {
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
-	struct mutex shmem_lock;
+	union {
+		/* Protect access to shmem area */
+		struct mutex shmem_lock;
+#define INFLIGHT_NONE	MSG_TOKEN_MAX
+		atomic_t inflight;
+	};
 	u32 func_id;
 };
 
@@ -54,6 +66,46 @@ static bool smc_chan_available(struct device *dev, int idx)
 	return true;
 }
 
+static inline void smc_channel_lock_init(struct scmi_smc *scmi_info)
+{
+#ifndef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+	mutex_init(&scmi_info->shmem_lock);
+#else
+	atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
+#endif
+}
+
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+static bool smc_xfer_inflight(struct scmi_xfer *xfer, atomic_t *inflight)
+{
+	int ret;
+
+	ret = atomic_cmpxchg(inflight, INFLIGHT_NONE, xfer->hdr.seq);
+
+	return ret == INFLIGHT_NONE;
+}
+#endif
+
+static inline void
+smc_channel_lock_acquire(struct scmi_smc *scmi_info,
+			 struct scmi_xfer *xfer __maybe_unused)
+{
+#ifndef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+	mutex_lock(&scmi_info->shmem_lock);
+#else
+	spin_until_cond(smc_xfer_inflight(xfer, &scmi_info->inflight));
+#endif
+}
+
+static inline void smc_channel_lock_release(struct scmi_smc *scmi_info)
+{
+#ifndef CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
+	mutex_unlock(&scmi_info->shmem_lock);
+#else
+	atomic_set(&scmi_info->inflight, INFLIGHT_NONE);
+#endif
+}
+
 static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx)
 {
@@ -114,7 +166,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 
 	scmi_info->func_id = func_id;
 	scmi_info->cinfo = cinfo;
-	mutex_init(&scmi_info->shmem_lock);
+	smc_channel_lock_init(scmi_info);
 	cinfo->transport_info = scmi_info;
 
 	return 0;
@@ -140,17 +192,18 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	struct arm_smccc_res res;
 
 	/*
-	 * Channel lock will be released only once response has been
+	 * Channel will be released only once response has been
 	 * surely fully retrieved, so after .mark_txdone()
 	 */
-	mutex_lock(&scmi_info->shmem_lock);
+	smc_channel_lock_acquire(scmi_info, xfer);
+
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
 	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
 	if (res.a0) {
-		mutex_unlock(&scmi_info->shmem_lock);
+		smc_channel_lock_release(scmi_info);
 		return -EOPNOTSUPP;
 	}
 
@@ -169,7 +222,7 @@ static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	mutex_unlock(&scmi_info->shmem_lock);
+	smc_channel_lock_release(scmi_info);
 }
 
 static bool
@@ -195,4 +248,11 @@ const struct scmi_desc scmi_smc_desc = {
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
 	.max_msg_size = 128,
+	/*
+	 * Make it atomic_capable only when the transport is also effectively
+	 * configured to be used in atomic mode, since it is only then that
+	 * sleeping primitives are swap out in favour of busy waiting.
+	 */
+	.atomic_capable = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
+	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
 };
-- 
2.17.1

