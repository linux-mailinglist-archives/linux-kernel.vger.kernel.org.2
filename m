Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E785389267
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354582AbhESPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:21:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:9762 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354419AbhESPVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:21:13 -0400
IronPort-SDR: bwPZTgANCD6yI9zBuolAlP3W/0RKgFbIAcsfZgJQ3h/0ixM8cdy+Cj5V+/INM2iZ1sHt17tIhR
 UATJXiN3FQIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264916850"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264916850"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:19:49 -0700
IronPort-SDR: TMjsN5N9i8bCyNLvivx2Cwg7FbLj36jgtiFnH68b3HXkuKntHsNuyPDNOfRRDtcyUr+5msKt4D
 pbZya2ABgARQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411775923"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 08:19:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, vitaly.slobodskoy@intel.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/6] perf: Save PMU specific data in task_struct
Date:   Wed, 19 May 2021 08:06:01 -0700
Message-Id: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some PMU specific data has to be saved/restored during context switch,
e.g. LBR call stack data. Currently, the data is saved in event context
structure, but only for per-process event. For system-wide event,
because of missing the LBR call stack data after context switch, LBR
callstacks are always shorter in comparison to per-process mode.

For example,
  Per-process mode:
  $perf record --call-graph lbr -- taskset -c 0 ./tchain_edit

  -   99.90%    99.86%  tchain_edit  tchain_edit       [.] f3
       99.86% _start
          __libc_start_main
          generic_start_main
          main
          f1
        - f2
             f3

  System-wide mode:
  $perf record --call-graph lbr -a -- taskset -c 0 ./tchain_edit

  -   99.88%    99.82%  tchain_edit  tchain_edit        [.] f3
   - 62.02% main
        f1
        f2
        f3
   - 28.83% f1
      - f2
        f3
   - 28.83% f1
      - f2
           f3
   - 8.88% generic_start_main
        main
        f1
        f2
        f3

It isn't practical to simply allocate the data for system-wide event in
CPU context structure for all tasks. We have no idea which CPU a task
will be scheduled to. The duplicated LBR data has to be maintained on
every CPU context structure. That's a huge waste. Otherwise, the LBR
data still lost if the task is scheduled to another CPU.

Save the pmu specific data in task_struct. The size of pmu specific data
is 788 bytes for LBR call stack. Usually, the overall amount of threads
doesn't exceed a few thousands. For 10K threads, keeping LBR data would
consume additional ~8MB. The additional space will only be allocated
during LBR call stack monitoring. It will be released when the
monitoring is finished.

Furthermore, moving task_ctx_data from perf_event_context to task_struct
can reduce complexity and make things clearer. E.g. perf doesn't need to
swap task_ctx_data on optimized context switch path.
This patch set is just the first step. There could be other
optimization/extension on top of this patch set. E.g. for cgroup
profiling, perf just needs to save/store the LBR call stack information
for tasks in specific cgroup. That could reduce the additional space.
Also, the LBR call stack can be available for software events, or allow
even debugging use cases, like LBRs on crash later.

The data can be shared among events. To sync the writers of
perf_ctx_data RCU pointer, add a lock in task_struct as well.

The Kmem cache of pmu specific data is saved in struct perf_ctx_data.
It's required when child task allocates the space.
The refcount in struct perf_ctx_data is used to track the users of pmu
specific data.

Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The V3 can be found here.
https://lore.kernel.org/lkml/1578495789-95006-1-git-send-email-kan.liang@linux.intel.com/

Changes since V3:
- Rebase for the Arch LBR. Use Kmem cache to replace the data_size.

Changes since V2:
- Cannot use mutex inside rcu_read_lock().
  Restore the pin lock perf_ctx_data_lock


 include/linux/perf_event.h | 28 ++++++++++++++++++++++++++++
 include/linux/sched.h      |  4 ++++
 kernel/events/core.c       |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f..d46b7e1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -851,6 +851,34 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 };
 
+/**
+ * struct perf_ctx_data - PMU specific data for a task
+ * @rcu_head:  To avoid the race on free PMU specific data
+ * @refcount:  To track users
+ * @ctx_cache: Kmem cache of PMU specific data
+ * @data:      PMU specific data
+ *
+ * Currently, the struct is only used in Intel LBR call stack mode to
+ * save/restore the call stack of a task on context switches.
+ * The data only be allocated when Intel LBR call stack mode is enabled.
+ * The data will be freed when the mode is disabled. The rcu_head is
+ * used to prevent the race on free the data.
+ * The content of the data will only be accessed in context switch, which
+ * should be protected by rcu_read_lock().
+ *
+ * Careful: Struct perf_ctx_data is added as a pointor in struct task_struct.
+ * When system-wide Intel LBR call stack mode is enabled, a buffer with
+ * constant size will be allocated for each task.
+ * Also, system memory consumption can further grow when the size of
+ * struct perf_ctx_data enlarges.
+ */
+struct perf_ctx_data {
+	struct rcu_head			rcu_head;
+	refcount_t			refcount;
+	struct kmem_cache		*ctx_cache;
+	void				*data;
+};
+
 /*
  * Number of contexts where an event can trigger:
  *	task, softirq, hardirq, nmi.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c8813..700f56f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -52,6 +52,7 @@ struct mempolicy;
 struct nameidata;
 struct nsproxy;
 struct perf_event_context;
+struct perf_ctx_data;
 struct pid_namespace;
 struct pipe_inode_info;
 struct rcu_node;
@@ -1135,6 +1136,9 @@ struct task_struct {
 	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
+	/* Sync the writers of perf_ctx_data RCU pointer */
+	raw_spinlock_t			perf_ctx_data_lock;
+	struct perf_ctx_data __rcu	*perf_ctx_data;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2e947a4..9bb9bee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13131,6 +13131,8 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 	memset(child->perf_event_ctxp, 0, sizeof(child->perf_event_ctxp));
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
+	child->perf_ctx_data = NULL;
+	raw_spin_lock_init(&child->perf_ctx_data_lock);
 
 	for_each_task_context_nr(ctxn) {
 		ret = perf_event_init_context(child, ctxn, clone_flags);
-- 
2.7.4

