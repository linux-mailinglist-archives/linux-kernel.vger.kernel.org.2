Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF52327DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhCAMG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:06:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13392 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhCAMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:06:57 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DpzTF5NLRz7rgT;
        Mon,  1 Mar 2021 20:04:33 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Mar 2021
 20:06:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <almasrymina@google.com>, <rientjes@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] hugetlb_cgroup: fix imbalanced css_get and css_put pair for shared mappings
Date:   Mon, 1 Mar 2021 07:05:40 -0500
Message-ID: <20210301120540.37076-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of hugetlb_cgroup for shared mappings could have
different behavior. Consider the following two scenarios:

1.Assume initial css reference count of hugetlb_cgroup is 1:
  1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
count is 2 associated with 1 file_region.
  1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
count is 3 associated with 2 file_region.
  1.3 coalesce_file_region will coalesce these two file_regions into one.
So css reference count is 3 associated with 1 file_region now.

2.Assume initial css reference count of hugetlb_cgroup is 1 again:
  2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
count is 2 associated with 1 file_region.

Therefore, we might have one file_region while holding one or more css
reference counts. This inconsistency could lead to imbalanced css_get()
and css_put() pair. If we do css_put one by one (i.g. hole punch case),
scenario 2 would put one more css reference. If we do css_put all together
(i.g. truncate case), scenario 1 will leak one css reference.

The imbalanced css_get() and css_put() pair would result in a non-zero
reference when we try to destroy the hugetlb cgroup. The hugetlb cgroup
directory is removed __but__ associated resource is not freed. This might
result in OOM or can not create a new hugetlb cgroup in a busy workload
ultimately.

In order to fix this, we have to make sure that one file_region must hold
and only hold one css reference. So in coalesce_file_region case, we should
release one css reference before coalescence. Also only put css reference
when the entire file_region is removed.

The last thing to note is that the caller of region_add() will only hold
one reference to h_cg->css for the whole contiguous reservation region.
But this area might be scattered when there are already some file_regions
reside in it. As a result, many file_regions may share only one h_cg->css
reference. In order to ensure that one file_region must hold and only hold
one h_cg->css reference, we should do css_get() for each file_region and
release the reference held by caller when they are done.

Fixes: 075a61d07a8e ("hugetlb_cgroup: add accounting for shared mappings")
Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@kernel.org
---
v1->v2:
	Fix auto build test ERROR when CGROUP_HUGETLB is disabled.
---
 include/linux/hugetlb_cgroup.h | 15 ++++++++++--
 mm/hugetlb.c                   | 42 ++++++++++++++++++++++++++++++----
 mm/hugetlb_cgroup.c            | 11 +++++++--
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..0bff345c4bc6 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -113,6 +113,11 @@ static inline bool hugetlb_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(hugetlb_cgrp_subsys);
 }
 
+static inline void hugetlb_cgroup_put_rsvd_cgroup(struct hugetlb_cgroup *h_cg)
+{
+	css_put(&h_cg->css);
+}
+
 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 					struct hugetlb_cgroup **ptr);
 extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
@@ -138,7 +143,8 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
 
 extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 						struct file_region *rg,
-						unsigned long nr_pages);
+						unsigned long nr_pages,
+						bool region_del);
 
 extern void hugetlb_cgroup_file_init(void) __init;
 extern void hugetlb_cgroup_migrate(struct page *oldhpage,
@@ -147,7 +153,8 @@ extern void hugetlb_cgroup_migrate(struct page *oldhpage,
 #else
 static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 						       struct file_region *rg,
-						       unsigned long nr_pages)
+						       unsigned long nr_pages,
+						       bool region_del)
 {
 }
 
@@ -185,6 +192,10 @@ static inline bool hugetlb_cgroup_disabled(void)
 	return true;
 }
 
+static inline void hugetlb_cgroup_put_rsvd_cgroup(struct hugetlb_cgroup *h_cg)
+{
+}
+
 static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 					       struct hugetlb_cgroup **ptr)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8fb42c6dd74b..87db91dff47f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -280,6 +280,18 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 		nrg->reservation_counter =
 			&h_cg->rsvd_hugepage[hstate_index(h)];
 		nrg->css = &h_cg->css;
