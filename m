Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6713630D5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhDQPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 11:12:40 -0400
Received: from [119.249.100.101] ([119.249.100.101]:37196 "EHLO
        mx421.baidu.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236588AbhDQPMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 11:12:38 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2021 11:12:37 EDT
Received: from unknown.domain.tld (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx421.baidu.com (Postfix) with ESMTP id 293972F00104;
        Sat, 17 Apr 2021 23:01:37 +0800 (CST)
From:   Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Optimize housekeeping_cpumask in for_each_cpu_and
Date:   Sat, 17 Apr 2021 23:01:37 +0800
Message-Id: <1618671697-26098-1-git-send-email-yuanzhaoxiong@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a 128 cores AMD machine, there are 8 cores in nohz_full mode, and
the others are used for housekeeping. When many housekeeping cpus are
in idle state, we can observe huge time burn in the loop for searching
nearest busy housekeeper cpu by ftrace.

   9)               |              get_nohz_timer_target() {
   9)               |                housekeeping_test_cpu() {
   9)   0.390 us    |                  housekeeping_get_mask.part.1();
   9)   0.561 us    |                }
   9)   0.090 us    |                __rcu_read_lock();
   9)   0.090 us    |                housekeeping_cpumask();
   9)   0.521 us    |                housekeeping_cpumask();
   9)   0.140 us    |                housekeeping_cpumask();

   ...

   9)   0.500 us    |                housekeeping_cpumask();
   9)               |                housekeeping_any_cpu() {
   9)   0.090 us    |                  housekeeping_get_mask.part.1();
   9)   0.100 us    |                  sched_numa_find_closest();
   9)   0.491 us    |                }
   9)   0.100 us    |                __rcu_read_unlock();
   9) + 76.163 us   |              }

for_each_cpu_and() is a micro function, so in get_nohz_timer_target()
function the
        for_each_cpu_and(i, sched_domain_span(sd),
                housekeeping_cpumask(HK_FLAG_TIMER))
equals to below:
        for (i = -1; i = cpumask_next_and(i, sched_domain_span(sd),
                housekeeping_cpumask(HK_FLAG_TIMER)), i < nr_cpu_ids;)
That will cause that housekeeping_cpumask() will be invoked many times.
The housekeeping_cpumask() function returns a const value, so it is
unnecessary to invoke it every time. This patch can minimize the worst
searching time from ~76us to ~16us in my testing.

Similarly, the find_new_ilb() function has the same problem.

Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/core.c | 6 ++++--
 kernel/sched/fair.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..14ad3bb36321 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -645,6 +645,7 @@ int get_nohz_timer_target(void)
 {
 	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
+	const struct cpumask *hk_mask;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
 		if (!idle_cpu(cpu))
@@ -652,10 +653,11 @@ int get_nohz_timer_target(void)
 		default_cpu = cpu;
 	}
 
+	hk_mask = housekeeping_cpumask(HK_FLAG_TIMER);
+
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu_and(i, sched_domain_span(sd),
-			housekeeping_cpumask(HK_FLAG_TIMER)) {
+		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
 			if (cpu == i)
 				continue;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..d3ecfbf160bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10097,9 +10097,11 @@ static inline int on_null_domain(struct rq *rq)
 static inline int find_new_ilb(void)
 {
 	int ilb;
+	const struct cpumask *hk_mask;
 
-	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
-			      housekeeping_cpumask(HK_FLAG_MISC)) {
+	hk_mask = housekeeping_cpumask(HK_FLAG_MISC);
+
+	for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {
 
 		if (ilb == smp_processor_id())
 			continue;
-- 
2.27.0

