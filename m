Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E043C766D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGMS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:28:21 -0400
Received: from foss.arm.com ([217.140.110.172]:48976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:28:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6661FB;
        Tue, 13 Jul 2021 11:25:30 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8883F7D8;
        Tue, 13 Jul 2021 11:25:28 -0700 (PDT)
Subject: Re: [PATCH v5 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
 <20210713094151.652597-5-namit@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <618969ce-c220-a1bd-1e0e-33a22338e718@arm.com>
Date:   Tue, 13 Jul 2021 19:25:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713094151.652597-5-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-13 10:41, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Refactor iommu_iotlb_gather_add_page() and factor out the logic that
> detects whether IOTLB gather range and a new range are disjoint. To be
> used by the next patch that implements different gathering logic for
> AMD.
> 
> Note that updating gather->pgsize unconditionally does not affect
> correctness as the function had (and has) an invariant, in which
> gather->pgsize always represents the flushing granularity of its range.
> Arguably, “size" should never be zero, but lets assume for the matter of
> discussion that it might.
> 
> If "size" equals to "gather->pgsize", then the assignment in question
> has no impact.
> 
> Otherwise, if "size" is non-zero, then iommu_iotlb_sync() would
> initialize the size and range (see iommu_iotlb_gather_init()), and the
> invariant is kept.
> 
> Otherwise, "size" is zero, and "gather" already holds a range, so
> gather->pgsize is non-zero and (gather->pgsize && gather->pgsize !=
> size) is true. Therefore, again, iommu_iotlb_sync() would be called and
> initialize the size.

With the caveat of one comment on the next patch...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   include/linux/iommu.h | 34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e554871db46f..979a5ceeea55 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
>   	iommu_iotlb_gather_init(iotlb_gather);
>   }
>   
> +/**
> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is disjoint
> + *
> + * @gather: TLB gather data
> + * @iova: start of page to invalidate
> + * @size: size of page to invalidate
> + *
> + * Helper for IOMMU drivers to check whether a new range and the gathered range
> + * are disjoint. For many IOMMUs, flushing the IOMMU in this case is better
> + * than merging the two, which might lead to unnecessary invalidations.
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
>   /**
>    * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
>    * @gather: TLB gather data
> @@ -533,20 +555,16 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   					       struct iommu_iotlb_gather *gather,
>   					       unsigned long iova, size_t size)
>   {
> -	unsigned long start = iova, end = start + size - 1;
> -
>   	/*
>   	 * If the new page is disjoint from the current range or is mapped at
>   	 * a different granularity, then sync the TLB so that the gather
>   	 * structure can be rewritten.
>   	 */
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
>   	iommu_iotlb_gather_add_range(gather, iova, size);
>   }
>   
> 
