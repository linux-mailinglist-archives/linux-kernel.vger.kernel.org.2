Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49579416137
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhIWOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:41:08 -0400
Received: from foss.arm.com ([217.140.110.172]:35314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241734AbhIWOlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:41:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81A4411FB;
        Thu, 23 Sep 2021 07:39:33 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 673473F718;
        Thu, 23 Sep 2021 07:39:32 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 2/5] coresight: trbe: Fix handling of spurious interrupts
Date:   Thu, 23 Sep 2021 15:39:16 +0100
Message-Id: <20210923143919.2944311-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210923143919.2944311-1-suzuki.poulose@arm.com>
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
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

On detecting a spurious IRQ after examining the TRBSR we simply
re-enable the TRBE without touching the other parameters.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 22 ++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index e78800ba5b5b..47120d263639 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -684,20 +684,16 @@ static int arm_trbe_disable(struct coresight_device *csdev)
 
 static void trbe_handle_spurious(struct perf_output_handle *handle)
 {
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	u64 limitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
 
-	buf->trbe_limit = compute_trbe_buffer_limit(handle);
-	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
-	if (buf->trbe_limit == buf->trbe_base) {
-		trbe_drain_and_disable_local();
-		/*
-		 * Just communicate trace truncation event to the user space by
-		 * marking it with PERF_AUX_FLAG_TRUNCATED.
-		 */
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
-		return;
-	}
-	trbe_enable_hw(buf);
+	/*
+	 * If the IRQ was spurious, simply re-enable the TRBE
+	 * back without modifying the buffer parameters to
+	 * retain the trace collected so far.
+	 */
+	limitr |= TRBLIMITR_ENABLE;
+	write_sysreg_s(limitr, SYS_TRBLIMITR_EL1);
+	isb();
 }
 
 static void trbe_handle_overflow(struct perf_output_handle *handle)
-- 
2.24.1

