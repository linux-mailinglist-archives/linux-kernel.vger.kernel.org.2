Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B607F38E63F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhEXMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhEXMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:08:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tAzKgcW9KS9l4nkDhbewM3vDoFeKoGJ9pD51+0h6puM=; b=K6EUb4UlXV0MknDc6ybfsZE67C
        oN0tYzaQGMxHiDAGoHYIE8WAZE+t6G3W1pnwfvg5YDZu9+Vxqa2LXEHrH3bQ1sVA/Q/f8salPct7H
        qzYxST6juZnFZKofobRmq9LsDxMFbKXqZVHJQCTwij/43TbJUwSqV12HaTKeOUbvw5OAzNoOx3UN9
        NkmN0oXUa6vi9aj2ZvJlP9C2elLZL5NPhZ0S/UKOKTaZcPvDNTj8d2seywyi4c60x5qyMNdUijQQ6
        Cde/nrQvizYHK2R2FP+70Kj2lNcQ42d8eZgB0q4GAI8D1rEE8bV4Ph3PNinN6ZEsEQl0jTeDy1Us+
        WlQZv+6w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ll9MC-002LDR-RT; Mon, 24 May 2021 12:07:01 +0000
Date:   Mon, 24 May 2021 13:06:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/swapfile: move scan_swap_map() under
 CONFIG_HIBERNATION
Message-ID: <YKuW3C6kAOwSfqnr@infradead.org>
References: <20210521070855.2015094-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521070855.2015094-1-linmiaohe@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please just fold it into the only caller and update the comments
referring to it.  Something like:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 149e77454e3c..0e575b45bb87 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -452,10 +452,10 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
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
@@ -580,7 +580,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 }
 
 /*
- * It's possible scan_swap_map() uses a free cluster in the middle of free
+ * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
  * cluster list. Avoiding such abuse to avoid list corruption.
  */
 static bool
@@ -1028,21 +1028,6 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
 
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
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 {
 	unsigned long size = swap_entry_size(entry_size);
@@ -1105,14 +1090,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
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
+		 * si->lock.  Since we dropped the swap_avail_lock, the
+		 * swap_avail_head list may have been modified; so if next is
+		 * still in the swap_avail_head list then try it, otherwise
+		 * start over if we have not gotten any slots.
 		 */
 		if (plist_node_empty(&next->avail_lists[node]))
 			goto start_over;
@@ -1132,24 +1117,18 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 swp_entry_t get_swap_page_of_type(int type)
 {
 	struct swap_info_struct *si = swap_type_to_swap_info(type);
-	pgoff_t offset;
+	swp_entry_t entry = { };
 
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
 
 static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
