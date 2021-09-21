Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06482413499
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhIUNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:30 -0400
Received: from foss.arm.com ([217.140.110.172]:33916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233422AbhIUNnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBA31106F;
        Tue, 21 Sep 2021 06:41:53 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F2333F40C;
        Tue, 21 Sep 2021 06:41:51 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 12/17] coresight: trbe: Add a helper to fetch cpudata from perf handle
Date:   Tue, 21 Sep 2021 14:41:16 +0100
Message-Id: <20210921134121.2423546-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to get the CPU specific data for TRBE instance, from
a given perf handle. This also adds extra checks to make sure that
the event associated with the handle is "bound" to the CPU and is
active on the TRBE.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 983dd5039e52..797d978f9fa7 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -268,6 +268,15 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
 	return buf->nr_pages * PAGE_SIZE;
 }
 
+static inline struct trbe_cpudata *
+trbe_handle_to_cpudata(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+
+	BUG_ON(!buf || !buf->cpudata);
+	return buf->cpudata;
+}
+
 /*
  * TRBE Limit Calculation
  *
@@ -533,8 +542,7 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
 {
 	int ec = get_trbe_ec(trbsr);
 	int bsc = get_trbe_bsc(trbsr);
-	struct trbe_buf *buf = etm_perf_sink_config(handle);
-	struct trbe_cpudata *cpudata = buf->cpudata;
+	struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);
 
 	WARN_ON(is_trbe_running(trbsr));
 	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
-- 
2.24.1

