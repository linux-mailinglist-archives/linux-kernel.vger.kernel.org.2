Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50A45B981
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbhKXLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:53:24 -0500
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:41139 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241850AbhKXLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:53:19 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 3B899BED80
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:50:09 +0000 (GMT)
Received: (qmail 1218 invoked from network); 24 Nov 2021 11:50:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Nov 2021 11:50:09 -0000
Date:   Wed, 24 Nov 2021 11:50:07 +0000
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
Message-ID: <20211124115007.GG3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
 <20211124103550.GE3366@techsingularity.net>
 <20211124195449.33f31e7f@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211124195449.33f31e7f@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 07:54:49PM +0900, Alexey Avramov wrote:
> > it does eventually get killed OOM
> 
> However, a full minute freeze can be a great evil in many situations - 
> during such a freeze, the system is completely unresponsive. 
> 
> So my next question is: How reasonable is the value MAX_RECLAIM_RETRIES?
> Is it also get "out of thin air"?
> 

The value is out of thin air but adjusting it may reintroduce issues
with kswapd running at 100% CPU.

> And would it make sense to have buttons to adjust the timeouts?

I don't think we should introduce a tunable for something like this,
it'll be impossible to use properly but can you test this?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 07db03883062..aa72c0f39dcc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1058,6 +1058,14 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 		break;
 	case VMSCAN_THROTTLE_NOPROGRESS:
 		timeout = HZ/2;
+
+		/*
+		 * If kswapd is disabled, use the minimum timeout as the
+		 * system may be at or near OOM.
+		 */
+		if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+			timeout = 1;
+
 		break;
 	case VMSCAN_THROTTLE_ISOLATED:
 		timeout = HZ/50;
@@ -3395,7 +3403,7 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 		return;
 
 	/* Throttle if making no progress at high prioities. */
-	if (sc->priority < DEF_PRIORITY - 2)
+	if (sc->priority < DEF_PRIORITY - 2 && !sc->nr_reclaimed)
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
@@ -3415,6 +3423,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
 	pg_data_t *last_pgdat = NULL;
+	pg_data_t *first_pgdat = NULL;
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -3478,14 +3487,18 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
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
