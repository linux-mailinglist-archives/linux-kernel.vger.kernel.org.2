Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B303D8FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhG1Nxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:53:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236968AbhG1Nwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802B4106F;
        Wed, 28 Jul 2021 06:52:48 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE8E83F70D;
        Wed, 28 Jul 2021 06:52:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 01/10] coresight: trbe: Add infrastructure for Errata handling
Date:   Wed, 28 Jul 2021 14:52:08 +0100
Message-Id: <20210728135217.591173-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210728135217.591173-1-suzuki.poulose@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a minimal infrastructure to keep track of the errata
affecting the given TRBE instance. Given that we have
heterogeneous CPUs, we have to manage the list per-TRBE
instance to be able to apply the work around as needed.

We rely on the arm64 errata framework for the actual
description and the discovery of a given erratum, to
keep the Erratum work around at a central place and
benefit from the code and the advertisement from the
kernel. We use a local mapping of the erratum to
avoid bloating up the individual TRBE structures.
i.e, each arm64 TRBE erratum bit is assigned a new number
within the driver to track. Each trbe instance updates
the list of affected erratum at probe time on the CPU.
This makes sure that we can easily access the list of
errata on a given TRBE instance without much overhead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index b8586c170889..0368bf405e35 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -16,6 +16,8 @@
 #define pr_fmt(fmt) DRVNAME ": " fmt
 
 #include <asm/barrier.h>
+#include <asm/cputype.h>
+
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
@@ -65,6 +67,35 @@ struct trbe_buf {
 	struct trbe_cpudata *cpudata;
 };
 
+/*
+ * TRBE erratum list
+ *
+ * We rely on the corresponding cpucaps to be defined for a given
+ * TRBE erratum. We map the given cpucap into a TRBE internal number
+ * to make the tracking of the errata lean.
+ *
+ * This helps in :
+ *   - Not duplicating the detection logic
+ *   - Streamlined detection of erratum across the system
+ *
+ * Since the erratum work arounds could be applied individually
+ * per TRBE instance, we keep track of the list of errata that
+ * affects the given instance of the TRBE.
+ */
+#define TRBE_ERRATA_MAX			0
+
+static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
+};
+
+/*
+ * struct trbe_cpudata: TRBE instance specific data
+ * @trbe_flag		- TRBE dirty/access flag support
+ * @tbre_align		- Actual TRBE alignment required for TRBPTR_EL1.
+ * @cpu			- CPU this TRBE belongs to.
+ * @mode		- Mode of current operation. (perf/disabled)
+ * @drvdata		- TRBE specific drvdata
+ * @errata		- Bit map for the errata on this TRBE.
+ */
 struct trbe_cpudata {
 	bool trbe_flag;
 	u64 trbe_align;
@@ -72,6 +103,7 @@ struct trbe_cpudata {
 	enum cs_mode mode;
 	struct trbe_buf *buf;
 	struct trbe_drvdata *drvdata;
+	DECLARE_BITMAP(errata, TRBE_ERRATA_MAX);
 };
 
 struct trbe_drvdata {
@@ -84,6 +116,21 @@ struct trbe_drvdata {
 	struct platform_device *pdev;
 };
 
+static void trbe_check_errata(struct trbe_cpudata *cpudata)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(trbe_errata_cpucaps); i++) {
+		if (this_cpu_has_cap(trbe_errata_cpucaps[i]))
+			set_bit(i, cpudata->errata);
+	}
+}
+
+static inline bool trbe_has_erratum(int i, struct trbe_cpudata *cpudata)
+{
+	return (i < TRBE_ERRATA_MAX) && test_bit(i, cpudata->errata);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -925,6 +972,7 @@ static void arm_trbe_probe_cpu(void *info)
 		goto cpu_clear;
 	}
 
+	trbe_check_errata(cpudata);
 	cpudata->trbe_align = 1ULL << get_trbe_address_align(trbidr);
 	if (cpudata->trbe_align > SZ_2K) {
 		pr_err("Unsupported alignment on cpu %d\n", cpu);
-- 
2.24.1

