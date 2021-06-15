Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB13A7D17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFOL13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:27:29 -0400
Received: from foss.arm.com ([217.140.110.172]:33238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhFOL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:27:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B511F31B;
        Tue, 15 Jun 2021 04:25:17 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1E93F719;
        Tue, 15 Jun 2021 04:25:16 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] iommu/amd: Sync once for scatter-gather operations
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-7-namit@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <99671205-134d-7563-63e2-b65c13d5d074@arm.com>
Date:   Tue, 15 Jun 2021 12:25:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607182541.119756-7-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-07 19:25, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> On virtual machines, software must flush the IOTLB after each page table
> entry update.
> 
> The iommu_map_sg() code iterates through the given scatter-gather list
> and invokes iommu_map() for each element in the scatter-gather list,
> which calls into the vendor IOMMU driver through iommu_ops callback. As
> the result, a single sg mapping may lead to multiple IOTLB flushes.
> 
> Fix this by adding amd_iotlb_sync_map() callback and flushing at this
> point after all sg mappings we set.
> 
> This commit is followed and inspired by commit 933fcd01e97e2
> ("iommu/vt-d: Add iotlb_sync_map callback").
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   drivers/iommu/amd/iommu.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 128f2e889ced..dd23566f1db8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2027,6 +2027,16 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>   	return ret;
>   }
>   
> +static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
> +				     unsigned long iova, size_t size)
> +{
> +	struct protection_domain *domain = to_pdomain(dom);
> +	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
> +
> +	if (ops->map)

Not too critical since you're only moving existing code around, but is 
ops->map ever not set? Either way the check ends up looking rather 
out-of-place here :/

It's not very clear what the original intent was - I do wonder whether 
it's supposed to be related to PAGE_MODE_NONE, but given that 
amd_iommu_map() has an explicit check and errors out early in that case, 
we'd never get here anyway. Possibly something to come back and clean up 
later?

Robin.

> +		domain_flush_np_cache(domain, iova, size);
> +}
> +
>   static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>   			 phys_addr_t paddr, size_t page_size, int iommu_prot,
>   			 gfp_t gfp)
> @@ -2045,10 +2055,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>   	if (iommu_prot & IOMMU_WRITE)
>   		prot |= IOMMU_PROT_IW;
>   
> -	if (ops->map) {
> +	if (ops->map)
>   		ret = ops->map(ops, iova, paddr, page_size, prot, gfp);
> -		domain_flush_np_cache(domain, iova, page_size);
> -	}
>   
>   	return ret;
>   }
> @@ -2249,6 +2257,7 @@ const struct iommu_ops amd_iommu_ops = {
>   	.attach_dev = amd_iommu_attach_device,
>   	.detach_dev = amd_iommu_detach_device,
>   	.map = amd_iommu_map,
> +	.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
>   	.unmap = amd_iommu_unmap,
>   	.iova_to_phys = amd_iommu_iova_to_phys,
>   	.probe_device = amd_iommu_probe_device,
> 
