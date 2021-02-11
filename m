Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADF83182AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 01:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhBKAdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:33:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:25775 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhBKAdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:33:51 -0500
IronPort-SDR: eqywnbvDESL52bMFyZbqCXaBI2xW8bEM4DKh9iYoX8vH6DyZBOjDr8YxI9GpqR4n4H6oxX4+HW
 PymEdJpzFSMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179616564"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="179616564"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 16:33:10 -0800
IronPort-SDR: P9lXBacJMoTJJ2bIflAS4zUodEwPknlaxUCr4WyjO03lqbk8/46omSIM/StoCvT31EWxoWI8eE
 fk35asmyRa3A==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="436881733"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 16:33:09 -0800
Date:   Wed, 10 Feb 2021 16:33:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Prathu Baronia <prathubaronia2011@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-ID: <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204073255.20769-2-prathu.baronia@oneplus.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:02:53PM +0530, Prathu Baronia wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap_atomic() is being deprecated in favor of kmap_local_page().
> 
> Replace the uses of kmap_atomic() within the highmem code.
> 
> On profiling clear_huge_page() using ftrace an improvement
> of 62% was observed on the below setup.
> 
> Setup:-
> Below data has been collected on Qualcomm's SM7250 SoC THP enabled
> (kernel v4.19.113) with only CPU-0(Cortex-A55) and CPU-7(Cortex-A76)
> switched on and set to max frequency, also DDR set to perf governor.
> 
> FTRACE Data:-
> 
> Base data:-
> Number of iterations: 48
> Mean of allocation time: 349.5 us
> std deviation: 74.5 us
> 
> v4 data:-
> Number of iterations: 48
> Mean of allocation time: 131 us
> std deviation: 32.7 us
> 
> The following simple userspace experiment to allocate
> 100MB(BUF_SZ) of pages and writing to it gave us a good insight,
> we observed an improvement of 42% in allocation and writing timings.
> -------------------------------------------------------------
> Test code snippet
> -------------------------------------------------------------
>       clock_start();
>       buf = malloc(BUF_SZ); /* Allocate 100 MB of memory */
> 
>         for(i=0; i < BUF_SZ_PAGES; i++)
>         {
>                 *((int *)(buf + (i*PAGE_SIZE))) = 1;
>         }
>       clock_end();
> -------------------------------------------------------------
> 
> Malloc test timings for 100MB anon allocation:-
> 
> Base data:-
> Number of iterations: 100
> Mean of allocation time: 31831 us
> std deviation: 4286 us
> 
> v4 data:-
> Number of iterations: 100
> Mean of allocation time: 18193 us
> std deviation: 4915 us
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

This already has my signed off by so I'm not going to 'review'.  With Prathu's
testing information I hope this can land.

Andrew did you see this patch?

Thanks,
Ira

> Signed-off-by: Prathu Baronia <prathu.baronia@oneplus.com>
> [Updated commit text with test data]
> ---
>  include/linux/highmem.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index d2c70d3772a3..9a202c7e4e26 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -146,9 +146,9 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>  #ifndef clear_user_highpage
>  static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>  {
> -	void *addr = kmap_atomic(page);
> +	void *addr = kmap_local_page(page);
>  	clear_user_page(addr, vaddr, page);
> -	kunmap_atomic(addr);
> +	kunmap_local(addr);
>  }
>  #endif
>  
> @@ -199,9 +199,9 @@ alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
>  
>  static inline void clear_highpage(struct page *page)
>  {
> -	void *kaddr = kmap_atomic(page);
> +	void *kaddr = kmap_local_page(page);
>  	clear_page(kaddr);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  }
>  
>  /*
> @@ -216,7 +216,7 @@ static inline void zero_user_segments(struct page *page,
>  		unsigned start1, unsigned end1,
>  		unsigned start2, unsigned end2)
>  {
> -	void *kaddr = kmap_atomic(page);
> +	void *kaddr = kmap_local_page(page);
>  	unsigned int i;
>  
>  	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
> @@ -227,7 +227,7 @@ static inline void zero_user_segments(struct page *page,
>  	if (end2 > start2)
>  		memset(kaddr + start2, 0, end2 - start2);
>  
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	for (i = 0; i < compound_nr(page); i++)
>  		flush_dcache_page(page + i);
>  }
> @@ -252,11 +252,11 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
>  {
>  	char *vfrom, *vto;
>  
> -	vfrom = kmap_atomic(from);
> -	vto = kmap_atomic(to);
> +	vfrom = kmap_local_page(from);
> +	vto = kmap_local_page(to);
>  	copy_user_page(vto, vfrom, vaddr, to);
> -	kunmap_atomic(vto);
> -	kunmap_atomic(vfrom);
> +	kunmap_local(vto);
> +	kunmap_local(vfrom);
>  }
>  
>  #endif
> @@ -267,11 +267,11 @@ static inline void copy_highpage(struct page *to, struct page *from)
>  {
>  	char *vfrom, *vto;
>  
> -	vfrom = kmap_atomic(from);
> -	vto = kmap_atomic(to);
> +	vfrom = kmap_local_page(from);
> +	vto = kmap_local_page(to);
>  	copy_page(vto, vfrom);
> -	kunmap_atomic(vto);
> -	kunmap_atomic(vfrom);
> +	kunmap_local(vto);
> +	kunmap_local(vfrom);
>  }
>  
>  #endif
> -- 
> 2.17.1
> 
