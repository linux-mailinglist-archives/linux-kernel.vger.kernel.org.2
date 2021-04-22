Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D73685A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhDVROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:14:16 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:13:39 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y10so16597376ilv.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DSl0517RJC/IGa12rn20xYGXFTSU8SInEu5Zm6c1rN4=;
        b=HjfnpiYsIYXjoM09ckrMCHq24Z8ntxc5d8yrRrlpt2BqPO8JWz+0BRUH9NhzbmDWA1
         FaRylo/TwfB1RWF/+k8szdVr1mNTl/PDrKpHMn7dSgNlQIsmyFNl6M6sZotppnp8CJcj
         dksh0taOaejs/S5etgJ+YEfgsqOZQgFYPP5VxpInbgCrUTt8i2DqRL7HGfMSQ81F2nkb
         oSyhPPvWve6GB0SIVm1J7kslZ/nrMqx4/f+XhgFo/O+dw019yuZ1CgZ6scknngwnemCM
         zeUC/vj13V+W0qdBabtNyLTdMB18bW4m9CxlYk6vVU0kigcWb6EHOO+Ye4fUR3nO8CgX
         m+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DSl0517RJC/IGa12rn20xYGXFTSU8SInEu5Zm6c1rN4=;
        b=tMNsQEWjXRnfu/sjFTc1BUrnB5280PnoGHSPINRrl0JeoJABIjpxaI2sGDi3yJD67w
         ldBnV9ssN8h4bTFHGaVoI0jXoKkGeZ3xCSiVoWuPVNp+4ShEAll1MMAyfC+4P59Y9zEN
         IUt0XiCCHFGYyY/iXdwmcdU7Dj9hizwVH7WBSwypS0+oZJH0sGjc8Wb5tKmXYD4nUlWD
         LpjlkBJqpUz9cc9b76r9epazXqHGpyTJBt71tCg9/ViG/ilo7LC9KzRIPrIHiZW/8seZ
         BMOFKCnaRxRrehX0i2tAXtUZMg+whFZE0Ab0pG9FlQqMYfwknWJhdhUIdK75sQBIF/gS
         ualQ==
X-Gm-Message-State: AOAM531RhE+R0DgP/A6f4gDc1VDgqYaACXHBxxVoZe9gC5THqIEIc6bJ
        NQKKvm7bCetZ3QRNQT0qZS1+4x99efHPAA==
X-Google-Smtp-Source: ABdhPJy3Agi5bWMQjZE7N0wk/Vutq1KFhepkrIq4b8y3Aar43c5hcn1j0zm22UvPdHkCCIPyeSvNLw==
X-Received: by 2002:a92:cc02:: with SMTP id s2mr3560847ilp.101.1619111619206;
        Thu, 22 Apr 2021 10:13:39 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:8e2c:52b6:a763:3432])
        by smtp.gmail.com with ESMTPSA id x13sm1418534ilv.88.2021.04.22.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 10:13:38 -0700 (PDT)
Date:   Thu, 22 Apr 2021 11:13:34 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        tim.c.chen@linux.intel.com, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
Message-ID: <YIGuvh70JbE1Cx4U@google.com>
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:36:19PM +0800, Xing Zhengjun wrote:
> Hi,
> 
>    In the system with very few file pages (nr_active_file + nr_inactive_file
> < 100), it is easy to reproduce "nr_isolated_file > nr_inactive_file",  then
> too_many_isolated return true, shrink_inactive_list enter "msleep(100)", the
> long latency will happen.
> 
> The test case to reproduce it is very simple: allocate many huge pages(near
> the DRAM size), then do free, repeat the same operation many times.
> In the test case, the system with very few file pages (nr_active_file +
> nr_inactive_file < 100), I have dumpped the numbers of
> active/inactive/isolated file pages during the whole test(see in the
> attachments) , in shrink_inactive_list "too_many_isolated" is very easy to
> return true, then enter "msleep(100)",in "too_many_isolated" sc->gfp_mask is
> 0x342cca ("_GFP_IO" and "__GFP_FS" is masked) , it is also very easy to
> enter “inactive >>=3”, then “isolated > inactive” will be true.
> 
> So I  have a proposal to set a threshold number for the total file pages to
> ignore the system with very few file pages, and then bypass the 100ms sleep.
> It is hard to set a perfect number for the threshold, so I just give an
> example of "256" for it.
> 
> I appreciate it if you can give me your suggestion/comments. Thanks.

Hi Zhengjun,

It seems to me using the number of isolated pages to keep a lid on
direct reclaimers is not a good solution. We shouldn't keep going
that direction if we really want to fix the problem because migration
can isolate many pages too, which in turn blocks page reclaim.

Here is something works a lot better. Please give it a try. Thanks.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 507d216610bf2..9a09f7e76f6b8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -951,6 +951,8 @@ typedef struct pglist_data {
 
 	/* Fields commonly accessed by the page reclaim scanner */
 
+	atomic_t nr_reclaimers;
+
 	/*
 	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
 	 *
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1c080fafec396..f7278642290a6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1786,43 +1786,6 @@ int isolate_lru_page(struct page *page)
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
@@ -1924,19 +1887,6 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	bool stalled = false;
 
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
-
 	lru_add_drain();
 
 	spin_lock_irq(&lruvec->lru_lock);
@@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 				gfp_t gfp_mask, nodemask_t *nodemask)
 {
+	int nr_cpus;
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
 		.nr_to_reclaim = SWAP_CLUSTER_MAX,
@@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
 
+	nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
+	while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
+		if (schedule_timeout_killable(HZ / 10))
+			return SWAP_CLUSTER_MAX;
+	}
+
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
+	if (nr_cpus)
+		atomic_dec(&pgdat->nr_reclaimers);
+
 	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
