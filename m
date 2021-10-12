Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027BB42A55B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhJLNVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:21:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbhJLNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C991063;
        Tue, 12 Oct 2021 06:18:29 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD1EE3F70D;
        Tue, 12 Oct 2021 06:18:27 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 13/15] coresight: trbe: Work around write to out of range
Date:   Tue, 12 Oct 2021 14:17:41 +0100
Message-Id: <20211012131743.2040596-14-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRBE implementations affected by Arm erratum (2253138 or 2224489), could
write to the next address after the TRBLIMITR.LIMIT, instead of wrapping
to the TRBBASER. This implies that the TRBE could potentially corrupt :

  - A page used by the rest of the kernel/user (if the LIMIT = end of
    perf ring buffer)
  - A page within the ring buffer, but outside the driver's range.
    [head, head + size]. This may contain some trace data, may be
    consumed by the userspace.

We workaround this erratum by :
  - Making sure that there is at least an extra PAGE space left in the
    TRBE's range than we normally assign. This will be additional to other
    restrictions (e.g, the TRBE alignment for working around
    TRBE_WORKAROUND_OVERWRITE_IN_FILL_MODE, where there is a minimum of
    PAGE_SIZE. Thus we would have 2 * PAGE_SIZE)

  - Adjust the LIMIT to leave the last PAGE_SIZE out of the TRBE's allowed
    range (i.e, TRBEBASER...TRBLIMITR.LIMIT), by :

        TRBLIMITR.LIMIT -= PAGE_SIZE

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 63 +++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 46d23fbfd5f7..5d350acef798 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -90,9 +90,11 @@ struct trbe_buf {
  *   - Streamlined detection of erratum across the system
  */
 #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
+#define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
 
 static int trbe_errata_cpucaps[] = {
 	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
 	-1,		/* Sentinel, must be the last entry */
 };
 
@@ -160,6 +162,11 @@ static inline bool trbe_may_overwrite_in_fill_mode(struct trbe_cpudata *cpudata)
 	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE);
 }
 
+static inline bool trbe_may_write_out_of_range(struct trbe_cpudata *cpudata)
+{
+	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -305,7 +312,21 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
 
 static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
 {
-	return TRBE_TRACE_MIN_BUF_SIZE;
+	u64 size = TRBE_TRACE_MIN_BUF_SIZE;
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	struct trbe_cpudata *cpudata = buf->cpudata;
+
+	/*
+	 * When the TRBE is affected by an erratum that could make it
+	 * write to the next "virtually addressed" page beyond the LIMIT.
+	 * We need to make sure there is always a PAGE after the LIMIT,
+	 * within the buffer. Thus we ensure there is at least an extra
+	 * page than normal. With this we could then adjust the LIMIT
+	 * pointer down by a PAGE later.
+	 */
+	if (trbe_may_write_out_of_range(cpudata))
+		size += PAGE_SIZE;
+	return size;
 }
 
 /*
@@ -611,6 +632,17 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 	/*
 	 * If the TRBE has wrapped around the write pointer has
 	 * wrapped and should be treated as limit.
+	 *
+	 * When the TRBE is affected by TRBE_WORKAROUND_WRITE_OUT_OF_RANGE,
+	 * it may write upto 64bytes beyond the "LIMIT". The driver already
+	 * keeps a valid page next to the LIMIT and we could potentially
+	 * consume the trace data that may have been collected there. But we
+	 * cannot be really sure it is available, and the TRBPTR may not
+	 * indicate the same. Also, affected cores are also affected by another
+	 * erratum which forces the PAGE_SIZE alignment on the TRBPTR, and thus
+	 * could potentially pad an entire PAGE_SIZE - 64bytes, to get those
+	 * 64bytes. Thus we ignore the potential triggering of the erratum
+	 * on WRAP and limit the data to LIMIT.
 	 */
 	if (wrap)
 		write = get_trbe_limit_pointer();
@@ -864,6 +896,35 @@ static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
 		buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
 	}
 
+	/*
+	 * TRBE_WORKAROUND_WRITE_OUT_OF_RANGE could cause the TRBE to write to
+	 * the next page after the TRBLIMITR.LIMIT. For perf, the "next page"
+	 * may be:
+	 *     - The page beyond the ring buffer. This could mean, TRBE could
+	 *       corrupt another entity (kernel / user)
+	 *     - A portion of the "ring buffer" consumed by the userspace.
+	 *       i.e, a page outisde [head, head + size].
+	 *
+	 * We work around this by:
+	 *     - Making sure that we have at least an extra space of PAGE left
+	 *       in the ring buffer [head, head + size], than we normally do
+	 *       without the erratum. See trbe_min_trace_buf_size().
+	 *
+	 *     - Adjust the TRBLIMITR.LIMIT to leave the extra PAGE outside
+	 *       the TRBE's range (i.e [TRBBASER, TRBLIMITR.LIMI] ).
+	 */
+	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE)) {
+		s64 space = buf->trbe_limit - buf->trbe_write;
+		/*
+		 * We must have more than a PAGE_SIZE worth space in the proposed
+		 * range for the TRBE.
+		 */
+		if (WARN_ON(space <= PAGE_SIZE ||
+			    !IS_ALIGNED(buf->trbe_limit, PAGE_SIZE)))
+			return -EINVAL;
+		buf->trbe_limit -= PAGE_SIZE;
+	}
+
 	return 0;
 }
 
-- 
2.25.4

