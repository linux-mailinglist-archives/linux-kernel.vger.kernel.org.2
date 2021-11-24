Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667CB45C778
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353795AbhKXOg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:36:29 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:43435 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351696AbhKXOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:36:18 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 951941C4550
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 14:33:06 +0000 (GMT)
Received: (qmail 23707 invoked from network); 24 Nov 2021 14:33:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Nov 2021 14:33:06 -0000
Date:   Wed, 24 Nov 2021 14:33:03 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        vbabka@suse.cz, neilb@suse.de, akpm@linux-foundation.org,
        corbet@lwn.net, riel@surriel.com, hannes@cmpxchg.org,
        david@fromorbit.com, willy@infradead.org, hdanton@sina.com,
        penguin-kernel@i-love.sakura.ne.jp, oleksandr@natalenko.name,
        kernel@xanmod.org, michael@michaellarabel.com, aros@gmx.com,
        hakavlad@gmail.com
Subject: Re: mm: 5.16 regression: reclaim_throttle leads to stall in near-OOM
 conditions
Message-ID: <20211124143303.GH3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
 <20211124103550.GE3366@techsingularity.net>
 <20211124195449.33f31e7f@mail.inbox.lv>
 <20211124115007.GG3366@techsingularity.net>
 <20211124214443.5c179d34@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211124214443.5c179d34@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 09:44:43PM +0900, Alexey Avramov wrote:
> > can you test this?
> 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> 
> Sorry, I didn't notice the diff you provided right away.
> 
> Now I've tested it and the result is the same: 1 min stall:
> 
> $ mem2log
> Starting mem2log with interval 2s, mode: 1
> Process memory locked with MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT
> All values are in mebibytes
> MemTotal: 11798.5, SwapTotal: 0.0

Curious that it's the same, it reduced the time to OOM for me quite a
bit. Another version is in a diff below. It special cases NOPROGRESS
to not stall at all if kswapd is disabled and otherwise stall for the
shortest possible duration. For my tests, it almost always hits OOM in
the same time as 5.15 with one corner case but OOM may still be delayed if
kswapd active or there are a lot of pages under writeback as there is the
possibility the system can make forward progress when writeback completes.

From another mail, you wrote

> My dissatisfaction is caused by the fact that the scale has now
> tipped sharply in favor of stall.

Understandable but the old throttling mechanism was functionally broken and
without some sort of throttling, CPU usage due to excessive LRU scanning
causes a different class of bugs.

> Although even before this change, users complained about the inability
> to wait for OOM:
> https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/

I think there might be an unwritten mm law now that someone is always
unhappy with OOM behaviour :(

Please let me know if this version works any better

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 07db03883062..d9166e94eb95 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1057,7 +1057,17 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 
 		break;
 	case VMSCAN_THROTTLE_NOPROGRESS:
-		timeout = HZ/2;
+		timeout = 1;
+
+		/*
+		 * If kswapd is disabled, reschedule if necessary but do not
+		 * throttle as the system is likely near OOM.
+		 */
+		if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES) {
+			cond_resched();
+			return;
+		}
+
 		break;
 	case VMSCAN_THROTTLE_ISOLATED:
 		timeout = HZ/50;
@@ -3395,7 +3405,7 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 		return;
 
 	/* Throttle if making no progress at high prioities. */
-	if (sc->priority < DEF_PRIORITY - 2)
+	if (sc->priority < DEF_PRIORITY - 2 && !sc->nr_reclaimed)
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
@@ -3415,6 +3425,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
 	pg_data_t *last_pgdat = NULL;
+	pg_data_t *first_pgdat = NULL;
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -3478,14 +3489,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			/* need some check for avoid more shrink_zone() */
 		}
 
+		if (!first_pgdat)
+			first_pgdat = zone->zone_pgdat;
+
 		/* See comment about same check for global reclaim above */
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
 		shrink_node(zone->zone_pgdat, sc);
-		consider_reclaim_throttle(zone->zone_pgdat, sc);
 	}
 
+	consider_reclaim_throttle(first_pgdat, sc);
+
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
 	 * promoted it to __GFP_HIGHMEM.
-- 
Mel Gorman
SUSE Labs
