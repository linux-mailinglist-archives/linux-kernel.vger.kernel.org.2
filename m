Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D770446785
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhKERHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:07:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:49761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhKERHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:07:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="231786284"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="231786284"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:58:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="450638454"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:58:59 -0700
Date:   Fri, 5 Nov 2021 09:58:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-ID: <20211105165859.GA3538886@iweiny-DESK2.sc.intel.com>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org>
 <YYVhHCJcm2DM2G9u@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYVhHCJcm2DM2G9u@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 04:51:40PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 05, 2021 at 01:50:37PM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> > > On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > > 
> > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > 
> > > > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > > > testing information I hope this can land.
> > > > 
> > > > Andrew did you see this patch?
> > > 
> > > I did now ;)
> > > 
> > > Tossed onto the post-rc1 pile, thanks,
> > 
> > This patch seems to have slipped through the gaps for a couple of cycles
> > now?  I found a missed spot in it for CONFIG_HIGHMEM:
> 
> Ugh, sorry, wrong version of the patch.

Check!  Yea this works for me...

I think this should to through as a separate patch because Prathu's has been
soaking for some time.  No need to complicate it with this.

FWIW you can add:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

When you submit this.

Ira

> 
> ---
>  mm/highmem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 471d9779a7f4..88f65f155845 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -382,7 +382,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  			unsigned this_end = min_t(unsigned, end1, PAGE_SIZE);
>  
>  			if (end1 > start1) {
> -				kaddr = kmap_atomic(page + i);
> +				kaddr = kmap_local_page(page + i);
>  				memset(kaddr + start1, 0, this_end - start1);
>  			}
>  			end1 -= this_end;
> @@ -397,7 +397,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  
>  			if (end2 > start2) {
>  				if (!kaddr)
> -					kaddr = kmap_atomic(page + i);
> +					kaddr = kmap_local_page(page + i);
>  				memset(kaddr + start2, 0, this_end - start2);
>  			}
>  			end2 -= this_end;
> @@ -405,7 +405,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  		}
>  
>  		if (kaddr) {
> -			kunmap_atomic(kaddr);
> +			kunmap_local(kaddr);
>  			flush_dcache_page(page + i);
>  		}
>  
> -- 
> 2.33.0
> 
