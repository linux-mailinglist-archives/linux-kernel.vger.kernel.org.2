Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742730CCB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhBBUF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:05:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:33451 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240384AbhBBUEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:04:42 -0500
IronPort-SDR: ttMbiJKim7JuOL+RoTvlqmMulO+vydZ6G8afqPze1jekOsVplvYVv10wwf53qA3Nf2qcHg4V2G
 r+4OKYPVrRAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160686273"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160686273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:03:55 -0800
IronPort-SDR: OES+swhzPW5eDUXfFVrTy/GfBdNHhwCuJFn5pI4BGKD12qdilj6y8GlinjmHZ2q3++g86RmQPr
 nNzvPUq4CSIA==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="391677087"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:03:55 -0800
Date:   Tue, 2 Feb 2021 12:03:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 1/1] mm: Optimizing hugepage zeroing in arm64
Message-ID: <20210202200354.GB3200985@iweiny-DESK2.sc.intel.com>
References: <20210202074225.7244-1-prathu.baronia@oneplus.com>
 <20210202074225.7244-2-prathu.baronia@oneplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202074225.7244-2-prathu.baronia@oneplus.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 01:12:24PM +0530, Prathu Baronia wrote:
> In !HIGHMEM cases, specially in 64-bit architectures, we don't need temp
> mapping of pages. Hence, k(map|unmap)_atomic() acts as nothing more than
> multiple barrier() calls, for example for a 2MB hugepage in
> clear_huge_page() these are called 512 times i.e. to map and unmap each
> subpage that means in total 2048 barrier calls. This called for
> optimization. Simply getting VADDR from page in the form of kmap_local_*
> APIs does the job for us.  We profiled clear_huge_page() using ftrace
> and observed an improvement of 62%.

Nice!

> 
> Setup:-
> Below data has been collected on Qualcomm's SM7250 SoC THP enabled
> (kernel
> v4.19.113) with only CPU-0(Cortex-A55) and CPU-7(Cortex-A76) switched on
> and set to max frequency, also DDR set to perf governor.
> 
> FTRACE Data:-
> 
> Base data:-
> Number of iterations: 48
> Mean of allocation time: 349.5 us
> std deviation: 74.5 us
> 
> v1 data:-
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
> v1 data:-
> Number of iterations: 100
> Mean of allocation time: 18193 us
> std deviation: 4915 us
> 
> Reported-by: Chintan Pandya <chintan.pandya@oneplus.com>
> Signed-off-by: Prathu Baronia <prathu.baronia@oneplus.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

FWIW, I have the same change in a patch in my kmap() changes branch.  However,
my patch also changes clear_highpage(), zero_user_segments(),
copy_user_highpage(), and copy_highpage().

Would changing those help you as well?

Ira

> ---
>  include/linux/highmem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index d2c70d3772a3..444df139b489 100644
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
> -- 
> 2.17.1
> 
