Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAD43C5B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhGLLlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:41:39 -0400
Received: from foss.arm.com ([217.140.110.172]:53990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234474AbhGLLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:41:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44DB3D6E;
        Mon, 12 Jul 2021 04:38:48 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B06F33F694;
        Mon, 12 Jul 2021 04:38:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, suzuki.poulose@arm.com,
        Tamas.Zsoldos@arm.com, will@kernel.org
Subject: [PATCH 2/5] coresight: etm4x: Use Trace Filtering controls dynamically
Date:   Mon, 12 Jul 2021 12:38:27 +0100
Message-Id: <20210712113830.2803257-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210712113830.2803257-1-suzuki.poulose@arm.com>
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
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
 .../coresight/coresight-etm4x-core.c          | 63 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h |  5 +-
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 6bbe4da31d9b..9b9cebae8bb5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -247,6 +247,45 @@ static inline void write_trfcr(u64 val)
 	isb();
 }
 
+/*
+ * etm4x_prohibit_trace - Prohibit the CPU from tracing at all ELs.
+ * When the CPU supports FEAT_TRF, we could move the ETM to a trace
+ * prohibited state by filtering the Exception levels via TRFCR_EL1.
+ */
+static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
+{
+	if (drvdata->trfcr) {
+		u64 val = read_trfcr();
+
+		write_trfcr(val & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE));
+	}
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
+	write_trfcr(trfcr);
+}
+
 #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
 
 #define HISI_HIP08_AMBA_ID		0x000b6d01
@@ -451,6 +490,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	if (etm4x_is_ete(drvdata))
 		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
 
+	etm4x_allow_trace(drvdata);
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
@@ -729,7 +769,6 @@ static int etm4_enable(struct coresight_device *csdev,
 static void etm4_disable_hw(void *info)
 {
 	u32 control;
-	u64 trfcr;
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
@@ -756,12 +795,7 @@ static void etm4_disable_hw(void *info)
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
@@ -777,9 +811,6 @@ static void etm4_disable_hw(void *info)
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
-	if (drvdata->trfc)
-		write_sysreg_s(trfcr, SYS_TRFCR_EL1);
-
 	/* read the status of the single shot comparators */
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_status[i] =
@@ -974,15 +1005,15 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
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
@@ -996,7 +1027,7 @@ static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
 	if (is_kernel_in_hyp_mode())
 		trfcr |= TRFCR_EL2_CX;
 
-	write_trfcr(trfcr);
+	drvdata->trfcr = trfcr;
 }
 
 static void etm4_init_arch_data(void *info)
@@ -1187,7 +1218,7 @@ static void etm4_init_arch_data(void *info)
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
 	etm4_cs_lock(drvdata, csa);
-	cpu_enable_tracing(drvdata);
+	cpu_detect_trace_filtering(drvdata);
 }
 
 static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
@@ -1682,7 +1713,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int ret = 0;
 
-	if (drvdata->trfc)
+	if (drvdata->trfcr)
 		drvdata->save_trfcr = read_trfcr();
 	/*
 	 * Save and restore the ETM Trace registers only if
@@ -1791,7 +1822,7 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 
 static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 {
-	if (drvdata->trfc)
+	if (drvdata->trfcr)
 		write_trfcr(drvdata->save_trfcr);
 	if (drvdata->state_needs_restore)
 		__etm4_cpu_restore(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 82cba16b73a6..2a7943e2bfcd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -919,7 +919,8 @@ struct etmv4_save_state {
  * @nooverflow:	Indicate if overflow prevention is supported.
  * @atbtrig:	If the implementation can support ATB triggers
  * @lpoverride:	If the implementation can support low-power state over.
- * @trfc:	If the implementation supports Arm v8.4 trace filter controls.
+ * @trfcr:	If the CPU supportfs FEAT_TRF, value of the TRFCR_ELx with
+ * 		trace allowed at user and kernel ELs. Otherwise, 0.
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
-- 
2.24.1

