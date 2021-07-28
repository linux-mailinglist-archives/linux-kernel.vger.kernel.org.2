Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0190A3D8FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhG1Nxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:53:44 -0400
Received: from foss.arm.com ([217.140.110.172]:56912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237483AbhG1Nwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:52:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC3A11D4;
        Wed, 28 Jul 2021 06:52:54 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D9353F70D;
        Wed, 28 Jul 2021 06:52:52 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 04/10] coresight: trbe: Decouple buffer base from the hardware base
Date:   Wed, 28 Jul 2021 14:52:11 +0100
Message-Id: <20210728135217.591173-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210728135217.591173-1-suzuki.poulose@arm.com>
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
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
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 0af644331b99..9735d514c5e1 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -59,6 +59,8 @@ struct trbe_buf {
 	 * trbe_limit sibling pointers.
 	 */
 	unsigned long trbe_base;
+	/* The base programmed into the TRBE */
+	unsigned long trbe_hw_base;
 	unsigned long trbe_limit;
 	unsigned long trbe_write;
 	int nr_pages;
@@ -504,7 +506,7 @@ static void trbe_enable_hw(struct trbe_buf *buf)
 	set_trbe_disabled();
 	isb();
 	clr_trbe_status();
-	set_trbe_base_pointer(buf->trbe_base);
+	set_trbe_base_pointer(buf->trbe_hw_base);
 	set_trbe_write_pointer(buf->trbe_write);
 
 	/*
@@ -709,6 +711,8 @@ static int __arm_trbe_enable(struct trbe_buf *buf,
 		trbe_stop_and_truncate_event(handle);
 		return -ENOSPC;
 	}
+	/* Set the base of the TRBE to the buffer base */
+	buf->trbe_hw_base = buf->trbe_base;
 	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
 	trbe_enable_hw(buf);
 	return 0;
@@ -808,7 +812,7 @@ static bool is_perf_trbe(struct perf_output_handle *handle)
 	struct trbe_drvdata *drvdata = cpudata->drvdata;
 	int cpu = smp_processor_id();
 
-	WARN_ON(buf->trbe_base != get_trbe_base_pointer());
+	WARN_ON(buf->trbe_hw_base != get_trbe_base_pointer());
 	WARN_ON(buf->trbe_limit != get_trbe_limit_pointer());
 
 	if (cpudata->mode != CS_MODE_PERF)
-- 
2.24.1

