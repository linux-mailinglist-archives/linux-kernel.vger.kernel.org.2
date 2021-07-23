Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90C3D3A75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhGWMGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235061AbhGWMGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:06:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39625D6E;
        Fri, 23 Jul 2021 05:46:37 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDFD73F694;
        Fri, 23 Jul 2021 05:46:35 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 10/10] coresight: trbe: Prohibit trace before disabling TRBE
Date:   Fri, 23 Jul 2021 13:46:11 +0100
Message-Id: <20210723124611.3828908-11-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must prohibit the CPU from tracing before we disable
the TRBE and only re-enable it when we are sure the TRBE
has been enabled back. Otherwise, leave the CPU in
prohibited state.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-self-hosted-trace.h    | 4 +++-
 drivers/hwtracing/coresight/coresight-trbe.c             | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
index 586d26e0cba3..34372482a3cd 100644
--- a/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
+++ b/drivers/hwtracing/coresight/coresight-self-hosted-trace.h
@@ -22,11 +22,13 @@ static inline void write_trfcr(u64 val)
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
 #endif			/*  __CORESIGHT_SELF_HOSTED_TRACE_H */
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index e7567727e8fc..b8586c170889 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) DRVNAME ": " fmt
 
 #include <asm/barrier.h>
+#include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
 #define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
@@ -764,6 +765,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	enum trbe_fault_action act;
 	u64 status;
 	bool truncated = false;
+	u64 trfcr;
 
 	/* Reads to TRBSR_EL1 is fine when TRBE is active */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
@@ -774,6 +776,8 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	if (!is_trbe_irq(status))
 		return IRQ_NONE;
 
+	/* Prohibit the CPU from tracing before we disable the TRBE */
+	trfcr = cpu_prohibit_trace();
 	/*
 	 * Ensure the trace is visible to the CPUs and
 	 * any external aborts have been resolved.
@@ -805,9 +809,14 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
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