+		/*
+		 * The caller (hugetlb_reserve_pages now) will only hold one
+		 * h_cg->css reference for the whole contiguous reservation
+		 * region. But this area might be scattered when there are
+		 * already some file_regions reside in it. As a result, many
+		 * file_regions may share only one h_cg->css reference. In
+		 * order to ensure that one file_region must hold and only
+		 * hold one h_cg->css reference, we should do css_get for
+		 * each file_region and leave the reference held by caller
+		 * untouched.
+		 */
+		css_get(&h_cg->css);
 		if (!resv->pages_per_hpage)
 			resv->pages_per_hpage = pages_per_huge_page(h);
 		/* pages_per_hpage should be the same for all entries in
@@ -293,6 +305,14 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 #endif
 }
 
+static void put_uncharge_info(struct file_region *rg)
+{
+#ifdef CONFIG_CGROUP_HUGETLB
+	if (rg->css)
+		css_put(rg->css);
+#endif
+}
+
 static bool has_same_uncharge_info(struct file_region *rg,
 				   struct file_region *org)
 {
@@ -316,6 +336,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 		prg->to = rg->to;
 
 		list_del(&rg->link);
+		put_uncharge_info(rg);
 		kfree(rg);
 
 		rg = prg;
@@ -327,6 +348,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 		nrg->from = rg->from;
 
 		list_del(&rg->link);
+		put_uncharge_info(rg);
 		kfree(rg);
 	}
 }
@@ -659,7 +681,7 @@ static long region_del(struct resv_map *resv, long f, long t)
 
 			del += t - f;
 			hugetlb_cgroup_uncharge_file_region(
-				resv, rg, t - f);
+				resv, rg, t - f, false);
 
 			/* New entry for end of split region */
 			nrg->from = t;
@@ -680,7 +702,7 @@ static long region_del(struct resv_map *resv, long f, long t)
 		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
 			del += rg->to - rg->from;
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
-							    rg->to - rg->from);
+							    rg->to - rg->from, true);
 			list_del(&rg->link);
 			kfree(rg);
 			continue;
@@ -688,13 +710,13 @@ static long region_del(struct resv_map *resv, long f, long t)
 
 		if (f <= rg->from) {	/* Trim beginning of region */
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
-							    t - rg->from);
+							    t - rg->from, false);
 
 			del += t - rg->from;
 			rg->from = t;
 		} else {		/* Trim end of region */
 			hugetlb_cgroup_uncharge_file_region(resv, rg,
-							    rg->to - f);
+							    rg->to - f, false);
 
 			del += rg->to - f;
 			rg->to = f;
@@ -5128,6 +5150,10 @@ bool hugetlb_reserve_pages(struct inode *inode,
 			 */
 			long rsv_adjust;
 
+			/*
+			 * hugetlb_cgroup_uncharge_cgroup_rsvd() will put the
+			 * reference to h_cg->css. See comment below for detail.
+			 */
 			hugetlb_cgroup_uncharge_cgroup_rsvd(
 				hstate_index(h),
 				(chg - add) * pages_per_huge_page(h), h_cg);
@@ -5135,6 +5161,14 @@ bool hugetlb_reserve_pages(struct inode *inode,
 			rsv_adjust = hugepage_subpool_put_pages(spool,
 								chg - add);
 			hugetlb_acct_memory(h, -rsv_adjust);
+		} else if (h_cg) {
+			/*
+			 * The file_regions will hold their own reference to
+			 * h_cg->css. So we should release the reference held
+			 * via hugetlb_cgroup_charge_cgroup_rsvd() when we are
+			 * done.
+			 */
+			hugetlb_cgroup_put_rsvd_cgroup(h_cg);
 		}
 	}
 	return true;
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f68b51fcda3d..8668ba87cfe4 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -391,7 +391,8 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
 
 void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 					 struct file_region *rg,
-					 unsigned long nr_pages)
+					 unsigned long nr_pages,
+					 bool region_del)
 {
 	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
 		return;
@@ -400,7 +401,13 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 	    !resv->reservation_counter) {
 		page_counter_uncharge(rg->reservation_counter,
 				      nr_pages * resv->pages_per_hpage);
-		css_put(rg->css);
+		/*
+		 * Only do css_put(rg->css) when we delete the entire region
+		 * because one file_region must hold and only hold one rg->css
+		 * reference.
+		 */
+		if (region_del)
+			css_put(rg->css);
 	}
 }
 
-- 
2.19.1

