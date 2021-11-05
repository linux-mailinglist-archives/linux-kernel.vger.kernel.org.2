Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED6446769
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhKEQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:59:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:45827 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhKEQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:59:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="219136683"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="219136683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:56:16 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="668299463"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:56:16 -0700
Date:   Fri, 5 Nov 2021 09:56:16 -0700
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
Message-ID: <20211105165616.GZ3538886@iweiny-DESK2.sc.intel.com>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYU2YSOGHJFIrzmm@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 01:49:21PM +0000, Matthew Wilcox wrote:
> On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> > On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > > testing information I hope this can land.
> > > 
> > > Andrew did you see this patch?
> > 
> > I did now ;)
> > 
> > Tossed onto the post-rc1 pile, thanks,
> 
> This patch seems to have slipped through the gaps for a couple of cycles
> now?  I found a missed spot in it for CONFIG_HIGHMEM:
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 471d9779a7f4..82d8c5ab6e8d 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -382,7 +382,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  			unsigned this_end = min_t(unsigned, end1, PAGE_SIZE);
>  
>  			if (end1 > start1) {
> -				kaddr = kmap_atomic(page + i);
> +				kaddr = kmap_local(page + i);

kmap_local_page()

>  				memset(kaddr + start1, 0, this_end - start1);
>  			}
>  			end1 -= this_end;
> @@ -397,7 +397,7 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  
>  			if (end2 > start2) {
>  				if (!kaddr)
> -					kaddr = kmap_atomic(page + i);
> +					kaddr = kmap_local(page + i);

kmap_local_page()

I'm ok with this.  I'm not sure if Prathu needed this or not.

Also I wonder if memset_page could be used?  It would end up mapping the page
2x sometimes.

As an aside I think flush_dcache_page() needs to be in memset_page() for
completeness but I'm a bit afraid of adding it with the current controversy...
:-/

Anyway, why hasn't Brathu's patch[1] landed yet?

I just checked 5.15 and it is not there?  I don't even see it in the 5.16
merge?  Perhaps it is coming in this merge window?  Andrew?

Ira

[1] https://lore.kernel.org/lkml/20210204073255.20769-2-prathu.baronia@oneplus.com/

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


