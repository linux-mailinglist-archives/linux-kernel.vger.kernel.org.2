Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7F3C5B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhGLLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:41:47 -0400
Received: from foss.arm.com ([217.140.110.172]:54034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234586AbhGLLll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:41:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C792106F;
        Mon, 12 Jul 2021 04:38:53 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F36413F694;
        Mon, 12 Jul 2021 04:38:51 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, suzuki.poulose@arm.com,
        Tamas.Zsoldos@arm.com, will@kernel.org
Subject: [PATCH 5/5] coresight: trbe: Prohibit tracing while handling an IRQ
Date:   Mon, 12 Jul 2021 12:38:30 +0100
Message-Id: <20210712113830.2803257-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210712113830.2803257-1-suzuki.poulose@arm.com>
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the TRBE generates an IRQ, we stop the TRBE, collect the trace
and then reprogram the TRBE with the updated buffer pointers in case
of a spurious IRQ. We might also leave the TRBE disabled, on an
overflow interrupt, without touching the ETE. This means the
the ETE is only disabled when the event is disabled later (via irq_work).
This is incorrect, as the ETE trace is still ON without actually being
captured and may be routed to the ATB.

So, we move the CPU into trace prohibited state (for all exception
levels) upon entering the IRQ handler. The state is restored before
enabling the TRBE back. Otherwise the trace remains prohibited.
Since, the ETM/ETE driver controls the TRFCR_EL1 per session,
(from commit "coresight: etm4x: Use Trace Filtering controls dynamically")
the tracing can be restored/enabled back when the event is rescheduled
in.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 43 ++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index c0c264264427..e4d88e0de2a8 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -83,6 +83,31 @@ struct trbe_drvdata {
 	struct platform_device *pdev;
 };
 
+static inline void write_trfcr(u64 val)
+{
+	write_sysreg_s(val, SYS_TRFCR_EL1);
+	isb();
+}
+
+/*
+ * Prohibit the CPU tracing at all ELs, in preparation to collect
+ * the trace buffer.
+ *
+ * Returns the original value of the trfcr for restoring later.
+ */
+static u64 cpu_prohibit_tracing(void)
+{
+	u64 trfcr = read_sysreg_s(SYS_TRFCR_EL1);
+
+	write_trfcr(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE));
+	return trfcr;
+}
+
+static void cpu_restore_tracing(u64 trfcr)
+{
+	write_trfcr(trfcr);
+}
+
 static int trbe_alloc_node(struct perf_event *event)
 {
 	if (event->cpu == -1)
@@ -681,7 +706,7 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 	return 0;
 }
 
-static void trbe_handle_spurious(struct perf_output_handle *handle)
+static void trbe_handle_spurious(struct perf_output_handle *handle, u64 trfcr)
 {
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
 
@@ -691,6 +716,7 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
 		trbe_drain_and_disable_local();
 		return;
 	}
+	cpu_restore_tracing(trfcr);
 	trbe_enable_hw(buf);
 }
 
@@ -760,7 +786,18 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	struct perf_output_handle **handle_ptr = dev;
 	struct perf_output_handle *handle = *handle_ptr;
 	enum trbe_fault_action act;
-	u64 status;
+	u64 status, trfcr;
+
+	/*
+	 * Prohibit the tracing, while we process this. We turn
+	 * things back right, if we get to enabling the TRBE
+	 * back again. Otherwise, the tracing still remains
+	 * prohibited, until the perf event state changes
+	 * or another event is scheduled. This ensures that
+	 * the trace is not generated when it cannot be
+	 * captured.
+	 */
+	trfcr = cpu_prohibit_tracing();
 
 	/*
 	 * Ensure the trace is visible to the CPUs and
@@ -791,7 +828,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 		trbe_handle_overflow(handle);
 		break;
 	case TRBE_FAULT_ACT_SPURIOUS:
-		trbe_handle_spurious(handle);
+		trbe_handle_spurious(handle, trfcr);
 		break;
 	case TRBE_FAULT_ACT_FATAL:
 		trbe_stop_and_truncate_event(handle);
-- 
2.24.1

