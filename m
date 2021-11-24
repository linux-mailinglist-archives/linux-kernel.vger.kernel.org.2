Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3C45C81A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbhKXO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:59:42 -0500
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:55281 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347885AbhKXO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:59:35 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id EA194FB06F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 14:56:23 +0000 (GMT)
Received: (qmail 25417 invoked from network); 24 Nov 2021 14:56:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Nov 2021 14:56:23 -0000
Date:   Wed, 24 Nov 2021 14:56:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
Message-ID: <20211124145621.GJ3366@techsingularity.net>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
 <20211123091304.GC3366@techsingularity.net>
 <21c3489c7ce8342d392c08547a3222a9c289e9fc.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <21c3489c7ce8342d392c08547a3222a9c289e9fc.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:18:01PM +0100, Mike Galbraith wrote:
> On Tue, 2021-11-23 at 09:13 +0000, Mel Gorman wrote:
> >
> > I'll see can I reproduce this...
> 
> You likely already know this, but just in case, just plunk the below
> into $LTPROOT/runtest/foo, and $LTPROOT/runltp -f foo.
> 
> #DESCRIPTION:Resource Management testing
> memcg_regression        memcg_regression_test.sh
> 

Thanks. Can you try the following patch please?

The test will still take longer to reach OOM and complete as it's stalling
but not as severely.

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
