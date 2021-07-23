Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F023D3A73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhGWMGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:07 -0400
Received: from foss.arm.com ([217.140.110.172]:45528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235025AbhGWMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:06:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEC87D6E;
        Fri, 23 Jul 2021 05:46:33 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41F9E3F694;
        Fri, 23 Jul 2021 05:46:32 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 08/10] coresight: trbe: Unify the enabling sequence
Date:   Fri, 23 Jul 2021 13:46:09 +0100
Message-Id: <20210723124611.3828908-9-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the sequence of enabling the TRBE. We do this from
event_start and also from the TRBE IRQ handler. Lets move
this to a common helper. The only minor functional change
is returning an error when we fail to enable the TRBE.
This should be handled already.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 34 +++++++++++---------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index d50f142e86d1..6d6aad171c72 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -632,6 +632,20 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
 	return size;
 }
 
+static int __arm_trbe_enable(struct trbe_buf *buf,
+			     struct perf_output_handle *handle)
+{
+	buf->trbe_limit = compute_trbe_buffer_limit(handle);
+	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
+	if (buf->trbe_limit == buf->trbe_base) {
+		trbe_stop_and_truncate_event(handle);
+		return -ENOSPC;
+	}
+	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
+	trbe_enable_hw(buf);
+	return 0;
+}
+
 static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
 	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -648,14 +662,8 @@ static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
 	cpudata->buf = buf;
 	cpudata->mode = mode;
 	buf->cpudata = cpudata;
-	buf->trbe_limit = compute_trbe_buffer_limit(handle);
-	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
-	if (buf->trbe_limit == buf->trbe_base) {
-		trbe_stop_and_truncate_event(handle);
-		return 0;
-	}
-	trbe_enable_hw(buf);
-	return 0;
+
+	return __arm_trbe_enable(buf, handle);
 }
 
 static int arm_trbe_disable(struct coresight_device *csdev)
@@ -722,14 +730,8 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
 		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
 		return;
 	}
-	buf->trbe_limit = compute_trbe_buffer_limit(handle);
-	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
-	if (buf->trbe_limit == buf->trbe_base) {
-		trbe_stop_and_truncate_event(handle);
-		return;
-	}
-	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
-	trbe_enable_hw(buf);
+
+	__arm_trbe_enable(buf, handle);
 }
 
 static bool is_perf_trbe(struct perf_output_handle *handle)
-- 
2.24.1

