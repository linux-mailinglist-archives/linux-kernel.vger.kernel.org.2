Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A443358435
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhDHNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:09:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16417 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhDHNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:09:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGM4K72mrzkjcw;
        Thu,  8 Apr 2021 21:07:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:09:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <ying.huang@intel.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm/swapfile: add percpu_ref support for swap
Date:   Thu, 8 Apr 2021 09:08:16 -0400
Message-ID: <20210408130820.48233-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210408130820.48233-1-linmiaohe@huawei.com>
References: <20210408130820.48233-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use percpu-refcount to serialize against concurrent swapoff. This
patch adds the percpu_ref support for later fixup.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h |  2 ++
 mm/swapfile.c        | 25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 144727041e78..849ba5265c11 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -240,6 +240,7 @@ struct swap_cluster_list {
  * The in-memory structure used to track swap areas.
  */
 struct swap_info_struct {
+	struct percpu_ref users;	/* serialization against concurrent swapoff */
 	unsigned long	flags;		/* SWP_USED etc: see above */
 	signed short	prio;		/* swap priority of this type */
 	struct plist_node list;		/* entry in swap_active_head */
@@ -260,6 +261,7 @@ struct swap_info_struct {
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
 	unsigned int old_block_size;	/* seldom referenced */
+	struct completion comp;		/* seldom referenced */
 #ifdef CONFIG_FRONTSWAP
 	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
 	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 149e77454e3c..724173cd7d0c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -39,6 +39,7 @@
 #include <linux/export.h>
 #include <linux/swap_slots.h>
 #include <linux/sort.h>
+#include <linux/completion.h>
 
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
@@ -511,6 +512,15 @@ static void swap_discard_work(struct work_struct *work)
 	spin_unlock(&si->lock);
 }
 
+static void swap_users_ref_free(struct percpu_ref *ref)
+{
+	struct swap_info_struct *si;
+
+	si = container_of(ref, struct swap_info_struct, users);
+	complete(&si->comp);
+	percpu_ref_exit(&si->users);
+}
+
 static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
 {
 	struct swap_cluster_info *ci = si->cluster_info;
@@ -2500,7 +2510,7 @@ static void enable_swap_info(struct swap_info_struct *p, int prio,
 	 * Guarantee swap_map, cluster_info, etc. fields are valid
 	 * between get/put_swap_device() if SWP_VALID bit is set
 	 */
-	synchronize_rcu();
+	percpu_ref_reinit(&p->users);
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
 	_enable_swap_info(p);
@@ -2621,11 +2631,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	p->flags &= ~SWP_VALID;		/* mark swap device as invalid */
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
+
+	percpu_ref_kill(&p->users);
 	/*
 	 * wait for swap operations protected by get/put_swap_device()
 	 * to complete
 	 */
-	synchronize_rcu();
+	wait_for_completion(&p->comp);
 
 	flush_work(&p->discard_work);
 
@@ -3132,7 +3144,7 @@ static bool swap_discardable(struct swap_info_struct *si)
 SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 {
 	struct swap_info_struct *p;
-	struct filename *name;
+	struct filename *name = NULL;
 	struct file *swap_file = NULL;
 	struct address_space *mapping;
 	int prio;
@@ -3163,6 +3175,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	INIT_WORK(&p->discard_work, swap_discard_work);
 
+	init_completion(&p->comp);
+	error = percpu_ref_init(&p->users, swap_users_ref_free,
+				PERCPU_REF_INIT_DEAD, GFP_KERNEL);
+	if (unlikely(error))
+		goto bad_swap;
+
 	name = getname(specialfile);
 	if (IS_ERR(name)) {
 		error = PTR_ERR(name);
@@ -3356,6 +3374,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
+	percpu_ref_exit(&p->users);
 	free_percpu(p->percpu_cluster);
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
-- 
2.19.1

