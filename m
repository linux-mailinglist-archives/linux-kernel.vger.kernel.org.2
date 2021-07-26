Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFA3D55A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhGZHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:49:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhGZHts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:49:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D75A106F;
        Mon, 26 Jul 2021 01:30:17 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4AEE3F66F;
        Mon, 26 Jul 2021 01:30:15 -0700 (PDT)
Subject: Re: [PATCH 17/23] iommu/vt-d: Prepare for multiple DMA domain types
To:     Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <11efdfa4ee223d12769d17459fcf789c626d7b82.1626888445.git.robin.murphy@arm.com>
 <7599b48f-169d-283f-782b-e54c667346e8@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fdf09426-d329-a212-6c5a-ddc9aadd77ec@arm.com>
Date:   Mon, 26 Jul 2021 09:30:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7599b48f-169d-283f-782b-e54c667346e8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-24 06:23, Lu Baolu wrote:
> Hi Robin,
> 
> On 2021/7/22 2:20, Robin Murphy wrote:
>> In preparation for the strict vs. non-strict decision for DMA domains to
>> be expressed in the domain type, make sure we expose our flush queue
>> awareness by accepting the new domain type, and test the specific
>> feature flag where we want to identify DMA domains in general. The DMA
>> ops setup can simply be made unconditional, since iommu-dma already
>> knows not to touch identity domains.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index e2add5a0caef..77d322272743 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -601,7 +601,7 @@ struct intel_iommu *domain_get_iommu(struct 
>> dmar_domain *domain)
>>       int iommu_id;
>>       /* si_domain and vm domain should not get here. */
>> -    if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
>> +    if (WARN_ON(!(domain->domain.type & __IOMMU_DOMAIN_DMA)))
>>           return NULL;
>>       for_each_domain_iommu(iommu_id, domain)
>> @@ -1035,7 +1035,7 @@ static struct dma_pte *pfn_to_dma_pte(struct 
>> dmar_domain *domain,
>>               pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << 
>> VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
>>               if (domain_use_first_level(domain)) {
>>                   pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
>> -                if (domain->domain.type == IOMMU_DOMAIN_DMA)
>> +                if (domain->domain.type & __IOMMU_DOMAIN_DMA_API)
>>                       pteval |= DMA_FL_PTE_ACCESS;
>>               }
>>               if (cmpxchg64(&pte->val, 0ULL, pteval))
>> @@ -2346,7 +2346,7 @@ __domain_mapping(struct dmar_domain *domain, 
>> unsigned long iov_pfn,
>>       if (domain_use_first_level(domain)) {
>>           attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
>> -        if (domain->domain.type == IOMMU_DOMAIN_DMA) {
>> +        if (domain->domain.type & __IOMMU_DOMAIN_DMA_API) {
>>               attr |= DMA_FL_PTE_ACCESS;
>>               if (prot & DMA_PTE_WRITE)
>>                   attr |= DMA_FL_PTE_DIRTY;
>> @@ -4528,6 +4528,7 @@ static struct iommu_domain 
>> *intel_iommu_domain_alloc(unsigned type)
>>       switch (type) {
>>       case IOMMU_DOMAIN_DMA:
>> +    case IOMMU_DOMAIN_DMA_FQ:
>>       case IOMMU_DOMAIN_UNMANAGED:
>>           dmar_domain = alloc_domain(0);
>>           if (!dmar_domain) {
>> @@ -5164,12 +5165,8 @@ static void intel_iommu_release_device(struct 
>> device *dev)
>>   static void intel_iommu_probe_finalize(struct device *dev)
>>   {
>> -    struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> -
>> -    if (domain && domain->type == IOMMU_DOMAIN_DMA)
>> -        iommu_setup_dma_ops(dev, 0, U64_MAX);
>> -    else
>> -        set_dma_ops(dev, NULL);
>> +    set_dma_ops(dev, NULL);
> 
> Is it reasonable to remove above line? The idea is that vendor iommu
> driver should not override the dma_ops if device doesn't have a DMA
> domain.

As the commit message implies, that's exactly how iommu_setup_dma_ops() 
has always behaved anyway. There should be no functional change here.

Robin.

>> +    iommu_setup_dma_ops(dev, 0, U64_MAX);
>>   }
>>   static void intel_iommu_get_resv_regions(struct device *device,
>>
> 
> Best regards,
> baolu
