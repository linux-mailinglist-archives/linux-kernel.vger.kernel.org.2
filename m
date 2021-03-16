Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9CC33CCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhCPEuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:50:37 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53690 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235083AbhCPEuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:50:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0US4yKUp_1615870216;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0US4yKUp_1615870216)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 12:50:16 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com,
        peterz@infradead.org, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH v4 3/4] sched/fair: Add cfs bandwidth burst statistics
Date:   Tue, 16 Mar 2021 12:49:30 +0800
Message-Id: <20210316044931.39733-4-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using cfs_b and meeting with some throttled periods, users shall
use burst buffer to allow bursty workloads. Apart from configuring some
burst buffer and watch whether throttled periods disappears, some
statistics on burst buffer using are also helpful. Thus expose the
following statistics into cpu.stat file:

nr_burst:   number of periods bandwidth burst occurs
burst_time: cumulative wall-time that any cpus has
	    used above quota in respective periods

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 kernel/sched/core.c  | 14 +++++++++++---
 kernel/sched/fair.c  | 13 ++++++++++++-
 kernel/sched/sched.h |  3 +++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 16e23a2499ef..f60232862300 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9016,6 +9016,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		cfs_b->buffer = min(max_cfs_runtime, quota + burst);
 		cfs_b->max_overrun = DIV_ROUND_UP_ULL(max_cfs_runtime, quota);
 		cfs_b->runtime = cfs_b->quota;
+		cfs_b->runtime_at_period_start = cfs_b->runtime;
 
 		/* Restart the period timer (if active) to handle new period expiry: */
 		start_cfs_bandwidth(cfs_b, 1);
@@ -9265,6 +9266,9 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
 
+	seq_printf(sf, "nr_burst %d\n", cfs_b->nr_burst);
+	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -9361,16 +9365,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	{
 		struct task_group *tg = css_tg(css);
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-		u64 throttled_usec;
+		u64 throttled_usec, burst_usec;
 
 		throttled_usec = cfs_b->throttled_time;
 		do_div(throttled_usec, NSEC_PER_USEC);
+		burst_usec = cfs_b->burst_time;
+		do_div(burst_usec, NSEC_PER_USEC);
 
 		seq_printf(sf, "nr_periods %d\n"
 			   "nr_throttled %d\n"
-			   "throttled_usec %llu\n",
+			   "throttled_usec %llu\n"
+			   "nr_burst %d\n"
+			   "burst_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
-			   throttled_usec);
+			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
 #endif
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c981d4845c96..e7574d8bc11a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4612,7 +4612,7 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 static void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b,
 					   u64 overrun)
 {
-	u64 refill;
+	u64 refill, runtime;
 
 	if (cfs_b->quota != RUNTIME_INF) {
 
@@ -4621,10 +4621,21 @@ static void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b,
 			return;
 		}
 
+		if (cfs_b->runtime_at_period_start > cfs_b->runtime) {
+			runtime = cfs_b->runtime_at_period_start
+				- cfs_b->runtime;
+			if (runtime > cfs_b->quota) {
+				cfs_b->burst_time += runtime - cfs_b->quota;
+				cfs_b->nr_burst++;
+			}
+		}
+
 		overrun = min(overrun, cfs_b->max_overrun);
 		refill = cfs_b->quota * overrun;
 		cfs_b->runtime += refill;
 		cfs_b->runtime = min(cfs_b->runtime, cfs_b->buffer);
+
+		cfs_b->runtime_at_period_start = cfs_b->runtime;
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index efcbbfc31619..7ef8d4733791 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -360,6 +360,7 @@ struct cfs_bandwidth {
 	u64			burst;
 	u64			buffer;
 	u64			max_overrun;
+	u64			runtime_at_period_start;
 	s64			hierarchical_quota;
 
 	u8			idle;
@@ -372,7 +373,9 @@ struct cfs_bandwidth {
 	/* Statistics: */
 	int			nr_periods;
 	int			nr_throttled;
+	int			nr_burst;
 	u64			throttled_time;
+	u64			burst_time;
 #endif
 };
 
-- 
2.14.4.44.g2045bb6

