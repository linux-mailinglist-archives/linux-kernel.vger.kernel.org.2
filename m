Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE61340FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 22:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhCRV3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 17:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhCRV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:28:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5975BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BMGtrr6rGCMUJvzDTXbcK0Tug3qQwQY7xCKv7FbOuxA=; b=C5ozsp5SQAidczGOeDPbVEXR9T
        cTy9zLd0iBOe1iRLaBBkjtnXD4HOsa+h3Hp6IUV9mkk0lxPednjg5xx5bmUaLHzFKHLT7LexdeZY6
        Mb1uObowMqzTyOAePlrXSceMb0HTnynNqp3qyUk4SAfOoiiY3sxYnbraUaF5g6nA7mi8sFHvLkEYi
        ltAw6UYOLACqkw+fE/Yj5hhASYtSniBYzY226/bJmnkQH/F/M2DcWRhEhMwa6RqMncGEmBRKlBVkm
        vpNMqa0NI9PbqnDdNGNjZnwEpfFVa7+PKFh127ZkMTHB6DjX2r5fXG6lXPJGbIcBKoRie/v15qfbp
        9v5Ua2MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lN0Bv-0062oC-Rf; Thu, 18 Mar 2021 21:28:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68386986500; Thu, 18 Mar 2021 22:28:26 +0100 (CET)
Date:   Thu, 18 Mar 2021 22:28:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC][PATCH] sched: Optimize cpufreq_update_util
Message-ID: <20210318212826.GW4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The below replaces cpufreq_update_util()'s indirect call with a
static_call(). The patch is quite gross, and we definitely need
static_call_update_cpuslocked().

cpufreq folks, is there a better way to do that optimize pass? That is,
we need to know when all CPUs have the *same* function set. Otherwise we
obviously cannot rewrite the text, which is shared by all CPUs.

Also, is there a lock order comment in cpufreq somewhere? I tried
following it, but eventually gave up and figured 'asking' lockdep was
far simpler.

---
 include/linux/sched/cpufreq.h |  9 ++++---
 kernel/sched/cpufreq.c        | 55 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h          | 28 ++++++++++++++++++++--
 kernel/static_call.c          |  4 ++--
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 6205578ab6ee..6d2972b67fa0 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -12,14 +12,17 @@
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
+struct update_util_data;
+
+typedef void (*cpu_util_update_f)(struct update_util_data *data,
+				u64 time, unsigned int flags);
 
 struct update_util_data {
-       void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
+	cpu_util_update_f func;
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
-                       void (*func)(struct update_util_data *data, u64 time,
-				    unsigned int flags));
+				  cpu_util_update_f func);
 void cpufreq_remove_update_util_hook(int cpu);
 bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
 
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 7c2fe50fd76d..b362a04e04d1 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -6,11 +6,60 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 #include <linux/cpufreq.h>
+#include <linux/static_call.h>
 
 #include "sched.h"
 
 DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+void cpufreq_update_indirect(struct update_util_data *data,
+			     u64 time, unsigned int flags)
+{
+	if (data)
+		data->func(data, time, flags);
+}
+
+DEFINE_STATIC_CALL(cpufreq_update_util, cpufreq_update_indirect);
+
+static void cpufreq_update_safe(void)
+{
+	static_call_update(cpufreq_update_util, cpufreq_update_indirect);
+}
+
+static void cpufreq_update_optimize(void)
+{
+	struct update_util_data *data;
+	cpu_util_update_f func = NULL, dfunc;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		data = per_cpu(cpufreq_update_util_data, cpu);
+		dfunc = data ? READ_ONCE(data->func) : NULL;
+
+		if (dfunc) {
+			if (!func)
+				func = dfunc;
+			else if (func != dfunc)
+				return;
+		} else if (func)
+			return;
+	}
+
+	pr_info("sched: optimized cpufreq_update_util\n");
+
+	/* all CPUs have the same @func */
+	static_call_update(cpufreq_update_util, func);
+}
+
+#else
+
+static inline void cpufreq_update_safe(void) { }
+static inline void cpufreq_update_optimize(void) { }
+
+#endif
+
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
  * @cpu: The CPU to set the pointer for.
@@ -39,8 +88,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
 		return;
 
+	cpufreq_update_safe();
+
 	data->func = func;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
+
+	cpufreq_update_optimize();
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
 
@@ -56,7 +109,9 @@ EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
  */
 void cpufreq_remove_update_util_hook(int cpu)
 {
+	cpufreq_update_safe();
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
+	cpufreq_update_optimize();
 }
 EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24ac31b40b55..333e33c3d496 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2473,6 +2473,30 @@ static inline u64 irq_time_read(int cpu)
 #ifdef CONFIG_CPU_FREQ
 DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+extern void cpufreq_update_indirect(struct update_util_data *data,
+				    u64 time, unsigned int flags);
+
+DECLARE_STATIC_CALL(cpufreq_update_util, cpufreq_update_indirect);
+
+static inline void cpufreq_update_util_call(struct update_util_data *data,
+					    u64 time, unsigned int flags)
+{
+	static_call_cond(cpufreq_update_util)(data, time, flags);
+}
+
+#else
+
+static inline void cpufreq_update_util_call(struct update_util_data *data,
+					    u64 time, unsigned int flags)
+{
+	if (data)
+		data->func(data, time, flags);
+}
+
+#endif
+
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
  * @rq: Runqueue to carry out the update for.
@@ -2501,9 +2525,9 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 
 	data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
 						  cpu_of(rq)));
-	if (data)
-		data->func(data, rq_clock(rq), flags);
+	cpufreq_update_util_call(data, rq_clock(rq), flags);
 }
+
 #else
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
diff --git a/kernel/static_call.c b/kernel/static_call.c
index ae825295cf68..fd73dfce3e50 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -122,7 +122,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	struct static_call_site *site, *stop;
 	struct static_call_mod *site_mod, first;
 
-	cpus_read_lock();
+//	cpus_read_lock();
 	static_call_lock();
 
 	if (key->func == func)
@@ -196,7 +196,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 
 done:
 	static_call_unlock();
-	cpus_read_unlock();
+//	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(__static_call_update);
 
