Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2BA3C7B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhGNBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhGNBmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:42:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDBC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 18:40:01 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j17-20020a63cf110000b0290226eb0c27acso224499pgg.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AavxPO4wMlqTs8bDIN0GFYiKk69Xkxiv2X8B1/QDwlE=;
        b=Z2ISWtgcpEpQj/dzyZ58bm0t4HFLzTogj7ZWoP7NjUhaQOlt1sAXVoja7tux0madc/
         z8KYgCiFiwqKsMYq+/E59vW0btAR/aPEUnoz4VZHQIXeSu29/+f62JDUxDbc3510yTEd
         HyAxaz1CRJsXRFMmk+F9EAslRmRFMQ8Kvcw0s9g7phLGe+u3kb/8PX8QzufZrK0EPNjO
         zunbBLOHb7mvfA1ZC2+k7H7jgoUUpISkLpSnrPl5LvmQ2lUEtjAywrTVTjQ7+8WZifYf
         oDxgDrqHbKBBKThOTBOcsuPDc6yuNJF+J15vrbGS5CfjZysAaAGkA/YjxvN3CL67s2Pe
         50qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AavxPO4wMlqTs8bDIN0GFYiKk69Xkxiv2X8B1/QDwlE=;
        b=HW/BJk7HkCs6e8Y1DG4deQunMaJkj4j3MbLFpMYTFD3nlVVQek/8hhPQbB6yPuA0Ae
         dLuHsMu7UeOoADKtVGo4hK0i+gZBLvtfPHy4vpFDTMW4lAqC67nLmBTtIsgjGAbWLnrb
         KgaVFZdYPLxePcbp4mAzJB4p8AgvlzaI49q2w+X1qXpllm9y8qTo69oPOMTF/1mXgFFv
         wbsD22rqy3iDixObZ6Cs/rk4eqw/yY3UmUod7RlK8LDwW57CTnv7fEN8e1aIYhLprNty
         PAB1yiVGPyllkz54XIVsr6nB1UNKKTToieqpdqRszhCp+yIKPkoqZHmt5dgtwpT7sh8S
         NRBQ==
X-Gm-Message-State: AOAM533SvrPb0LCUQfgoxkDyxnDxgEDqJfmgxsoWecWbzH5UrlrDsSu9
        QS0iPK/hv8+5C4A6xbvaXFY8B3uqaRw+Dw==
X-Google-Smtp-Source: ABdhPJyGknWXQmJCSc6OliWSLHvZToljApe89R8GXFu81DER3Fq002ZUpbUxGzP2I2eScSHO6LXizBt7PEa8Cg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:c6c:5381:cc6a:6baa])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:710a:: with SMTP id
 h10mr1177731pjk.103.1626226800792; Tue, 13 Jul 2021 18:40:00 -0700 (PDT)
Date:   Tue, 13 Jul 2021 18:39:47 -0700
Message-Id: <20210714013948.270662-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v4 1/2] memcg: switch lruvec stats to rstat
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat") switched
memcg stats to rstat infrastructure but skipped the conversion of the
lruvec stats as such stats are read in the performance critical code
paths and flushing stats may have impacted the performances of the
applications. This patch converts the lruvec stats to rstat and later
patches add mechanisms to keep the performance impact to minimum.

