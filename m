Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A8C3D3A71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhGWMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234999AbhGWMF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D4421063;
        Fri, 23 Jul 2021 05:46:30 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5A263F694;
        Fri, 23 Jul 2021 05:46:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 06/10] coresight: trbe: Fix handling of spurious interrupts
Date:   Fri, 23 Jul 2021 13:46:07 +0100
Message-Id: <20210723124611.3828908-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a spurious IRQ, right now we disable the TRBE and then re-enable
it back, resetting the "buffer" pointers(i.e BASE, LIMIT and more
importantly WRITE) to the original pointers from the AUX handle.
This implies that we overwrite any trace that was written so far,
(by overwriting TRBPTR) while we should have ignored the IRQ.

This patch cleans the behavior, by only stopping the TRBE if the
IRQ was indeed raised, as we can read the TRBSR without stopping
the TRBE (Only writes to the TRBSR requires the TRBE disabled).
And also, on detecting a spurious IRQ after examining the TRBSR,
we simply re-enable the TRBE without touching the other parameters.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 29 ++++++++++----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 62e1a08f73ff..503bea0137ae 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -679,15 +679,16 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 
 static void trbe_handle_spurious(struct perf_output_handle *handle)
 {
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	u64 limitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 
-	buf->trbe_limit = compute_trbe_buffer_limit(handle);
-	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
-	if (buf->trbe_limit == buf->trbe_base) {
-		trbe_drain_and_disable_local();
-		return;
-	}
-	trbe_enable_hw(buf);
+	/*
+	 * If the IRQ was spurious, simply re-enable the TRBE
+	 * back without modifiying the buffer parameters to
+	 * retain the trace collected so far.
+	 */
+	limitr |= TRBLIMITR_ENABLE;
+	write_sysreg_s(limitr, SYS_TRBLIMITR_EL1);
+	isb();
 }
 
 static void trbe_handle_overflow(struct perf_output_handle *handle)
@@ -760,12 +761,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	enum trbe_fault_action act;
 	u64 status;
 
-	/*
-	 * Ensure the trace is visible to the CPUs and
-	 * any external aborts have been resolved.
-	 */
-	trbe_drain_and_disable_local();
-
+	/* Reads to TRBSR_EL1 is fine when TRBE is active */
 	status = read_sysreg_s(SYS_TRBSR_EL1);
 	/*
 	 * If the pending IRQ was handled by update_buffer callback
@@ -774,6 +770,11 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
 	if (!is_trbe_irq(status))
 		return IRQ_NONE;
 
+	/*
+	 * Ensure the trace is visible to the CPUs and
+	 * any external aborts have been resolved.
+	 */
+	trbe_drain_and_disable_local();
 	clr_trbe_irq();
 	isb();
 
-- 
2.24.1

