Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755C442A553
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhJLNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:20:37 -0400
Received: from foss.arm.com ([217.140.110.172]:41728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236701AbhJLNUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460DC1063;
        Tue, 12 Oct 2021 06:18:19 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D01383F70D;
        Tue, 12 Oct 2021 06:18:17 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 07/15] coresight: trbe: Decouple buffer base from the hardware base
Date:   Tue, 12 Oct 2021 14:17:35 +0100
Message-Id: <20211012131743.2040596-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always set the TRBBASER_EL1 to the base of the virtual ring
buffer. We are about to change this for working around an erratum.
So, in preparation to that, allow the driver to choose a different
base for the TRBBASER_EL1 (which is within the buffer range).

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 3de03136285f..58796ff425a4 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -57,6 +57,8 @@ struct trbe_buf {
 	 * trbe_limit sibling pointers.
 	 */
 	unsigned long trbe_base;
+	/* The base programmed into the TRBE */
+	unsigned long trbe_hw_base;
 	unsigned long trbe_limit;
 	unsigned long trbe_write;
 	int nr_pages;
@@ -470,12 +472,13 @@ static void set_trbe_limit_pointer_enabled(unsigned long addr)
 
 static void trbe_enable_hw(struct trbe_buf *buf)
 {
-	WARN_ON(buf->trbe_write < buf->trbe_base);
+	WARN_ON(buf->trbe_hw_base < buf->trbe_base);
+	WARN_ON(buf->trbe_write < buf->trbe_hw_base);
 	WARN_ON(buf->trbe_write >= buf->trbe_limit);
 	set_trbe_disabled();
 	isb();
 	clr_trbe_status();
-	set_trbe_base_pointer(buf->trbe_base);
+	set_trbe_base_pointer(buf->trbe_hw_base);
 	set_trbe_write_pointer(buf->trbe_write);
 
 	/*
@@ -520,7 +523,12 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
 	else
 		write = get_trbe_write_pointer();
 
-	end_off = write - get_trbe_base_pointer();
+	/*
+	 * TRBE may use a different base address than the base
+	 * of the ring buffer. Thus use the beginning of the ring
+	 * buffer to compute the offsets.
+	 */
+	end_off = write - buf->trbe_base;
 	start_off = PERF_IDX2OFF(handle->head, buf);
 
 	if (WARN_ON_ONCE(end_off < start_off))
@@ -678,6 +686,8 @@ static int __arm_trbe_enable(struct trbe_buf *buf,
 		trbe_stop_and_truncate_event(handle);
 		return -ENOSPC;
 	}
+	/* Set the base of the TRBE to the buffer base */
+	buf->trbe_hw_base = buf->trbe_base;
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
 	trbe_enable_hw(buf);
 	return 0;
@@ -771,7 +781,7 @@ static bool is_perf_trbe(struct perf_output_handle *handle)
 	struct trbe_drvdata *drvdata = cpudata->drvdata;
 	int cpu = smp_processor_id();
 
-	WARN_ON(buf->trbe_base != get_trbe_base_pointer());
+	WARN_ON(buf->trbe_hw_base != get_trbe_base_pointer());
 	WARN_ON(buf->trbe_limit != get_trbe_limit_pointer());
 
 	if (cpudata->mode != CS_MODE_PERF)
-- 
2.25.4

