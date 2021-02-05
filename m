Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF45D310FF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhBEQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhBEQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:47:59 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76FC0611C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:28:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w20so5700273qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxrjTr68An1JC48/Dgt1GzhHxl+q3IMmZm87Cqod2Wk=;
        b=UXEdA9XIIDNdFZJuaqb/nXFFnkcvMoaPtHHtFWL+4bMPmKeVsckk5C87KVeoYGGsa8
         sYC3BcYqPGDm8T31oENVu58gH3vxnMWxKc4figxpcaw6BiGbIkG8o8Qg7R1iVeYr86tP
         4aoxAtEwnNW3DupHid/5l3ajalJ/o1QRc8XWBTGxl9K9ZsHbqR+CwbACa99EG+r8KcV4
         Uunev0c1l7ccXlDUrdJf8ZE0oFB67CecnPo6JmEA9rM7HAWaBiOtbj/jeXOLDYDa8nwd
         tRhm8snSOBYK4gwxd3T930OxIXLYRaPNtQTi0GU9eKdnZbDiZIhv9ZITv1NIijm350XU
         eubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxrjTr68An1JC48/Dgt1GzhHxl+q3IMmZm87Cqod2Wk=;
        b=axArBlLagDvElhZDoUYAgt+1E0TNf9thHsqLiy/SQLZcI0JsZq/55CCzTwVUrX7/8w
         mFqbxKLuYkPVAYoZG1rxvZnpAOKwF1pmfN2iGlBwaxqksMfAB8aWz0xRyYGSkK5FVSq2
         xioJ497wnjC7HRiFiDy7N6/e0FUJZckAGxwWZhS7yO7gHh41e/OpidgX6+y8BtBlGSrM
         IL92OhUQFK6ehDpuTe5r99orR4miX8j9M16hzEbhj9adSUPekgQUi951lYk+crxLkog2
         r0Z4yBWr8ef5ojulsQuT6suAts4iH/8ZP7pkV2mA59mmzobT94vlt5yDl6wb+ii8soFA
         00EA==
X-Gm-Message-State: AOAM533dx3jki0MKAS2OmlzSnmQqkeH8e9j7fCRj8yxucLMBpzVWKJrD
        8j6GiFBofyUP9QZ9Pf+Hm3PVow==
X-Google-Smtp-Source: ABdhPJz2hOV8/sFaI1qNGyF3ytetlSHqn6vPj8Gg3rEO7EwO8gpb1YS3mUpj3LdsyWMAd4HsEYm59Q==
X-Received: by 2002:a05:622a:488:: with SMTP id p8mr5337533qtx.137.1612549714317;
        Fri, 05 Feb 2021 10:28:34 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t8sm9188103qkt.125.2021.02.05.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:33 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/8] mm: memcontrol: switch to rstat
Date:   Fri,  5 Feb 2021 13:28:04 -0500
Message-Id: <20210205182806.17220-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the memory controller's custom hierarchical stats code with
the generic rstat infrastructure provided by the cgroup core.

The current implementation does batched upward propagation from the
write side (i.e. as stats change). The per-cpu batches introduce an
error, which is multiplied by the number of subgroups in a tree. In
systems with many CPUs and sizable cgroup trees, the error can be
large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
subgroups results in an error of up to 128M per stat item). This can
entirely swallow allocation bursts inside a workload that the user is
expecting to see reflected in the statistics.

In the past, we've done read-side aggregation, where a memory.stat
read would have to walk the entire subtree and add up per-cpu
counts. This became problematic with lazily-freed cgroups: we could
have large subtrees where most cgroups were entirely idle. Hence the
switch to change-driven upward propagation. Unfortunately, it needed
to trade accuracy for speed due to the write side being so hot.

Rstat combines the best of both worlds: from the write side, it
cheaply maintains a queue of cgroups that have pending changes, so
that the read side can do selective tree aggregation. This way the
reported stats will always be precise and recent as can be, while the
aggregation can skip over potentially large numbers of idle cgroups.

The way rstat works is that it implements a tree for tracking cgroups
with pending local changes, as well as a flush function that walks the
tree upwards. The controller then drives this by 1) telling rstat when
a local cgroup stat changes (e.g. mod_memcg_state) and 2) when a flush
is required to get uptodate hierarchy stats for a given subtree
(e.g. when memory.stat is read). The controller also provides a flush
callback that is called during the rstat flush walk for each cgroup
and aggregates its local per-cpu counters and propagates them upwards.

