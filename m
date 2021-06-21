Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA73AE607
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhFUJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:30:30 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44566 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230121AbhFUJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:30:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Ud8YYYw_1624267688;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Ud8YYYw_1624267688)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Jun 2021 17:28:09 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     luca.abeni@santannapisa.it
Cc:     anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        changhuaixin@linux.alibaba.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: [PATCH v6 2/3] sched/fair: Add cfs bandwidth burst statistics
Date:   Mon, 21 Jun 2021 17:27:59 +0800
Message-Id: <20210621092800.23714-3-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following statistics in cpu.stat file is added to show how much workload
is making use of cfs_b burst:

nr_bursts:  number of periods bandwidth burst occurs
burst_usec: cumulative wall-time that any cpus has
	    used above quota in respective periods

The larger nr_bursts is, the more bursty periods there are. And the larger
burst_usec is, the more burst time is used by bursty workload.

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 kernel/sched/core.c  | 13 ++++++++++---
 kernel/sched/fair.c  | 11 +++++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b58ced2194a0..1e41c51b14b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9265,6 +9265,9 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
 
+	seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
+	seq_printf(sf, "burst_usec %llu\n", cfs_b->burst_time);
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -9361,16 +9364,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
+			   "nr_bursts %d\n"
+			   "burst_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
-			   throttled_usec);
+			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
 #endif
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53d7cc4d009b..62b73722e510 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4634,11 +4634,22 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
+	u64 runtime;
+
 	if (unlikely(cfs_b->quota == RUNTIME_INF))
 		return;
 
+	if (cfs_b->runtime_at_period_start > cfs_b->runtime) {
+		runtime = cfs_b->runtime_at_period_start - cfs_b->runtime;
+		if (runtime > cfs_b->quota) {
+			cfs_b->burst_time += runtime - cfs_b->quota;
+			cfs_b->nr_burst++;
+		}
+	}
+
 	cfs_b->runtime += cfs_b->quota;
 	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
+	cfs_b->runtime_at_period_start = cfs_b->runtime;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d317ca74a48c..b770b553dfbb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -367,6 +367,7 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	u64			burst;
+	u64			runtime_at_period_start;
 	s64			hierarchical_quota;
 
 	u8			idle;
@@ -379,7 +380,9 @@ struct cfs_bandwidth {
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

