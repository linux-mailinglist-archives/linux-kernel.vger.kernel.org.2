Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CE32F028
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCEQf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:35:58 -0500
Received: from foss.arm.com ([217.140.110.172]:56706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCEQf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:35:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B17911FB;
        Fri,  5 Mar 2021 08:35:29 -0800 (PST)
Received: from DESKTOP-VLO843J.arm.com (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26A9E3F73B;
        Fri,  5 Mar 2021 08:35:28 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, john.garry@huawei.com,
        thunder.leizhen@huawei.com, vjitta@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/iova: Add rbtree entry helper
Date:   Fri,  5 Mar 2021 16:35:22 +0000
Message-Id: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repeating the rb_entry() boilerplate all over the place gets old fast.
Before adding yet more instances, add a little hepler to tidy it up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c..c28003e1d2ee 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -27,6 +27,11 @@ static void fq_destroy_all_entries(struct iova_domain *iovad);
 static void fq_flush_timeout(struct timer_list *t);
 static void free_global_cached_iovas(struct iova_domain *iovad);
 
+static struct iova *to_iova(struct rb_node *node)
+{
+	return rb_entry(node, struct iova, node);
+}
+
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn)
@@ -136,7 +141,7 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 {
 	struct iova *cached_iova;
 
-	cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
+	cached_iova = to_iova(iovad->cached32_node);
 	if (free == cached_iova ||
 	    (free->pfn_hi < iovad->dma_32bit_pfn &&
 	     free->pfn_lo >= cached_iova->pfn_lo)) {
@@ -144,7 +149,7 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 	}
 
-	cached_iova = rb_entry(iovad->cached_node, struct iova, node);
+	cached_iova = to_iova(iovad->cached_node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
 		iovad->cached_node = rb_next(&free->node);
 }
@@ -159,7 +164,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 	new = (start) ? &start : &(root->rb_node);
 	/* Figure out where to put new node */
 	while (*new) {
-		struct iova *this = rb_entry(*new, struct iova, node);
+		struct iova *this = to_iova(*new);
 
 		parent = *new;
 
@@ -198,7 +203,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		goto iova32_full;
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
-	curr_iova = rb_entry(curr, struct iova, node);
+	curr_iova = to_iova(curr);
 	retry_pfn = curr_iova->pfn_hi + 1;
 
 retry:
@@ -207,7 +212,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		new_pfn = (high_pfn - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
-		curr_iova = rb_entry(curr, struct iova, node);
+		curr_iova = to_iova(curr);
 	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
 
 	if (high_pfn < size || new_pfn < low_pfn) {
@@ -215,7 +220,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 			high_pfn = limit_pfn;
 			low_pfn = retry_pfn;
 			curr = &iovad->anchor.node;
-			curr_iova = rb_entry(curr, struct iova, node);
+			curr_iova = to_iova(curr);
 			goto retry;
 		}
 		iovad->max32_alloc_size = size;
@@ -331,7 +336,7 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 	assert_spin_locked(&iovad->iova_rbtree_lock);
 
 	while (node) {
-		struct iova *iova = rb_entry(node, struct iova, node);
+		struct iova *iova = to_iova(node);
 
 		if (pfn < iova->pfn_lo)
 			node = node->rb_left;
@@ -617,7 +622,7 @@ static int
 __is_range_overlap(struct rb_node *node,
 	unsigned long pfn_lo, unsigned long pfn_hi)
 {
-	struct iova *iova = rb_entry(node, struct iova, node);
+	struct iova *iova = to_iova(node);
 
 	if ((pfn_lo <= iova->pfn_hi) && (pfn_hi >= iova->pfn_lo))
 		return 1;
@@ -685,7 +690,7 @@ reserve_iova(struct iova_domain *iovad,
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
 		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
-			iova = rb_entry(node, struct iova, node);
+			iova = to_iova(node);
 			__adjust_overlap_range(iova, &pfn_lo, &pfn_hi);
 			if ((pfn_lo >= iova->pfn_lo) &&
 				(pfn_hi <= iova->pfn_hi))
-- 
2.17.1

