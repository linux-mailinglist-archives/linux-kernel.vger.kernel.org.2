Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340273F7186
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbhHYJQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:16:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3688 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhHYJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:16:31 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GvgKP1g25z67Xj5;
        Wed, 25 Aug 2021 17:14:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 25 Aug 2021 11:15:44 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 25 Aug 2021 10:15:42 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] drivers/perf: thunderx2_pmu: Change data in size tx2_uncore_event_update()
Date:   Wed, 25 Aug 2021 17:10:55 +0800
Message-ID: <1629882656-217983-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629882656-217983-1-git-send-email-john.garry@huawei.com>
References: <1629882656-217983-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A LSL of 32 requires > 32b value to hold the result. However in
tx2_uncore_event_update(), 1UL << 32 currently only works as unsigned
long is 64b on a 64b system.

If we want to compile test for a 32b system, we need unsigned long long,
whose min size is 64b.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/thunderx2_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index fc1a376ee906..05378c0fd8f3 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -487,7 +487,7 @@ static void tx2_uncore_event_update(struct perf_event *event)
 		new = reg_readl(hwc->event_base);
 		prev = local64_xchg(&hwc->prev_count, new);
 		/* handles rollover of 32 bit counter */
-		delta = (u32)(((1UL << 32) - prev) + new);
+		delta = (u32)(((1ULL << 32) - prev) + new);
 	}
 
 	/* DMC event data_transfers granularity is 16 Bytes, convert it to 64 */
-- 
2.26.2

