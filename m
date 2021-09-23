Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625A641613F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbhIWOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241753AbhIWOlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3EBE11FB;
        Thu, 23 Sep 2021 07:39:37 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9DFC3F718;
        Thu, 23 Sep 2021 07:39:36 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 5/5] coresight: trbe: Prohibit trace before disabling TRBE
Date:   Thu, 23 Sep 2021 15:39:19 +0100
Message-Id: <20210923143919.2944311-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210923143919.2944311-1-suzuki.poulose@arm.com>
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the TRBE generates an IRQ, we stop the TRBE, collect the trace
and then reprogram the TRBE with the updated buffer pointers, whenever
possible. We might also leave the TRBE disabled, if there is not
enough space left in the buffer. However, we do not touch the ETE at
all during all of this. This means the ETE is only disabled when
the event is disabled later (via irq_work). This is incorrect, as the
ETE trace is still ON without actually being captured and may be routed
to the ATB (even if it is for a short duration).

So, we move the CPU into trace prohibited state always before disabling
the TRBE, upon entering the IRQ handler. The state is restored if the
TRBE is enabled back. Otherwise the trace remains prohibited.

Since, the ETM/ETE driver now controls the TRFCR_EL1 per session, the
tracing can be restored/enabled back when the event is rescheduled
in.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-self-hosted-trace.h    | 4 +++-
 drivers/hwtracing/coresight/coresight-trbe.c             | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
index 23f05df3f173..53840a2c41f2 100644
--- a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
+++ b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
@@ -21,11 +21,13 @@ static inline void write_trfcr(u64 val)
 	isb();
 }
 
-static inline void cpu_prohibit_trace(void)
+static inline u64 cpu_prohibit_trace(void)
 {
 	u64 trfcr = read_trfcr();
 
 	/* Prohibit tracing at EL0 & the kernel EL */
 	write_trfcr(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE));
+	/* Return the original value of the TRFCR */
+	return trfcr;
 }
 #endif /*  __CORESIGHT_SELF_HOSTED_TRACE_H */
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 4174300f1344..a53ee98f312f 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) DRVNAME ": " fmt
 
 #include <asm/barrier.h>
+#include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
 #define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
@@ -775,6 +776,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	enum trbe_fault_action act;
 	u64 status;
 	bool truncated = false;
+	u64 trfcr;
 
 	/* Reads to TRBSR_EL1 is fine when TRBE is active */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -785,6 +787,8 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	if (!is_trbe_irq(status))
 		return IRQ_NONE;
 
+	/* Prohibit the CPU from tracing before we disable the TRBE */
+	trfcr = cpu_prohibit_trace();
 	/*
 	 * Ensure the trace is visible to the CPUs and
 	 * any external aborts have been resolved.
@@ -816,9 +820,14 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	/*
 	 * If the buffer was truncated, ensure perf callbacks
 	 * have completed, which will disable the event.
+	 *
+	 * Otherwise, restore the trace filter controls to
+	 * allow the tracing.
 	 */
 	if (truncated)
 		irq_work_run();
+	else
+		write_trfcr(trfcr);
 
 	return IRQ_HANDLED;
 }
-- 
2.24.1

