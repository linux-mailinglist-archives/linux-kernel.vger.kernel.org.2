Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA63AAD30
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhFQHTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:19:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:29569 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhFQHTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:19:43 -0400
IronPort-SDR: 3yy11/AVNkDuWbaTeGD7Wf5IVBSKf3K9A31kEpURhk15aj+tfAmDXWb5udBd8dzxvzD+suTAf+
 ytKRPekfok2w==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="186009257"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="186009257"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:17:35 -0700
IronPort-SDR: 7mIaHJqyAcgjcjKemwRozT1mCbDOnCiIhOiokO+K3rim8RJj1C3utmbA4rTiduWFf1HbU9gXXn
 D9ohL96aueZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472325834"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:17:32 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, isaacm@codeaurora.org,
        pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: Re: [PATCH v7 05/15] iommu: Use bitmap to calculate page size in
 iommu_pgsize()
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-6-git-send-email-quic_c_gdjako@quicinc.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d28e9cf-ac5d-06db-a110-2cdd3f506924@linux.intel.com>
Date:   Thu, 17 Jun 2021 15:16:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-6-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 9:38 PM, Georgi Djakov wrote:
> From: Will Deacon <will@kernel.org>
> 
> Avoid the potential for shifting values by amounts greater than the
> width of their type by using a bitmap to compute page size in
> iommu_pgsize().
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5419c4b9f27a..80e471ada358 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/device.h>
>   #include <linux/kernel.h>
> +#include <linux/bits.h>
>   #include <linux/bug.h>
>   #include <linux/types.h>
>   #include <linux/init.h>
> @@ -2378,30 +2379,22 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
>   			   unsigned long addr_merge, size_t size)
>   {
>   	unsigned int pgsize_idx;
> +	unsigned long pgsizes;
>   	size_t pgsize;
>   
> -	/* Max page size that still fits into 'size' */
> -	pgsize_idx = __fls(size);
> +	/* Page sizes supported by the hardware and small enough for @size */
> +	pgsizes = domain->pgsize_bitmap & GENMASK(__fls(size), 0);
>   
> -	/* need to consider alignment requirements ? */
> -	if (likely(addr_merge)) {
> -		/* Max page size allowed by address */
> -		unsigned int align_pgsize_idx = __ffs(addr_merge);
> -		pgsize_idx = min(pgsize_idx, align_pgsize_idx);
> -	}
> -
> -	/* build a mask of acceptable page sizes */
> -	pgsize = (1UL << (pgsize_idx + 1)) - 1;
> -
> -	/* throw away page sizes not supported by the hardware */
> -	pgsize &= domain->pgsize_bitmap;
> +	/* Constrain the page sizes further based on the maximum alignment */
> +	if (likely(addr_merge))
> +		pgsizes &= GENMASK(__ffs(addr_merge), 0);
>   
> -	/* make sure we're still sane */
> -	BUG_ON(!pgsize);
> +	/* Make sure we have at least one suitable page size */
> +	BUG_ON(!pgsizes);
>   
> -	/* pick the biggest page */
> -	pgsize_idx = __fls(pgsize);
> -	pgsize = 1UL << pgsize_idx;
> +	/* Pick the biggest page size remaining */
> +	pgsize_idx = __fls(pgsizes);
> +	pgsize = BIT(pgsize_idx);
>   
>   	return pgsize;
>   }
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
