Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA541348F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbhIUNnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhIUNnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F57211B3;
        Tue, 21 Sep 2021 06:41:36 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47FEE3F793;
        Tue, 21 Sep 2021 06:41:34 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 03/17] coresight: trbe: Add a helper to calculate the trace generated
Date:   Tue, 21 Sep 2021 14:41:07 +0100
Message-Id: <20210921134121.2423546-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We collect the trace from the TRBE on FILL event from IRQ context
and when via update_buffer(), when the event is stopped. Let us
consolidate how we calculate the trace generated into a helper.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 48 ++++++++++++--------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 63f7edd5fd1f..063c4505a203 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -527,6 +527,30 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
 	return TRBE_FAULT_ACT_SPURIOUS;
 }
 
+static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
+					 struct trbe_buf *buf,
+					 bool wrap)
+{
+	u64 write;
+	u64 start_off, end_off;
+
+	/*
+	 * If the TRBE has wrapped around the write pointer has
+	 * wrapped and should be treated as limit.
+	 */
+	if (wrap)
+		write = get_trbe_limit_pointer();
+	else
+		write = get_trbe_write_pointer();
+
+	end_off = write - buf->trbe_base;
+	start_off = PERF_IDX2OFF(handle->head, buf);
+
+	if (WARN_ON_ONCE(end_off < start_off))
+		return 0;
+	return (end_off - start_off);
+}
+
 static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 				   struct perf_event *event, void **pages,
 				   int nr_pages, bool snapshot)
@@ -588,9 +612,9 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
 	struct trbe_buf *buf = config;
 	enum trbe_fault_action act;
-	unsigned long size, offset;
-	unsigned long write, base, status;
+	unsigned long size, status;
 	unsigned long flags;
+	bool wrap = false;
 
 	WARN_ON(buf->cpudata != cpudata);
 	WARN_ON(cpudata->cpu != smp_processor_id());
@@ -630,8 +654,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	 * handle gets freed in etm_event_stop().
 	 */
 	trbe_drain_and_disable_local();
-	write = get_trbe_write_pointer();
-	base = get_trbe_base_pointer();
 
 	/* Check if there is a pending interrupt and handle it here */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -655,20 +677,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 			goto done;
 		}
 
-		/*
-		 * Otherwise, the buffer is full and the write pointer
-		 * has reached base. Adjust this back to the Limit pointer
-		 * for correct size. Also, mark the buffer truncated.
-		 */
-		write = get_trbe_limit_pointer();
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
+		wrap = true;
 	}
 
-	offset = write - base;
-	if (WARN_ON_ONCE(offset < PERF_IDX2OFF(handle->head, buf)))
-		size = 0;
-	else
-		size = offset - PERF_IDX2OFF(handle->head, buf);
+	size = trbe_get_trace_size(handle, buf, wrap);
 
 done:
 	local_irq_restore(flags);
@@ -749,11 +762,10 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
 {
 	struct perf_event *event = handle->event;
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
-	unsigned long offset, size;
+	unsigned long size;
 	struct etm_event_data *event_data;
 
-	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
-	size = offset - PERF_IDX2OFF(handle->head, buf);
+	size = trbe_get_trace_size(handle, buf, true);
 	if (buf->snapshot)
 		handle->head += size;
 
-- 
2.24.1

