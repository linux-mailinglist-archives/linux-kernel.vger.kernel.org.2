Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90544270C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhJHSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:31:55 -0400
Received: from foss.arm.com ([217.140.110.172]:41508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240478AbhJHSbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:31:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1284A11FB;
        Fri,  8 Oct 2021 11:29:42 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D36D3F766;
        Fri,  8 Oct 2021 11:29:40 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 11/16] coresight: trbe: Add a helper to determine the minimum buffer size
Date:   Fri,  8 Oct 2021 19:29:01 +0100
Message-Id: <20211008182906.1688009-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211008182906.1688009-1-suzuki.poulose@arm.com>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
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
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 2a1656902836..c2ab4351e80b 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -303,6 +303,11 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
 	return buf->nr_pages * PAGE_SIZE;
 }
 
+static u64 trbe_min_trace_buf_size(struct perf_output_handle *handle)
+{
+	return TRBE_TRACE_MIN_BUF_SIZE;
+}
+
 /*
  * TRBE Limit Calculation
  *
@@ -473,7 +478,7 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
 	 * have space for a meaningful run, we rather pad it
 	 * and start fresh.
 	 */
-	if (limit && (limit - head < TRBE_TRACE_MIN_BUF_SIZE)) {
+	if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
 		trbe_pad_buf(handle, limit - head);
 		limit = __trbe_normal_offset(handle);
 	}
-- 
2.25.4