This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
aggregation. It removes 3 words from the per-cpu data. It eliminates
memcg_exact_page_state(), since memcg_page_state() is now exact.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h |  67 ++++++-----
 mm/memcontrol.c            | 224 +++++++++++++++----------------------
 2 files changed, 133 insertions(+), 158 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ecdfae3289..a8c7a0ccc759 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -76,10 +76,27 @@ enum mem_cgroup_events_target {
 };
 
 struct memcg_vmstats_percpu {
-	long stat[MEMCG_NR_STAT];
-	unsigned long events[NR_VM_EVENT_ITEMS];
-	unsigned long nr_page_events;
-	unsigned long targets[MEM_CGROUP_NTARGETS];
+	/* Local (CPU and cgroup) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_VM_EVENT_ITEMS];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[MEMCG_NR_STAT];
+	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
+
+	/* Cgroup1: threshold notifications & softlimit tree updates */
+	unsigned long		nr_page_events;
+	unsigned long		targets[MEM_CGROUP_NTARGETS];
+};
+
+struct memcg_vmstats {
+	/* Aggregated (CPU and subtree) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_VM_EVENT_ITEMS];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[MEMCG_NR_STAT];
+	unsigned long		events_pending[NR_VM_EVENT_ITEMS];
 };
 
 struct mem_cgroup_reclaim_iter {
@@ -287,8 +304,8 @@ struct mem_cgroup {
 
 	MEMCG_PADDING(_pad1_);
 
-	atomic_long_t		vmstats[MEMCG_NR_STAT];
-	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
+	/* memory.stat */
+	struct memcg_vmstats	vmstats;
 
 	/* memory.events */
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
@@ -315,10 +332,6 @@ struct mem_cgroup {
 	atomic_t		moving_account;
 	struct task_struct	*move_lock_task;
 
-	/* Legacy local VM stats and events */
-	struct memcg_vmstats_percpu __percpu *vmstats_local;
-
-	/* Subtree VM stats and events (batched updates) */
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -942,10 +955,6 @@ static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
 	local_irq_restore(flags);
 }
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-						gfp_t gfp_mask,
-						unsigned long *total_scanned);
-
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count);
 
@@ -1028,6 +1037,10 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 void mem_cgroup_split_huge_fixup(struct page *head);
 #endif
 
+unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+						gfp_t gfp_mask,
+						unsigned long *total_scanned);
+
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1136,6 +1149,10 @@ static inline bool lruvec_holds_page_lru_lock(struct page *page,
 	return lruvec == &pgdat->__lruvec;
 }
 
+static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+}
+
 static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
 {
 	return NULL;
@@ -1349,18 +1366,6 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 	mod_node_page_state(page_pgdat(page), idx, val);
 }
 
-static inline
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
-{
-	return 0;
-}
-
-static inline void mem_cgroup_split_huge_fixup(struct page *head)
-{
-}
-
 static inline void count_memcg_events(struct mem_cgroup *memcg,
 				      enum vm_event_item idx,
 				      unsigned long count)
@@ -1383,8 +1388,16 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
 
-static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+static inline void mem_cgroup_split_huge_fixup(struct page *head)
+{
+}
+
+static inline
+unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					    gfp_t gfp_mask,
+					    unsigned long *total_scanned)
 {
+	return 0;
 }
 #endif /* CONFIG_MEMCG */
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2f97cb4cef6d..5dc0bd53b64a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -757,6 +757,11 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+static void memcg_flush_vmstats(struct mem_cgroup *memcg)
+{
+	cgroup_rstat_flush(memcg->css.cgroup);
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -765,37 +770,17 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
  */
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
-	long x, threshold = MEMCG_CHARGE_BATCH;
-
 	if (mem_cgroup_disabled())
 		return;
 
-	if (memcg_stat_item_in_bytes(idx))
-		threshold <<= PAGE_SHIFT;
-
-	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
-	if (unlikely(abs(x) > threshold)) {
-		struct mem_cgroup *mi;
-
-		/*
-		 * Batch local counters to keep them in sync with
-		 * the hierarchical ones.
-		 */
-		__this_cpu_add(memcg->vmstats_local->stat[idx], x);
-		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-			atomic_long_add(x, &mi->vmstats[idx]);
-		x = 0;
-	}
-	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
+	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
+	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 }
 
