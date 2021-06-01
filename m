Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B539775A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhFAQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:01:18 -0400
Received: from foss.arm.com ([217.140.110.172]:53250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhFAQBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:01:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C1C101E;
        Tue,  1 Jun 2021 08:59:35 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356943F719;
        Tue,  1 Jun 2021 08:59:34 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu/amd: Do not sync on page size changes
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>, linux-kernel@vger.kernel.org
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-5-namit@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f00bd0ce-e4a7-93c6-39ae-db19779b9331@arm.com>
Date:   Tue, 1 Jun 2021 16:59:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210502070001.1559127-5-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-02 07:59, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Some IOMMU architectures perform invalidations regardless of the page
> size. In such architectures there is no need to sync when the page size
> changes or to regard pgsize when making interim flush in
> iommu_iotlb_gather_add_page().
> 
> Add a "ignore_gather_pgsize" property for each IOMMU-ops to decide
> whether gather's pgsize is tracked and triggers a flush.

I've objected before[1], and I'll readily object again ;)

I still think it's very silly to add a bunch of indirection all over the 
place to make a helper function not do the main thing it's intended to 
help with. If you only need trivial address gathering then it's far 
simpler to just implement trivial address gathering. I suppose if you 
really want to you could factor out another helper to share the 5 lines 
of code which ended up in mtk-iommu (see commit f21ae3b10084).

Robin.

[1] 
https://lore.kernel.org/linux-iommu/49bae447-d662-e6cf-7500-ab78e3b75dc4@arm.com/

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   drivers/iommu/amd/iommu.c | 1 +
>   include/linux/iommu.h     | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b8cabbbeed71..1849b53f2149 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2215,6 +2215,7 @@ const struct iommu_ops amd_iommu_ops = {
>   	.put_resv_regions = generic_iommu_put_resv_regions,
>   	.is_attach_deferred = amd_iommu_is_attach_deferred,
>   	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
> +	.ignore_gather_pgsize = true,
>   	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>   	.iotlb_sync = amd_iommu_iotlb_sync,
>   	.def_domain_type = amd_iommu_def_domain_type,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..1fb2695418e9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -284,6 +284,7 @@ struct iommu_ops {
>   	int (*def_domain_type)(struct device *dev);
>   
>   	unsigned long pgsize_bitmap;
> +	bool ignore_gather_pgsize;
>   	struct module *owner;
>   };
>   
> @@ -508,7 +509,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   	 * a different granularity, then sync the TLB so that the gather
>   	 * structure can be rewritten.
>   	 */
> -	if (gather->pgsize != size ||
> +	if ((gather->pgsize != size && !domain->ops->ignore_gather_pgsize) ||
>   	    end + 1 < gather->start || start > gather->end + 1) {
>   		if (gather->pgsize)
>   			iommu_iotlb_sync(domain, gather);
> 
