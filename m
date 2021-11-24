Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B045CC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhKXTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhKXTBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:01:48 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43926C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:38 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a2so3676189qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GHpOrDBD++sc93tc/L8OmRqfKlAP1K5vxxUZb1iqnA=;
        b=DYs9xHaSUVtbhWufOqdFQc2hJtEwF7MWTI2iWcHdqq7jTbuUv7ItFeN1C06bLYAcxJ
         uHxAS4p3d7DabXSa2RhqpUYEu9Kc7S72Ryi9rS2lSd/lTH8XEB1qwQZUrrsvtv/0BN1m
         tW39zebzEOR39jb2wmu9RoT4CjbCnwGMTh81odz8JkKqbY4UK3OPDP4r6qB7S8mtqGvv
         KwYBpKU4B5uWTMNVZNwB0vHnZt2Ypn04kLkbj/IXCsEoczSPUiJ9FGu68q4rIES3Dz2T
         PkRQ4hy1fU+sU1Xk5FxOLfIUEuOhxLFb5yAqmm+CHa7TTopLfouNeXF/e+2VP+Fg0hdk
         hn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GHpOrDBD++sc93tc/L8OmRqfKlAP1K5vxxUZb1iqnA=;
        b=sS9cWHNteKSuONzR1makNcNyLfJ/9oq9FSpMpjaFHui2ZN8WSvHdXPxdJ9AEvv/c+k
         3nLmjkB+mVO6JdFWlAde2LsIg5fUok7RpaOlK0Zwe/vHB0JrT/DotQK4ARXnr1B2kcdz
         NtSGLw7mbLAKlDbinkawLVK7cDuv/TcicaKLaS3rO150+wPgafvRanPWyr+e2FgkM0OE
         YqCDPh66+UIcXx3RIdu3mNxV3sD0n3AsUs/ESN1/HEhUlV6lTLdWSgRAsaCYPsbMwU/+
         OLoq7ihgVzuf1jptbLo/yg8VoJnuSq10dLG8osAAgx2ihlQ+elKrO8fDmPM4Sw7JVz7F
         xDqQ==
X-Gm-Message-State: AOAM532uXtOui7/p90EVrqIAlZ8NKpRhDJgAldh9gpWrAybPyaS3Z/Fs
        mfly+q+YPfs9/9KXlEFnkMQ=
X-Google-Smtp-Source: ABdhPJz3W3gFe4xpNelJ32yWZ0+f7CZx17yr1W/V5NZAW7nSVzj53PMwsCOYGHgHorF7jQecmBQJ8w==
X-Received: by 2002:a05:622a:30e:: with SMTP id q14mr10311012qtw.71.1637780317332;
        Wed, 24 Nov 2021 10:58:37 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:a1b0])
        by smtp.gmail.com with ESMTPSA id r16sm315775qkp.42.2021.11.24.10.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:58:36 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     dave.hansen@linux.intel.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Promotion and demotion related statistics
Date:   Wed, 24 Nov 2021 13:58:26 -0500
Message-Id: <e3db05f4bd7dd9363c2a895875505088d3273bb8.1637778851.git.hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1637778851.git.hasanalmaruf@fb.com>
References: <cover.1637778851.git.hasanalmaruf@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Promotion and demotion related statistics can help better understand
the effectiveness of the page placement mechanism. we want to know
among the promoted/demoted pages what is the distribution of anon and
file pages. how much of the demoted pages become promotion candidate
can give us insight on whether the page placement mechanism is thrashing
among the NUMA nodes. we can also use this information to rate limit the
migration across the NUMA nodes.

Promotion can fail for many reasons, e.g., target node having low memory,
page refcount being abnormal, whole system being low on memory etc. Adding
counters to track the failure reasons will give the detailed info about
why and where it fails, and help debugging the system.

To track the demoted pages, PG_demoted bit is introduced for pages that
get demoted. Upon demotion, PG_demoted bit is set in thepage flag. upon
promotion, the bit gets reset for that page.

