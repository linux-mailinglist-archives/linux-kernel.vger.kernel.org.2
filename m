Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491C245CC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbhKXTB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhKXTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:01:49 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E22C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:39 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l8so3704748qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJgPRgekSlvs885MNHC+5vq6TTVnni6tQ47GqPwt7rg=;
        b=MvRBGkIQBQAk0E7xGqOI5gYq6jBORKhrthwKkCbSgJAz4nGyJiaNGZ9Mtc6UaDcerB
         Evff3YgwsZJQmALZSPRPk7KYRo9ix+upCvBTPWj+YniORrUC3Fciabhdlx0Pw35yrFlT
         nc+IF0wiCz3mGuMVJJjfff0eIRF4fUM0NytTxIsIMaiYC6pV67T2rQ5fRZGxLqiBMdZe
         wJv50yvJj5xdsvbVlSt9o+jlR8Bb0m30iV/f5+GoF9U8MM8weiViLkUCLQJPUcptRp/f
         7sxnUVlQnZks8CpMTF3D6YVBpJwQ4a6Cfhiz+8FEFPCicyslwKhlsxDy0haeR1nmSUr2
         hRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJgPRgekSlvs885MNHC+5vq6TTVnni6tQ47GqPwt7rg=;
        b=QQxMxdL0XggNTfxrw30km2O9abkT/cCw4NtnHp40rj8SnDcFhzaj+jOug3qlkCSO1W
         FT8hDZ59TP8dtW3LfzOHHEn1JCc8q4tvZF9+lN9AXj/6CoCYn2YnbkxdOT6Mv22ChCk7
         +5Qo7b8XmfpCg4TEpXhApr1Xt/3RXBbJ/KfEx2DYcIo79RhFwHEOD2zgbeWHICJzPMme
         VIwmRg4iPUqThV7yRqqqCkeyACRFX/6jZh1BJ87SQx5K2VzRcHTpi0u3WyXVsAJoFrg5
         hCV6Miv9fTltCx6lAALz8ruogxZcMzHwF7tykp9ryETGGm7PqxhTZg/9sH6UDsn2xxEZ
         ViNQ==
X-Gm-Message-State: AOAM532p4iCWma0MWTxi0yDxJ/fqZ4BN+6DU1jtkh6OSAsfABL/AY3NS
        mISUiaG3AneC5Ts8Qnrf/BQ=
X-Google-Smtp-Source: ABdhPJyBHAfCScYWsB5ed0Scn3PNhF3ifCh2b+2ctuePXtPnNP1fg4oc+lKSTW6lVUbrPP5Dq3dPwA==
X-Received: by 2002:a05:622a:188:: with SMTP id s8mr10130369qtw.347.1637780318711;
        Wed, 24 Nov 2021 10:58:38 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:a1b0])
        by smtp.gmail.com with ESMTPSA id r16sm315775qkp.42.2021.11.24.10.58.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:58:38 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     dave.hansen@linux.intel.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] NUMA balancing for tiered-memory system
Date:   Wed, 24 Nov 2021 13:58:27 -0500
Message-Id: <06f961992a2c119ed0904825d8ab3f2b2a2c682b.1637778851.git.hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1637778851.git.hasanalmaruf@fb.com>
References: <cover.1637778851.git.hasanalmaruf@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of new memory types and technologies, a server may have
different types of memory, e.g. DRAM, PMEM, CXL-enabled memory, etc. As
different types of memory usually have different level of performance
impact, such a system can be called as a tiered-memory system.

In a tiered-memory system, NUMA memory nodes can be CPU-less nodes. For
such a system, memory with CPU are considered as the toptier node while
memory without CPU are non-toptier nodes.

In default NUMA Balancing, NUMA hint faults are generate on both toptier
and non-toptier nodes. However, in a tiered-memory system, hot memories in
toptier memory nodes may not need to be migrated around. In such cases,
it's unnecessary to scan the pages in the toptier memory nodes. We disable
unnecessary scannings in the toptier nodes for a tiered-memory system.

To support NUMA balancing for a tiered-memory system, the existing sysctl
user-space interface for enabling numa_balancing is extended in a backward
compatible way, so that users can enable/disable these functionalities
individually. The sysctl is converted from a Boolean value to a bits field.
Current definition for '/proc/sys/kernel/numa_balancing' is as follow:

