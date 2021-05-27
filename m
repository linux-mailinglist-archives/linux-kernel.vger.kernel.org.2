Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB8392D81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhE0MF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:05:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbhE0MFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:05:49 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrRHP0l03z66V5;
        Thu, 27 May 2021 20:01:21 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 20:04:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/swapfile: fold scan_swap_map() into the only caller get_swap_page_of_type()
Date:   Thu, 27 May 2021 20:03:28 +0800
Message-ID: <20210527120328.3935132-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should fold scan_swap_map() into the only caller get_swap_page_of_type()
and update the comments referring to it to make the code more succinct.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
Hi Andrew,
  Please feel free to merge this with
mm-swapfile-move-get_swap_page_of_type-under-config_hibernation.patch and
mm-swapfile-move-get_swap_page_of_type-under-config_hibernation-fix.patch
Many thanks!
---
 mm/swapfile.c | 57 ++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 53d2161edfc0..166be489664d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -453,10 +453,10 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 		unsigned int idx)
 {
 	/*
-	 * If scan_swap_map() can't find a free cluster, it will check
+	 * If scan_swap_map_slots() can't find a free cluster, it will check
 	 * si->swap_map directly. To make sure the discarding cluster isn't
-	 * taken by scan_swap_map(), mark the swap entries bad (occupied). It
-	 * will be cleared after discard
+	 * taken by scan_swap_map_slots(), mark the swap entries bad (occupied).
+	 * It will be cleared after discard
 	 */
 	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
@@ -589,7 +589,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 }
 
 /*
- * It's possible scan_swap_map() uses a free cluster in the middle of free
+ * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
  * cluster list. Avoiding such abuse to avoid list corruption.
  */
 static bool
@@ -1099,14 +1099,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 nextsi:
 		/*
 		 * if we got here, it's likely that si was almost full before,
-		 * and since scan_swap_map() can drop the si->lock, multiple
-		 * callers probably all tried to get a page from the same si
-		 * and it filled up before we could get one; or, the si filled
-		 * up between us dropping swap_avail_lock and taking si->lock.
-		 * Since we dropped the swap_avail_lock, the swap_avail_head
-		 * list may have been modified; so if next is still in the
-		 * swap_avail_head list then try it, otherwise start over
-		 * if we have not gotten any slots.
+		 * and since scan_swap_map_slots() can drop the si->lock,
+		 * multiple callers probably all tried to get a page from the
+		 * same si and it filled up before we could get one; or, the si
+		 * filled up between us dropping swap_avail_lock and taking
+		 * si->lock. Since we dropped the swap_avail_lock, the
+		 * swap_avail_head list may have been modified; so if next is
+		 * still in the swap_avail_head list then try it, otherwise
+		 * start over if we have not gotten any slots.
 		 */
 		if (plist_node_empty(&next->avail_lists[node]))
 			goto start_over;
@@ -1774,42 +1774,21 @@ int free_swap_and_cache(swp_entry_t entry)
 
 #ifdef CONFIG_HIBERNATION
 
-static unsigned long scan_swap_map(struct swap_info_struct *si,
-				   unsigned char usage)
-{
-	swp_entry_t entry;
-	int n_ret;
-
-	n_ret = scan_swap_map_slots(si, usage, 1, &entry);
-
-	if (n_ret)
-		return swp_offset(entry);
-	else
-		return 0;
-
-}
-
 swp_entry_t get_swap_page_of_type(int type)
 {
 	struct swap_info_struct *si = swap_type_to_swap_info(type);
-	pgoff_t offset;
+	swp_entry_t entry = {0};
 
 	if (!si)
 		goto fail;
 
+	/* This is called for allocating swap entry, not cache */
 	spin_lock(&si->lock);
-	if (si->flags & SWP_WRITEOK) {
-		/* This is called for allocating swap entry, not cache */
-		offset = scan_swap_map(si, 1);
-		if (offset) {
-			atomic_long_dec(&nr_swap_pages);
-			spin_unlock(&si->lock);
-			return swp_entry(type, offset);
-		}
-	}
+	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
+		atomic_long_dec(&nr_swap_pages);
 	spin_unlock(&si->lock);
 fail:
-	return (swp_entry_t) {0};
+	return entry;
 }
 
 /*
@@ -2649,7 +2628,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	spin_lock(&p->lock);
 	drain_mmlist();
 
-	/* wait for anyone still in scan_swap_map */
+	/* wait for anyone still in scan_swap_map_slots */
 	p->highest_bit = 0;		/* cuts scans short */
 	while (p->flags >= SWP_SCANNING) {
 		spin_unlock(&p->lock);
-- 
2.23.0

