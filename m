Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0D3CB0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhGPC3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:29:49 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11285 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhGPC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:29:45 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GQw2s3xq4z1CJtB;
        Fri, 16 Jul 2021 10:21:09 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:26:49 +0800
Received: from huawei.com (10.67.174.153) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 16 Jul
 2021 10:26:49 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <daniel.m.jordan@oracle.com>
CC:     <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <zhangqiao22@huawei.com>
Subject: [PATCH -next v3] sched: Dec cfs_bandwidth_used in destroy_cfs_bandwidth()
Date:   Fri, 16 Jul 2021 10:27:56 +0800
Message-ID: <20210716022756.193817-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210706083820.41358-1-zhangqiao22@huawei.com>
References: <20210706083820.41358-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.153]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_bandwidth_used is a static_key to control cfs bandwidth
feature. When adding a cfs_bandwidth group, we need increase
the key, and decrease it when removing. But currently when we
remove a cfs bandwidth group, we don't decrease the key and
this switch will always be on even if there is no cfs bandwidth
group in the system.

Fix the problem as two steps:
1.Rename cfs_bandwidth_usage_{dec, inc}() to
cfs_bandwidth_usage_{dec,inc}_cpuslocked() and its caller need to
hold the hotplug lock.
2.Add cfs_bandwidth_usage_dec() and its caller don't need
to hold the hotplug lock. And when removing a cfs bandwidth group,
we decrease cfs_bandwidth_used by calling cfs_bandwidth_usage_dec().

Fixes: 56f570e512ee ("sched: use jump labels to reduce overhead when bandwidth control is inactive")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
Changes since v2:
 - Remove cfs_bandwidth_usage_inc()
 - Make cfs_bandwidth_usage_dec() static

Changes since v1:
 - Add suffix _cpuslocked to cfs_bandwidth_usage_{dec,inc}.
 - Use static_key_slow_{dec,inc}_cpuslocked() in origin
 cfs_bandwidth_usage_{dec,inc}().
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  | 18 ++++++++++++++----
 kernel/sched/sched.h |  4 ++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 014ce8b385c7..d407aab4ea38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9865,7 +9865,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	 * before making related changes, and on->off must occur afterwards
 	 */
 	if (runtime_enabled && !runtime_was_enabled)
-		cfs_bandwidth_usage_inc();
+		cfs_bandwidth_usage_inc_cpuslocked();
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
@@ -9893,7 +9893,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		rq_unlock_irq(rq, &rf);
 	}
 	if (runtime_was_enabled && !runtime_enabled)
-		cfs_bandwidth_usage_dec();
+		cfs_bandwidth_usage_dec_cpuslocked();
 out_unlock:
 	mutex_unlock(&cfs_constraints_mutex);
 	put_online_cpus();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44e44c235f1f..03a1e98cbe96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4613,23 +4613,30 @@ static inline bool cfs_bandwidth_used(void)
 	return static_key_false(&__cfs_bandwidth_used);
 }
 
-void cfs_bandwidth_usage_inc(void)
+void cfs_bandwidth_usage_inc_cpuslocked(void)
 {
 	static_key_slow_inc_cpuslocked(&__cfs_bandwidth_used);
 }
 
-void cfs_bandwidth_usage_dec(void)
+void cfs_bandwidth_usage_dec_cpuslocked(void)
 {
 	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);
 }
+
+static void cfs_bandwidth_usage_dec(void)
+{
+	static_key_slow_dec(&__cfs_bandwidth_used);
+}
 #else /* CONFIG_JUMP_LABEL */
 static bool cfs_bandwidth_used(void)
 {
 	return true;
 }
 
-void cfs_bandwidth_usage_inc(void) {}
-void cfs_bandwidth_usage_dec(void) {}
+void cfs_bandwidth_usage_inc_cpuslocked(void) {}
+void cfs_bandwidth_usage_dec_cpuslocked(void) {}
+
+static void cfs_bandwidth_usage_dec(void) {}
 #endif /* CONFIG_JUMP_LABEL */
 
 /*
@@ -5345,6 +5352,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	if (!cfs_b->throttled_cfs_rq.next)
 		return;
 
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_bandwidth_usage_dec();
+
 	hrtimer_cancel(&cfs_b->period_timer);
 	hrtimer_cancel(&cfs_b->slack_timer);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0fa583db5c4a..6b2f58a99fa2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2690,8 +2690,8 @@ extern void init_cfs_rq(struct cfs_rq *cfs_rq);
 extern void init_rt_rq(struct rt_rq *rt_rq);
 extern void init_dl_rq(struct dl_rq *dl_rq);
 
-extern void cfs_bandwidth_usage_inc(void);
-extern void cfs_bandwidth_usage_dec(void);
+extern void cfs_bandwidth_usage_inc_cpuslocked(void);
+extern void cfs_bandwidth_usage_dec_cpuslocked(void);
 
 #ifdef CONFIG_NO_HZ_COMMON
 #define NOHZ_BALANCE_KICK_BIT	0
-- 
2.18.0.huawei.25

