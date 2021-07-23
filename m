Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1BE3D3A70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhGWMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:00 -0400
Received: from foss.arm.com ([217.140.110.172]:45486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234980AbhGWMFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:05:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A452ED6E;
        Fri, 23 Jul 2021 05:46:28 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38E5B3F694;
        Fri, 23 Jul 2021 05:46:27 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        jinlmao@qti.qualcomm.com
Subject: [PATCH v2 05/10] coresight: trbe: Drop duplicate TRUNCATE flags
Date:   Fri, 23 Jul 2021 13:46:06 +0100
Message-Id: <20210723124611.3828908-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210723124611.3828908-1-suzuki.poulose@arm.com>
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We mark the buffer as TRUNCATED when there is no space left
in the buffer. But we do it at different points.
    __trbe_normal_offset()
and also, at all the callers of the above function via
compute_trbe_buffer_limit(), when the limit == base (i.e
offset = 0 as returned by the __trbe_normal_offset()).

So, given that the callers already mark the buffer as TRUNCATED
drop the caller inside the __trbe_normal_offset().

This is in preparation to moving the handling of TRUNCATED
into a central place.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 446f080f8320..62e1a08f73ff 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -253,13 +253,9 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
 	 * trbe_base				trbe_base + nr_pages
 	 *
 	 * Perf aux buffer does not have any space for the driver to write into.
-	 * Just communicate trace truncation event to the user space by marking
-	 * it with PERF_AUX_FLAG_TRUNCATED.
 	 */
-	if (!handle->size) {
-		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	if (!handle->size)
 		return 0;
-	}
 
 	/* Compute the tail and wakeup indices now that we've aligned head */
 	tail = PERF_IDX2OFF(handle->head + handle->size, buf);
@@ -361,7 +357,6 @@ static unsigned long __trbe_normal_offset(struct perf_output_handle *handle)
 		return limit;
 
 	trbe_pad_buf(handle, handle->size);
-	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	return 0;
 }
 
-- 
2.24.1

