Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8D392C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhE0KyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:54:20 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:46465 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236221AbhE0KyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:54:17 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id C4608FB19B
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 11:52:43 +0100 (IST)
Received: (qmail 18388 invoked from network); 27 May 2021 10:52:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 May 2021 10:52:43 -0000
Date:   Thu, 27 May 2021 11:52:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/6] mm/page_alloc: Disassociate the pcp->high from
 pcp->batch
Message-ID: <20210527105241.GB30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-3-mgorman@techsingularity.net>
 <10cb326c-b4ad-3a82-a38b-aba7d2192736@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <10cb326c-b4ad-3a82-a38b-aba7d2192736@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:14:13PM +0200, Vlastimil Babka wrote:
> > @@ -6698,11 +6717,10 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
> >   */
> >  static void zone_set_pageset_high_and_batch(struct zone *zone)
> >  {
> > -	unsigned long new_high, new_batch;
> > +	int new_high, new_batch;
> >  
> > -	new_batch = zone_batchsize(zone);
> > -	new_high = 6 * new_batch;
> > -	new_batch = max(1UL, 1 * new_batch);
> > +	new_batch = max(1, zone_batchsize(zone));
> > +	new_high = zone_highsize(zone, new_batch);
> >  
> >  	if (zone->pageset_high == new_high &&
> >  	    zone->pageset_batch == new_batch)
> > @@ -8170,6 +8188,12 @@ static void __setup_per_zone_wmarks(void)
> >  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
> >  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
> >  
> > +		/*
> > +		 * The watermark size have changed so update the pcpu batch
> > +		 * and high limits or the limits may be inappropriate.
> > +		 */
> > +		zone_set_pageset_high_and_batch(zone);
> 
> Hm so this puts the call in the path of various watermark related sysctl
> handlers, but it's not protected by pcp_batch_high_lock. The zone lock won't
> help against zone_pcp_update() from a hotplug handler. On the other hand, since
> hotplug handlers also call __setup_per_zone_wmarks(), the zone_pcp_update()
> calls there are now redundant and could be removed, no?
> But later there will be a new sysctl in patch 6/6 using pcp_batch_high_lock,
> thus that one will not be protected against the watermark related sysctl
> handlers that reach here.
> 
> To solve all this, seems like the static lock in setup_per_zone_wmarks() could
> become a top-level visible lock and pcp high/batch updates could switch to that
> one instead of own pcp_batch_high_lock. And zone_pcp_update() calls from hotplug
> handlers could be removed.
> 

Hmm, the locking has very different hold times. The static lock in
setup_per_zone_wmarks is a spinlock that protects against parallel updates
of watermarks and is held for a short duration. The pcp_batch_high_lock
is a mutex that is held for a relatively long time while memory is being
offlined and can sleep. Memory hotplug updates the watermarks without
pcp_batch_high_lock held so overall, unifying the locking there should
be a separate series.

How about this as a fix for this patch?

---8<---
mm/page_alloc: Disassociate the pcp->high from pcp->batch -fix

Vlastimil Babka noted that __setup_per_zone_wmarks updating pcp->high
did not protect watermark-related sysctl handlers from a parallel
memory hotplug operations. This patch moves the PCP update to
setup_per_zone_wmarks and updates the PCP high value while protected
by the pcp_batch_high_lock mutex.

This is a fix to the mmotm patch mm-page_alloc-disassociate-the-pcp-high-from-pcp-batch.patch.
It'll cause a conflict with mm-page_alloc-adjust-pcp-high-after-cpu-hotplug-events.patch
but the resolution is simply to change the caller in setup_per_zone_wmarks
to zone_pcp_update(zone, 0)

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 329b71e41db4..b1b3c66e9d88 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8199,12 +8199,6 @@ static void __setup_per_zone_wmarks(void)
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
 
-		/*
-		 * The watermark size have changed so update the pcpu batch
-		 * and high limits or the limits may be inappropriate.
-		 */
-		zone_set_pageset_high_and_batch(zone);
-
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -8221,11 +8215,19 @@ static void __setup_per_zone_wmarks(void)
  */
 void setup_per_zone_wmarks(void)
 {
+	struct zone *zone;
 	static DEFINE_SPINLOCK(lock);
 
 	spin_lock(&lock);
 	__setup_per_zone_wmarks();
 	spin_unlock(&lock);
+
+	/*
+	 * The watermark size have changed so update the pcpu batch
+	 * and high limits or the limits may be inappropriate.
+	 */
+	for_each_zone(zone)
+		zone_pcp_update(zone);
 }
 
 /*
