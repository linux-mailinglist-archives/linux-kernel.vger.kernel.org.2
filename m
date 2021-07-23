Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D83D3A74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhGWMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:45544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235017AbhGWMGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:06:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB051063;
        Fri, 23 Jul 2021 05:46:35 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFF213F694;
        Fri, 23 Jul 2021 05:46:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 09/10] coresight: trbe: End the AUX handle on truncation
Date:   Fri, 23 Jul 2021 13:46:10 +0100
Message-Id: <20210723124611.3828908-10-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we detect that there isn't enough space left to start
a meaningful session, we disable the TRBE, marking the buffer
as TRUNCATED. But we delay the notification to the perf layer
by perf_aux_output_end() until the event is scheduled out.
This will cause significant black outs in the trace. Now that
the CoreSight PMU layer can handle a closed "AUX" handle
properly, we can close the handle as soon as we detect the
case, allowing the userspace to collect and re-enable the
event.

Also, while in the IRQ handler, move the irq_work_run() after
we have updated the handle, to make sure the "TRUNCATED" flag
causes the event to be disabled as soon as possible.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 25 ++++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 6d6aad171c72..e7567727e8fc 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -134,6 +134,7 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
 	trbe_drain_and_disable_local();
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED |
 				     PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
+	perf_aux_output_end(handle, 0);
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
 }
 
@@ -699,7 +700,7 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
 	isb();
 }
 
-static void trbe_handle_overflow(struct perf_output_handle *handle)
+static int trbe_handle_overflow(struct perf_output_handle *handle)
 {
 	struct perf_event *event = handle->event;
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
@@ -728,10 +729,10 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 		 */
 		trbe_drain_and_disable_local();
 		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
-		return;
+		return -EINVAL;
 	}
 
-	__arm_trbe_enable(buf, handle);
+	return __arm_trbe_enable(buf, handle);
 }
 
 static bool is_perf_trbe(struct perf_output_handle *handle)
@@ -762,6 +763,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	struct perf_output_handle *handle = *handle_ptr;
 	enum trbe_fault_action act;
 	u64 status;
+	bool truncated = false;
 
 	/* Reads to TRBSR_EL1 is fine when TRBE is active */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -786,24 +788,27 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
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

