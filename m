Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5B34E713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhC3MFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:05:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15824 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhC3MFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:05:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8p4j5Hzpz9sKj;
        Tue, 30 Mar 2021 20:03:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 20:05:32 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next] sched/fair: Move update_nohz_stats() under CONFIG_NO_HZ_COMMON
Date:   Tue, 30 Mar 2021 20:06:57 +0800
Message-ID: <20210330120657.54173-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_nohz_stats() only call _nohz_idle_balance() under CONFIG_NO_HZ_COMMON.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdbb2d40..2a20ada83cbb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8395,28 +8395,6 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
-static bool update_nohz_stats(struct rq *rq)
-{
-#ifdef CONFIG_NO_HZ_COMMON
-	unsigned int cpu = rq->cpu;
-
-	if (!rq->has_blocked_load)
-		return false;
-
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
-		return false;
-
-	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
-		return true;
-
-	update_blocked_averages(cpu);
-
-	return rq->has_blocked_load;
-#else
-	return false;
-#endif
-}
-
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10380,6 +10358,24 @@ void nohz_balance_enter_idle(int cpu)
 	WRITE_ONCE(nohz.has_blocked, 1);
 }
 
+static bool update_nohz_stats(struct rq *rq)
+{
+	unsigned int cpu = rq->cpu;
+
+	if (!rq->has_blocked_load)
+		return false;
+
+	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
+		return false;
+
+	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
+		return true;
+
+	update_blocked_averages(cpu);
+
+	return rq->has_blocked_load;
+}
+
 /*
  * Internal function that runs load balance for all idle cpus. The load balance
  * can be a simple update of blocked load or a complete load balance with
-- 
2.26.2