- 0x0: NUMA_BALANCING_DISABLED
- 0x1: NUMA_BALANCING_NORMAL
- 0x2: NUMA_BALANCING_TIERED_MEMORY

If a system has single toptier node online, default NUMA balancing will
automatically be downgraded to the tiered-memory mode to avoid the
unnecessary scanning in the toptier node mentioned above.

Signed-off-by: Hasan Al Maruf <hasanalmaruf@fb.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 18 +++++++++++
 include/linux/mempolicy.h                   |  2 ++
 include/linux/node.h                        |  7 ++++
 include/linux/sched/sysctl.h                |  6 ++++
 kernel/sched/core.c                         | 36 +++++++++++++++++----
 kernel/sched/fair.c                         | 10 +++++-
 kernel/sched/sched.h                        |  1 +
 kernel/sysctl.c                             |  7 ++--
 mm/huge_memory.c                            | 27 ++++++++++------
 mm/mprotect.c                               |  8 ++++-
 10 files changed, 101 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 24ab20d7a50a..1abab69dd5b6 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -608,6 +608,24 @@ numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
 numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
 
 
+By default, NUMA hinting faults are generate on both toptier and non-toptier
+nodes. However, in a tiered-memory system, hot memories in toptier memory nodes
+may not need to be migrated around. In such cases, it's unnecessary to scan the
+pages in the toptier memory nodes. For a tiered-memory system, unnecessary scannings
+and hinting faults in the toptier nodes are disabled.
+
+This interface takes bits field as input. Supported values and corresponding modes are
+as follow:
+
+- 0x0: NUMA_BALANCING_DISABLED
+- 0x1: NUMA_BALANCING_NORMAL
+- 0x2: NUMA_BALANCING_TIERED_MEMORY
+
+If a system has single toptier node online, then default NUMA balancing will
+automatically be downgraded to the tiered-memory mode to avoid the unnecessary scanning
+and hinting faults.
+
+
 numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms, numa_balancing_scan_size_mb
 ===============================================================================================================================
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index c7637cfa1be2..ab57b6a82e0a 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -188,6 +188,7 @@ extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long,
 extern void mpol_put_task_policy(struct task_struct *);
 
 extern bool numa_demotion_enabled;
+extern bool numa_promotion_tiered_enabled;
 
 #else
 
@@ -299,5 +300,6 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 }
 
 #define numa_demotion_enabled	false
+#define numa_promotion_tiered_enabled	false
 #endif /* CONFIG_NUMA */
 #endif
diff --git a/include/linux/node.h b/include/linux/node.h
index 8e5a29897936..9a69b31cae74 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -181,4 +181,11 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
 
 #define to_node(device) container_of(device, struct node, dev)
 
+static inline bool node_is_toptier(int node)
+{
+	// ideally, toptier nodes should be the memory with CPU.
+	// for now, just assume node0 is the toptier memory
+	// return node_state(node, N_CPU);
+	return (node == 0);
+}
 #endif /* _LINUX_NODE_H_ */
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba88aca5..249e00c42246 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -39,6 +39,12 @@ enum sched_tunable_scaling {
 };
 extern enum sched_tunable_scaling sysctl_sched_tunable_scaling;
 
+#define NUMA_BALANCING_DISABLED			0x0
+#define NUMA_BALANCING_NORMAL			0x1
+#define NUMA_BALANCING_TIERED_MEMORY	0x2
+
+extern int sysctl_numa_balancing_mode;
+
 extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 790c573f7ed4..3d65e601b973 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3596,9 +3596,29 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
+int sysctl_numa_balancing_mode;
+bool numa_promotion_tiered_enabled;
 
 #ifdef CONFIG_NUMA_BALANCING
 
