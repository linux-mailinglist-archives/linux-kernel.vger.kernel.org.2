Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB23C5B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhGLLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:41:41 -0400
Received: from foss.arm.com ([217.140.110.172]:54004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234504AbhGLLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:41:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 082726D;
        Mon, 12 Jul 2021 04:38:50 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 764D13F694;
        Mon, 12 Jul 2021 04:38:48 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, suzuki.poulose@arm.com,
        Tamas.Zsoldos@arm.com, will@kernel.org
Subject: [PATCH 3/5] coresight: trbe: Keep TRBE disabled on overflow irq
Date:   Mon, 12 Jul 2021 12:38:28 +0100
Message-Id: <20210712113830.2803257-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210712113830.2803257-1-suzuki.poulose@arm.com>
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an AUX buffer is marked TRUNCATED, the kernel will disable
the event (via irq_work) and can only be re-enabled by the
userspace tool.

Also, since we *always* mark the buffer as TRUNCATED (which is
needs to be reconsidered, see below), we need not re-enable the
TRBE as the event is going to be now disabled. This follows the
SPE driver behavior.

Without this change, we could leave the event disabled for
ever under certain conditions. i.e, when we try to re-enable
in the IRQ handler, if there is no space left in the buffer,
we "TRUNCATE" the buffer and create a record of size 0.
The perf tool skips such records and the event will remain
disabled forever.

Regarding the use of TRUNCATED flag:
With FILL mode, the TRBE stops collection when the buffer is
full, raising the IRQ. Now, since the IRQ is asynchronous,
we could loose some amount of trace, after the buffer was
full until the IRQ is handled. Also the last packet may
have been trimmed. The decoder can figure this out and
cope with this. The side effect of this approach is:

 We always disable the event when there is an IRQ, even
 when the other half of the ring buffer is free ! This
 is not ideal.

Now, we should switch to using PARTIAL to indicate that there
was potentially some partial trace packets in the buffer and
some data was lost. We should use TRUNCATED only when there
is absolutely no space in the ring buffer. This change would
also require some additional changes in the CoreSight PMU
framework to allow, sinks to "close" the handle (rather
than the PMU driver closing the handle upon event_stop).
So, until that is sorted, let us keep the TRUNCATED flag
and the rework can be addressed separately.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Reported-by: Tamas Zsoldos <Tamas.Zsoldos@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 34 +++++++-------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 176868496879..ec38cf17b693 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -696,10 +696,8 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
 
 static void trbe_handle_overflow(struct perf_output_handle *handle)
 {
-	struct perf_event *event = handle->event;
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
 	unsigned long offset, size;
-	struct etm_event_data *event_data;
 
 	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
 	size = offset - PERF_IDX2OFF(handle->head, buf);
@@ -709,30 +707,22 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 	/*
 	 * Mark the buffer as truncated, as we have stopped the trace
 	 * collection upon the WRAP event, without stopping the source.
+	 *
+	 * We don't re-enable the TRBE here, as the event is
+	 * bound to be disabled due to the TRUNCATED flag.
+	 * This is not ideal, as we could use the available space in
+	 * the ring buffer and continue the tracing.
+	 *
+	 * TODO: Revisit the use of TRUNCATED flag and may be instead use
+	 * PARTIAL, to indicate trace may contain partial packets.
+	 * And TRUNCATED can be used only if we do not have enough space
+	 * in the buffer. This would need additional changes in
+	 * etm_event_stop() to allow the sinks to leave a closed
+	 * aux_handle.
 	 */
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
 				     PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, size);
-	event_data = perf_aux_output_begin(handle, event);
-	if (!event_data) {
-		/*
-		 * We are unable to restart the trace collection,
-		 * thus leave the TRBE disabled. The etm-perf driver
-		 * is able to detect this with a disconnected handle
-		 * (handle->event = NULL).
-		 */
-		trbe_drain_and_disable_local();
-		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
-		return;
-	}
-	buf->trbe_limit = compute_trbe_buffer_limit(handle);
-	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
-	if (buf->trbe_limit == buf->trbe_base) {
-		trbe_stop_and_truncate_event(handle);
-		return;
-	}
-	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
-	trbe_enable_hw(buf);
 }
 
 static bool is_perf_trbe(struct perf_output_handle *handle)
-- 
2.24.1

