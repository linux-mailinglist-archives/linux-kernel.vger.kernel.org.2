Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36404413490
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhIUNnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233326AbhIUNnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:43:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0819C106F;
        Tue, 21 Sep 2021 06:41:38 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4170B3F793;
        Tue, 21 Sep 2021 06:41:36 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 04/17] coresight: trbe: Add a helper to pad a given buffer area
Date:   Tue, 21 Sep 2021 14:41:08 +0100
Message-Id: <20210921134121.2423546-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the helper to pad a given AUX buffer area to allow
"filling" ignore packets, without moving any handle pointers.
This will be useful in working around errata, where we may
have to fill the buffer after a session.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 063c4505a203..a32ef083aa36 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -227,12 +227,18 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
  * consumed from the user space. The enabled TRBE buffer area is a moving subset of
  * the allocated perf auxiliary buffer.
  */
+
+static void __trbe_pad_buf(struct trbe_buf *buf, u64 offset, int len)
+{
+	memset((void *)buf->trbe_base + offset, ETE_IGNORE_PACKET, len);
+}
+
 static void trbe_pad_buf(struct perf_output_handle *handle, int len)
 {
 	struct trbe_buf *buf = etm_perf_sink_config(handle);
 	u64 head = PERF_IDX2OFF(handle->head, buf);
 
-	memset((void *)buf->trbe_base + head, ETE_IGNORE_PACKET, len);
+	__trbe_pad_buf(buf, head, len);
 	if (!buf->snapshot)
 		perf_aux_output_skip(handle, len);
 }
-- 
2.24.1