promotion related statistics:
=============================
pgpromote_candidate - candidates that get selected for promotion
pgpromote_candidate_demoted - promotion candidate that got demoted earlier
pgpromote_candidate_anon - promotion candidate that are anon
pgpromote_candidate_file - promotion candidate that are file
pgpromote_tried - pages that had a try to migrate via NUMA Balancing
pgpromote_file- successfully promoted file pages
pgpromote_anon - successfully promoted anon pages

promotion failure related statistics:
=====================================
pgmigrate_fail_dst_node_full - failed as the target node is full
pgmigrate_fail_numa_isolate - failed in isolating numa page
pgmigrate_fail_nomem - failed as no memory left in the system
pgmigrate_fail_refcount - failed as ref count mismatched

demotion related statistics:
============================
pgdemote_file - successfully demoted file pages
pgdemote_anon - successfully demoted anon pages

Signed-off-by: Hasan Al Maruf <hasanalmaruf@fb.com>
---
 include/linux/mempolicy.h            |  4 +-
 include/linux/page-flags.h           |  9 ++++
 include/linux/page_ext.h             |  3 ++
 include/linux/sched/numa_balancing.h | 63 +++++++++++++++++++++++++++-
 include/linux/vm_event_item.h        | 13 ++++++
 include/trace/events/mmflags.h       | 10 ++++-
 kernel/sched/fair.c                  | 12 +++++-
 kernel/sched/sched.h                 |  1 +
 mm/huge_memory.c                     |  2 +-
 mm/memory.c                          |  2 +-
 mm/mempolicy.c                       |  7 +++-
 mm/migrate.c                         | 48 ++++++++++++++++-----
 mm/vmscan.c                          |  8 ++++
 mm/vmstat.c                          | 13 ++++++
 14 files changed, 174 insertions(+), 21 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 78a736e76d5c..c7637cfa1be2 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -184,7 +184,7 @@ extern void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
 /* Check if a vma is migratable */
 extern bool vma_migratable(struct vm_area_struct *vma);
 
-extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
+extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long, int);
 extern void mpol_put_task_policy(struct task_struct *);
 
 extern bool numa_demotion_enabled;
@@ -284,7 +284,7 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 #endif
 
 static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
-				 unsigned long address)
+				 unsigned long address, int flags)
 {
 	return -1; /* no node preference */
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..8babc550d178 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -137,6 +137,9 @@ enum pageflags {
 #endif
 #ifdef CONFIG_64BIT
 	PG_arch_2,
+#ifdef CONFIG_NUMA_BALANCING
+	PG_demoted,
+#endif
 #endif
 	__NR_PAGEFLAGS,
 
@@ -443,6 +446,12 @@ TESTCLEARFLAG(Young, young, PF_ANY)
 PAGEFLAG(Idle, idle, PF_ANY)
 #endif
 
+#if defined(CONFIG_NUMA_BALANCING) && defined(CONFIG_64BIT)
+TESTPAGEFLAG(Demoted, demoted, PF_NO_TAIL)
+SETPAGEFLAG(Demoted, demoted, PF_NO_TAIL)
+TESTCLEARFLAG(Demoted, demoted, PF_NO_TAIL)
+#endif
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index aff81ba31bd8..1a1e632031d3 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -23,6 +23,9 @@ enum page_ext_flags {
 	PAGE_EXT_YOUNG,
 	PAGE_EXT_IDLE,
 #endif
+#if defined(CONFIG_NUMA_BALANCING) && !defined(CONFIG_64BIT)
+	PAGE_EXT_DEMOTED,
+#endif
 };
 
 /*
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..c13ba820c07d 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -8,12 +8,14 @@
  */
 
 #include <linux/sched.h>
+#include <linux/page-flags.h>
 
 #define TNF_MIGRATED	0x01
 #define TNF_NO_GROUP	0x02
 #define TNF_SHARED	0x04
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
+#define TNF_DEMOTED	0x40
 
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
@@ -21,7 +23,53 @@ extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
-					int src_nid, int dst_cpu);
+					int src_nid, int dst_cpu, int flags);
+#ifdef CONFIG_64BIT
+static inline bool page_is_demoted(struct page *page)
+{
+	return PageDemoted(page);
+}
+
+static inline void set_page_demoted(struct page *page)
+{
+	SetPageDemoted(page);
+}
+
+static inline bool test_and_clear_page_demoted(struct page *page)
+{
+	return TestClearPageDemoted(page);
+}
+#else /* !CONFIG_64BIT */
+static inline bool page_is_demoted(struct page *page)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+
+	if (unlikely(!page_ext))
+		return false;
+
+	return test_bit(PAGE_EXT_DEMOTED, &page_ext->flags);
+}
+
+static inline void set_page_demoted(struct page *page)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+
+	if (unlikely(!page_ext))
+		return false;
+
+	return set_bit(PAGE_EXT_DEMOTED, &page_ext->flags);
+}
+
+static inline bool test_and_clear_page_demoted(struct page *page)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+
+	if (unlikely(!page_ext))
+		return false;
+
+	return test_and_clear_bit(PAGE_EXT_DEMOTED, &page_ext->flags);
+}
+#endif /* !CONFIG_64BIT */
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -38,10 +86,21 @@ static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
-				struct page *page, int src_nid, int dst_cpu)
+				struct page *page, int src_nid, int dst_cpu, int flags)
 {
 	return true;
 }
