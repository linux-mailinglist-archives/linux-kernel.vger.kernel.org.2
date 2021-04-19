Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0D363D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbhDSIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:32:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17014 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhDSIc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:32:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FP0Mt6xclzPqyj;
        Mon, 19 Apr 2021 16:28:58 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 16:31:47 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, <luoshijie1@huawei.com>
Subject: [PATCH RESEND] mm: fix some typos and code style problems
Date:   Mon, 19 Apr 2021 04:30:57 -0400
Message-ID: <20210419083057.64820-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix some typos and code style problems in mm.

gfp.h: s/MAXNODES/MAX_NUMNODES
mmzone.h: s/then/than
rmap.c: s/__vma_split()/__vma_adjust()
swap.c: s/__mod_zone_page_stat/__mod_zone_page_state, s/is is/is
swap_state.c: s/whoes/whose
z3fold.c: code style problem fix in z3fold_unregister_migration
zsmalloc.c: s/of/or, s/give/given

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/gfp.h    | 2 +-
 include/linux/mmzone.h | 2 +-
 mm/rmap.c              | 2 +-
 mm/swap.c              | 4 ++--
 mm/swap_state.c        | 2 +-
 mm/z3fold.c            | 2 +-
 mm/zsmalloc.c          | 4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 8572a1474e16..5f597df8da98 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -490,7 +490,7 @@ static inline int gfp_zonelist(gfp_t flags)
 
 /*
  * We get the zone list from the current node and the gfp_mask.
- * This zone list contains a maximum of MAXNODES*MAX_NR_ZONES zones.
+ * This zone list contains a maximum of MAX_NUMNODES*MAX_NR_ZONES zones.
  * There are two zonelists per node, one for all zones with memory and
  * one containing just zones from the node the zonelist belongs to.
  *
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..5fd14fd85d4c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -55,7 +55,7 @@ enum migratetype {
 	 * pageblocks to MIGRATE_CMA which can be done by
 	 * __free_pageblock_cma() function.  What is important though
 	 * is that a range of pageblocks must be aligned to
-	 * MAX_ORDER_NR_PAGES should biggest page be bigger then
+	 * MAX_ORDER_NR_PAGES should biggest page be bigger than
 	 * a single pageblock.
 	 */
 	MIGRATE_CMA,
diff --git a/mm/rmap.c b/mm/rmap.c
index b0fc27e77d6d..693a610e181d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -257,7 +257,7 @@ static inline void unlock_anon_vma_root(struct anon_vma *root)
  * Attach the anon_vmas from src to dst.
  * Returns 0 on success, -ENOMEM on failure.
  *
- * anon_vma_clone() is called by __vma_split(), __split_vma(), copy_vma() and
+ * anon_vma_clone() is called by __vma_adjust(), __split_vma(), copy_vma() and
  * anon_vma_fork(). The first three want an exact copy of src, while the last
  * one, anon_vma_fork(), may try to reuse an existing anon_vma to prevent
  * endless growth of anon_vma. Since dst->anon_vma is set to NULL before call,
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..9e0028b01b97 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -483,7 +483,7 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
 	if (unlikely(unevictable) && !TestSetPageMlocked(page)) {
 		int nr_pages = thp_nr_pages(page);
 		/*
-		 * We use the irq-unsafe __mod_zone_page_stat because this
+		 * We use the irq-unsafe __mod_zone_page_state because this
 		 * counter is not modified from interrupt context, and the pte
 		 * lock is held(spinlock), which implies preemption disabled.
 		 */
@@ -794,7 +794,7 @@ void lru_add_drain_all(void)
 	 * below which drains the page vectors.
 	 *
 	 * Let x, y, and z represent some system CPU numbers, where x < y < z.
-	 * Assume CPU #z is is in the middle of the for_each_online_cpu loop
+	 * Assume CPU #z is in the middle of the for_each_online_cpu loop
 	 * below and has already reached CPU #y's per-cpu data. CPU #x comes
 	 * along, adds some pages to its per-cpu vectors, then calls
 	 * lru_add_drain_all().
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3cdee7b11da9..5d1fafffee4e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -797,7 +797,7 @@ static void swap_ra_info(struct vm_fault *vmf,
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
- * Primitive swap readahead code. We simply read in a few pages whoes
+ * Primitive swap readahead code. We simply read in a few pages whose
  * virtual addresses are around the fault address in the same vma.
  *
  * Caller must hold read mmap_lock if vmf->vma is not NULL.
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 9d889ad2bb86..7fe7adaaad01 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -391,7 +391,7 @@ static void z3fold_unregister_migration(struct z3fold_pool *pool)
 {
 	if (pool->inode)
 		iput(pool->inode);
- }
+}
 
 /* Initializes the z3fold header of a newly allocated z3fold page */
 static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 30c358b72025..412e0f95e2c1 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -61,7 +61,7 @@
 #define ZSPAGE_MAGIC	0x58
 
 /*
- * This must be power of 2 and greater than of equal to sizeof(link_free).
+ * This must be power of 2 and greater than or equal to sizeof(link_free).
  * These two conditions ensure that any 'struct link_free' itself doesn't
  * span more than 1 page which avoids complex case of mapping 2 pages simply
  * to restore link_free pointer values.
@@ -530,7 +530,7 @@ static void set_zspage_mapping(struct zspage *zspage,
  * class maintains a list of zspages where each zspage is divided
  * into equal sized chunks. Each allocation falls into one of these
  * classes depending on its size. This function returns index of the
- * size class which has chunk size big enough to hold the give size.
+ * size class which has chunk size big enough to hold the given size.
  */
 static int get_size_class_index(int size)
 {
-- 
2.19.1

