Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556933D8FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhG1NyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:54:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237509AbhG1NxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:53:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E531042;
        Wed, 28 Jul 2021 06:53:01 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB0F73F70D;
        Wed, 28 Jul 2021 06:52:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 08/10] coresight: trbe: Workaround TRBE errat overwrite in FILL mode
Date:   Wed, 28 Jul 2021 14:52:15 +0100
Message-Id: <20210728135217.591173-9-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210728135217.591173-1-suzuki.poulose@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
an erratum, which when triggered, might cause the TRBE to overwrite
the trace data already collected in FILL mode, in the event of a WRAP.
i.e, the TRBE doesn't stop writing the data, instead wraps to the base
and could write upto 3 cache line size worth trace. Thus, this could
corrupt the trace at the "BASE" pointer.

The workaround is to program the write pointer 256bytes from the
base, such that if the erratum is triggered, it doesn't overwrite
the trace data that was captured. This skipped region could be
padded with ignore packets at the end of the session, so that
the decoder sees a continuous buffer with some padding at the
beginning. The trace data written at the base is considered
lost as the limit could have been in the middle of the perf
ring buffer, and jumping to the "base" is not acceptable.
We set the flags already to indicate that some amount of trace
was lost during the FILL event IRQ. So this is fine.

One important change with the work around is, we program the
TRBBASER_EL1 to current page where we are allowed to write.
Otherwise, it could overwrite a region that may be consumed
by the perf. Towards this, we always make sure that the
"handle->head" and thus the trbe_write is PAGE_SIZE aligned,
so that we can set the BASE to the PAGE base and move the
TRBPTR to the 256bytes offset.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 111 +++++++++++++++++--
 1 file changed, 102 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 9ea28813182b..cd997ed5d918 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -17,6 +17,7 @@
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
+#include <asm/cpufeature.h>
 
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
@@ -84,9 +85,17 @@ struct trbe_buf {
  * per TRBE instance, we keep track of the list of errata that
  * affects the given instance of the TRBE.
  */
-#define TRBE_ERRATA_MAX			0
+#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
+#define TRBE_ERRATA_MAX				1
+
+/*
+ * Safe limit for the number of bytes that may be overwritten
+ * when the erratum is triggered.
+ */
+#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP	256
 
 static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
+	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
 };
 
 /*
@@ -531,10 +540,13 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
 	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
 		return TRBE_FAULT_ACT_FATAL;
 
-	if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
-		if (get_trbe_write_pointer() == get_trbe_base_pointer())
-			return TRBE_FAULT_ACT_WRAP;
-	}
+	/*
+	 * It is not necessary to verify the TRBPTR == TRBBASER to detect
+	 * a FILL event. Moreover, CPU errata could make this check invalid.
+	 */
+	if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED))
+		return TRBE_FAULT_ACT_WRAP;
+
 	return TRBE_FAULT_ACT_SPURIOUS;
 }
 
@@ -544,6 +556,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 {
 	u64 write;
 	u64 start_off, end_off;
+	u64 size;
 
 	/*
 	 * If the TRBE has wrapped around the write pointer has
@@ -559,7 +572,18 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 
 	if (WARN_ON_ONCE(end_off < start_off))
 		return 0;
-	return (end_off - start_off);
+
+	size = end_off - start_off;
+	/*
+	 * If the TRBE is affected by the following erratum, we must fill
+	 * the space we skipped with IGNORE packets. And we are always
+	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
+	 */
+	if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE, buf->cpudata) &&
+	    !WARN_ON(size < TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP))
+		__trbe_pad_buf(buf, start_off, TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP);
+
+	return size;
 }
 
 static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
@@ -704,20 +728,73 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	return size;
 }
 
+
+static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
+{
+	/*
+	 * TRBE_WORKAROUND_OVERWRITE_FILL_MODE causes the TRBE to overwrite a few cache
+	 * line size from the "TRBBASER_EL1" in the event of a "FILL".
+	 * Thus, we could loose some amount of the trace at the base.
+	 *
+	 * To work around this:
+	 * - Software must leave 256bytes of space from the base, so that
+	 *   the trace collected now is not overwritten.
+	 * - Fill the first 256bytes with IGNORE packets for the decoder
+	 *   to ignore at the end of the session, so that the decoder ignores
+	 *   this gap.
+	 *
+	 * This also means that, the TRBE driver must set the TRBBASER_EL1
+	 * such that, when the erratum is triggered, it doesn't overwrite
+	 * the "area" outside the area marked by (handle->head, +size).
+	 * So, we make sure that the handle->head is always PAGE aligned,
+	 * by tweaking the required alignment for the TRBE (trbe_align).
+	 * And when we enable the TRBE,
+	 *
+	 *   - move the TRBPTR_EL1 to 256bytes past the starting point.
+	 *     So that any trace collected in this run is not overwritten.
+	 *
+	 *   - set the TRBBASER_EL1 to the original trbe_write. This will
+	 *     ensure that, if the TRBE hits the erratum, it would only
+	 *     write within the region allowed for the TRBE.
+	 *
+	 * At the trace collection time, we always pad the skipped bytes
+	 * with IGNORE packets to make sure the decoder doesn't see any
+	 * overwritten packets.
+	 */
+	if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE, buf->cpudata)) {
+		if (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE)))
+			return -EINVAL;
+		buf->trbe_hw_base = buf->trbe_write;
+		buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP;
+	}
+
+	return 0;
+}
+
 static int __arm_trbe_enable(struct trbe_buf *buf,
 			     struct perf_output_handle *handle)
 {
+	int ret = 0;
+
 	buf->trbe_limit = compute_trbe_buffer_limit(handle);
 	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
 	if (buf->trbe_limit == buf->trbe_base) {
-		trbe_stop_and_truncate_event(handle);
-		return -ENOSPC;
+		ret = -ENOSPC;
+		goto err;
 	}
 	/* Set the base of the TRBE to the buffer base */
 	buf->trbe_hw_base = buf->trbe_base;
+
+	ret = trbe_apply_work_around_before_enable(buf);
+	if (ret)
+		goto err;
+
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
 	trbe_enable_hw(buf);
 	return 0;
+err:
+	trbe_stop_and_truncate_event(handle);
+	return ret;
 }
 
 static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
@@ -1003,7 +1080,23 @@ static void arm_trbe_probe_cpu(void *info)
 		pr_err("Unsupported alignment on cpu %d\n", cpu);
 		goto cpu_clear;
 	}
-	cpudata->trbe_align = cpudata->trbe_hw_align;
+
+	/*
+	 * If the TRBE is affected by erratum TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
+	 * we must always program the TBRPTR_EL1, 256bytes from a page
+	 * boundary, with TRBBASER_EL1 set to the page, to prevent
+	 * TRBE over-writing 256bytes at TRBBASER_EL1 on FILL event.
+	 *
+	 * Thus make sure we always align our write pointer to a PAGE_SIZE,
+	 * which also guarantees that we have at least a PAGE_SIZE space in
+	 * the buffer (TRBLIMITR is PAGE aligned) and thus we can skip
+	 * the required bytes at the base.
+	 */
+	if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE, cpudata))
+		cpudata->trbe_align = PAGE_SIZE;
+	else
+		cpudata->trbe_align = cpudata->trbe_hw_align;
+
 	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
 	cpudata->cpu = cpu;
 	cpudata->drvdata = drvdata;
-- 
2.24.1

