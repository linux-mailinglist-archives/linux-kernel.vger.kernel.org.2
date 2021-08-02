Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C13DDBBE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhHBPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234211AbhHBPCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0560260FC4;
        Mon,  2 Aug 2021 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627916520;
        bh=Itlu8DBFT8qE0fjbcCvRJBNsGuat0L/pnhVJ+0wi3t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/ii3slm/ZyE9VlY2kJyItA2I3DwoyQ0TpfMuoDomWmhvGvptcP0as9XfixHJQH//
         FuMsgSg/A4CkXIfx7QWWSYKsqvSZw0TBy3FOtIvPs3tc+1Ig5cin/yd41fD4A4RyWD
         +q7k/MlQpe5F/kUyt1f0Aa34NJjp6dx0lB86o9K7hTRUJirTC1JNP4dFcjvkooB/y6
         wa3NFejkM5Pf6Ya/51cw+5bamOGgrd+krl7fAYBwB7Vj+BPWBI107/zuP49uXGyBhN
         J1biR41HoSwjTwB+JcfBMHKonNT8cadg9wp+s6tUXMbKY2aZLbwoykefGIHSXqjJXl
         YqQ7+CvdDoUbA==
Date:   Mon, 2 Aug 2021 16:01:53 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, digetx@gmail.com, mst@redhat.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v4 2/6] iova: Allow rcache range upper limit to be
 flexible
Message-ID: <20210802150153.GC28735@willie-the-truck>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626259003-201303-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 06:36:39PM +0800, John Garry wrote:
> Some LLDs may request DMA mappings whose IOVA length exceeds that of the
> current rcache upper limit.

What's an LLD?

> This means that allocations for those IOVAs will never be cached, and
> always must be allocated and freed from the RB tree per DMA mapping cycle.
> This has a significant effect on performance, more so since commit
> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> fails"), as discussed at [0].
> 
> As a first step towards allowing the rcache range upper limit be
> configured, hold this value in the IOVA rcache structure, and allocate
> the rcaches separately.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c |  2 +-
>  drivers/iommu/iova.c      | 23 +++++++++++++++++------
>  include/linux/iova.h      |  4 ++--
>  3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..4772278aa5da 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -434,7 +434,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	 * rounding up anything cacheable to make sure that can't happen. The
>  	 * order of the unadjusted size will still match upon freeing.
>  	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +	if (iova_len < (1 << (iovad->rcache_max_size - 1)))
>  		iova_len = roundup_pow_of_two(iova_len);
>  
>  	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b6cf5f16123b..07ce73fdd8c1 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -15,6 +15,8 @@
>  /* The anchor node sits above the top of the usable address space */
>  #define IOVA_ANCHOR	~0UL
>  
> +#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA range size (in pages) */

Is that the same as an 'order'? i.e. IOVA_RANGE_CACHE_MAX_ORDER?

> +
>  static bool iova_rcache_insert(struct iova_domain *iovad,
>  			       unsigned long pfn,
>  			       unsigned long size);
> @@ -881,7 +883,14 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>  	unsigned int cpu;
>  	int i;
>  
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
> +
> +	iovad->rcaches = kcalloc(iovad->rcache_max_size,
> +				 sizeof(*iovad->rcaches), GFP_KERNEL);
> +	if (!iovad->rcaches)
> +		return;

Returning quietly here doesn't seem like the right thing to do. At least, I
don't think the rest of the functions here are checking rcaches against
NULL.

Will
