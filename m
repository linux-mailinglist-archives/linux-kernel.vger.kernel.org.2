Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503D03C9DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhGOL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:26:23 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11280 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbhGOL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:26:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GQX0V0S2Dz1CJYh;
        Thu, 15 Jul 2021 19:17:46 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 19:23:25 +0800
Received: from huawei.com (10.67.174.153) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 15 Jul
 2021 19:23:24 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <zhangqiao22@huawei.com>
CC:     <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <daniel.m.jordan@oracle.co>
Subject: [PATCH -next v2] sched: Dec cfs_bandwith_used in destroy_cfs_bandwidth()
Date:   Thu, 15 Jul 2021 19:24:33 +0800
Message-ID: <20210715112433.32419-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20210706083820.41358-1-zhangqiao22@huawei.com>
References: <20210706083820.41358-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.153]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_bandwith_uesd is a static_key to control cfs bandwidth
feature. When adding a cfs_bandwidth group, we need increase
the key, and decrease it when removing. But currently when we
remove a cfs_bandwidth group, we don't decrease the key and
this switch will always be on even if there is no cfs bandwidth
group in the system.

Fix the problem as two steps:
1.Rename cfs_bandwidth_usage_{dec, inc}() to
cfs_bandwidth_usage_{dec,inc}_cpuslocked() and its caller need to
hold the hotplug lock.
2.Add cfs_bandwidth_usage_{dec,inc}() and its caller don't need
to hold the hotplug lock. And when removing a cfs bandwidth group,
we decrease cfs_bandwith_used() by calling cfs_bandwidth_usage_dec().

Fixes: 56f570e512ee ("sched: use jump labels to reduce overhead when bandwidth control is inactive")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
Changes since v1:
 - Add suffix _cpuslocked to cfs_bandwidth_usage_{dec,inc}.
 - Use static_key_slow_{dec,inc}_cpuslocked() in origin
 cfs_bandwidth_usage_{dec,inc}().
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  | 20 ++++++++++++++++++--
 kernel/sched/sched.h |  3 +++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b726ea4ac341..76f661f3f12b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9854,7 +9854,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	 * before making related changes, and on->off must occur afterwards
 	 */
 	if (runtime_enabled && !runtime_was_enabled)
-		cfs_bandwidth_usage_inc();
+		cfs_bandwidth_usage_inc_cpuslocked();
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
@@ -9882,7 +9882,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		rq_unlock_irq(rq, &rf);
 	}
 	if (runtime_was_enabled && !runtime_enabled)
-		cfs_bandwidth_usage_dec();
+		cfs_bandwidth_usage_dec_cpuslocked();
 out_unlock:
 	mutex_unlock(&cfs_constraints_mutex);
 	put_online_cpus();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44e44c235f1f..e6d66a62c960 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4613,21 +4613,34 @@ static inline bool cfs_bandwidth_used(void)
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
+void cfs_bandwidth_usage_inc(void)
+{
+	static_key_slow_inc(&__cfs_bandwidth_used);
+}
+
+void cfs_bandwidth_usage_dec(void)
+{
+	static_key_slow_dec(&__cfs_bandwidth_used);
+}
 #else /* CONFIG_JUMP_LABEL */
 static bool cfs_bandwidth_used(void)
 {
 	return true;
 }
 
+void cfs_bandwidth_usage_inc_cpuslocked(void) {}
+void cfs_bandwidth_usage_dec_cpuslocked(void) {}
+
 void cfs_bandwidth_usage_inc(void) {}
 void cfs_bandwidth_usage_dec(void) {}
 #endif /* CONFIG_JUMP_LABEL */
@@ -5345,6 +5358,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	if (!cfs_b->throttled_cfs_rq.next)
 		return;
 
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_bandwidth_usage_dec();
+
 	hrtimer_cancel(&cfs_b->period_timer);
 	hrtimer_cancel(&cfs_b->slack_timer);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0fa583db5c4a..4baba3473b0b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2693,6 +2693,9 @@ extern void init_dl_rq(struct dl_rq *dl_rq);
 extern void cfs_bandwidth_usage_inc(void);
 extern void cfs_bandwidth_usage_dec(void);
 
+extern void cfs_bandwidth_usage_inc_cpuslocked(void);
+extern void cfs_bandwidth_usage_dec_cpuslocked(void);
+
 #ifdef CONFIG_NO_HZ_COMMON
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
-- 
2.18.0.huawei.25

