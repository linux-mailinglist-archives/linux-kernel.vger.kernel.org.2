Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7485F360397
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhDOHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:42:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:42807 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhDOHmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:42:21 -0400
IronPort-SDR: 8VyL5GpXMZQz8Att7+QMGcAxj9tJBp/3HCwdryE/3WptDGVifOefDNsnOp1UFYWcWz4Q8HbZdr
 acG2E0zxXzHg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="192680522"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="192680522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 00:41:57 -0700
IronPort-SDR: 6L5AYO8ltjmCOblx6iq8FIwhqD26Z7/LPF5t8obwDF1rr6WSyHtJiYB8Dhya8dXCl2/tPpdGVf
 0dCdBQURPPDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="522275586"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2021 00:41:53 -0700
Date:   Thu, 15 Apr 2021 15:41:52 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 11/13] mm/mempolicy: huge-page allocation for many
 preferred
Message-ID: <20210415074152.GA61572@shbuild999.sh.intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-12-git-send-email-feng.tang@intel.com>
 <YHbtTtEfCICx/yME@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbtTtEfCICx/yME@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Many thanks for reviewing the whole patchset! We will check them.

On Wed, Apr 14, 2021 at 03:25:34PM +0200, Michal Hocko wrote:
> Please use hugetlb prefix to make it explicit that this is hugetlb
> related.
> 
> On Wed 17-03-21 11:40:08, Feng Tang wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > Implement the missing huge page allocation functionality while obeying
> > the preferred node semantics.
> > 
> > This uses a fallback mechanism to try multiple preferred nodes first,
> > and then all other nodes. It cannot use the helper function that was
> > introduced because huge page allocation already has its own helpers and
> > it was more LOC, and effort to try to consolidate that.
> > 
> > The weirdness is MPOL_PREFERRED_MANY can't be called yet because it is
> > part of the UAPI we haven't yet exposed. Instead of make that define
> > global, it's simply changed with the UAPI patch.
> > 
> > [ feng: add NOWARN flag, and skip the direct reclaim to speedup allocation
> >   in some case ]
> > 
> > Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/hugetlb.c   | 26 +++++++++++++++++++++++---
> >  mm/mempolicy.c |  3 ++-
> >  2 files changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8fb42c6..9dfbfa3 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1105,7 +1105,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
> >  				unsigned long address, int avoid_reserve,
> >  				long chg)
> >  {
> > -	struct page *page;
> > +	struct page *page = NULL;
> >  	struct mempolicy *mpol;
> >  	gfp_t gfp_mask;
> >  	nodemask_t *nodemask;
> > @@ -1126,7 +1126,17 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
> >  
> >  	gfp_mask = htlb_alloc_mask(h);
> >  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> > -	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> > +	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
> 
> Please use MPOL_PREFERRED_MANY explicitly here.
> 
> > +		gfp_t gfp_mask1 = gfp_mask | __GFP_NOWARN;
> > +
> > +		gfp_mask1 &= ~__GFP_DIRECT_RECLAIM;
> > +		page = dequeue_huge_page_nodemask(h,
> > +				gfp_mask1, nid, nodemask);
> > +		if (!page)
> > +			page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
> > +	} else {
> > +		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> > +	}
> >  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> >  		SetHPageRestoreReserve(page);
> >  		h->resv_huge_pages--;
> 
> __GFP_DIRECT_RECLAIM handing is not needed here. dequeue_huge_page_nodemask 
> only uses gfp mask to get zone and cpusets constraines. So the above
> should have simply been
> 	if (mpol->mode == MPOL_PREFERRED_MANY) {
> 		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> 		if (page)
> 			goto got_page;
> 		/* fallback to all nodes */
> 		nodemask = NULL;
> 	}
> 	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> got_page:
> 	if (page ...)

You are right, no need to change the gfp_mask here.


> > @@ -1883,7 +1893,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
> >  	nodemask_t *nodemask;
> >  
> >  	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
> > -	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
> > +	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
> > +		gfp_t gfp_mask1 = gfp_mask | __GFP_NOWARN;
> > +
> > +		gfp_mask1 &= ~__GFP_DIRECT_RECLAIM;
> > +		page = alloc_surplus_huge_page(h,
> > +				gfp_mask1, nid, nodemask);
> > +		if (!page)
> > +			alloc_surplus_huge_page(h, gfp_mask, nid, NULL);
> > +	} else {
> > +		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
> > +	}
> 
> And here similar
> 	if (mpol->mode == MPOL_PREFERRED_MANY) {
> 		page = alloc_surplus_huge_page(h, (gfp_mask | __GFP_NOWARN) & ~(__GFP_DIRECT_RECLAIM), nodemask);
> 		if (page)
> 			goto got_page;
> 		/* fallback to all nodes */
> 		nodemask = NULL;
> 	}
> 	page = alloc_surplus_huge_page(h, gfp_mask, nodemask);
> got_page:
> >  	mpol_cond_put(mpol);
> 
> You can have a dedicated gfp mask here if you prefer of course but I
> calling out MPOL_PREFERRED_MANY explicitly will make the code easier to
> read.

Will follow. The "if (mpol->mode != MPOL_BIND && nodemask) {
/* AKA MPOL_PREFERRED_MANY *a/ " and "MPOL_MAX + 1" will be replaced
in the 12/13 patch.

Thanks,
Feng

> >  	return page;
> -- 
> Michal Hocko
> SUSE Labs
