Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FA4270BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhJHSbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:31:35 -0400
Received: from foss.arm.com ([217.140.110.172]:41428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240334AbhJHSb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:31:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFB112FC;
        Fri,  8 Oct 2021 11:29:32 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 749693F766;
        Fri,  8 Oct 2021 11:29:30 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 06/16] coresight: trbe: Add a helper to pad a given buffer area
Date:   Fri,  8 Oct 2021 19:28:56 +0100
Message-Id: <20211008182906.1688009-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211008182906.1688009-1-suzuki.poulose@arm.com>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 5902ef41bfb8..3de03136285f 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -199,12 +199,18 @@ static void trbe_stop_and_truncate_event(struct perf_output_handle *handle)
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
2.25.4

