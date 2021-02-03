Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0066130E370
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBCTmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:42:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:31775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhBCTmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:42:32 -0500
IronPort-SDR: MF7m5DVHJ9MqvZJjqp1rOvQ1Y9goDrDYOivSPOWi/UOmQv+uAa0cvb3+jdf+XRJ2dHwsvCiaSi
 jjxJREMdDDxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168786540"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168786540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:42:12 -0800
IronPort-SDR: 5PXk2IM/lL7HaK0MhY3Qyh8dIXUEIa71n2wUZ67klgH2pq/sIM5IXz8kGgGiG5t6xtWepomcl/
 GbHMGxsFrRYg==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="576012095"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:42:12 -0800
Date:   Wed, 3 Feb 2021 11:42:11 -0800
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
Message-ID: <20210203194211.GE3200985@iweiny-DESK2.sc.intel.com>
References: <20210202074225.7244-1-prathu.baronia@oneplus.com>
 <20210202074225.7244-2-prathu.baronia@oneplus.com>
 <20210202200354.GB3200985@iweiny-DESK2.sc.intel.com>
 <CAJp9fscSi1yqcZagc7HzKV1h99X0wP6FWuQx8OpnqwgSp8yA5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJp9fscSi1yqcZagc7HzKV1h99X0wP6FWuQx8OpnqwgSp8yA5A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:08:08PM +0530, Prathu Baronia wrote:
>    Hey Ira,
>    I looked at your below-mentioned patch and I agree that the
>    above-mentioned functions also need modification similar to
>    clear_user_highpage().
>    Would it be okay with you if I send your patch again with a modified
>    commit message by adding my data and maintaining your authorship?
>    [1]https://lore.kernel.org/lkml/20201210171834.2472353-2-ira.weiny@intel.com/

Sure.  I have not changed the patch at all from that version.

Andrew, will this be going through your tree?  If not who?

If you take the above patch I can drop it from the series I'm about to submit
to convert btrfs kmaps.

Ira

>    Regards,
>    Prathu Baronia
> 
>    On Wed, Feb 3, 2021 at 1:33 AM Ira Weiny <[2]ira.weiny@intel.com> wrote:
> 
>      On Tue, Feb 02, 2021 at 01:12:24PM +0530, Prathu Baronia wrote:
>      > In !HIGHMEM cases, specially in 64-bit architectures, we don't need
>      temp
>      > mapping of pages. Hence, k(map|unmap)_atomic() acts as nothing more
>      than
>      > multiple barrier() calls, for example for a 2MB hugepage in
>      > clear_huge_page() these are called 512 times i.e. to map and unmap
>      each
>      > subpage that means in total 2048 barrier calls. This called for
>      > optimization. Simply getting VADDR from page in the form of
>      kmap_local_*
>      > APIs does the job for us.  We profiled clear_huge_page() using ftrace
>      > and observed an improvement of 62%.
> 
>      Nice!
> 
>      >
>      > Setup:-
>      > Below data has been collected on Qualcomm's SM7250 SoC THP enabled
>      > (kernel
>      > v4.19.113) with only CPU-0(Cortex-A55) and CPU-7(Cortex-A76) switched
>      on
>      > and set to max frequency, also DDR set to perf governor.
>      >
>      > FTRACE Data:-
>      >
>      > Base data:-
>      > Number of iterations: 48
>      > Mean of allocation time: 349.5 us
>      > std deviation: 74.5 us
>      >
>      > v1 data:-
>      > Number of iterations: 48
>      > Mean of allocation time: 131 us
>      > std deviation: 32.7 us
>      >
>      > The following simple userspace experiment to allocate
>      > 100MB(BUF_SZ) of pages and writing to it gave us a good insight,
>      > we observed an improvement of 42% in allocation and writing timings.
>      > -------------------------------------------------------------
>      > Test code snippet
>      > -------------------------------------------------------------
>      >       clock_start();
>      >       buf = malloc(BUF_SZ); /* Allocate 100 MB of memory */
>      >
>      >         for(i=0; i < BUF_SZ_PAGES; i++)
>      >         {
>      >                 *((int *)(buf + (i*PAGE_SIZE))) = 1;
>      >         }
>      >       clock_end();
>      > -------------------------------------------------------------
>      >
>      > Malloc test timings for 100MB anon allocation:-
>      >
>      > Base data:-
>      > Number of iterations: 100
>      > Mean of allocation time: 31831 us
>      > std deviation: 4286 us
>      >
>      > v1 data:-
>      > Number of iterations: 100
>      > Mean of allocation time: 18193 us
>      > std deviation: 4915 us
>      >
>      > Reported-by: Chintan Pandya <[3]chintan.pandya@oneplus.com>
>      > Signed-off-by: Prathu Baronia <[4]prathu.baronia@oneplus.com>
> 
>      Reviewed-by: Ira Weiny <[5]ira.weiny@intel.com>
> 
>      FWIW, I have the same change in a patch in my kmap() changes branch. 
>      However,
>      my patch also changes clear_highpage(), zero_user_segments(),
>      copy_user_highpage(), and copy_highpage().
> 
>      Would changing those help you as well?
> 
>      Ira
> 
>      > ---
>      >  include/linux/highmem.h | 4 ++--
>      >  1 file changed, 2 insertions(+), 2 deletions(-)
>      >
>      > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>      > index d2c70d3772a3..444df139b489 100644
>      > --- a/include/linux/highmem.h
>      > +++ b/include/linux/highmem.h
>      > @@ -146,9 +146,9 @@ static inline void
>      invalidate_kernel_vmap_range(void *vaddr, int size)
>      >  #ifndef clear_user_highpage
>      >  static inline void clear_user_highpage(struct page *page, unsigned
>      long vaddr)
>      >  {
>      > -     void *addr = kmap_atomic(page);
>      > +     void *addr = kmap_local_page(page);
>      >       clear_user_page(addr, vaddr, page);
>      > -     kunmap_atomic(addr);
>      > +     kunmap_local(addr);
>      >  }
>      >  #endif
>      > 
>      > --
>      > 2.17.1
>      >
> 
> References
> 
>    Visible links
>    1. https://lore.kernel.org/lkml/20201210171834.2472353-2-ira.weiny@intel.com/
>    2. mailto:ira.weiny@intel.com
>    3. mailto:chintan.pandya@oneplus.com
>    4. mailto:prathu.baronia@oneplus.com
>    5. mailto:ira.weiny@intel.com
