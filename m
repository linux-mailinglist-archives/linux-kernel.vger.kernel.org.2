Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9E3B8766
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhF3RKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhF3RKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:10:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA7C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:08:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 17so2832269pfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvKR09L/+eyUPmXhwUrDGsuNs85a9cp92Ey9Voe1J+o=;
        b=QIzcdNfmGPAqRzWjezAA33W4tYYPhmedHPy/VbFEQJIHnN+PtcD9HtzTZwmw9cbpUZ
         3a6NPryaJj1XkPlw0Dm3LUm/iDb2nrzVDTQW77AvYQnItjQ/cYyhnoiBdaCWVaEexogF
         vnx3WibV3K2vQKp+L4PmiDf+y8iKUQH6OqNps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvKR09L/+eyUPmXhwUrDGsuNs85a9cp92Ey9Voe1J+o=;
        b=L2e3ZzavnPMyQhsGPNTNOu64k1ih1SDPLz6A8O0vzfWQYaQaWDif3/s3rinKLZM6sg
         a/Z35JtZtsAh9qFaiVujSFUKhEzDIdYrN14u8FzfkUyBXAaywCSjcGOUf/ODPgFRhAu0
         cuYUvNJCgJFFc8BE6zsUcaDrmBMLEIarDEIyFlYK1GmR3f3aPgju7N9x5e0F5KLf7EKk
         /45w3LJYvCbsLy5059AfMJ68lqeMPwBKJ1+YNEh8kupd6mtlKQHpHPlGW9DCEtGcR7+i
         3odGxhDRAmsltSqKZ7L4w2iJObt09sANpnOxJIeu6mLnXANC1imMa5yZsifjDxWQhl3m
         zkyg==
X-Gm-Message-State: AOAM533r8XttosXT/ZMvnR7b0trRt6VdIUedjcHVmIGGz4fEesbgHY05
        wgZE5LGXbAeu/cgFHNm9fL8sUQ==
X-Google-Smtp-Source: ABdhPJzz2Y/9FapiZdh7ArWUM/0VBt3Y6NUo8Lx+mw99szYfNMhdBmW3JfzyRrQm30vWv5+HCz7GBw==
X-Received: by 2002:a63:4c5e:: with SMTP id m30mr35026847pgl.153.1625072873759;
        Wed, 30 Jun 2021 10:07:53 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:fc3:76ac:de4c:1c78])
        by smtp.gmail.com with ESMTPSA id l20sm160645pjq.24.2021.06.30.10.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:07:53 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Evan Green <evgreen@chromium.org>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1] mm: Enable suspend-only swap spaces
Date:   Wed, 30 Jun 2021 10:07:26 -0700
Message-Id: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's not possible to enable hibernation without also enabling
generic swap for a given swap area. These two use cases are not the
same. For example there may be users who want to enable hibernation,
but whose drives don't have the write endurance for generic swap
activities.

Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
generic swapping to it. This region can still be wired up for use in
suspend-to-disk activities, but will never have regular pages swapped to
it.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 include/linux/swap.h |  4 +++-
 mm/swapfile.c        | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6f5a43251593c8..a9fc37e29c17d6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -28,10 +28,11 @@ struct pagevec;
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */
 #define SWAP_FLAG_DISCARD_ONCE	0x20000 /* discard swap area at swapon-time */
 #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
+#define SWAP_FLAG_NOSWAP	0x80000 /* use only for suspend, not swap */
 
 #define SWAP_FLAGS_VALID	(SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER | \
 				 SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | \
-				 SWAP_FLAG_DISCARD_PAGES)
+				 SWAP_FLAG_DISCARD_PAGES | SWAP_FLAG_NOSWAP)
 #define SWAP_BATCH 64
 
 static inline int current_is_kswapd(void)
@@ -182,6 +183,7 @@ enum {
 	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
+	SWP_NOSWAP	= (1 << 13),	/* use only for suspend, not swap */
 					/* add others here before... */
 	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
 };
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c776f2ae..164937f958c319 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -697,7 +697,8 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 	if (si->inuse_pages == si->pages) {
 		si->lowest_bit = si->max;
 		si->highest_bit = 0;
-		del_from_avail_list(si);
+		if (!(si->flags & SWP_NOSWAP))
+			del_from_avail_list(si);
 	}
 }
 
@@ -726,7 +727,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		bool was_full = !si->highest_bit;
 
 		WRITE_ONCE(si->highest_bit, end);
-		if (was_full && (si->flags & SWP_WRITEOK))
+		if (was_full &&
+		    ((si->flags & (SWP_WRITEOK | SWP_NOSWAP)) == SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
 	atomic_long_add(nr_entries, &nr_swap_pages);
@@ -1078,6 +1080,9 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			WARN(!(si->flags & SWP_WRITEOK),
 			     "swap_info %d in list but !SWP_WRITEOK\n",
 			     si->type);
+			WARN((si->flags & SWP_NOSWAP),
+			     "swap_info %d in list but SWP_NOSWAP\n",
+			     si->type);
 			__del_from_avail_list(si);
 			spin_unlock(&si->lock);
 			goto nextsi;
@@ -2469,7 +2474,8 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * swap_info_struct.
 	 */
 	plist_add(&p->list, &swap_active_head);
-	add_to_avail_list(p);
+	if (!(p->flags & SWP_NOSWAP))
+		add_to_avail_list(p);
 }
 
 static void enable_swap_info(struct swap_info_struct *p, int prio,
@@ -2564,7 +2570,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
-	del_from_avail_list(p);
+	if (!(p->flags & SWP_NOSWAP))
+		del_from_avail_list(p);
+
 	spin_lock(&p->lock);
 	if (p->prio < 0) {
 		struct swap_info_struct *si = p;
@@ -3329,16 +3337,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio =
 		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
+
+	if (swap_flags & SWAP_FLAG_NOSWAP)
+		p->flags |= SWP_NOSWAP;
 	enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
 
-	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
+	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s%s\n",
 		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
 		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
 		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
 		(p->flags & SWP_DISCARDABLE) ? "D" : "",
 		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
 		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
-		(frontswap_map) ? "FS" : "");
+		(frontswap_map) ? "FS" : "",
+		(p->flags & SWP_NOSWAP) ? "N" : "");
 
 	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
-- 
2.31.0

