Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B159351D8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhDAS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:29:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15522 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhDASE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:04:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FB0xd0r8ZzPnQ6;
        Thu,  1 Apr 2021 19:16:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 19:19:10 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] arm64: perf: Remove redundant initialization in perf_event.c
Date:   Thu, 1 Apr 2021 19:16:41 +0800
Message-ID: <1617275801-1980-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization of value in function armv8pmu_read_hw_counter()
and armv8pmu_read_counter() seem redundant, as they are soon updated.
So, We can remove them.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 arch/arm64/kernel/perf_event.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4658fcf..f594957 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -470,9 +470,8 @@ static inline u64 armv8pmu_read_evcntr(int idx)
 static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
 {
 	int idx = event->hw.idx;
-	u64 val = 0;
+	u64 val = armv8pmu_read_evcntr(idx);
 
-	val = armv8pmu_read_evcntr(idx);
 	if (armv8pmu_event_is_chained(event))
 		val = (val << 32) | armv8pmu_read_evcntr(idx - 1);
 	return val;
@@ -520,7 +519,7 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	u64 value = 0;
+	u64 value;
 
 	if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		value = read_sysreg(pmccntr_el0);
-- 
2.8.1

