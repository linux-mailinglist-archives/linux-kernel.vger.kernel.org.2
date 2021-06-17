Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB53AAD38
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFQHUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:20:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:13016 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhFQHUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:20:47 -0400
IronPort-SDR: JwG3sshC+lsHjNv388vwzVViheZo3nDbiXEerv53CRMRPcvEtLJI5wL+4iePaRCg1Y8zsvyXka
 UKaMO/2QSiXw==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206273299"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="206273299"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:18:40 -0700
IronPort-SDR: p9P7Of8bXcURhxEQ7QVJfZ0eAGv7dO+302tJ+CVcvyeZPQIfuCx0r5wP8QM8reaCVTRnkMAvFS
 GaK90l/9wVVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472326150"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:18:36 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, isaacm@codeaurora.org,
        pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: Re: [PATCH v7 06/15] iommu: Split 'addr_merge' argument to
 iommu_pgsize() into separate parts
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-7-git-send-email-quic_c_gdjako@quicinc.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <21ba382a-8add-5872-13c9-6f97698a594d@linux.intel.com>
Date:   Thu, 17 Jun 2021 15:17:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-7-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 9:38 PM, Georgi Djakov wrote:
> From: Will Deacon <will@kernel.org>
> 
> The 'addr_merge' parameter to iommu_pgsize() is a fabricated address
> intended to describe the alignment requirements to consider when
> choosing an appropriate page size. On the iommu_map() path, this address
> is the logical OR of the virtual and physical addresses.
> 
> Subsequent improvements to iommu_pgsize() will need to check the
> alignment of the virtual and physical components of 'addr_merge'
> independently, so pass them in as separate parameters and reconstruct
> 'addr_merge' locally.
> 
> No functional change.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 80e471ada358..80e14c139d40 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2375,12 +2375,13 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   }
>   EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>   
> -static size_t iommu_pgsize(struct iommu_domain *domain,
> -			   unsigned long addr_merge, size_t size)
> +static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
> +			   phys_addr_t paddr, size_t size)
>   {
>   	unsigned int pgsize_idx;
>   	unsigned long pgsizes;
>   	size_t pgsize;
> +	unsigned long addr_merge = paddr | iova;
>   
>   	/* Page sizes supported by the hardware and small enough for @size */
>   	pgsizes = domain->pgsize_bitmap & GENMASK(__fls(size), 0);
> @@ -2433,7 +2434,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>   
>   	while (size) {
> -		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
> +		size_t pgsize = iommu_pgsize(domain, iova, paddr, size);
>   
>   		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
>   			 iova, &paddr, pgsize);
> @@ -2521,8 +2522,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	 * or we hit an area that isn't mapped.
>   	 */
>   	while (unmapped < size) {
> -		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
> +		size_t pgsize;
>   
> +		pgsize = iommu_pgsize(domain, iova, iova, size - unmapped);
>   		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
>   		if (!unmapped_page)
>   			break;
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
