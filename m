Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBE44FCBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhKOBbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:31:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26309 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhKOBah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:30:37 -0500
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HsrzB67rDzbhql;
        Mon, 15 Nov 2021 09:22:46 +0800 (CST)
Received: from huawei.com (10.67.174.191) by dggeml756-chm.china.huawei.com
 (10.1.199.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Mon, 15
 Nov 2021 09:27:40 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     <yuehaibing@huawei.com>, <weiyongjun1@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, <w.f@huawei.com>,
        <hucool.lihua@huawei.com>, <cj.chengjian@huawei.com>,
        <judy.chenhui@huawei.com>
Subject: [PATCH -next 1/1] sched/rt: Try to restart rt period timer when rt runtime exceeded
Date:   Mon, 15 Nov 2021 01:46:28 +0000
Message-ID: <20211115014628.15017-2-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115014628.15017-1-hucool.lihua@huawei.com>
References: <20211115014628.15017-1-hucool.lihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml756-chm.china.huawei.com (10.1.199.158)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rt_runtime is modified from -1 to a valid control value, it may
cause the task to be throttled all the time. Operations like the following
will trigger the bug. E.g:
1. echo -1 > /proc/sys/kernel/sched_rt_runtime_us
2. Run a FIFO task named A that executes while(1)
3. echo 950000 > /proc/sys/kernel/sched_rt_runtime_us

When rt_runtime is -1, The rt period timer will not be activated when task A
enqueued. And then the task will be throttled after setting rt_runtime to
950,000. The task will always be throttled because the rt period timer is not
activated.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
---
 kernel/sched/rt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bb945f8faeca..630f2cbe37d0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -947,6 +947,23 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 	return rt_task_of(rt_se)->prio;
 }
 
+static inline void try_start_rt_bandwidth(struct rt_bandwidth *rt_b)
+{
+	raw_spin_lock(&rt_b->rt_runtime_lock);
+	if (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF) {
+		raw_spin_unlock(&rt_b->rt_runtime_lock);
+		return;
+	}
+
+	if (!rt_b->rt_period_active) {
+		rt_b->rt_period_active = 1;
+		hrtimer_forward_now(&rt_b->rt_period_timer, rt_b->rt_period);
+		hrtimer_start_expires(&rt_b->rt_period_timer,
+				      HRTIMER_MODE_ABS_PINNED_HARD);
+	}
+	raw_spin_unlock(&rt_b->rt_runtime_lock);
+}
+
 static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
@@ -1027,11 +1044,16 @@ static void update_curr_rt(struct rq *rq)
 		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 
 		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
+			int exceeded;
+
 			raw_spin_lock(&rt_rq->rt_runtime_lock);
 			rt_rq->rt_time += delta_exec;
-			if (sched_rt_runtime_exceeded(rt_rq))
+			exceeded = sched_rt_runtime_exceeded(rt_rq);
+			if (exceeded)
 				resched_curr(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
+			if (exceeded)
+				try_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
 }
@@ -2905,8 +2927,10 @@ static int sched_rt_global_validate(void)
 
 static void sched_rt_do_global(void)
 {
+	raw_spin_lock(&def_rt_bandwidth.rt_runtime_lock);
 	def_rt_bandwidth.rt_runtime = global_rt_runtime();
 	def_rt_bandwidth.rt_period = ns_to_ktime(global_rt_period());
+	raw_spin_unlock(&def_rt_bandwidth.rt_runtime_lock);
 }
 
 int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-- 
2.17.1

