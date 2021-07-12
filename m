Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE043C5B89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhGLLlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:41:37 -0400
Received: from foss.arm.com ([217.140.110.172]:53978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234457AbhGLLle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:41:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E2A931B;
        Mon, 12 Jul 2021 04:38:46 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E65503F694;
        Mon, 12 Jul 2021 04:38:44 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, suzuki.poulose@arm.com,
        Tamas.Zsoldos@arm.com, will@kernel.org
Subject: [PATCH 1/5] coresight: etm4x: Save restore TRFCR_EL1
Date:   Mon, 12 Jul 2021 12:38:26 +0100
Message-Id: <20210712113830.2803257-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210712113830.2803257-1-suzuki.poulose@arm.com>
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU enters a low power mode, the TRFCR_EL1 contents could be
reset. Thus we need to save/restore the TRFCR_EL1 along with the ETM4x
registers to allow the tracing.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 52 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index da27cd4a3c38..6bbe4da31d9b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -236,6 +236,17 @@ struct etm4_enable_arg {
 	int rc;
 };
 
+static inline u64 read_trfcr(void)
+{
+	return read_sysreg_s(SYS_TRFCR_EL1);
+}
+
+static inline void write_trfcr(u64 val)
+{
+	write_sysreg_s(val, SYS_TRFCR_EL1);
+	isb();
+}
+
 #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
 
 #define HISI_HIP08_AMBA_ID		0x000b6d01
@@ -985,7 +996,7 @@ static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
 	if (is_kernel_in_hyp_mode())
 		trfcr |= TRFCR_EL2_CX;
 
-	write_sysreg_s(trfcr, SYS_TRFCR_EL1);
+	write_trfcr(trfcr);
 }
 
 static void etm4_init_arch_data(void *info)
@@ -1528,7 +1539,7 @@ static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
 	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
 }
 
-static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
+static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
 	struct etmv4_save_state *state;
@@ -1667,7 +1678,22 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	return ret;
 }
 
-static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
+static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
+{
+	int ret = 0;
+
+	if (drvdata->trfc)
+		drvdata->save_trfcr = read_trfcr();
+	/*
+	 * Save and restore the ETM Trace registers only if
+	 * the ETM is active.
+	 */
+	if (local_read(&drvdata->mode) && drvdata->save_state)
+		ret = __etm4_cpu_save(drvdata);
+	return ret;
+}
+
+static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 {
 	int i;
 	struct etmv4_save_state *state = drvdata->save_state;
@@ -1763,6 +1789,14 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4_cs_lock(drvdata, csa);
 }
 
+static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
+{
+	if (drvdata->trfc)
+		write_trfcr(drvdata->save_trfcr);
+	if (drvdata->state_needs_restore)
+		__etm4_cpu_restore(drvdata);
+}
+
 static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 			      void *v)
 {
@@ -1774,23 +1808,17 @@ static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 
 	drvdata = etmdrvdata[cpu];
 
-	if (!drvdata->save_state)
-		return NOTIFY_OK;
-
 	if (WARN_ON_ONCE(drvdata->cpu != cpu))
 		return NOTIFY_BAD;
 
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		/* save the state if self-hosted coresight is in use */
-		if (local_read(&drvdata->mode))
-			if (etm4_cpu_save(drvdata))
-				return NOTIFY_BAD;
+		if (etm4_cpu_save(drvdata))
+			return NOTIFY_BAD;
 		break;
 	case CPU_PM_EXIT:
 	case CPU_PM_ENTER_FAILED:
-		if (drvdata->state_needs_restore)
-			etm4_cpu_restore(drvdata);
+		etm4_cpu_restore(drvdata);
 		break;
 	default:
 		return NOTIFY_DONE;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index e5b79bdb9851..82cba16b73a6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -921,6 +921,7 @@ struct etmv4_save_state {
  * @lpoverride:	If the implementation can support low-power state over.
  * @trfc:	If the implementation supports Arm v8.4 trace filter controls.
  * @config:	structure holding configuration parameters.
+ * @save_trfcr:	Saved TRFCR_EL1 register during a CPU PM event.
  * @save_state:	State to be preserved across power loss
  * @state_needs_restore: True when there is context to restore after PM exit
  * @skip_power_up: Indicates if an implementation can skip powering up
@@ -973,6 +974,7 @@ struct etmv4_drvdata {
 	bool				lpoverride;
 	bool				trfc;
 	struct etmv4_config		config;
+	u64				save_trfcr;
 	struct etmv4_save_state		*save_state;
 	bool				state_needs_restore;
 	bool				skip_power_up;
-- 
2.24.1

