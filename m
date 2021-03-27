Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEEE34B779
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhC0N73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 09:59:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15077 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0N7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 09:59:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F70kv1jqPz1BFpJ;
        Sat, 27 Mar 2021 21:56:55 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 21:58:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched/fair: Fix unused function warning
Date:   Sat, 27 Mar 2021 21:56:00 +0800
Message-ID: <20210327135600.27836-1-yuehaibing@huawei.com>
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

Move update_nohz_stats() to #ifdef block fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdbb2d40..c7a7ef97d167 100644
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
@@ -10097,6 +10075,24 @@ static inline int on_null_domain(struct rq *rq)
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
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
  * idle load balancing details
  * - When one of the busy CPUs notice that there may be an idle rebalancing
-- 
2.17.1

