Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECE41349E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhIUNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:47 -0400
Received: from foss.arm.com ([217.140.110.172]:33946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhIUNna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB0B6D;
        Tue, 21 Sep 2021 06:42:01 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E934A3F40C;
        Tue, 21 Sep 2021 06:41:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 16/17] coresight: trbe: Work around write to out of range
Date:   Tue, 21 Sep 2021 14:41:20 +0100
Message-Id: <20210921134121.2423546-17-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
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
    TRBE_WORKAROUND_OVERWRITE_IN_FILL_MODE, where there is a minimum of PAGE_SIZE.
    Thus we would have 2 * PAGE_SIZE)

  - Adjust the LIMIT to leave the last PAGE_SIZE out of the TRBE's allowed
    range (i.e, TRBEBASER...TRBLIMITR.LIMIT), by :

        TRBLIMITR.LIMIT -= PAGE_SIZE

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 59 +++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 02f9e00e2091..ea907345354c 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -86,7 +86,8 @@ struct trbe_buf {
  * affects the given instance of the TRBE.
  */
 #define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
-#define TRBE_ERRATA_MAX				1
+#define TRBE_WORKAROUND_WRITE_OUT_OF_RANGE	1
+#define TRBE_ERRATA_MAX				2
 
 /*
  * Safe limit for the number of bytes that may be overwritten
@@ -96,6 +97,7 @@ struct trbe_buf {
 
 static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
 	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+	[TRBE_WORKAROUND_WRITE_OUT_OF_RANGE] = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
 };
 
 /*
@@ -279,7 +281,20 @@ trbe_handle_to_cpudata(struct perf_output_handle *handle)
 
 static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
 {
-	return TRBE_TRACE_MIN_BUF_SIZE;
+	u64 size = TRBE_TRACE_MIN_BUF_SIZE;
+	struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);
+
+	/*
+	 * When the TRBE is affected by an erratum that could make it
+	 * write to the next "virtually addressed" page beyond the LIMIT.
+	 * We need to make sure there is always a PAGE after the LIMIT,
+	 * within the buffer. Thus we ensure there is at least an extra
+	 * page than normal. With this we could then adjust the LIMIT
+	 * pointer down by a PAGE later.
+	 */
+	if (trbe_has_erratum(cpudata, TRBE_WORKAROUND_WRITE_OUT_OF_RANGE))
+		size += PAGE_SIZE;
+	return size;
 }
 
 /*
@@ -585,6 +600,17 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
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
@@ -811,6 +837,35 @@ static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
 		buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
 	}
 
+	/*
+	 * TRBE_WORKAROUND_WRITE_OUT_OF_RANGE could cause the TRBE to write to
+	 * the next page after the TRBLIMITR.LIMIT. For perf, the "next page"
+	 * may be:
+	 * 	- The page beyond the ring buffer. This could mean, TRBE could
+	 * 	  corrupt another entity (kernel / user)
+	 * 	- A portion of the "ring buffer" consumed by the userspace.
+	 * 	  i.e, a page outisde [head, head + size].
+	 *
+	 * We work around this by:
+	 * 	- Making sure that we have at least an extra space of PAGE left
+	 * 	in the ring buffer [head, head + size], than we normally do
+	 * 	without the erratum. See trbe_min_trace_buf_size().
+	 *
+	 * 	- Adjust the TRBLIMITR.LIMIT to leave the extra PAGE outside
+	 * 	the TRBE's range (i.e [TRBBASER, TRBLIMITR.LIMI] ).
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
2.24.1

