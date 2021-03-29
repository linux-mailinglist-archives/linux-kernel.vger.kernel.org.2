Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379DF34D29C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhC2OmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:42:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14188 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhC2Ol4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:41:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8FZs6jmxzmbjj;
        Mon, 29 Mar 2021 22:39:17 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 22:41:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] sched/fair: Fix unused function warning
Date:   Mon, 29 Mar 2021 22:40:29 +0800
Message-ID: <20210329144029.29200-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while CONFIG_NO_HZ_COMMON is not enabled, gcc warn this:

kernel/sched/fair.c:8398:13: warning: ‘update_nohz_stats’ defined but not used [-Wunused-function]
 static bool update_nohz_stats(struct rq *rq)
             ^~~~~~~~~~~~~~~~~

Move update_nohz_stats() to #ifdef checking this.

Fixes: 0826530de3cb ("sched/fair: Remove update of blocked load from newidle_balance")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
v2: Add Fixes tag, also move update_nohz_stats() closer to its only caller _nohz_idle_balance()
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
2.17.1

