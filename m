Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59695315409
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhBIQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhBIQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:35:14 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD50C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:33:34 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c5so4569684qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c7KKDZjaxaFY9q8eZHotItsTCY8IOulNrOVG8uy+3Fo=;
        b=EGTdLrmCzoAqYv1zIBxNwi+PsHEeWXwUXGu65/rZk+HCpvWRgshq6/FyJ7/5YeqNgc
         oJ78++4WDokf+78vnlbVaD7wSsvbFbmZIwTN/9ov5kaIwSF6J8LAkgQ0KwzBx0tkc3Xs
         RyklhxZI2vadLRxDzjBSYQ/6Kt6RyDYqOdUqP1bSsvAoh5HJ+UlUuF6SsbCtl0urTiyk
         qjwmcrh4SXDB6/5nnLEjf8Opb6H45X5FtQCWU5ua5qTS9bw1huTlgvhKu72wTLx0Ml/5
         vT1GhnVDXTULjmYXQGV4T1YdZL4cjYvWK5YKIqNAnJON2dBgW2yQY2OjU8HQ/cIjl0SS
         AKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7KKDZjaxaFY9q8eZHotItsTCY8IOulNrOVG8uy+3Fo=;
        b=Z53DFddNd0l090S67t2D+WBzzuIt7RJfaDTSq+AE0YL1cJPj7FM43ARtt49H0q8Mde
         bhjWVCBdDck+w4MHc6WlQK+w7J27l7jMrYRI6HS0fiT3WysVGKbzBFIGOj4kLLqmuOiN
         m5KLzkLDRlOgST3JuqRFz4+djkCp6BnjGFKCHGt1ONx8AFiw/vImp/Db1muQeH7Dlmte
         aHdl3YRMh2MCimDd6CBM9LaoKhGKkQOiw3RVtgJMTis4t6f1i+Z03hIYAzsK03g2f8aH
         bDqgOFKBUaKtlSuq1k9q5DUrWlSnAmBU6Hv5bbCMduvRK/qaae1XEWYEs7gGvTiIg648
         3bAg==
X-Gm-Message-State: AOAM533uMYfgCiq9JBODcA8Z4UVUURQSMXcNMV5U2dAvM0KDul6pdVsr
        jqrzfTU8EH/Gk84lsuhC7lCfSg==
X-Google-Smtp-Source: ABdhPJyuQ8pkOyYLjTVBlJattH2XNOprO7ERpFDZWiH/wF/JJdY8W/IeAMqeNYxK9A0bzT/6i1SZUw==
X-Received: by 2002:aed:204d:: with SMTP id 71mr20576189qta.318.1612888414028;
        Tue, 09 Feb 2021 08:33:34 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q25sm19273355qkc.23.2021.02.09.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:33 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 5/8] cgroup: rstat: punt root-level optimization to individual controllers
Date:   Tue,  9 Feb 2021 11:33:01 -0500
Message-Id: <20210209163304.77088-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current users of the rstat code can source root-level statistics from
the native counters of their respective subsystem, allowing them to
forego aggregation at the root level. This optimization is currently
implemented inside the generic rstat code, which doesn't track the
root cgroup and doesn't invoke the subsystem flush callbacks on it.

However, the memory controller cannot do this optimization, because
cgroup1 breaks out memory specifically for the local level, including
at the root level. In preparation for the memory controller switching
to rstat, move the optimization from rstat core to the controllers.

Afterwards, rstat will always track the root cgroup for changes and
invoke the subsystem callbacks on it; and it's up to the subsystem to
special-case and skip aggregation of the root cgroup if it can source
this information through other, cheaper means.

This is the case for the io controller and the cgroup base stats. In
their respective flush callbacks, check whether the parent is the root
cgroup, and if so, skip the unnecessary upward propagation.

The extra cost of tracking the root cgroup is negligible: on stat
changes, we actually remove a branch that checks for the root. The
queueing for a flush touches only per-cpu data, and only the first
stat change since a flush requires a (per-cpu) lock.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c    | 17 +++++++-----
 kernel/cgroup/rstat.c | 61 +++++++++++++++++++++++++------------------
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a317c03d40f6..582d2f18717e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -764,6 +764,10 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct blkcg_gq *blkg;
 
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (!cgroup_parent(css->cgroup))
+		return;
+
 	rcu_read_lock();
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -786,8 +790,8 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		blkg_iostat_add(&bisc->last, &delta);
 		u64_stats_update_end(&blkg->iostat.sync);
 
