Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFEC3AAD43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFQHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:22:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:62829 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhFQHWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:22:16 -0400
IronPort-SDR: B+D6otS55zZqlwhcuvqkvTcMJY2P3bF7foovu4B2a3V++9sPpOmi5Myo4WvpicpOS66KidG8Gh
 jBSZUacjoWpA==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206353680"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206353680"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:20:09 -0700
IronPort-SDR: f5uyLCePA4vQedp0tG3ISxCOvFjgXxQLmtIdc/4UlSvhvwSV1D1ygdcsL/yeyrAgdrl+LIWqsE
 s/z3BhsOKRXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472326493"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:20:06 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, isaacm@codeaurora.org,
        pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: Re: [PATCH v7 08/15] iommu: Add support for the map_pages() callback
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-9-git-send-email-quic_c_gdjako@quicinc.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bc003ab7-5067-53de-a94e-815462991f8f@linux.intel.com>
Date:   Thu, 17 Jun 2021 15:18:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-9-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 9:38 PM, Georgi Djakov wrote:
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> 
> Since iommu_pgsize can calculate how many pages of the
> same size can be mapped/unmapped before the next largest
> page size boundary, add support for invoking an IOMMU
> driver's map_pages() callback, if it provides one.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 725622c7e603..70a729ce88b1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2429,6 +2429,30 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
>   	return pgsize;
>   }
>   
> +static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
> +			     phys_addr_t paddr, size_t size, int prot,
> +			     gfp_t gfp, size_t *mapped)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	size_t pgsize, count;
> +	int ret;
> +
> +	pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
> +
> +	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
> +		 iova, &paddr, pgsize, count);
> +
> +	if (ops->map_pages) {
> +		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
> +				     gfp, mapped);
> +	} else {
> +		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
> +		*mapped = ret ? 0 : pgsize;
> +	}
> +
> +	return ret;
> +}
> +
>   static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>   {
> @@ -2439,7 +2463,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	phys_addr_t orig_paddr = paddr;
>   	int ret = 0;
>   
> -	if (unlikely(ops->map == NULL ||
> +	if (unlikely(!(ops->map || ops->map_pages) ||
>   		     domain->pgsize_bitmap == 0UL))
>   		return -ENODEV;
>   
> @@ -2463,18 +2487,21 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>   
>   	while (size) {
> -		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
> +		size_t mapped = 0;
>   
> -		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
> -			 iova, &paddr, pgsize);
> -		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
> +		ret = __iommu_map_pages(domain, iova, paddr, size, prot, gfp,
> +					&mapped);
> +		/*
> +		 * Some pages may have been mapped, even if an error occurred,
> +		 * so we should account for those so they can be unmapped.
> +		 */
> +		size -= mapped;
>   
>   		if (ret)
>   			break;
>   
> -		iova += pgsize;
> -		paddr += pgsize;
> -		size -= pgsize;
> +		iova += mapped;
> +		paddr += mapped;
>   	}
>   
>   	/* unroll mapping in case something went wrong */
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
