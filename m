Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9642A559
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbhJLNVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:41814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236857AbhJLNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AAACED1;
        Tue, 12 Oct 2021 06:18:27 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10D993F70D;
        Tue, 12 Oct 2021 06:18:25 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 12/15] coresight: trbe: Make sure we have enough space
Date:   Tue, 12 Oct 2021 14:17:40 +0100
Message-Id: <20211012131743.2040596-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012131743.2040596-1-suzuki.poulose@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index c2ab4351e80b..46d23fbfd5f7 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -477,10 +477,14 @@ static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
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
2.25.4

