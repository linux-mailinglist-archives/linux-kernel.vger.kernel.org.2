Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A939A119
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFCMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:36:25 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:39470 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230128AbhFCMgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:36:24 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id ED5A4BADCA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:34:38 +0100 (IST)
Received: (qmail 19116 invoked from network); 3 Jun 2021 12:34:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Jun 2021 12:34:38 -0000
Date:   Thu, 3 Jun 2021 13:34:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-ID: <20210603123437.GW30378@techsingularity.net>
References: <20210603084621.24109-1-mgorman@techsingularity.net>
 <20210603084621.24109-3-mgorman@techsingularity.net>
 <1c15b083-26f8-4473-80e6-bcc2f549ba41@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1c15b083-26f8-4473-80e6-bcc2f549ba41@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 01:12:10PM +0200, Vlastimil Babka wrote:
> > From a functional point of view, a patch like this is necessary to
> > make bulk allocation of high-order pages work with similar performance
> > to order-0 bulk allocations. The bulk allocator is not updated in this
> > series as it would have to be determined by bulk allocation users how
> > they want to track the order of pages allocated with the bulk allocator.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks!

> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 0ed61f32d898..1ceaa5f44db6 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -333,6 +333,24 @@ enum zone_watermarks {
> >  	NR_WMARK
> >  };
> >  
> > +/*
> > + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER plus one additional
> > + * for pageblock size for THP if configured.
> > + */
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +#define NR_PCP_THP 1
> > +#else
> > +#define NR_PCP_THP 0
> > +#endif
> > +#define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
> > +
> > +/*
> > + * Shift to encode migratetype in order in the least significant bits and
> > + * migratetype in the higher bits.
> 
> Hard for me to understand that comment. I would describe what the code does as
> e,g, "Shift to encode migratetype and order in the same integer, with order in
> the least significant bit ..." etc.

That comment is a lot better :)

> 
> > + */
> > +#define NR_PCP_ORDER_SHIFT 8
> 
> Also ORDER_SHIFT is a bit misnomer, it's more precisely an ORDER_WIDTH, and we
> are shifting migratetype with it, not order. I'm just comparing with how we name
> nid/zid/etc bits in page flags.
> 

Ok, I can change that.

> > @@ -687,10 +687,53 @@ static void bad_page(struct page *page, const char *reason)
> >  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> >  }
> >  
> > +static inline unsigned int order_to_pindex(int migratetype, int order)
> > +{
> > +	int base = order;
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> > +		VM_BUG_ON(order != pageblock_order);
> > +		base = PAGE_ALLOC_COSTLY_ORDER + 1;
> > +	}
> > +#else
> > +	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> > +#endif
> > +
> > +	return (MIGRATE_PCPTYPES * base) + migratetype;
> > +}
> > +
> > +static inline int pindex_to_order(unsigned int pindex)
> > +{
> > +	int order = pindex / PAGE_ALLOC_COSTLY_ORDER;
> 
> This seems wrong, shouldn't we divide by MIGRATE_PCPTYPES?
> It just happens to be the same number, so testing won't flag this.
> 

Whoops, yes, basic algebra says you're right so well spotted. If
PAGE_ALLOC_COSTLY_ORDER ever changed for some reason, this would blow up.

So this?


diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bbe05289b121..f1bed5b847ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -345,11 +345,11 @@ enum zone_watermarks {
 #define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
 
 /*
- * Shift to encode migratetype in order in the least significant bits and
- * migratetype in the higher bits.
+ * Shift to encode migratetype and order in the same integer, with order
+ * in the least significant bits.
  */
-#define NR_PCP_ORDER_SHIFT 8
-#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_SHIFT) - 1)
+#define NR_PCP_ORDER_WIDTH 8
+#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_WIDTH) - 1)
 
 #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
 #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 49f3c7dcdfca..7be71f9ad9f0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -694,7 +694,7 @@ static inline unsigned int order_to_pindex(int migratetype, int order)
 
 static inline int pindex_to_order(unsigned int pindex)
 {
-	int order = pindex / PAGE_ALLOC_COSTLY_ORDER;
+	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
@@ -1487,7 +1487,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			batch_free = count;
 
 		order = pindex_to_order(pindex);
-		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_SHIFT));
+		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
 		do {
 			page = list_last_entry(list, struct page, lru);
 			/* must delete to avoid corrupting pcp list */
@@ -1499,7 +1499,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				continue;
 
 			/* Encode order with the migratetype */
-			page->index <<= NR_PCP_ORDER_SHIFT;
+			page->index <<= NR_PCP_ORDER_WIDTH;
 			page->index |= order;
 
 			list_add_tail(&page->lru, &head);
@@ -1537,7 +1537,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 
 		/* mt has been encoded with the order (see above) */
 		order = mt & NR_PCP_ORDER_MASK;
-		mt >>= NR_PCP_ORDER_SHIFT;
+		mt >>= NR_PCP_ORDER_WIDTH;
 
 		/* MIGRATE_ISOLATE page should not go to pcplists */
 		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);



-- 
Mel Gorman
SUSE Labs