-		/* propagate global delta to parent */
-		if (parent) {
+		/* propagate global delta to parent (unless that's root) */
+		if (parent && parent->parent) {
 			u64_stats_update_begin(&parent->iostat.sync);
 			blkg_iostat_set(&delta, &blkg->iostat.cur);
 			blkg_iostat_sub(&delta, &blkg->iostat.last);
@@ -801,10 +805,11 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 }
 
 /*
- * The rstat algorithms intentionally don't handle the root cgroup to avoid
- * incurring overhead when no cgroups are defined. For that reason,
- * cgroup_rstat_flush in blkcg_print_stat does not actually fill out the
- * iostat in the root cgroup's blkcg_gq.
+ * We source root cgroup stats from the system-wide stats to avoid
+ * tracking the same information twice and incurring overhead when no
+ * cgroups are defined. For that reason, cgroup_rstat_flush in
+ * blkcg_print_stat does not actually fill out the iostat in the root
+ * cgroup's blkcg_gq.
  *
  * However, we would like to re-use the printing code between the root and
  * non-root cgroups to the extent possible. For that reason, we simulate
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index faa767a870ba..3a3fd2993a65 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -25,13 +25,8 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup *parent;
 	unsigned long flags;
 
-	/* nothing to do for root */
-	if (!cgroup_parent(cgrp))
-		return;
-
 	/*
 	 * Speculative already-on-list test. This may race leading to
 	 * temporary inaccuracies, which is fine.
@@ -46,10 +41,10 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	raw_spin_lock_irqsave(cpu_lock, flags);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
-	for (parent = cgroup_parent(cgrp); parent;
-	     cgrp = parent, parent = cgroup_parent(cgrp)) {
+	while (true) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
+		struct cgroup *parent = cgroup_parent(cgrp);
+		struct cgroup_rstat_cpu *prstatc;
 
 		/*
 		 * Both additions and removals are bottom-up.  If a cgroup
@@ -58,8 +53,17 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 		if (rstatc->updated_next)
 			break;
 
+		/* Root has no parent to link it to, but mark it busy */
+		if (!parent) {
+			rstatc->updated_next = cgrp;
+			break;
+		}
+
+		prstatc = cgroup_rstat_cpu(parent, cpu);
 		rstatc->updated_next = prstatc->updated_children;
 		prstatc->updated_children = cgrp;
+
+		cgrp = parent;
 	}
 
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
@@ -113,23 +117,26 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	 */
 	if (rstatc->updated_next) {
 		struct cgroup *parent = cgroup_parent(pos);
-		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
-		struct cgroup_rstat_cpu *nrstatc;
-		struct cgroup **nextp;
-
-		nextp = &prstatc->updated_children;
-		while (true) {
-			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
-			if (*nextp == pos)
-				break;
-
-			WARN_ON_ONCE(*nextp == parent);
-			nextp = &nrstatc->updated_next;
+
+		if (parent) {
+			struct cgroup_rstat_cpu *prstatc;
+			struct cgroup **nextp;
+
+			prstatc = cgroup_rstat_cpu(parent, cpu);
+			nextp = &prstatc->updated_children;
+			while (true) {
+				struct cgroup_rstat_cpu *nrstatc;
+
+				nrstatc = cgroup_rstat_cpu(*nextp, cpu);
+				if (*nextp == pos)
+					break;
+				WARN_ON_ONCE(*nextp == parent);
+				nextp = &nrstatc->updated_next;
+			}
+			*nextp = rstatc->updated_next;
 		}
 
-		*nextp = rstatc->updated_next;
 		rstatc->updated_next = NULL;
-
 		return pos;
 	}
 
@@ -309,11 +316,15 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_base_stat cur, delta;
 	unsigned seq;
 
+	/* Root-level stats are sourced from system-wide CPU stats */
+	if (!parent)
+		return;
+
 	/* fetch the current per-cpu values */
 	do {
 		seq = __u64_stats_fetch_begin(&rstatc->bsync);
@@ -326,8 +337,8 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
 	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
 
-	/* propagate global delta to parent */
-	if (parent) {
+	/* propagate global delta to parent (unless that's root) */
+	if (cgroup_parent(parent)) {
 		delta = cgrp->bstat;
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
 		cgroup_base_stat_add(&parent->bstat, &delta);
-- 
2.30.0

