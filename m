Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2676369B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhDWUY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhDWUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:24:22 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:23:44 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i22so37017391ila.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aX40hSHxXwjOOtduDth6BOwMQx+lmvX1XrYRrMT3+DA=;
        b=U2DHWpx7H3uEAXAfRq2GO7OlE46CLU9tpsxeTgtrAIO9RI3UzpbA6njlYrzjGoC8Vk
         82H3BH9eBvNJPkJShp2n6EWjXo+6oTSzpzp5mWKfTnA+wZRMCpXzDC2/EhDPsuKyLAKA
         V4KZHMfX/0k9nZxFmIjW+sInViNJ+8OKOdbnx+SxBGTVcgM/zyW9JixdSkW2KCk2LUow
         sB7c0UPFFmk7gdQdv5Ve00c43YEK11vtl0CuzIeDS86AFjItN02YQud0s7Y/BztZEPxl
         7Qvj7UJa9eeCe74/JuhbeXzOrFke/sr+pMqY3VwhT8Ioa9lJpoB77a1DGfoqF0s1PPGA
         bNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aX40hSHxXwjOOtduDth6BOwMQx+lmvX1XrYRrMT3+DA=;
        b=c/aEe71SsbegNdtLDwHkBoYKJl+22vghtRS+NZbVlC0f0SN6uGLTwtjJsGr2Z+4h3V
         qx59QZ9aRsFGISXGGP4Imd/mHFuKTNg1/CS+VCOwTpeCW1y58rQxubbyqYViC8iZmMUo
         DwsxtbFAWvt7siHCNJ1YOpB2VjWIP27PLxqSlMsDhgGVGiIjJs9HD7Bs1GUZO4eb5UZy
         U+SMVeTCnxjRq8AEaOPzJGZtqIYYR4jYhG9Yq2Lj4lvoX0FCxkYPKzuHaZMx7bmZfowT
         QpcywsZ50yVy2csf0B9NZbDv1lWiIwTst31inwGLxXQ75LTi6DzG9tmi+5MDCdms14b4
         pszQ==
X-Gm-Message-State: AOAM5339BFmurQdPfZs3Z6jLb6e7QB8l2ul2jAgpvlw/W9yqlwbSyhH2
        TSDCNALK22eQuexWJIRxTSXw0QAOFEIaYw==
X-Google-Smtp-Source: ABdhPJyEJvX89TONfQQzbYOZWkTGQR71kw6GLXDSUJpmChPvZ78m79zxlR9KB1iqNA4RIJzBgNKaSg==
X-Received: by 2002:a92:d092:: with SMTP id h18mr4415717ilh.62.1619209423477;
        Fri, 23 Apr 2021 13:23:43 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:a272:a6c7:58b2:8c6a])
        by smtp.gmail.com with ESMTPSA id h11sm2991816ilr.84.2021.04.23.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 13:23:42 -0700 (PDT)
Date:   Fri, 23 Apr 2021 14:23:38 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        tim.c.chen@linux.intel.com, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
Message-ID: <YIMsykToLKUVMWbZ@google.com>
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
 <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 02:57:07PM +0800, Xing Zhengjun wrote:
