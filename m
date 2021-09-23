Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C325441613B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbhIWOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241752AbhIWOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E94C812FC;
        Thu, 23 Sep 2021 07:39:34 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B40773F718;
        Thu, 23 Sep 2021 07:39:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH v4 3/5] coresight: trbe: Do not truncate buffer on IRQ
Date:   Thu, 23 Sep 2021 15:39:17 +0100
Message-Id: <20210923143919.2944311-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210923143919.2944311-1-suzuki.poulose@arm.com>
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRBE driver marks the AUX buffer as TRUNCATED when we get an IRQ
on FILL event. This has rather unwanted side-effect of the event
being disabled when there may be more space in the ring buffer.

So, instead of TRUNCATE we need a different flag to indicate
that the trace may have lost a few bytes (i.e from the point of
generating the FILL event until the IRQ is consumed). Anyways, the
userspace must use the size from RECORD_AUX headers to restrict
the "trace" decoding.

Using PARTIAL flag causes the perf tool to generate the
following warning:

  Warning:
  AUX data had gaps in it XX times out of YY!

  Are you running a KVM guest in the background?

which is pointlessly scary for a user. The other remaining options
are :
  - COLLISION - Use by SPE to indicate samples collided
  - Add a new flag - Specifically for CoreSight, doesn't sound
    so good, if we can re-use something.

Given that we don't already use the "COLLISION" flag, the above
behavior can be notified using this flag for CoreSight.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3:
 - Moved setting the COLLISION flag to a helper and added
   comments to explain.
---
 drivers/hwtracing/coresight/coresight-trbe.c | 27 +++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 47120d263639..0a9106c15639 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -120,6 +120,25 @@ static void trbe_reset_local(void)
 	write_sysreg_s(0, SYS_TRBSR_EL1);
 }
 
+static void trbe_report_wrap_event(struct perf_output_handle *handle)
+{
+	/*
+	 * Mark the buffer to indicate that there was a WRAP event by
+	 * setting the COLLISION flag. This indicates to the user that
+	 * the TRBE trace collection was stopped without stopping the
+	 * ETE and thus there might be some amount of trace that was
+	 * lost between the time the WRAP was detected and the IRQ
+	 * was consumed by the CPU.
+	 *
+	 * Setting the TRUNCATED flag would move the event to STOPPED
+	 * state unnecessarily, even when there is space left in the
+	 * ring buffer. Using the COLLISION flag doesn't have this side
+	 * effect. We only set TRUNCATED flag when there is no space
+	 * left in the ring buffer.
+	 */
+	perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
+}
+
 static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
 {
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
@@ -612,7 +631,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 		 * for correct size. Also, mark the buffer truncated.
 		 */
 		write = get_trbe_limit_pointer();
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		trbe_report_wrap_event(handle);
 	}
 
 	offset = write - base;
@@ -708,11 +727,7 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 	if (buf->snapshot)
 		handle->head += size;
 
-	/*
-	 * Mark the buffer as truncated, as we have stopped the trace
-	 * collection upon the WRAP event, without stopping the source.
-	 */
-	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	trbe_report_wrap_event(handle);
 	perf_aux_output_end(handle, size);
 	event_data = perf_aux_output_begin(handle, event);
 	if (!event_data) {
-- 
2.24.1