The rstat conversion comes with the price i.e. memory cost. Effectively
this patch reverts the savings done by the commit f3344adf38bd ("mm:
memcontrol: optimize per-lruvec stats counter memory usage"). However
this cost is justified due to negative impact of the inaccurate lruvec
stats on many heuristics. One such case is reported in [1].

The memory reclaim code is filled with plethora of heuristics and many
of those heuristics reads the lruvec stats. So, inaccurate stats can
make such heuristics ineffective. [1] reports the impact of inaccurate
lruvec stats on the "cache trim mode" heuristic. Inaccurate lruvec stats
can impact the deactivation and aging anon heuristics as well.

[1] https://lore.kernel.org/linux-mm/20210311004449.1170308-1-ying.huang@intel.com/

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v3:
- Add back the signoff

Changes since v2:
- updated commit message

Changes since v1:
- None

 include/linux/memcontrol.h |  42 +++++++-------
 mm/memcontrol.c            | 114 +++++++++++++------------------------
 2 files changed, 58 insertions(+), 98 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..0bfa0409af22 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -105,14 +105,6 @@ struct mem_cgroup_reclaim_iter {
 	unsigned int generation;
 };
 
-struct lruvec_stat {
-	long count[NR_VM_NODE_STAT_ITEMS];
-};
-
-struct batched_lruvec_stat {
-	s32 count[NR_VM_NODE_STAT_ITEMS];
-};
-
 /*
  * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
  * shrinkers, which have elements charged to this memcg.
@@ -123,24 +115,30 @@ struct shrinker_info {
 	unsigned long *map;
 };
 
+struct lruvec_stats_percpu {
+	/* Local (CPU and cgroup) state */
+	long state[NR_VM_NODE_STAT_ITEMS];
+
+	/* Delta calculation for lockless upward propagation */
+	long state_prev[NR_VM_NODE_STAT_ITEMS];
+};
+
+struct lruvec_stats {
+	/* Aggregated (CPU and subtree) state */
+	long state[NR_VM_NODE_STAT_ITEMS];
+
+	/* Pending child counts during tree propagation */
+	long state_pending[NR_VM_NODE_STAT_ITEMS];
+};
+
 /*
  * per-node information in memory controller.
  */
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
-	/*
-	 * Legacy local VM stats. This should be struct lruvec_stat and
-	 * cannot be optimized to struct batched_lruvec_stat. Because
-	 * the threshold of the lruvec_stat_cpu can be as big as
-	 * MEMCG_CHARGE_BATCH * PAGE_SIZE. It can fit into s32. But this
-	 * filed has no upper limit.
-	 */
-	struct lruvec_stat __percpu *lruvec_stat_local;
-
-	/* Subtree VM stats (batched updates) */
-	struct batched_lruvec_stat __percpu *lruvec_stat_cpu;
-	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
+	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
+	struct lruvec_stats			lruvec_stats;
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
@@ -965,7 +963,7 @@ static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = atomic_long_read(&pn->lruvec_stat[idx]);
+	x = READ_ONCE(pn->lruvec_stats.state[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -985,7 +983,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	for_each_possible_cpu(cpu)
-		x += per_cpu(pn->lruvec_stat_local->count[idx], cpu);
+		x += per_cpu(pn->lruvec_stats_percpu->state[idx], cpu);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..848d711bf576 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -671,23 +671,11 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
-static struct mem_cgroup_per_node *
-parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
-{
-	struct mem_cgroup *parent;
-
-	parent = parent_mem_cgroup(pn->memcg);
-	if (!parent)
-		return NULL;
-	return parent->nodeinfo[nid];
-}
-
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val)
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	long x, threshold = MEMCG_CHARGE_BATCH;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
@@ -696,21 +684,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__mod_memcg_state(memcg, idx, val);
 
 	/* Update lruvec */
-	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
-
-	if (vmstat_item_in_bytes(idx))
-		threshold <<= PAGE_SHIFT;
-
-	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > threshold)) {
-		pg_data_t *pgdat = lruvec_pgdat(lruvec);
-		struct mem_cgroup_per_node *pi;
-
-		for (pi = pn; pi; pi = parent_nodeinfo(pi, pgdat->node_id))
-			atomic_long_add(x, &pi->lruvec_stat[idx]);
-		x = 0;
-	}
-	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 }
 
 /**
@@ -2289,40 +2263,13 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	mutex_unlock(&percpu_charge_mutex);
 }
 
-static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
-{
-	int nid;
-
-	for_each_node(nid) {
-		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
-		unsigned long stat[NR_VM_NODE_STAT_ITEMS];
-		struct batched_lruvec_stat *lstatc;
-		int i;
-
-		lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			stat[i] = lstatc->count[i];
-			lstatc->count[i] = 0;
-		}
-
-		do {
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
-		} while ((pn = parent_nodeinfo(pn, nid)));
-	}
-}
-
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *memcg;
 
 	stock = &per_cpu(memcg_stock, cpu);
 	drain_stock(stock);
 
-	for_each_mem_cgroup(memcg)
-		memcg_flush_lruvec_page_state(memcg, cpu);
-
 	return 0;
 }
 
@@ -5126,17 +5073,9 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return 1;
 
-	pn->lruvec_stat_local = alloc_percpu_gfp(struct lruvec_stat,
-						 GFP_KERNEL_ACCOUNT);
-	if (!pn->lruvec_stat_local) {
-		kfree(pn);
-		return 1;
-	}
-
-	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct batched_lruvec_stat,
-					       GFP_KERNEL_ACCOUNT);
-	if (!pn->lruvec_stat_cpu) {
-		free_percpu(pn->lruvec_stat_local);
+	pn->lruvec_stats_percpu = alloc_percpu_gfp(struct lruvec_stats_percpu,
+						   GFP_KERNEL_ACCOUNT);
+	if (!pn->lruvec_stats_percpu) {
 		kfree(pn);
 		return 1;
 	}
@@ -5157,8 +5096,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
-	free_percpu(pn->lruvec_stat_cpu);
-	free_percpu(pn->lruvec_stat_local);
+	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn);
 }
 
@@ -5174,15 +5112,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
-	int cpu;
-
 	memcg_wb_domain_exit(memcg);
-	/*
-	 * Flush percpu lruvec stats to guarantee the value
-	 * correctness on parent's and all ancestor levels.
-	 */
-	for_each_online_cpu(cpu)
-		memcg_flush_lruvec_page_state(memcg, cpu);
 	__mem_cgroup_free(memcg);
 }
 
@@ -5415,7 +5345,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
 	long delta, v;
-	int i;
+	int i, nid;
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
@@ -5463,6 +5393,36 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (parent)
 			parent->vmstats.events_pending[i] += delta;
 	}
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		struct mem_cgroup_per_node *ppn = NULL;
+		struct lruvec_stats_percpu *lstatc;
+
+		if (parent)
+			ppn = parent->nodeinfo[nid];
+
+		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
+
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			delta = pn->lruvec_stats.state_pending[i];
+			if (delta)
+				pn->lruvec_stats.state_pending[i] = 0;
+
+			v = READ_ONCE(lstatc->state[i]);
+			if (v != lstatc->state_prev[i]) {
+				delta += v - lstatc->state_prev[i];
+				lstatc->state_prev[i] = v;
+			}
+
+			if (!delta)
+				continue;
+
+			pn->lruvec_stats.state[i] += delta;
+			if (ppn)
+				ppn->lruvec_stats.state_pending[i] += delta;
+		}
+	}
 }
 
 #ifdef CONFIG_MMU
@@ -6396,6 +6356,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
+	cgroup_rstat_flush(memcg->css.cgroup);
+
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
 
-- 
2.32.0.93.g670b81a890-goog

