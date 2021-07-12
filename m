Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5B3C5B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhGLLlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:41:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhGLLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:41:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1F2C31B;
        Mon, 12 Jul 2021 04:38:51 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A1C83F694;
        Mon, 12 Jul 2021 04:38:50 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, suzuki.poulose@arm.com,
        Tamas.Zsoldos@arm.com, will@kernel.org
Subject: [PATCH 4/5] coresight: trbe: Move irq_work queue processing
Date:   Mon, 12 Jul 2021 12:38:29 +0100
Message-Id: <20210712113830.2803257-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210712113830.2803257-1-suzuki.poulose@arm.com>
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRBE driver issues the irq_work_run() to ensure that
any pending disable event callback has been processed. But this
is done before we mark the AUX buffer as TRUNCATED, making
the call pointless. Move the call after the current handle
has been closed.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Reported-by: Tamas Zsoldos <Tamas.Zsoldos@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index ec38cf17b693..c0c264264427 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -723,6 +723,14 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
 				     PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, size);
+
+	/*
+	 * Ensure perf callbacks have completed. Since we
+	 * always TRUNCATE the buffer on IRQ, the event
+	 * is scheduled to be disabled. Make sure that happens
+	 * as soon as possible.
+	 */
+	irq_work_run();
 }
 
 static bool is_perf_trbe(struct perf_output_handle *handle)
@@ -777,12 +785,6 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
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
-- 
2.24.1

