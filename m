Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B633C28BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGIRxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:53:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060AC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:51:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso6491803pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/sMV2mqnVxpHb+Jh4Ox0/pgOOprIGWewt8+N7MTGsQ=;
        b=i7QnlekLD0vZWkUuFCZcPIP9sJZ+ecwaI1dmx06LLcmxlR2fCMiiK2FSSCPRWhgchq
         8/UU7M3RqQvSLgqOBEIWePBiq/gzhVyswxor2ghWgr5DnVUzZTNexY7JLfObYoLr/7pH
         baLzQbRZlkt6FW1Tngtn1XtT79AZeLGz3A6VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/sMV2mqnVxpHb+Jh4Ox0/pgOOprIGWewt8+N7MTGsQ=;
        b=mppigilAgE2m5rIuk8QwZF8rCsMRBobQaPTxbOpHBW5u/tHozLbX6VognEL8Lmj2gP
         sJ5YawEXC++jT1kEtx9GX9KU3oCmL8U8nRuNMLkLNZGckC/Mj/ER9D+CG/wpVFS4NUX9
         RIJjkIIyQDH8M1junZcYkRBIfnNl2MCoWdHpGU+jXRCiMHVetNj2Z4CUHaTObtIbkWsi
         BegWwP0STwA8EufIpmQjVYGIfNUq2pzPg1l0bzMJmC6aAceMN0I5eHeOe6rNOdxGEN7y
         bif3TWS3DHUa2mlXUbxvnISd08kLSvwlnJGqzinnmQxCKn38lwTTEGwJnpvK9cYWIZCa
         XnQw==
X-Gm-Message-State: AOAM533SV4sWntBE3WEUGGfVmgKjZUaeeWiZz+Cu/viZzMvdMukdoKib
        UPEobmoiaCPtw+sfQZxJW2BNUA==
X-Google-Smtp-Source: ABdhPJyhRcLTZBa+XfteRdCO+FA9/OHAKBN+7g2rwoXy1FoYfOJS5iJftyYHXwOm4q6g6A12szEkJQ==
X-Received: by 2002:a17:90a:4490:: with SMTP id t16mr102131pjg.183.1625853067635;
        Fri, 09 Jul 2021 10:51:07 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:8991:801d:8d8e:6534])
        by smtp.gmail.com with ESMTPSA id n26sm7812310pgd.15.2021.07.09.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:51:07 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Evan Green <evgreen@chromium.org>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] mm: Enable suspend-only swap spaces
Date:   Fri,  9 Jul 2021 10:50:48 -0700
Message-Id: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
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

Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
under SwapTotal and SwapFree, since they are not usable as general swap.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
 - NOSWAP regions should not contribute to Swap stats in /proc/meminfo.
   [David]
 - Adjusted comment of SWAP_FLAG_NOSWAP [Pavel]
 - Note: Opted not to take Pavel's tag since enough has changed in this
   revision to warrant another look.
 - Call swap_entry_free() in swap_free to avoid NOSWAP leaks back into
   the general pool via swap_slots_cache [me].

 include/linux/swap.h |  4 +++-
 mm/swapfile.c        | 52 +++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6f5a43251593c8..995466c9f16a76 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -28,10 +28,11 @@ struct pagevec;
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */
 #define SWAP_FLAG_DISCARD_ONCE	0x20000 /* discard swap area at swapon-time */
 #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
+#define SWAP_FLAG_NOSWAP	0x80000 /* use only for hibernate, not swap */
 
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
index 1e07d1c776f2ae..d9ab39d32e55ec 100644
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
 
@@ -726,10 +727,12 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		bool was_full = !si->highest_bit;
 
 		WRITE_ONCE(si->highest_bit, end);
-		if (was_full && (si->flags & SWP_WRITEOK))
+		if (was_full &&
+		    ((si->flags & (SWP_WRITEOK | SWP_NOSWAP)) == SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
-	atomic_long_add(nr_entries, &nr_swap_pages);
+	if (!(si->flags & SWP_NOSWAP))
+		atomic_long_add(nr_entries, &nr_swap_pages);
 	si->inuse_pages -= nr_entries;
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1078,6 +1081,9 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			WARN(!(si->flags & SWP_WRITEOK),
 			     "swap_info %d in list but !SWP_WRITEOK\n",
 			     si->type);
+			WARN((si->flags & SWP_NOSWAP),
+			     "swap_info %d in list but SWP_NOSWAP\n",
+			     si->type);
 			__del_from_avail_list(si);
 			spin_unlock(&si->lock);
 			goto nextsi;
@@ -1338,8 +1344,12 @@ void swap_free(swp_entry_t entry)
 	struct swap_info_struct *p;
 
 	p = _swap_info_get(entry);
-	if (p)
-		__swap_entry_free(p, entry);
+	if (p) {
+		if (p->flags & SWP_NOSWAP)
+			swap_entry_free(p, entry);
+		else
+			__swap_entry_free(p, entry);
+	}
 }
 
 /*
@@ -1783,8 +1793,10 @@ swp_entry_t get_swap_page_of_type(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	spin_lock(&si->lock);
-	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
-		atomic_long_dec(&nr_swap_pages);
+	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry)) {
+		if (!(si->flags & SWP_NOSWAP))
+			atomic_long_dec(&nr_swap_pages);
+	}
 	spin_unlock(&si->lock);
 fail:
 	return entry;
@@ -2454,8 +2466,6 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 static void _enable_swap_info(struct swap_info_struct *p)
 {
 	p->flags |= SWP_WRITEOK;
-	atomic_long_add(p->pages, &nr_swap_pages);
-	total_swap_pages += p->pages;
 
 	assert_spin_locked(&swap_lock);
 	/*
@@ -2469,7 +2479,11 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * swap_info_struct.
 	 */
 	plist_add(&p->list, &swap_active_head);
-	add_to_avail_list(p);
+	if (!(p->flags & SWP_NOSWAP)) {
+		atomic_long_add(p->pages, &nr_swap_pages);
+		total_swap_pages += p->pages;
+		add_to_avail_list(p);
+	}
 }
 
 static void enable_swap_info(struct swap_info_struct *p, int prio,
@@ -2564,7 +2578,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
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
@@ -2581,8 +2597,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		least_priority++;
 	}
 	plist_del(&p->list, &swap_active_head);
-	atomic_long_sub(p->pages, &nr_swap_pages);
-	total_swap_pages -= p->pages;
+	if (!(p->flags & SWP_NOSWAP)) {
+		atomic_long_sub(p->pages, &nr_swap_pages);
+		total_swap_pages -= p->pages;
+	}
 	p->flags &= ~SWP_WRITEOK;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
@@ -3329,16 +3347,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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