> On 4/23/2021 1:13 AM, Yu Zhao wrote:
> > On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
> > > Hi,
> > > 
> > >     In the system with very few file pages (nr_active_file + nr_inactive_file
> > > < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file",  then
> > > too_many_isolated return true, shrink_inactive_list enter "msleep(100)", the
> > > long latency will happen.
> > > 
> > > The test case to reproduce it is very simple: allocate many huge pages(near
> > > the DRAM size), then do free, repeat the same operation many times.
> > > In the test case, the system with very few file pages (nr_active_file +
> > > nr_inactive_file < 100), I have dumpped the numbers of
> > > active/inactive/isolated file pages during the whole test(see in the
> > > attachments) , in shrink_inactive_list "too_many_isolated" is very easy to
> > > return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp_mask is
> > > 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy to
> > > enter “inactive >>=3”, then “isolated > inactive” will be true.
> > > 
> > > So I  have a proposal to set a threshold number for the total file pages to
> > > ignore the system with very few file pages, and then bypass the 100ms sleep.
> > > It is hard to set a perfect number for the threshold, so I just give an
> > > example of "256" for it.
> > > 
> > > I appreciate it if you can give me your suggestion/comments. Thanks.
> > 
> > Hi Zhengjun,
> > 
> > It seems to me using the number of isolated pages to keep a lid on
> > direct reclaimers is not a good solution. We shouldn't keep going
> > that direction if we really want to fix the problem because migration
> > can isolate many pages too, which in turn blocks page reclaim.
> > 
> > Here is something works a lot better. Please give it a try. Thanks.
> 
> Thanks, I will try it with my test cases.

Thanks. I took care my sloppiness from yesterday and tested the
following. It should apply cleanly and work well. Please let me know.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 47946cec7584..48bb2b77389e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -832,6 +832,7 @@ typedef struct pglist_data {
 #endif
 
 	/* Fields commonly accessed by the page reclaim scanner */
+	atomic_t		nr_reclaimers;
 
 	/*
 	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cbd7a1..3fcdfbee89c7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1775,43 +1775,6 @@ int isolate_lru_page(struct page *page)
 	return ret;
 }
 
-/*
- * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages from the LRU list and
- * then get rescheduled. When there are massive number of tasks doing page
- * allocation, such sleeping direct reclaimers may keep piling up on each CPU,
- * the LRU list will go small and be scanned faster than necessary, leading to
- * unnecessary swapping, thrashing and OOM.
- */
-static int too_many_isolated(struct pglist_data *pgdat, int file,
-		struct scan_control *sc)
-{
-	unsigned long inactive, isolated;
-
-	if (current_is_kswapd())
-		return 0;
-
-	if (!writeback_throttling_sane(sc))
-		return 0;
-
-	if (file) {
-		inactive = node_page_state(pgdat, NR_INACTIVE_FILE);
-		isolated = node_page_state(pgdat, NR_ISOLATED_FILE);
-	} else {
-		inactive = node_page_state(pgdat, NR_INACTIVE_ANON);
-		isolated = node_page_state(pgdat, NR_ISOLATED_ANON);
-	}
-
-	/*
-	 * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, so they
-	 * won't get blocked by normal direct-reclaimers, forming a circular
-	 * deadlock.
-	 */
-	if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
-		inactive >>= 3;
-
-	return isolated > inactive;
-}
-
 /*
  * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
  * On return, @list is reused as a list of pages to be freed by the caller.
@@ -1911,20 +1874,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	bool file = is_file_lru(lru);
 	enum vm_event_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-	bool stalled = false;
-
-	while (unlikely(too_many_isolated(pgdat, file, sc))) {
-		if (stalled)
-			return 0;
-
-		/* wait a bit for the reclaimer. */
-		msleep(100);
-		stalled = true;
-
-		/* We are about to die and free our memory. Return now. */
-		if (fatal_signal_pending(current))
-			return SWAP_CLUSTER_MAX;
-	}
 
 	lru_add_drain();
 
@@ -2903,6 +2852,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
 	pg_data_t *last_pgdat = NULL;
+	bool should_retry = false;
+	int nr_cpus = num_online_cpus();
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -2914,9 +2865,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->gfp_mask |= __GFP_HIGHMEM;
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
-
+retry:
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					sc->reclaim_idx, sc->nodemask) {
+		/*
+		 * Shrink each node in the zonelist once. If the zonelist is
+		 * ordered by zone (not the default) then a node may be shrunk
+		 * multiple times but in that case the user prefers lower zones
+		 * being preserved.
+		 */
+		if (zone->zone_pgdat == last_pgdat)
+			continue;
+
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -2941,16 +2901,28 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 				sc->compaction_ready = true;
 				continue;
 			}
+		}
 
-			/*
-			 * Shrink each node in the zonelist once. If the
-			 * zonelist is ordered by zone (not the default) then a
-			 * node may be shrunk multiple times but in that case
-			 * the user prefers lower zones being preserved.
-			 */
-			if (zone->zone_pgdat == last_pgdat)
-				continue;
+		/*
+		 * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages from
+		 * the LRU list and then get rescheduled. When there are massive
+		 * number of tasks doing page allocation, such sleeping direct
+		 * reclaimers may keep piling up on each CPU, the LRU list will
+		 * go small and be scanned faster than necessary, leading to
+		 * unnecessary swapping, thrashing and OOM.
+		 */
+		VM_BUG_ON(current_is_kswapd());
 
+		if (!atomic_add_unless(&zone->zone_pgdat->nr_reclaimers, 1, nr_cpus)) {
+			should_retry = true;
+			continue;
+		}
+
+		if (last_pgdat)
+			atomic_dec(&last_pgdat->nr_reclaimers);
+		last_pgdat = zone->zone_pgdat;
+
+		if (!cgroup_reclaim(sc)) {
 			/*
 			 * This steals pages from memory cgroups over softlimit
 			 * and returns the number of reclaimed pages and
@@ -2966,13 +2938,20 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			/* need some check for avoid more shrink_zone() */
 		}
 
-		/* See comment about same check for global reclaim above */
-		if (zone->zone_pgdat == last_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
+	if (last_pgdat)
+		atomic_dec(&last_pgdat->nr_reclaimers);
+	else if (should_retry) {
+		/* wait a bit for the reclaimer. */
+		if (!schedule_timeout_killable(HZ / 10))
+			goto retry;
+
+		/* We are about to die and free our memory. Return now. */
+		sc->nr_reclaimed += SWAP_CLUSTER_MAX;
+	}
+
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
 	 * promoted it to __GFP_HIGHMEM.
@@ -4189,6 +4168,15 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	set_task_reclaim_state(p, &sc.reclaim_state);
 
 	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
+		int nr_cpus = num_online_cpus();
+
+		VM_BUG_ON(current_is_kswapd());
+
+		if (!atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
+			schedule_timeout_killable(HZ / 10);
+			goto out;
+		}
+
 		/*
 		 * Free memory by calling shrink node with increasing
 		 * priorities until we have enough memory freed.
@@ -4196,8 +4184,10 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		do {
 			shrink_node(pgdat, &sc);
 		} while (sc.nr_reclaimed < nr_pages && --sc.priority >= 0);
-	}
 
+		atomic_dec(&pgdat->nr_reclaimers);
+	}
+out:
 	set_task_reclaim_state(p, NULL);
 	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
