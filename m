Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAE3D3A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhGWMFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:05:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234899AbhGWMFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFF1F12FC;
        Fri, 23 Jul 2021 05:46:23 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41D4B3F694;
        Fri, 23 Jul 2021 05:46:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 02/10] coresight: etm4x: Use Trace Filtering controls dynamically
Date:   Fri, 23 Jul 2021 13:46:03 +0100
Message-Id: <20210723124611.3828908-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Trace Filtering support (FEAT_TRF) ensures that the ETM
can be prohibited from generating any trace for a given EL.
This is much stricter knob, than the TRCVICTLR exception level
masks. At the moment, we do a onetime enable trace at user and
kernel and leave it untouched for the kernel life time.

This patch makes the switch dynamic, by honoring the filters
set by the user and enforcing them in the TRFCR controls.
We also rename the cpu_enable_tracing() appropriately to
cpu_detect_trace_filtering() and the drvdata member
trfc => trfcr to indicate the "value" of the TRFCR_EL1.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 61 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h |  5 +-
 .../coresight/coresight-self-hosted-trace.h   |  7 +++
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3e548dac9b05..adba84b29455 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -237,6 +237,43 @@ struct etm4_enable_arg {
 	int rc;
 };
 
+/*
+ * etm4x_prohibit_trace - Prohibit the CPU from tracing at all ELs.
+ * When the CPU supports FEAT_TRF, we could move the ETM to a trace
+ * prohibited state by filtering the Exception levels via TRFCR_EL1.
+ */
+static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
+{
+	if (drvdata->trfcr)
+		cpu_prohibit_trace();
+}
+
+/*
+ * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
+ * as configured by the drvdata->config.mode for the current
+ * session. Even though we have TRCVICTLR bits to filter the
+ * trace in the ELs, it doesn't prevent the ETM from generating
+ * a packet (e.g, TraceInfo) that might contain the addresses from
+ * the excluded levels. Thus we use the additional controls provided
+ * via the Trace Filtering controls (FEAT_TRF) to make sure no trace
+ * is generated for the excluded ELs.
+ */
+static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
+{
+	u64 trfcr = drvdata->trfcr;
+
+	/* If the CPU doesn't support FEAT_TRF, nothing to do */
+	if (!trfcr)
+		return;
+
+	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
+		trfcr &= ~TRFCR_ELx_ExTRE;
+	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
+		trfcr &= ~TRFCR_ELx_E0TRE;
+
+	write_trfcr(trfcr);
+}
+
 #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
 
 #define HISI_HIP08_AMBA_ID		0x000b6d01
@@ -441,6 +478,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	if (etm4x_is_ete(drvdata))
 		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
 
+	etm4x_allow_trace(drvdata);
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
@@ -719,7 +757,6 @@ static int etm4_enable(struct coresight_device *csdev,
 static void etm4_disable_hw(void *info)
 {
 	u32 control;
-	u64 trfcr;
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
@@ -746,12 +783,7 @@ static void etm4_disable_hw(void *info)
 	 * If the CPU supports v8.4 Trace filter Control,
 	 * set the ETM to trace prohibited region.
 	 */
-	if (drvdata->trfc) {
-		trfcr = read_sysreg_s(SYS_TRFCR_EL1);
-		write_sysreg_s(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE),
-			       SYS_TRFCR_EL1);
-		isb();
-	}
+	etm4x_prohibit_trace(drvdata);
 	/*
 	 * Make sure everything completes before disabling, as recommended
 	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
@@ -767,9 +799,6 @@ static void etm4_disable_hw(void *info)
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
-	if (drvdata->trfc)
-		write_sysreg_s(trfcr, SYS_TRFCR_EL1);
-
 	/* read the status of the single shot comparators */
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_status[i] =
@@ -964,15 +993,15 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 	return false;
 }
 
-static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
+static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
 {
 	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
 	u64 trfcr;
 
+	drvdata->trfcr = 0;
 	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
 		return;
 
-	drvdata->trfc = true;
 	/*
 	 * If the CPU supports v8.4 SelfHosted Tracing, enable
 	 * tracing at the kernel EL and EL0, forcing to use the
@@ -986,7 +1015,7 @@ static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
 	if (is_kernel_in_hyp_mode())
 		trfcr |= TRFCR_EL2_CX;
 
-	write_trfcr(trfcr);
+	drvdata->trfcr = trfcr;
 }
 
 static void etm4_init_arch_data(void *info)
@@ -1177,7 +1206,7 @@ static void etm4_init_arch_data(void *info)
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
 	etm4_cs_lock(drvdata, csa);
-	cpu_enable_tracing(drvdata);
+	cpu_detect_trace_filtering(drvdata);
 }
 
 static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
@@ -1673,7 +1702,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	int ret = 0;
 
 	/* Save the TRFCR irrespective of whether the ETM is ON */
-	if (drvdata->trfc)
+	if (drvdata->trfcr)
 		drvdata->save_trfcr = read_trfcr();
 	/*
 	 * Save and restore the ETM Trace registers only if
@@ -1782,7 +1811,7 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 {
-	if (drvdata->trfc)
+	if (drvdata->trfcr)
 		write_trfcr(drvdata->save_trfcr);
 	if (drvdata->state_needs_restore)
 		__etm4_cpu_restore(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 82cba16b73a6..724819592c2e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -919,7 +919,8 @@ struct etmv4_save_state {
  * @nooverflow:	Indicate if overflow prevention is supported.
  * @atbtrig:	If the implementation can support ATB triggers
  * @lpoverride:	If the implementation can support low-power state over.
- * @trfc:	If the implementation supports Arm v8.4 trace filter controls.
+ * @trfcr:	If the CPU supportfs FEAT_TRF, value of the TRFCR_ELx with
+ *		trace allowed at user and kernel ELs. Otherwise, 0.
  * @config:	structure holding configuration parameters.
  * @save_trfcr:	Saved TRFCR_EL1 register during a CPU PM event.
  * @save_state:	State to be preserved across power loss
@@ -972,7 +973,7 @@ struct etmv4_drvdata {
 	bool				nooverflow;
 	bool				atbtrig;
 	bool				lpoverride;
-	bool				trfc;
+	u64				trfcr;
 	struct etmv4_config		config;
 	u64				save_trfcr;
 	struct etmv4_save_state		*save_state;
diff --git a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
index 53b35a28075e..586d26e0cba3 100644
--- a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
+++ b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
@@ -22,4 +22,11 @@ static inline void write_trfcr(u64 val)
 	isb();
 }
 
+static inline void cpu_prohibit_trace(void)
+{
+	u64 trfcr = read_trfcr();
+
+	/* Prohibit tracing at EL0 & the kernel EL */
+	write_trfcr(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE));
+}
 #endif			/*  __CORESIGHT_SELF_HOSTED_TRACE_H */
-- 
2.24.1

