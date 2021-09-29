Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7348541C29C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbhI2KWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:22:08 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34200 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245345AbhI2KWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:22:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uq1.Yfp_1632910824;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uq1.Yfp_1632910824)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 18:20:25 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hugetlb_cgroup: Add interfaces to move hugetlb charge at task migration
Date:   Wed, 29 Sep 2021 18:19:27 +0800
Message-Id: <c25b1c26a2aa8b1434b39ad736a2a2f9c14719b6.1632843268.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now in the hugetlb cgroup, charges associated with a task aren't moved
to the new hugetlb cgroup at task migration, which is not reasonable.
Thus this patch set adds some interfaces for charging to the new hugetlb
cgroup and uncharging from the old hugetlb cgroup at task migration.

This patch adds can_attach() and cancel_attach() to check if we can
charge to the new hugetlb cgroup.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb_cgroup.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 5383023..2568d0c 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -19,6 +19,7 @@
 
 #include <linux/cgroup.h>
 #include <linux/page_counter.h>
+#include <linux/pagewalk.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
@@ -32,6 +33,14 @@
 
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
 
+static struct hugetlb_move_charge {
+	struct mm_struct *mm;
+	struct hugetlb_cgroup *from;
+	struct hugetlb_cgroup *to;
+	unsigned long precharge[HUGE_MAX_HSTATE];
+	unsigned long moved_charge[HUGE_MAX_HSTATE];
+} hmc;
+
 static inline struct page_counter *
 __hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
 				     bool rsvd)
@@ -151,6 +160,157 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(h_cgroup);
 }
 
+static int hugetlb_cgroup_precharge_pte_range(pte_t *pte, unsigned long hmask,
+					      unsigned long addr,
+					      unsigned long end,
+					      struct mm_walk *walk)
+{
+	struct page *page;
+	spinlock_t *ptl;
+	pte_t entry;
+	struct hstate *h = hstate_vma(walk->vma);
+
+	ptl = huge_pte_lock(h, walk->mm, pte);
+	entry = huge_ptep_get(pte);
+	/* TODO: only handle present hugetlb pages now. */
+	if (!pte_present(entry)) {
+		spin_unlock(ptl);
+		return 0;
+	}
+
+	page = pte_page(entry);
+	spin_unlock(ptl);
+
+	spin_lock_irq(&hugetlb_lock);
+	if (hugetlb_cgroup_from_page(page) == hmc.from) {
+		int idx = hstate_index(h);
+
+		hmc.precharge[idx]++;
+	}
+	spin_unlock_irq(&hugetlb_lock);
+
+	cond_resched();
+	return 0;
+}
+
+static const struct mm_walk_ops hugetlb_precharge_walk_ops = {
+	.hugetlb_entry	= hugetlb_cgroup_precharge_pte_range,
+};
+
+static int hugetlb_cgroup_precharge(struct mm_struct *mm)
+{
+	struct page_counter *counter;
+	unsigned long precharge;
+	int idx;
+
+	mmap_read_lock(mm);
+	walk_page_range(mm, 0, mm->highest_vm_end, &hugetlb_precharge_walk_ops, NULL);
+	mmap_read_unlock(mm);
+
+	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
+		if (!hmc.precharge[idx])
+			continue;
+
+		precharge = hmc.precharge[idx];
+		hmc.precharge[idx] = 0;
+
+		if (!page_counter_try_charge(
+			__hugetlb_cgroup_counter_from_cgroup(hmc.to, idx, false),
+			precharge * pages_per_huge_page(&hstates[idx]), &counter))
+			return -ENOMEM;
+
+		hmc.precharge[idx] = precharge;
+	}
+
+	return 0;
+}
+
+static void hugetlb_cgroup_clear(void)
+{
+	struct mm_struct *mm = hmc.mm;
+	struct hugetlb_cgroup *to = hmc.to;
+	int idx;
+
+	/* we must uncharge all the leftover precharges from hmc.to */
+	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
+		if (!hmc.precharge[idx])
+			continue;
+
+		page_counter_uncharge(
+			__hugetlb_cgroup_counter_from_cgroup(to, idx, false),
+			hmc.precharge[idx] * pages_per_huge_page(&hstates[idx]));
+		hmc.precharge[idx] = 0;
+	}
+
+	hmc.from = NULL;
+	hmc.to = NULL;
+	hmc.mm = NULL;
+
+	mmput(mm);
+}
+
+static int hugetlb_cgroup_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *leader, *p;
+	struct hugetlb_cgroup *h_cgroup, *from_hcg;
+	struct mm_struct *mm;
+	int ret = 0, idx;
+
+	if (hugetlb_cgroup_disabled())
+		return 0;
+
+	/*
+	 * Multi-process migrations only happen on the default hierarchy
+	 * where charge immigration is not used.  Perform charge
+	 * immigration if @tset contains a leader and whine if there are
+	 * multiple.
+	 */
+	p = NULL;
+	cgroup_taskset_for_each_leader(leader, css, tset) {
+		WARN_ON_ONCE(p);
+		p = leader;
+		h_cgroup = hugetlb_cgroup_from_css(css);
+	}
+	if (!p)
+		return 0;
+
+	from_hcg = hugetlb_cgroup_from_task(p);
+	VM_BUG_ON(from_hcg == h_cgroup);
+
+	mm = get_task_mm(p);
+	if (!mm)
+		return 0;
+
+	VM_BUG_ON(hmc.from);
+	VM_BUG_ON(hmc.to);
+	VM_BUG_ON(hmc.mm);
+
+	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
+		VM_BUG_ON(hmc.precharge[idx]);
+		VM_BUG_ON(hmc.moved_charge[idx]);
+	}
+
+	hmc.mm = mm;
+	hmc.from = from_hcg;
+	hmc.to = h_cgroup;
+
+	ret = hugetlb_cgroup_precharge(mm);
+	if (ret)
+		hugetlb_cgroup_clear();
+
+	return ret;
+}
+
+static void hugetlb_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	if (hugetlb_cgroup_disabled())
+		return;
+
+	if (hmc.to)
+		hugetlb_cgroup_clear();
+}
+
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -806,6 +966,8 @@ struct cgroup_subsys hugetlb_cgrp_subsys = {
 	.css_alloc	= hugetlb_cgroup_css_alloc,
 	.css_offline	= hugetlb_cgroup_css_offline,
 	.css_free	= hugetlb_cgroup_css_free,
+	.can_attach	= hugetlb_cgroup_can_attach,
+	.cancel_attach	= hugetlb_cgroup_cancel_attach,
 	.dfl_cftypes	= hugetlb_files,
 	.legacy_cftypes	= hugetlb_files,
 };
-- 
1.8.3.1

