Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0BF3ECEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHPHJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:09:50 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55270 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233692AbhHPHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:09:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Uj7Ybxy_1629097753;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Uj7Ybxy_1629097753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Aug 2021 15:09:14 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, anderson@cs.unc.edu, baruah@wustl.edu,
        bsegall@google.com, changhuaixin@linux.alibaba.com,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: [PATCH 1/2] sched/fair: Add cfs bandwidth burst statistics
Date:   Mon, 16 Aug 2021 15:08:48 +0800
Message-Id: <20210816070849.3153-2-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210816070849.3153-1-changhuaixin@linux.alibaba.com>
References: <20210816070849.3153-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new statistics are introduced to show the internal of burst feature
and explain why burst helps or not.

nr_bursts:  number of periods bandwidth burst occurs
burst_usec: cumulative wall-time that any cpus has
	    used above quota in respective periods

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 13 ++++++++++---
 kernel/sched/fair.c  |  9 +++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..9a286c8a1354 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10088,6 +10088,9 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
 
+	seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
+	seq_printf(sf, "burst_usec %llu\n", cfs_b->burst_time);
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10184,16 +10187,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
index 44c452072a1b..464371f364f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4655,11 +4655,20 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
+	s64 runtime;
+
 	if (unlikely(cfs_b->quota == RUNTIME_INF))
 		return;
 
 	cfs_b->runtime += cfs_b->quota;
+	runtime = cfs_b->runtime_snap - cfs_b->runtime;
+	if (runtime > 0) {
+		cfs_b->burst_time += runtime;
+		cfs_b->nr_burst++;
+	}
+
 	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
+	cfs_b->runtime_snap = cfs_b->runtime;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..80e4322727b4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -367,6 +367,7 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	u64			burst;
+	u64			runtime_snap;
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

