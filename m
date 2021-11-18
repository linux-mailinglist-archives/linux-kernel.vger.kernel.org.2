Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF64557F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbhKRJZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:25:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbhKRJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:25:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48E1321763;
        Thu, 18 Nov 2021 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637227357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6iiWQeeIKLNGLnUwc8/VbB9r+gV+5b2XZV6BZvYfco=;
        b=kecWV1Ad/JRMeprX80gouQRTuyWFJjecbRj2QGb7406UCMNuemOzEqK4qPtiN3vr0Bkeo+
        VigrxkcImtS51/CliB4OoDpfyIzMgUCq3imyADdiv/4c/uNGOIoThG1QZA1FRHaUUI9+Fk
        zBf/JE719T4ZUrTU9Udc9PTGFThXgX0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15D1AA3B81;
        Thu, 18 Nov 2021 09:22:37 +0000 (UTC)
Date:   Thu, 18 Nov 2021 10:22:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZYbXC/ycmif8WIE@dhcp22.suse.cz>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Mel]

On Wed 17-11-21 15:39:30, Neil Brown wrote:
> 
> __GFP_ATOMIC serves little purpose.
> It's main effect is to set ALLOC_HARDER which adds a few little boosts to
> increase the chance of an allocation succeeding, one of which is to
> lower the water-mark at which it will succeed.
> 
> It is *always* paired with __GFP_HIGH which sets ALLOC_HIGH which also
> adjusts this watermark.  It is probable that other users of __GFP_HIGH
> should benefit from the other little bonuses that __GFP_ATOMIC gets.
> 
> __GFP_ATOMIC also gives a warning if used with __GFP_DIRECT_RECLAIM.
> There is little point to this.  We already get a might_sleep() warning
> if __GFP_DIRECT_RECLAIM is set.
> 
> __GFP_ATOMIC allows the "watermark_boost" to be side-stepped.  It is
> probable that testing ALLOC_HARDER is a better fit here.
> 
> __GFP_ATOMIC is used by tegra-smmu.c to check if the allocation might
> sleep.  This should test __GFP_DIRECT_RECLAIM instead.
> 
> This patch:
>  - removes __GFP_ATOMIC
>  - causes __GFP_HIGH to set ALLOC_HARDER unless __GFP_NOMEMALLOC is set
>    (as well as ALLOC_HIGH).
>  - makes other adjustments as suggested by the above.
> 
> The net result is not change to GFP_ATOMIC allocations.  Other
> allocations that use __GFP_HIGH will benefit from a few different extra
> privileges.  This affects:
>   xen, dm, md, ntfs3
>   the vermillion frame buffer
>   hibernation
>   ksm
>   swap
> all of which likely produce more benefit than cost if these selected
> allocation are more likely to succeed quickly.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> This patch came out of my attempts to review and document some of the
> __GFP flags.  I couldn't find that __GFP_ATOMIC meant anything really
> useful, so I thought that discarding it would be best.
> 
> Obviously GFP_ATOMIC is useful - just not __GFP_ATOMIC (and the fact
> that both names exist could be seen as a warning sign).
> 
> Thanks,
> NeilBrown
> 
> 
>  Documentation/vm/balance.rst         |  2 +-
>  drivers/iommu/tegra-smmu.c           |  4 ++--
>  include/linux/gfp.h                  | 12 ++++--------
>  include/trace/events/mmflags.h       |  1 -
>  lib/test_printf.c                    |  8 ++++----
>  mm/internal.h                        |  3 +--
>  mm/memcontrol.c                      |  2 +-
>  mm/page_alloc.c                      | 16 ++++------------
>  tools/perf/builtin-kmem.c            |  1 -
>  tools/testing/radix-tree/linux/gfp.h |  3 +--
>  10 files changed, 18 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/vm/balance.rst b/Documentation/vm/balance.rst
> index 6a1fadf3e173..e38e9d83c1c7 100644
> --- a/Documentation/vm/balance.rst
> +++ b/Documentation/vm/balance.rst
> @@ -6,7 +6,7 @@ Memory Balancing
>  
>  Started Jan 2000 by Kanoj Sarcar <kanoj@sgi.com>
>  
> -Memory balancing is needed for !__GFP_ATOMIC and !__GFP_KSWAPD_RECLAIM as
> +Memory balancing is needed for !__GFP_HIGH and !__GFP_KSWAPD_RECLAIM as
>  well as for non __GFP_IO allocations.
>  
>  The first reason why a caller may avoid reclaim is that the caller can not
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e900e3c46903..c5fa8b8673b6 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -676,12 +676,12 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
>  	 * allocate page in a sleeping context if GFP flags permit. Hence
>  	 * spinlock needs to be unlocked and re-locked after allocation.
>  	 */
> -	if (!(gfp & __GFP_ATOMIC))
> +	if (gfp & __GFP_DIRECT_RECLAIM)
>  		spin_unlock_irqrestore(&as->lock, *flags);
>  
>  	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
>  
> -	if (!(gfp & __GFP_ATOMIC))
> +	if (gfp & __GFP_DIRECT_RECLAIM)
>  		spin_lock_irqsave(&as->lock, *flags);
>  
>  	/*
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b976c4177299..676c813bd93f 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -39,7 +39,7 @@ struct vm_area_struct;
>  #define ___GFP_IO		0x40u
>  #define ___GFP_FS		0x80u
>  #define ___GFP_ZERO		0x100u
> -#define ___GFP_ATOMIC		0x200u
> +/* 0x200u unused */
>  #define ___GFP_DIRECT_RECLAIM	0x400u
>  #define ___GFP_KSWAPD_RECLAIM	0x800u
>  #define ___GFP_WRITE		0x1000u
> @@ -116,11 +116,8 @@ struct vm_area_struct;
>   *
>   * %__GFP_HIGH indicates that the caller is high-priority and that granting
>   * the request is necessary before the system can make forward progress.
> - * For example, creating an IO context to clean pages.
> - *
> - * %__GFP_ATOMIC indicates that the caller cannot reclaim or sleep and is
> - * high priority. Users are typically interrupt handlers. This may be
> - * used in conjunction with %__GFP_HIGH
> + * For example creating an IO context to clean pages and requests
> + * from atomic context.
>   *
>   * %__GFP_MEMALLOC allows access to all memory. This should only be used when
>   * the caller guarantees the allocation will allow more memory to be freed
> @@ -135,7 +132,6 @@ struct vm_area_struct;
>   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>   */
> -#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
>  #define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
>  #define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
>  #define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
> @@ -320,7 +316,7 @@ struct vm_area_struct;
>   * version does not attempt reclaim/compaction at all and is by default used
>   * in page fault path, while the non-light is used by khugepaged.
>   */
> -#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> +#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
>  #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
>  #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
>  #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 116ed4d5d0f8..30f492256b8c 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -29,7 +29,6 @@
>  	{(unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
>  	{(unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
>  	{(unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
> -	{(unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
>  	{(unsigned long)__GFP_IO,		"__GFP_IO"},		\
>  	{(unsigned long)__GFP_FS,		"__GFP_FS"},		\
>  	{(unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 07309c45f327..8010de49b6c5 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -673,17 +673,17 @@ flags(void)
>  	gfp = GFP_ATOMIC|__GFP_DMA;
>  	test("GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
>  
> -	gfp = __GFP_ATOMIC;
> -	test("__GFP_ATOMIC", "%pGg", &gfp);
> +	gfp = __GFP_HIGH;
> +	test("__GFP_HIGH", "%pGg", &gfp);
>  
>  	/* Any flags not translated by the table should remain numeric */
>  	gfp = ~__GFP_BITS_MASK;
>  	snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
>  	test(cmp_buffer, "%pGg", &gfp);
>  
> -	snprintf(cmp_buffer, BUF_SIZE, "__GFP_ATOMIC|%#lx",
> +	snprintf(cmp_buffer, BUF_SIZE, "__GFP_HIGH|%#lx",
>  							(unsigned long) gfp);
> -	gfp |= __GFP_ATOMIC;
> +	gfp |= __GFP_HIGH;
>  	test(cmp_buffer, "%pGg", &gfp);
>  
>  	kfree(cmp_buffer);
> diff --git a/mm/internal.h b/mm/internal.h
> index 3b79a5c9427a..4564067065f9 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -20,8 +20,7 @@
>   */
>  #define GFP_RECLAIM_MASK (__GFP_RECLAIM|__GFP_HIGH|__GFP_IO|__GFP_FS|\
>  			__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NOFAIL|\
> -			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC|\
> -			__GFP_ATOMIC)
> +			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC)
>  
>  /* The GFP flags allowed during early boot */
>  #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 781605e92015..1ff55347e4b9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2621,7 +2621,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * put the burden of reclaim on regular allocation requests
>  	 * and let these go through as privileged allocations.
>  	 */
> -	if (gfp_mask & __GFP_ATOMIC)
> +	if (gfp_mask & __GFP_HIGH)
>  		goto force;
>  
>  	/*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..4fff90ca145b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3932,12 +3932,12 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>  					free_pages))
>  		return true;
>  	/*
> -	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
> +	 * Ignore watermark boosting for GFP_HIGH order-0 allocations
>  	 * when checking the min watermark. The min watermark is the
>  	 * point where boosting is ignored so that kswapd is woken up
>  	 * when below the low watermark.
>  	 */
> -	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
> +	if (unlikely(!order && (alloc_flags & ALLOC_HARDER) && z->watermark_boost
>  		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
>  		mark = z->_watermark[WMARK_MIN];
>  		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
> @@ -4661,12 +4661,12 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  	 * The caller may dip into page reserves a bit more if the caller
>  	 * cannot run direct reclaim, or if the caller has realtime scheduling
>  	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
> -	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
> +	 * set both ALLOC_HARDER (unless __GFP_NOMEMALLOC) and ALLOC_HIGH.
>  	 */
>  	alloc_flags |= (__force int)
>  		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
>  
> -	if (gfp_mask & __GFP_ATOMIC) {
> +	if (gfp_mask & __GFP_HIGH) {
>  		/*
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
>  		 * if it can't schedule.
> @@ -4859,14 +4859,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	unsigned int cpuset_mems_cookie;
>  	int reserve_flags;
>  
> -	/*
> -	 * We also sanity check to catch abuse of atomic reserves being used by
> -	 * callers that are not in atomic context.
> -	 */
> -	if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
> -				(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
> -		gfp_mask &= ~__GFP_ATOMIC;
> -
>  retry_cpuset:
>  	compaction_retries = 0;
>  	no_progress_loops = 0;
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index da03a341c63c..17e6eeb6e196 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -640,7 +640,6 @@ static const struct {
>  	{ "__GFP_HIGHMEM",		"HM" },
>  	{ "GFP_DMA32",			"D32" },
>  	{ "__GFP_HIGH",			"H" },
> -	{ "__GFP_ATOMIC",		"_A" },
>  	{ "__GFP_IO",			"I" },
>  	{ "__GFP_FS",			"F" },
>  	{ "__GFP_NOWARN",		"NWR" },
> diff --git a/tools/testing/radix-tree/linux/gfp.h b/tools/testing/radix-tree/linux/gfp.h
> index 32159c08a52e..0a0741104dfe 100644
> --- a/tools/testing/radix-tree/linux/gfp.h
> +++ b/tools/testing/radix-tree/linux/gfp.h
> @@ -12,7 +12,6 @@
>  #define __GFP_FS		0x80u
>  #define __GFP_NOWARN		0x200u
>  #define __GFP_ZERO		0x8000u
> -#define __GFP_ATOMIC		0x80000u
>  #define __GFP_ACCOUNT		0x100000u
>  #define __GFP_DIRECT_RECLAIM	0x400000u
>  #define __GFP_KSWAPD_RECLAIM	0x2000000u
> @@ -20,7 +19,7 @@
>  #define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM|__GFP_KSWAPD_RECLAIM)
>  
>  #define GFP_ZONEMASK	0x0fu
> -#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
> +#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
>  #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
>  #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
>  
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
