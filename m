Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6E433C56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhJSQfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:35:53 -0400
Received: from foss.arm.com ([217.140.110.172]:51662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234528AbhJSQfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:35:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D0AED1;
        Tue, 19 Oct 2021 09:33:27 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 576DC3F694;
        Tue, 19 Oct 2021 09:33:26 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 09/15] coresight: trbe: Add infrastructure for Errata handling
Date:   Tue, 19 Oct 2021 17:31:47 +0100
Message-Id: <20211019163153.3692640-10-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211019163153.3692640-1-suzuki.poulose@arm.com>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a minimal infrastructure to keep track of the errata
affecting the given TRBE instance. Given that we have
heterogeneous CPUs, we have to manage the list per-TRBE
instance to be able to apply the work around as needed.
Thus we will need to check if individual CPUs are affected
by the erratum.

We rely on the arm64 errata framework for the actual
description and the discovery of a given erratum, to
keep the Erratum work around at a central place and
benefit from the code and the advertisement from the
kernel. Though we could reuse the "this_cpu_has_cap()"
to apply an erratum work around, it is a bit of a heavy
operation, as it must go through the "erratum" detection
check on the CPU every time it is called (e.g, scanning
through a table of affected MIDRs). Since we need
to do this check for every session, may be multiple
times (depending on the wrok around), we could save
the cycles by caching the affected errata per-CPU
instance in the per-CPU struct trbe_cpudata.

Since we are only interested in the errata affecting
the TRBE driver, we only need to track a very few of them
per-CPU.  Thus we use a local mapping of the CPUCAP for the
erratum to avoid bloating up a bitmap for trbe_cpudata.

i.e, each arm64 TRBE erratum bit is assigned a "index"
within the driver to track. Each trbe instance updates
the list of affected erratum at probe time on the CPU.
This makes sure that we can easily access the list of
errata on a given TRBE instance without much overhead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v4:
  - Ensure the arm_trbe_probe_cpu() is called from non preemptible
    context for hotplugged CPUs
Changes since v2:
  - Automatically define TRBE_ERRATA_MAX
  - Add some basic sanity check to make sure the new entries
    are added in order.
  - Describe the design choice of caching CPU local errata
    in trbe_cpudata instead of using this_cpu_has_cap()
Changes since v1:
  - Flip the order of args for trbe_has_erratum()
  - Move erratum detection further down in the sequence
---
 drivers/hwtracing/coresight/coresight-trbe.c | 69 +++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index cdbb134892f6..fdd60ff4fb3d 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -16,6 +16,8 @@
 #define pr_fmt(fmt) DRVNAME ": " fmt
 
 #include <asm/barrier.h>
+#include <asm/cpufeature.h>
+
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
@@ -67,6 +69,34 @@ struct trbe_buf {
 	struct trbe_cpudata *cpudata;
 };
 
+/*
+ * TRBE erratum list
+ *
+ * The errata are defined in arm64 generic cpu_errata framework.
+ * Since the errata work arounds could be applied individually
+ * to the affected CPUs inside the TRBE driver, we need to know if
+ * a given CPU is affected by the erratum. Unlike the other erratum
+ * work arounds, TRBE driver needs to check multiple times during
+ * a trace session. Thus we need a quicker access to per-CPU
+ * errata and not issue costly this_cpu_has_cap() everytime.
+ * We keep a set of the affected errata in trbe_cpudata, per TRBE.
+ *
+ * We rely on the corresponding cpucaps to be defined for a given
+ * TRBE erratum. We map the given cpucap into a TRBE internal number
+ * to make the tracking of the errata lean.
+ *
+ * This helps in :
+ *   - Not duplicating the detection logic
+ *   - Streamlined detection of erratum across the system
+ */
+
+static int trbe_errata_cpucaps[] = {
+	-1,		/* Sentinel, must be the last entry */
+};
+
+/* The total number of listed errata in trbe_errata_cpucaps */
+#define TRBE_ERRATA_MAX			(ARRAY_SIZE(trbe_errata_cpucaps) - 1)
+
 /*
  * struct trbe_cpudata: TRBE instance specific data
  * @trbe_flag		- TRBE dirty/access flag support
@@ -75,6 +105,7 @@ struct trbe_buf {
  * @cpu			- CPU this TRBE belongs to.
  * @mode		- Mode of current operation. (perf/disabled)
  * @drvdata		- TRBE specific drvdata
+ * @errata		- Bit map for the errata on this TRBE.
  */
 struct trbe_cpudata {
 	bool trbe_flag;
@@ -84,6 +115,7 @@ struct trbe_cpudata {
 	enum cs_mode mode;
 	struct trbe_buf *buf;
 	struct trbe_drvdata *drvdata;
+	DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
 };
 
 struct trbe_drvdata {
@@ -96,6 +128,25 @@ struct trbe_drvdata {
 	struct platform_device *pdev;
 };
 
+static void trbe_check_errata(struct trbe_cpudata *cpudata)
+{
+	int i;
+
+	for (i = 0; i < TRBE_ERRATA_MAX; i++) {
+		int cap = trbe_errata_cpucaps[i];
+
+		if (WARN_ON_ONCE(cap < 0))
+			return;
+		if (this_cpu_has_cap(cap))
+			set_bit(i, cpudata->errata);
+	}
+}
+
+static inline bool trbe_has_erratum(struct trbe_cpudata *cpudata, int i)
+{
+	return (i < TRBE_ERRATA_MAX) && test_bit(i, cpudata->errata);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -956,6 +1007,9 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	cpumask_clear_cpu(cpu, &drvdata->supported_cpus);
 }
 
+/*
+ * Must be called with preemption disabled, for trbe_check_errata().
+ */
 static void arm_trbe_probe_cpu(void *info)
 {
 	struct trbe_drvdata *drvdata = info;
@@ -983,6 +1037,12 @@ static void arm_trbe_probe_cpu(void *info)
 		goto cpu_clear;
 	}
 
+	/*
+	 * Run the TRBE erratum checks, now that we know
+	 * this instance is about to be registered.
+	 */
+	trbe_check_errata(cpudata);
+
 	cpudata->trbe_align = cpudata->trbe_hw_align;
 	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
 	cpudata->cpu = cpu;
@@ -1038,6 +1098,13 @@ static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
 	return 0;
 }
 
+static void arm_trbe_probe_hotplugged_cpu(struct trbe_drvdata *drvdata)
+{
+	preempt_disable();
+	arm_trbe_probe_cpu(drvdata);
+	preempt_enable();
+}
+
 static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
 {
 	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
@@ -1049,7 +1116,7 @@ static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
 		 * initialize it now.
 		 */
 		if (!coresight_get_percpu_sink(cpu)) {
-			arm_trbe_probe_cpu(drvdata);
+			arm_trbe_probe_hotplugged_cpu(drvdata);
 			if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
 				arm_trbe_register_coresight_cpu(drvdata, cpu);
 			if (cpumask_test_cpu(cpu, &drvdata->supported_cpus))
-- 
2.25.4