+/*
+ * If there is only one toptier node available, pages on that
+ * node can not be promotrd to anywhere. In that case, downgrade
+ * to numa_promotion_tiered_enabled mode
+ */
+static void check_numa_promotion_mode(void)
+{
+	int node, toptier_node_count = 0;
+
+	for_each_online_node(node) {
+		if (node_is_toptier(node))
+			++toptier_node_count;
+	}
+	if (toptier_node_count == 1) {
+		numa_promotion_tiered_enabled = true;
+	}
+}
+
 void set_numabalancing_state(bool enabled)
 {
 	if (enabled)
@@ -3611,20 +3631,22 @@ void set_numabalancing_state(bool enabled)
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table t;
 	int err;
-	int state = static_branch_likely(&sched_numa_balancing);
 
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	t = *table;
-	t.data = &state;
-	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (err < 0)
 		return err;
-	if (write)
-		set_numabalancing_state(state);
+	if (write) {
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL)
+			check_numa_promotion_mode();
+		else if (sysctl_numa_balancing_mode & NUMA_BALANCING_TIERED_MEMORY)
+			numa_promotion_tiered_enabled = true;
+
+		set_numabalancing_state(*(int *)table->data);
+	}
 	return err;
 }
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 210612c9d1e9..45e39832a2b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1424,7 +1424,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 
 	count_vm_numa_event(PGPROMOTE_CANDIDATE);
 
-	if (flags & TNF_DEMOTED)
+	if (numa_demotion_enabled && (flags & TNF_DEMOTED))
 		count_vm_numa_event(PGPROMOTE_CANDIDATE_DEMOTED);
 
 	if (page_is_file_lru(page))
@@ -1435,6 +1435,14 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
+	/*
+	 * The pages in non-toptier memory node should be migrated
+	 * according to hot/cold instead of accessing CPU node.
+	 */
+	if (numa_promotion_tiered_enabled && !node_is_toptier(src_nid))
+		return true;
+
+
 	/*
 	 * Allow first faults or private faults to migrate immediately early in
 	 * the lifetime of a task. The magic number 4 is based on waiting for
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6057ad67d223..379f3b6f1a3f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -51,6 +51,7 @@
 #include <linux/kthread.h>
 #include <linux/membarrier.h>
 #include <linux/migrate.h>
+#include <linux/mempolicy.h>
 #include <linux/mm_inline.h>
 #include <linux/mmu_context.h>
 #include <linux/nmi.h>
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6b6653529d92..751b52062eb4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -113,6 +113,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
+static int __maybe_unused three = 3;
 static int __maybe_unused four = 4;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -1840,12 +1841,12 @@ static struct ctl_table kern_table[] = {
 	},
 	{
 		.procname	= "numa_balancing",
-		.data		= NULL, /* filled in by handler */
-		.maxlen		= sizeof(unsigned int),
+		.data		= &sysctl_numa_balancing_mode,
+		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &three,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_SCHED_DEBUG */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e9d7b9125c5e..b76a0990c5f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -22,6 +22,7 @@
 #include <linux/freezer.h>
 #include <linux/pfn_t.h>
 #include <linux/mman.h>
+#include <linux/mempolicy.h>
 #include <linux/memremap.h>
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
@@ -1849,16 +1850,24 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 #endif
 
-	/*
-	 * Avoid trapping faults against the zero page. The read-only
-	 * data is likely to be read-cached on the local CPU and
-	 * local/remote hits to the zero page are not interesting.
-	 */
-	if (prot_numa && is_huge_zero_pmd(*pmd))
-		goto unlock;
+	if (prot_numa) {
+		struct page *page;
+		/*
+		 * Avoid trapping faults against the zero page. The read-only
+		 * data is likely to be read-cached on the local CPU and
+		 * local/remote hits to the zero page are not interesting.
+		 */
+		if (is_huge_zero_pmd(*pmd))
+			goto unlock;
 
-	if (prot_numa && pmd_protnone(*pmd))
-		goto unlock;
+		if (pmd_protnone(*pmd))
+			goto unlock;
+
+		/* skip scanning toptier node */
+		page = pmd_page(*pmd);
+		if (numa_promotion_tiered_enabled && node_is_toptier(page_to_nid(page)))
+			goto unlock;
+	}
 
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 94188df1ee55..3171f435925b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -83,6 +83,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			 */
 			if (prot_numa) {
 				struct page *page;
+				int nid;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -109,7 +110,12 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */
-				if (target_node == page_to_nid(page))
+				nid = page_to_nid(page);
+				if (target_node == nid)
+					continue;
+
+				/* skip scanning toptier node */
+				if (numa_promotion_tiered_enabled && node_is_toptier(nid))
 					continue;
 			}
 
-- 
2.30.2

