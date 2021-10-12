Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0042A54F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhJLNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:20:22 -0400
Received: from foss.arm.com ([217.140.110.172]:41704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236720AbhJLNUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1E841063;
        Tue, 12 Oct 2021 06:18:15 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E74F3F70D;
        Tue, 12 Oct 2021 06:18:14 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 05/15] coresight: trbe: Add a helper to calculate the trace generated
Date:   Tue, 12 Oct 2021 14:17:33 +0100
Message-Id: <20211012131743.2040596-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We collect the trace from the TRBE on FILL event from IRQ context
and via update_buffer(), when the event is stopped. Let us
consolidate how we calculate the trace generated into a helper.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
  - Fix code style issues
  - Read base pointer directly now. Switch to using cached value
    of the base of the ring buffer, when this changes.
---
 drivers/hwtracing/coresight/coresight-trbe.c | 47 ++++++++++++--------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2825ccb0cf39..5902ef41bfb8 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -499,6 +499,29 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
 	return TRBE_FAULT_ACT_SPURIOUS;
 }
 
+static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
+					 struct trbe_buf *buf, bool wrap)
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
+	end_off = write - get_trbe_base_pointer();
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
@@ -560,9 +583,9 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
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
@@ -602,8 +625,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	 * handle gets freed in etm_event_stop().
 	 */
 	trbe_drain_and_disable_local();
-	write = get_trbe_write_pointer();
-	base = get_trbe_base_pointer();
 
 	/* Check if there is a pending interrupt and handle it here */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -627,20 +648,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 			goto done;
 		}
 
-		/*
-		 * Otherwise, the buffer is full and the write pointer
-		 * has reached base. Adjust this back to the Limit pointer
-		 * for correct size. Also, mark the buffer truncated.
-		 */
-		write = get_trbe_limit_pointer();
 		trbe_report_wrap_event(handle);
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
@@ -721,11 +733,10 @@ static int trbe_handle_overflow(struct perf_output_handle *handle)
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
2.25.4

