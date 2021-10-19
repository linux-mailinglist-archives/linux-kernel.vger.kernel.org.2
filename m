Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBECF433C53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhJSQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:35:48 -0400
Received: from foss.arm.com ([217.140.110.172]:51624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234459AbhJSQff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:35:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F3A1063;
        Tue, 19 Oct 2021 09:33:22 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 668223F694;
        Tue, 19 Oct 2021 09:33:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     will@kernel.org, mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v6 06/15] coresight: trbe: Add a helper to pad a given buffer area
Date:   Tue, 19 Oct 2021 17:31:44 +0100
Message-Id: <20211019163153.3692640-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211019163153.3692640-1-suzuki.poulose@arm.com>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
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
index 54f5d61ee9fb..e3767f21ee68 100644
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

