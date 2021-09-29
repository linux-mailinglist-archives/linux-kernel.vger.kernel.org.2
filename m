Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3D941C29D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbhI2KWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:22:10 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57857 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245388AbhI2KWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:22:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uq1.Yg-_1632910825;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uq1.Yg-_1632910825)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 18:20:25 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hugetlb_cgroup: Add post_attach interface for tasks migration
Date:   Wed, 29 Sep 2021 18:19:28 +0800
Message-Id: <5c9b016a8fced386e85a2198c62314aa3c344101.1632843268.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add post_attach interface to change the page's hugetlb cgroup
and uncharge the old hugetlb cgroup when tasks migration finished.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb_cgroup.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 2568d0c..bd53d04 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -229,6 +229,7 @@ static void hugetlb_cgroup_clear(void)
 {
 	struct mm_struct *mm = hmc.mm;
 	struct hugetlb_cgroup *to = hmc.to;
+	struct hugetlb_cgroup *from = hmc.from;
 	int idx;
 
 	/* we must uncharge all the leftover precharges from hmc.to */
@@ -242,6 +243,17 @@ static void hugetlb_cgroup_clear(void)
 		hmc.precharge[idx] = 0;
 	}
 
+	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
+		if (!hmc.moved_charge[idx])
+			continue;
+
+		page_counter_uncharge(
+			__hugetlb_cgroup_counter_from_cgroup(from, idx, false),
+			hmc.moved_charge[idx] * pages_per_huge_page(&hstates[idx]));
+
+		hmc.moved_charge[idx] = 0;
+	}
+
 	hmc.from = NULL;
 	hmc.to = NULL;
 	hmc.mm = NULL;
@@ -311,6 +323,61 @@ static void hugetlb_cgroup_cancel_attach(struct cgroup_taskset *tset)
 		hugetlb_cgroup_clear();
 }
 
+static int hugetlb_cgroup_move_charge_pte_range(pte_t *pte, unsigned long hmask,
+						unsigned long addr,
+						unsigned long end,
+						struct mm_walk *walk)
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
+		set_hugetlb_cgroup(page, hmc.to);
+		hmc.precharge[idx]--;
+		hmc.moved_charge[idx]++;
+	}
+	spin_unlock_irq(&hugetlb_lock);
+
+	cond_resched();
+	return 0;
+}
+
+static const struct mm_walk_ops hugetlb_charge_walk_ops = {
+	.hugetlb_entry  = hugetlb_cgroup_move_charge_pte_range,
+};
+
+static void hugetlb_cgroup_move_task(void)
+{
+	if (hugetlb_cgroup_disabled())
+		return;
+
+	if (!hmc.to)
+		return;
+
+	mmap_read_lock(hmc.mm);
+	walk_page_range(hmc.mm, 0, hmc.mm->highest_vm_end,
+			 &hugetlb_charge_walk_ops, NULL);
+	mmap_read_unlock(hmc.mm);
+
+	hugetlb_cgroup_clear();
+}
+
 /*
  * Should be called with hugetlb_lock held.
  * Since we are holding hugetlb_lock, pages cannot get moved from
@@ -968,6 +1035,7 @@ struct cgroup_subsys hugetlb_cgrp_subsys = {
 	.css_free	= hugetlb_cgroup_css_free,
 	.can_attach	= hugetlb_cgroup_can_attach,
 	.cancel_attach	= hugetlb_cgroup_cancel_attach,
+	.post_attach    = hugetlb_cgroup_move_task,
 	.dfl_cftypes	= hugetlb_files,
 	.legacy_cftypes	= hugetlb_files,
 };
-- 
1.8.3.1

