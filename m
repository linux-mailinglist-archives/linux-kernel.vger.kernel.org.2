Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2161645F1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354387AbhKZQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:29:34 -0500
Received: from outbound-smtp03.blacknight.com ([81.17.249.16]:49571 "EHLO
        outbound-smtp03.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238131AbhKZQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:27:32 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id D4153C0D59
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:24:18 +0000 (GMT)
Received: (qmail 24859 invoked from network); 26 Nov 2021 16:24:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Nov 2021 16:24:18 -0000
Date:   Fri, 26 Nov 2021 16:24:16 +0000
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
Message-ID: <20211126162416.GK3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
 <20211124103550.GE3366@techsingularity.net>
 <20211124195449.33f31e7f@mail.inbox.lv>
 <20211124115007.GG3366@techsingularity.net>
 <20211124214443.5c179d34@mail.inbox.lv>
 <20211124143303.GH3366@techsingularity.net>
 <20211127010631.4e33a432@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211127010631.4e33a432@mail.inbox.lv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 01:06:31AM +0900, Alexey Avramov wrote:
> >Please let me know if this version works any better
> 
> It's better, but not the same as 5.15.
> 
> Sometimes stall is short, sometimes is long (3 `tail /dev/zero` test):
> 

It's somewhat expected. If the system is able to make some sort of
progress and kswapd is active, it'll throttle until progress is
impossible. It'll be somewhat variable how long it can keep making
progress be it discarding page cache or writing to swap but it'll only
OOM when the system is truly OOM.

Might be worth trying the patch below on top. It will delay throttling
for longer with the caveat that CPU usage due to reclaim when very low
on memory may be excessive.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 176ddd28df21..167ea4f324a8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3404,8 +3404,8 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 	if (current_is_kswapd())
 		return;
 
-	/* Throttle if making no progress at high prioities. */
-	if (sc->priority < DEF_PRIORITY - 2 && !sc->nr_reclaimed)
+	/* Throttle if making no progress at high priority. */
+	if (sc->priority == 1 && !sc->nr_reclaimed)
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }

