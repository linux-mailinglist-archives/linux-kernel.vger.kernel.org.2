Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737FC41349A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhIUNni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:38 -0400
Received: from foss.arm.com ([217.140.110.172]:33928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233330AbhIUNnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4FA111B3;
        Tue, 21 Sep 2021 06:41:55 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 099F63F40C;
        Tue, 21 Sep 2021 06:41:53 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 13/17] coresight: trbe: Add a helper to determine the minimum buffer size
Date:   Tue, 21 Sep 2021 14:41:17 +0100
Message-Id: <20210921134121.2423546-14-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the TRBE to operate, we need a minimum space available to collect
meaningful trace session. This is currently a few bytes, but we may need
to extend this for working around errata. So, abstract this into a helper
function.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 797d978f9fa7..3373f4e2183b 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -277,6 +277,11 @@ trbe_handle_to_cpudata(struct perf_output_handle *handle)
 	return buf->cpudata;
 }
 
+static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
+{
+	return TRBE_TRACE_MIN_BUF_SIZE;
+}
+
 /*
  * TRBE Limit Calculation
  *
@@ -447,7 +452,7 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
 	 * have space for a meaningful run, we rather pad it
 	 * and start fresh.
 	 */
-	if (limit && (limit - head < TRBE_TRACE_MIN_BUF_SIZE)) {
+	if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
 		trbe_pad_buf(handle, limit - head);
 		limit = __trbe_normal_offset(handle);
 	}
-- 
2.24.1

