Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738B941613D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbhIWOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:19 -0400
Received: from foss.arm.com ([217.140.110.172]:35340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241759AbhIWOlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77719D6E;
        Thu, 23 Sep 2021 07:39:36 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27B303F718;
        Thu, 23 Sep 2021 07:39:35 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 4/5] coresight: trbe: End the AUX handle on truncation
Date:   Thu, 23 Sep 2021 15:39:18 +0100
Message-Id: <20210923143919.2944311-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210923143919.2944311-1-suzuki.poulose@arm.com>
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we detect that there isn't enough space left to start a meaningful
session, we disable the TRBE, marking the buffer as TRUNCATED. But we delay
the notification to the perf layer by perf_aux_output_end() until the event
is scheduled out, triggered from the kernel perf layer. This will cause
significant black outs in the trace. Now that the CoreSight PMU layer can
handle a closed "AUX" handle properly, we can close the handle as soon as
we detect the case, allowing the userspace to collect and re-enable the
event.

Also, while in the IRQ handler, move the irq_work_run() after we have
updated the handle, to make sure the "TRUNCATED" flag causes the event to
be disabled as soon as possible.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 26 ++++++++++++--------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 0a9106c15639..4174300f1344 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -152,6 +152,7 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
 	 */
 	trbe_drain_and_disable_local();
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	perf_aux_output_end(handle, 0);
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
 }
 
@@ -715,7 +716,7 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
 	isb();
 }
 
-static void trbe_handle_overflow(struct perf_output_handle *handle)
+static int trbe_handle_overflow(struct perf_output_handle *handle)
 {
 	struct perf_event *event = handle->event;
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
@@ -739,9 +740,10 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 		 */
 		trbe_drain_and_disable_local();
 		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
-		return;
+		return -EINVAL;
 	}
-	__arm_trbe_enable(buf, handle);
+
+	return __arm_trbe_enable(buf, handle);
 }
 
 static bool is_perf_trbe(struct perf_output_handle *handle)
@@ -772,6 +774,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	struct perf_output_handle *handle = *handle_ptr;
 	enum trbe_fault_action act;
 	u64 status;
+	bool truncated = false;
 
 	/* Reads to TRBSR_EL1 is fine when TRBE is active */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -796,24 +799,27 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	if (!is_perf_trbe(handle))
 		return IRQ_NONE;
 
-	/*
-	 * Ensure perf callbacks have completed, which may disable
-	 * the trace buffer in response to a TRUNCATION flag.
-	 */
-	irq_work_run();
-
 	act = trbe_get_fault_act(status);
 	switch (act) {
 	case TRBE_FAULT_ACT_WRAP:
-		trbe_handle_overflow(handle);
+		truncated = !!trbe_handle_overflow(handle);
 		break;
 	case TRBE_FAULT_ACT_SPURIOUS:
 		trbe_handle_spurious(handle);
 		break;
 	case TRBE_FAULT_ACT_FATAL:
 		trbe_stop_and_truncate_event(handle);
+		truncated = true;
 		break;
 	}
+
+	/*
+	 * If the buffer was truncated, ensure perf callbacks
+	 * have completed, which will disable the event.
+	 */
+	if (truncated)
+		irq_work_run();
+
 	return IRQ_HANDLED;
 }
 
-- 
2.24.1

