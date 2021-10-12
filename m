Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462AE42A558
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhJLNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:21:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236799AbhJLNUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C23D13A1;
        Tue, 12 Oct 2021 06:18:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21FC13F7D8;
        Tue, 12 Oct 2021 06:18:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 09/15] coresight: trbe: Add infrastructure for Errata handling
Date:   Tue, 12 Oct 2021 14:17:37 +0100
Message-Id: <20211012131743.2040596-10-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
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
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
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
 drivers/hwtracing/coresight/coresight-trbe.c | 58 +++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index f8c04c428780..443194114eb3 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) DRVNAME ": " fmt
 
 #include <asm/barrier.h>
+
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
@@ -67,14 +68,43 @@ struct trbe_buf {
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
  * @trbe_hw_align	- Actual TRBE alignment required for TRBPTR_EL1.
- * @trbe_align		- Software alignment used for the TRBPTR_EL1,
+ * @trbe_align		- Software alignment used for the TRBPTR_EL1
  * @cpu			- CPU this TRBE belongs to.
  * @mode		- Mode of current operation. (perf/disabled)
  * @drvdata		- TRBE specific drvdata
+ * @errata		- Bit map for the errata on this TRBE.
  */
 struct trbe_cpudata {
 	bool trbe_flag;
@@ -84,6 +114,7 @@ struct trbe_cpudata {
 	enum cs_mode mode;
 	struct trbe_buf *buf;
 	struct trbe_drvdata *drvdata;
+	DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
 };
 
 struct trbe_drvdata {
@@ -96,6 +127,25 @@ struct trbe_drvdata {
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
@@ -979,6 +1029,12 @@ static void arm_trbe_probe_cpu(void *info)
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
-- 
2.25.4