-/*
- * idx can be of type enum memcg_stat_item or node_stat_item.
- * Keep in sync with memcg_exact_page_state().
- */
+/* idx can be of type enum memcg_stat_item or node_stat_item. */
 static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
-	long x = atomic_long_read(&memcg->vmstats[idx]);
+	long x = READ_ONCE(memcg->vmstats.state[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -803,17 +788,14 @@ static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
-/*
- * idx can be of type enum memcg_stat_item or node_stat_item.
- * Keep in sync with memcg_exact_page_state().
- */
+/* idx can be of type enum memcg_stat_item or node_stat_item. */
 static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
 	long x = 0;
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
+		x += per_cpu(memcg->vmstats_percpu->state[idx], cpu);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -936,30 +918,16 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
 {
-	unsigned long x;
-
 	if (mem_cgroup_disabled())
 		return;
 
-	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
-	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
-		struct mem_cgroup *mi;
-
-		/*
-		 * Batch local counters to keep them in sync with
-		 * the hierarchical ones.
-		 */
-		__this_cpu_add(memcg->vmstats_local->events[idx], x);
-		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-			atomic_long_add(x, &mi->vmevents[idx]);
-		x = 0;
-	}
-	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
+	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
+	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
-	return atomic_long_read(&memcg->vmevents[event]);
+	return READ_ONCE(memcg->vmstats.events[event]);
 }
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
@@ -968,7 +936,7 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_local->events[event], cpu);
+		x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
 	return x;
 }
 
@@ -1631,6 +1599,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 *
 	 * Current memory state:
 	 */
+	memcg_flush_vmstats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -2450,22 +2419,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	drain_stock(stock);
 
 	for_each_mem_cgroup(memcg) {
-		struct memcg_vmstats_percpu *statc;
 		int i;
 
-		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
-
-		for (i = 0; i < MEMCG_NR_STAT; i++) {
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 			int nid;
 
-			if (statc->stat[i]) {
-				mod_memcg_state(memcg, i, statc->stat[i]);
-				statc->stat[i] = 0;
-			}
-
-			if (i >= NR_VM_NODE_STAT_ITEMS)
-				continue;
-
 			for_each_node(nid) {
 				struct batched_lruvec_stat *lstatc;
 				struct mem_cgroup_per_node *pn;
@@ -2484,13 +2442,6 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 				}
 			}
 		}
-
-		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-			if (statc->events[i]) {
-				count_memcg_events(memcg, i, statc->events[i]);
-				statc->events[i] = 0;
-			}
-		}
 	}
 
 	return 0;
@@ -3618,6 +3569,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 {
 	unsigned long val;
 
+	memcg_flush_vmstats(memcg);
+
 	if (mem_cgroup_is_root(memcg)) {
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
@@ -3683,26 +3636,15 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
+static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
 {
-	unsigned long stat[MEMCG_NR_STAT] = {0};
-	struct mem_cgroup *mi;
-	int node, cpu, i;
-
-	for_each_online_cpu(cpu)
-		for (i = 0; i < MEMCG_NR_STAT; i++)
-			stat[i] += per_cpu(memcg->vmstats_percpu->stat[i], cpu);
-
-	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-		for (i = 0; i < MEMCG_NR_STAT; i++)
-			atomic_long_add(stat[i], &mi->vmstats[i]);
+	int node;
 
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
+		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0 };
 		struct mem_cgroup_per_node *pi;
-
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-			stat[i] = 0;
+		int cpu, i;
 
 		for_each_online_cpu(cpu)
 			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
@@ -3715,25 +3657,6 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
 	}
 }
 
-static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
-{
-	unsigned long events[NR_VM_EVENT_ITEMS];
-	struct mem_cgroup *mi;
-	int cpu, i;
-
-	for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
-		events[i] = 0;
-
-	for_each_online_cpu(cpu)
-		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
-			events[i] += per_cpu(memcg->vmstats_percpu->events[i],
-					     cpu);
-
-	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
-			atomic_long_add(events[i], &mi->vmevents[i]);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
@@ -4050,6 +3973,8 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
+	memcg_flush_vmstats(memcg);
+
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
@@ -4120,6 +4045,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
+	memcg_flush_vmstats(memcg);
+
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
@@ -4596,22 +4523,6 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
 	return &memcg->cgwb_domain;
 }
 
