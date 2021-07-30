Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D33DB349
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhG3GLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:11:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:5028 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236430AbhG3GLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:11:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="213070178"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="213070178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465345019"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:11:29 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 17/24] iommu/vt-d: Prepare for multiple DMA domain
 types
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <3cf1ab93d3a4868db3b2e60c7c9781619e449694.1627468309.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ad334873-b148-b9b7-efc7-e1c753937f85@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:09:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3cf1ab93d3a4868db3b2e60c7c9781619e449694.1627468309.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> In preparation for the strict vs. non-strict decision for DMA domains
> to be expressed in the domain type, make sure we expose our flush queue
> awareness by accepting the new domain type, and test the specific
> feature flag where we want to identify DMA domains in general. The DMA
> ops reset/setup can simply be made unconditional, since iommu-dma
> already knows only to touch DMA domains.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7e168634c433..8fc46c9d6b96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -582,7 +582,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
>   	int iommu_id;
>   
>   	/* si_domain and vm domain should not get here. */
> -	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
> +	if (WARN_ON(!iommu_is_dma_domain(&domain->domain)))
>   		return NULL;
>   
>   	for_each_domain_iommu(iommu_id, domain)
> @@ -1034,7 +1034,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
>   			if (domain_use_first_level(domain)) {
>   				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
> -				if (domain->domain.type == IOMMU_DOMAIN_DMA)
> +				if (iommu_is_dma_domain(&domain->domain))
>   					pteval |= DMA_FL_PTE_ACCESS;
>   			}
>   			if (cmpxchg64(&pte->val, 0ULL, pteval))
> @@ -2345,7 +2345,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>   	if (domain_use_first_level(domain)) {
>   		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
>   
> -		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
> +		if (iommu_is_dma_domain(&domain->domain)) {
>   			attr |= DMA_FL_PTE_ACCESS;
>   			if (prot & DMA_PTE_WRITE)
>   				attr |= DMA_FL_PTE_DIRTY;
> @@ -4528,6 +4528,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   
>   	switch (type) {
>   	case IOMMU_DOMAIN_DMA:
> +	case IOMMU_DOMAIN_DMA_FQ:
>   	case IOMMU_DOMAIN_UNMANAGED:
>   		dmar_domain = alloc_domain(0);
>   		if (!dmar_domain) {
> @@ -5197,12 +5198,8 @@ static void intel_iommu_release_device(struct device *dev)
>   
>   static void intel_iommu_probe_finalize(struct device *dev)
>   {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -
> -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, 0, U64_MAX);
> -	else
> -		set_dma_ops(dev, NULL);
> +	set_dma_ops(dev, NULL);
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>   }
>   
>   static void intel_iommu_get_resv_regions(struct device *device,
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
