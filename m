Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC48141349B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhIUNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhIUNn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8566D;
        Tue, 21 Sep 2021 06:41:57 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02F473F40C;
        Tue, 21 Sep 2021 06:41:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 14/17] coresight: trbe: Make sure we have enough space
Date:   Tue, 21 Sep 2021 14:41:18 +0100
Message-Id: <20210921134121.2423546-15-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TRBE driver makes sure that there is enough space for a meaningful
run, otherwise pads the given space and restarts the offset calculation
once. But there is no guarantee that we may find space or hit "no space".
Make sure that we repeat the step until, either :
  - We have the minimum space
   OR
  - There is NO space at all.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 3373f4e2183b..02f9e00e2091 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -451,10 +451,14 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
 	 * If the head is too close to the limit and we don't
 	 * have space for a meaningful run, we rather pad it
 	 * and start fresh.
+	 *
+	 * We might have to do this more than once to make sure
+	 * we have enough required space.
 	 */
-	if (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
+	while (limit && ((limit - head) < trbe_min_trace_buf_size(handle))) {
 		trbe_pad_buf(handle, limit - head);
 		limit = __trbe_normal_offset(handle);
+		head = PERF_IDX2OFF(handle->head, buf);
 	}
 	return limit;
 }
-- 
2.24.1

