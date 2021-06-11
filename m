Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451CE3A439A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFKN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231355AbhFKN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:59:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AE0D6136D;
        Fri, 11 Jun 2021 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623419871;
        bh=AWgV4bmc3bhqQ3YMzaNffyJ3Z0ebJe9ErfEnzD8ZC4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftgXHKBP57eTVl2kXNV5HOJw8snhE5MH/1WJh/0rLs0dfdeUBjDBQmSfjOJ/j3bCW
         fFenox6M2hbp34GAEAGU6KJNuYnhp5+4s2EJeoCCDcVbi/i1OroqYVGsPpVg6pyGMS
         BE+vKIKp9s06CVOp944zx+GQmoauzg9vDpVE0zoynExgfn1uO0l4puYhrAexm2UHeE
         40BUL8C3dPCFJL2YeZajxim0GeYcyVShC77WLyHZaCZXM2YaD1uzpQes7Oy5nWiZUf
         LTdjFuhoyvsPUlyADkjSKFrzH/aSj6HG/RnS9+MJtJE/yWMzkUl1WXxJfSo5wMit3H
         Yr8DD9hvvAqRQ==
Date:   Fri, 11 Jun 2021 14:57:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Message-ID: <20210611135746.GC15776@willie-the-truck>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607182541.119756-5-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Refactor iommu_iotlb_gather_add_page() and factor out the logic that
> detects whether IOTLB gather range and a new range are disjoint. To be
> used by the next patch that implements different gathering logic for
> AMD.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)

[...]

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f254c62f3720..b5a2bfc68fb0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
>  	iommu_iotlb_gather_init(iotlb_gather);
>  }
>  
> +/**
> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is disjoint
> + *
> + * @gather: TLB gather data
> + * @iova: start of page to invalidate
> + * @size: size of page to invalidate
> + *
> + * Helper for IOMMU drivers to check whether a new range is and the gathered
> + * range are disjoint. 

I can't quite parse this. Delete the "is"?

>     For many IOMMUs, flushing the IOMMU in this case is
> + * better than merging the two, which might lead to unnecessary invalidations.
> + */
> +static inline
> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
> +				    unsigned long iova, size_t size)
> +{
> +	unsigned long start = iova, end = start + size - 1;
> +
> +	return gather->end != 0 &&
> +		(end + 1 < gather->start || start > gather->end + 1);
> +}
> +
> +
>  /**
>   * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
>   * @gather: TLB gather data
> @@ -533,20 +555,16 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>  					       struct iommu_iotlb_gather *gather,
>  					       unsigned long iova, size_t size)
>  {
> -	unsigned long start = iova, end = start + size - 1;
> -
>  	/*
>  	 * If the new page is disjoint from the current range or is mapped at
>  	 * a different granularity, then sync the TLB so that the gather
>  	 * structure can be rewritten.
>  	 */
> -	if (gather->pgsize != size ||
> -	    end + 1 < gather->start || start > gather->end + 1) {
> -		if (gather->pgsize)
> -			iommu_iotlb_sync(domain, gather);
> -		gather->pgsize = size;
> -	}
> +	if ((gather->pgsize && gather->pgsize != size) ||
> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
> +		iommu_iotlb_sync(domain, gather);
>  
> +	gather->pgsize = size;

Why have you made this unconditional? I think it's ok, but just not sure
if it's necessary or not.

Will