+static inline bool page_is_demoted(struct page *page)
+{
+	return false;
+}
+static inline void set_page_demoted(struct page *page)
+{
+}
+static inline bool test_and_clear_page_demoted(struct page *page)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_SCHED_NUMA_BALANCING_H */
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index b136ed6224a2..9cb43a2998cb 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -35,6 +35,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		PGSTEAL_DIRECT,
 		PGDEMOTE_KSWAPD,
 		PGDEMOTE_DIRECT,
+		PGDEMOTE_FILE,
+		PGDEMOTE_ANON,
 		PGSCAN_KSWAPD,
 		PGSCAN_DIRECT,
 		PGSCAN_DIRECT_THROTTLE,
@@ -56,9 +58,20 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
+		PGPROMOTE_CANDIDATE,		/* candidates get selected for promotion */
+		PGPROMOTE_CANDIDATE_DEMOTED,/* promotion candidate that got demoted earlier */
+		PGPROMOTE_CANDIDATE_ANON,	/* promotion candidate that are anon */
+		PGPROMOTE_CANDIDATE_FILE,	/* promotion candidate that are file */
+		PGPROMOTE_TRIED,			/* tried to migrate via NUMA balancing */
+		PGPROMOTE_FILE,				/* successfully promoted file pages  */
+		PGPROMOTE_ANON,				/* successfully promoted anon pages  */
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
+		PGMIGRATE_DST_NODE_FULL_FAIL,	/* failed as the target node is full */
+		PGMIGRATE_NUMA_ISOLATE_FAIL,	/* failed in isolating numa page */
+		PGMIGRATE_NOMEM_FAIL,			/* failed as no memory left */
+		PGMIGRATE_REFCOUNT_FAIL,		/* failed in ref count */
 		THP_MIGRATION_SUCCESS,
 		THP_MIGRATION_FAIL,
 		THP_MIGRATION_SPLIT,
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 67018d367b9f..7ba2c2702ef7 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -85,6 +85,13 @@
 #define IF_HAVE_PG_ARCH_2(flag,string)
 #endif
 
+#if defined(CONFIG_NUMA_BALANCING) && defined(CONFIG_64BIT)
+#define IF_HAVE_PG_DEMOTED(flag, string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_DEMOTED(flag, string)
+#endif
+
+
 #define __def_pageflag_names						\
 	{1UL << PG_locked,		"locked"	},		\
 	{1UL << PG_waiters,		"waiters"	},		\
@@ -112,7 +119,8 @@ IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
 IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
-IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
+IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2")	\
+IF_HAVE_PG_DEMOTED(PG_demoted,		"demoted")
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 572f312cc803..210612c9d1e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1416,12 +1416,22 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 }
 
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
-				int src_nid, int dst_cpu)
+				int src_nid, int dst_cpu, int flags)
 {
 	struct numa_group *ng = deref_curr_numa_group(p);
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	count_vm_numa_event(PGPROMOTE_CANDIDATE);
+
+	if (flags & TNF_DEMOTED)
+		count_vm_numa_event(PGPROMOTE_CANDIDATE_DEMOTED);
+
+	if (page_is_file_lru(page))
+		count_vm_numa_event(PGPROMOTE_CANDIDATE_FILE);
+	else
+		count_vm_numa_event(PGPROMOTE_CANDIDATE_ANON);
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eee49ce2d596..6057ad67d223 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -51,6 +51,7 @@
 #include <linux/kthread.h>
 #include <linux/membarrier.h>
 #include <linux/migrate.h>
+#include <linux/mm_inline.h>
 #include <linux/mmu_context.h>
 #include <linux/nmi.h>
 #include <linux/proc_fs.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bc642923e0c9..e9d7b9125c5e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1475,7 +1475,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 * page_table_lock if at all possible
 	 */
 	page_locked = trylock_page(page);
-	target_nid = mpol_misplaced(page, vma, haddr);
+	target_nid = mpol_misplaced(page, vma, haddr, flags);
 	if (target_nid == NUMA_NO_NODE) {
 		/* If the page was locked, there are no parallel migrations */
 		if (page_locked)
diff --git a/mm/memory.c b/mm/memory.c
index c8083f571c89..314fe3b2f462 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4131,7 +4131,7 @@ static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(page, vma, addr);
+	return mpol_misplaced(page, vma, addr, *flags);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index db363a2d3d66..580e76ae58e6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2466,7 +2466,7 @@ static void sp_free(struct sp_node *n)
  * Policy determination "mimics" alloc_page_vma().
  * Called from fault path where we know the vma and faulting address.
  */
-int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
+int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr, int flags)
 {
 	struct mempolicy *pol;
 	struct zoneref *z;
@@ -2477,6 +2477,9 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	int polnid = NUMA_NO_NODE;
 	int ret = -1;
 
+	if (test_and_clear_page_demoted(page))
+		flags |= TNF_DEMOTED;
+
 	pol = get_vma_policy(vma, addr);
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;
@@ -2526,7 +2529,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	if (pol->flags & MPOL_F_MORON) {
 		polnid = thisnid;
 
-		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
+		if (!should_numa_migrate_memory(current, page, curnid, thiscpu, flags))
 			goto out;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index fc7f0148fb3f..cda68581e14d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/ptrace.h>
 #include <linux/oom.h>
 #include <linux/memory.h>
+#include <linux/sched/numa_balancing.h>
 
 #include <asm/tlbflush.h>
 
@@ -264,6 +265,15 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 		} else
 #endif
 		{
+#ifdef CONFIG_NUMA_BALANCING
+			if (page_is_demoted(page) && vma_migratable(vma)) {
+				bool writable = pte_write(pte);
+
+				pte = pte_modify(pte, PAGE_NONE);
+				if (writable)
+					pte = pte_mk_savedwrite(pte);
+			}
+#endif
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 
 			if (PageAnon(new))
@@ -406,6 +416,9 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	int expected_count = expected_page_refs(mapping, page) + extra_count;
 	int nr = thp_nr_pages(page);
 
+	if (page_count(page) != expected_count)
+		count_vm_events(PGMIGRATE_REFCOUNT_FAIL, thp_nr_pages(page));
+
 	if (!mapping) {
 		/* Anonymous page without mapping */
 		if (page_count(page) != expected_count)
@@ -1260,6 +1273,10 @@ static int unmap_and_move(new_page_t get_new_page,
 	if (!newpage)
 		return -ENOMEM;
 
+	/* TODO: check whether Ksm pages can be demoted? */
+	if (reason == MR_DEMOTION && !PageKsm(page))
+		set_page_demoted(newpage);
+
 	rc = __unmap_and_move(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(newpage, reason);
@@ -1590,6 +1607,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					goto out;
 				}
 				nr_failed++;
+				count_vm_events(PGMIGRATE_NOMEM_FAIL, thp_nr_pages(page));
 				goto out;
 			case -EAGAIN:
 				if (is_thp) {
@@ -2141,8 +2159,10 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, compound_nr(page)))
+	if (!migrate_balanced_pgdat(pgdat, compound_nr(page))) {
+		count_vm_events(PGMIGRATE_DST_NODE_FULL_FAIL, thp_nr_pages(page));
 		return 0;
+	}
 
 	if (isolate_lru_page(page))
 		return 0;
@@ -2200,6 +2220,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	bool is_file;
 	LIST_HEAD(migratepages);
 
 	/*
@@ -2209,18 +2230,15 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (is_shared_exec_page(vma, page))
 		goto out;
 
-	/*
-	 * Also do not migrate dirty pages as not all filesystems can move
-	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
-	 */
-	if (page_is_file_lru(page) && PageDirty(page))
-		goto out;
-
 	isolated = numamigrate_isolate_page(pgdat, page);
-	if (!isolated)
+	if (!isolated) {
+		count_vm_events(PGMIGRATE_NUMA_ISOLATE_FAIL, thp_nr_pages(page));
 		goto out;
+	}
 
+	is_file = page_is_file_lru(page);
 	list_add(&page->lru, &migratepages);
+	count_vm_numa_event(PGPROMOTE_TRIED);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
 				     NULL, node, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED, NULL);
@@ -2232,8 +2250,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			putback_lru_page(page);
 		}
 		isolated = 0;
-	} else
+	} else {
 		count_vm_numa_event(NUMA_PAGE_MIGRATE);
+		if (is_file)
+			count_vm_numa_event(PGPROMOTE_FILE);
+		else
+			count_vm_numa_event(PGPROMOTE_ANON);
+	}
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
@@ -2267,13 +2290,16 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
-	if (!new_page)
+	if (!new_page) {
+		count_vm_events(PGMIGRATE_NOMEM_FAIL, HPAGE_PMD_NR);
 		goto out_fail;
+	}
 	prep_transhuge_page(new_page);
 
 	isolated = numamigrate_isolate_page(pgdat, page);
 	if (!isolated) {
 		put_page(new_page);
+		count_vm_events(PGMIGRATE_NUMA_ISOLATE_FAIL, HPAGE_PMD_NR);
 		goto out_fail;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 62ba2835c74a..47c868d2ecfd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1142,6 +1142,7 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
 	int err;
+	bool file_lru;
 
 	if (list_empty(demote_pages))
 		return 0;
@@ -1149,6 +1150,8 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	if (target_nid == NUMA_NO_NODE)
 		return 0;
 
+	file_lru = page_is_file_lru(lru_to_page(demote_pages));
+
 	/* Demotion ignores all cpuset and mempolicy settings */
 	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
 			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
@@ -1159,6 +1162,11 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	else
 		__count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
 
+	if (file_lru)
+		__count_vm_events(PGDEMOTE_FILE, nr_succeeded);
+	else
+		__count_vm_events(PGDEMOTE_ANON, nr_succeeded);
+
 	return nr_succeeded;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90c8c7cbce51..cda2505bb21f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1261,6 +1261,8 @@ const char * const vmstat_text[] = {
 	"pgsteal_direct",
 	"pgdemote_kswapd",
 	"pgdemote_direct",
+	"pgdemote_file",
+	"pgdemote_anon",
 	"pgscan_kswapd",
 	"pgscan_direct",
 	"pgscan_direct_throttle",
@@ -1291,10 +1293,21 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults",
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
+	"pgpromote_candidate",
+	"pgpromote_candidate_demoted",
+	"pgpromote_candidate_anon",
+	"pgpromote_candidate_file",
+	"pgpromote_tried",
+	"pgpromote_file",
+	"pgpromote_anon",
 #endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
 	"pgmigrate_fail",
+	"pgmigrate_fail_dst_node_full",
+	"pgmigrate_fail_numa_isolate",
+	"pgmigrate_fail_nomem",
+	"pgmigrate_fail_refcount",
 	"thp_migration_success",
 	"thp_migration_fail",
 	"thp_migration_split",
-- 
2.30.2

