Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD93256FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhBYTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:45:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234876AbhBYTjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:39:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF041476;
        Thu, 25 Feb 2021 11:36:16 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E4653F70D;
        Thu, 25 Feb 2021 11:36:15 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 12/19] coresight: etm4x: Add support for PE OS lock
Date:   Thu, 25 Feb 2021 19:35:36 +0000
Message-Id: <20210225193543.2920532-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225193543.2920532-1-suzuki.poulose@arm.com>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETE may not implement the OS lock and instead could rely on
the PE OS Lock for the trace unit access. This is indicated
by the TRCOLSR.OSM == 0b100. Add support for handling the
PE OS lock

Cc: Mike Leach <mike.leach@linaro.org>
Reviewed-by: mike.leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 50 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h | 15 ++++++
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 00297906669c..35802caca32a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -115,30 +115,59 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
 	}
 }
 
-static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
+static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
+			       struct csdev_access *csa)
 {
-	/* Writing 0 to TRCOSLAR unlocks the trace registers */
-	etm4x_relaxed_write32(csa, 0x0, TRCOSLAR);
-	drvdata->os_unlock = true;
+	u32 oslsr = etm4x_relaxed_read32(csa, TRCOSLSR);
+
+	drvdata->os_lock_model = ETM_OSLSR_OSLM(oslsr);
+}
+
+static void etm_write_os_lock(struct etmv4_drvdata *drvdata,
+			      struct csdev_access *csa, u32 val)
+{
+	val = !!val;
+
+	switch (drvdata->os_lock_model) {
+	case ETM_OSLOCK_PRESENT:
+		etm4x_relaxed_write32(csa, val, TRCOSLAR);
+		break;
+	case ETM_OSLOCK_PE:
+		write_sysreg_s(val, SYS_OSLAR_EL1);
+		break;
+	default:
+		pr_warn_once("CPU%d: Unsupported Trace OSLock model: %x\n",
+			     smp_processor_id(), drvdata->os_lock_model);
+		fallthrough;
+	case ETM_OSLOCK_NI:
+		return;
+	}
 	isb();
 }
 
+static inline void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata,
+				      struct csdev_access *csa)
+{
+	WARN_ON(drvdata->cpu != smp_processor_id());
+
+	/* Writing 0 to OS Lock unlocks the trace unit registers */
+	etm_write_os_lock(drvdata, csa, 0x0);
+	drvdata->os_unlock = true;
+}
+
 static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
 	if (!WARN_ON(!drvdata->csdev))
 		etm4_os_unlock_csa(drvdata, &drvdata->csdev->access);
-
 }
 
 static void etm4_os_lock(struct etmv4_drvdata *drvdata)
 {
 	if (WARN_ON(!drvdata->csdev))
 		return;
-
-	/* Writing 0x1 to TRCOSLAR locks the trace registers */
-	etm4x_relaxed_write32(&drvdata->csdev->access, 0x1, TRCOSLAR);
+	/* Writing 0x1 to OS Lock locks the trace registers */
+	etm_write_os_lock(drvdata, &drvdata->csdev->access, 0x1);
 	drvdata->os_unlock = false;
-	isb();
 }
 
 static void etm4_cs_lock(struct etmv4_drvdata *drvdata,
@@ -937,6 +966,9 @@ static void etm4_init_arch_data(void *info)
 	if (!etm4_init_csdev_access(drvdata, csa))
 		return;
 
+	/* Detect the support for OS Lock before we actually use it */
+	etm_detect_os_lock(drvdata, csa);
+
 	/* Make sure all registers are accessible */
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index f6478ef642bf..5b961c5b78d1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -505,6 +505,20 @@
 					 ETM_MODE_EXCL_KERN | \
 					 ETM_MODE_EXCL_USER)
 
+/*
+ * TRCOSLSR.OSLM advertises the OS Lock model.
+ * OSLM[2:0] = TRCOSLSR[4:3,0]
+ *
+ *	0b000 - Trace OS Lock is not implemented.
+ *	0b010 - Trace OS Lock is implemented.
+ *	0b100 - Trace OS Lock is not implemented, unit is controlled by PE OS Lock.
+ */
+#define ETM_OSLOCK_NI		0b000
+#define ETM_OSLOCK_PRESENT	0b010
+#define ETM_OSLOCK_PE		0b100
+
+#define ETM_OSLSR_OSLM(oslsr)	((((oslsr) & GENMASK(4, 3)) >> 2) | (oslsr & 0x1))
+
 /*
  * TRCDEVARCH Bit field definitions
  * Bits[31:21]	- ARCHITECT = Always Arm Ltd.
@@ -898,6 +912,7 @@ struct etmv4_drvdata {
 	u8				s_ex_level;
 	u8				ns_ex_level;
 	u8				q_support;
+	u8				os_lock_model;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
-- 
2.24.1