-/*
- * idx can be of type enum memcg_stat_item or node_stat_item.
- * Keep in sync with memcg_exact_page().
- */
-static unsigned long memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
-{
-	long x = atomic_long_read(&memcg->vmstats[idx]);
-	int cpu;
-
-	for_each_online_cpu(cpu)
-		x += per_cpu_ptr(memcg->vmstats_percpu, cpu)->stat[idx];
-	if (x < 0)
-		x = 0;
-	return x;
-}
-
 /**
  * mem_cgroup_wb_stats - retrieve writeback related stats from its memcg
  * @wb: bdi_writeback in question
@@ -4637,13 +4548,14 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
+	memcg_flush_vmstats(memcg);
 
-	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
-	*pfilepages = memcg_exact_page_state(memcg, NR_INACTIVE_FILE) +
-			memcg_exact_page_state(memcg, NR_ACTIVE_FILE);
-	*pheadroom = PAGE_COUNTER_MAX;
+	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
+	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
+	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
+			memcg_page_state(memcg, NR_ACTIVE_FILE);
 
+	*pheadroom = PAGE_COUNTER_MAX;
 	while ((parent = parent_mem_cgroup(memcg))) {
 		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
 					    READ_ONCE(memcg->memory.high));
@@ -5275,7 +5187,6 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
 	free_percpu(memcg->vmstats_percpu);
-	free_percpu(memcg->vmstats_local);
 	kfree(memcg);
 }
 
@@ -5283,11 +5194,10 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	memcg_wb_domain_exit(memcg);
 	/*
-	 * Flush percpu vmstats and vmevents to guarantee the value correctness
-	 * on parent's and all ancestor levels.
+	 * Flush percpu lruvec stats to guarantee the value
+	 * correctness on parent's and all ancestor levels.
 	 */
-	memcg_flush_percpu_vmstats(memcg);
-	memcg_flush_percpu_vmevents(memcg);
+	memcg_flush_lruvec_page_state(memcg);
 	__mem_cgroup_free(memcg);
 }
 
@@ -5314,11 +5224,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		goto fail;
 	}
 
-	memcg->vmstats_local = alloc_percpu_gfp(struct memcg_vmstats_percpu,
-						GFP_KERNEL_ACCOUNT);
-	if (!memcg->vmstats_local)
-		goto fail;
-
 	memcg->vmstats_percpu = alloc_percpu_gfp(struct memcg_vmstats_percpu,
 						 GFP_KERNEL_ACCOUNT);
 	if (!memcg->vmstats_percpu)
@@ -5518,6 +5423,62 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
+static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+	struct memcg_vmstats_percpu *statc;
+	long delta, v;
+	int i;
+
+	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
+
+	for (i = 0; i < MEMCG_NR_STAT; i++) {
+		/*
+		 * Collect the aggregated propagation counts of groups
+		 * below us. We're in a per-cpu loop here and this is
+		 * a global counter, so the first cycle will get them.
+		 */
+		delta = memcg->vmstats.state_pending[i];
+		if (delta)
+			memcg->vmstats.state_pending[i] = 0;
+
+		/* Add CPU changes on this level since the last flush */
+		v = READ_ONCE(statc->state[i]);
+		if (v != statc->state_prev[i]) {
+			delta += v - statc->state_prev[i];
+			statc->state_prev[i] = v;
+		}
+
+		if (!delta)
+			continue;
+
+		/* Aggregate counts on this level and propagate upwards */
+		memcg->vmstats.state[i] += delta;
+		if (parent)
+			parent->vmstats.state_pending[i] += delta;
+	}
+
+	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
+		delta = memcg->vmstats.events_pending[i];
+		if (delta)
+			memcg->vmstats.events_pending[i] = 0;
+
+		v = READ_ONCE(statc->events[i]);
+		if (v != statc->events_prev[i]) {
+			delta += v - statc->events_prev[i];
+			statc->events_prev[i] = v;
+		}
+
+		if (!delta)
+			continue;
+
+		memcg->vmstats.events[i] += delta;
+		if (parent)
+			parent->vmstats.events_pending[i] += delta;
+	}
+}
+
 #ifdef CONFIG_MMU
 /* Handlers for move charge at task migration. */
 static int mem_cgroup_do_precharge(unsigned long count)
@@ -6571,6 +6532,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_released = mem_cgroup_css_released,
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
+	.css_rstat_flush = mem_cgroup_css_rstat_flush,
 	.can_attach = mem_cgroup_can_attach,
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
-- 
2.30.0

