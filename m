Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D983D3A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhGWMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:05:50 -0400
Received: from foss.arm.com ([217.140.110.172]:45434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhGWMFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1050E1063;
        Fri, 23 Jul 2021 05:46:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97FCD3F694;
        Fri, 23 Jul 2021 05:46:20 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 01/10] coresight: etm4x: Save restore TRFCR_EL1
Date:   Fri, 23 Jul 2021 13:46:02 +0100
Message-Id: <20210723124611.3828908-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU enters a low power mode, the TRFCR_EL1 contents could be
reset. Thus we need to save/restore the TRFCR_EL1 along with the ETM4x
registers to allow the tracing.

The TRFCR related helpers are in a new header file, as we need to use
them for TRBE in the later patches.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Moved the TRFCR helpers in to a new header file
---
 .../coresight/coresight-etm4x-core.c          | 43 +++++++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +
 .../coresight/coresight-self-hosted-trace.h   | 25 +++++++++++
 3 files changed, 58 insertions(+), 12 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-self-hosted-trace.h

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index da27cd4a3c38..3e548dac9b05 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -39,6 +39,7 @@
 
 #include "coresight-etm4x.h"
 #include "coresight-etm-perf.h"
+#include "coresight-self-hosted-trace.h"
 
 static int boot_enable;
 module_param(boot_enable, int, 0444);
@@ -985,7 +986,7 @@ static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
 	if (is_kernel_in_hyp_mode())
 		trfcr |= TRFCR_EL2_CX;
 
-	write_sysreg_s(trfcr, SYS_TRFCR_EL1);
+	write_trfcr(trfcr);
 }
 
 static void etm4_init_arch_data(void *info)
@@ -1528,7 +1529,7 @@ static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
 	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
 }
 
-static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
+static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
 	struct etmv4_save_state *state;
@@ -1667,7 +1668,23 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	return ret;
 }
 
-static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
+static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
+{
+	int ret = 0;
+
+	/* Save the TRFCR irrespective of whether the ETM is ON */
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
@@ -1763,6 +1780,14 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
@@ -1774,23 +1799,17 @@ static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 
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
diff --git a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
new file mode 100644
index 000000000000..53b35a28075e
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Arm v8 Self-Hosted trace support.
+ *
+ * Copyright (C) 2021 ARM Ltd.
+ */
+
+#ifndef __CORESIGHT_SELF_HOSTED_TRACE_H
+#define __CORESIGHT_SELF_HOSTED_TRACE_H
+
+#include <asm/sysreg.h>
+
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
+#endif			/*  __CORESIGHT_SELF_HOSTED_TRACE_H */
-- 
2.24.1

