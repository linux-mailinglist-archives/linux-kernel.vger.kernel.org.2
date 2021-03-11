Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A889337780
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhCKP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:27:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2686 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhCKP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:27:21 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DxCKD1tw1z67y1w;
        Thu, 11 Mar 2021 23:19:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 11 Mar 2021 16:27:18 +0100
Received: from [10.47.4.196] (10.47.4.196) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 15:27:17 +0000
Subject: Re: [PATCH] iommu/dma: Resurrect the "forcedac" option
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <murphyt7@tcd.ie>,
        <thunder.leizhen@huawei.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a47a2df2-d6a8-80f0-1c87-ef2eb2fa4174@huawei.com>
Date:   Thu, 11 Mar 2021 15:25:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.196]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2021 16:32, Robin Murphy wrote:
> In converting intel-iommu over to the common IOMMU DMA ops, it quietly
> lost the functionality of its "forcedac" option. Since this is a handy
> thing both for testing and for performance optimisation on certain
> platforms, reimplement it under the common IOMMU parameter namespace.
> 
> For the sake of fixing the inadvertent breakage of the Intel-specific
> parameter, remove the dmar_forcedac remnants and hook it up as an alias
> while documenting the transition to the new common parameter.
> 
> Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

If it's worth anything:
Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
>   drivers/iommu/dma-iommu.c                       | 13 ++++++++++++-
>   drivers/iommu/intel/iommu.c                     |  5 ++---
>   include/linux/dma-iommu.h                       |  2 ++
>   4 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..835f810f2f26 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1869,13 +1869,6 @@
>   			bypassed by not enabling DMAR with this option. In
>   			this case, gfx device will use physical address for
>   			DMA.
> -		forcedac [X86-64]
> -			With this option iommu will not optimize to look
> -			for io virtual address below 32-bit forcing dual
> -			address cycle on pci bus for cards supporting greater
> -			than 32-bit addressing. The default is to look
> -			for translation below 32-bit and if not available
> -			then look in the higher range.
>   		strict [Default Off]
>   			With this option on every unmap_single operation will
>   			result in a hardware IOTLB flush operation as opposed
> @@ -1964,6 +1957,14 @@
>   		nobypass	[PPC/POWERNV]
>   			Disable IOMMU bypass, using IOMMU for PCI devices.
>   
> +	iommu.forcedac=	[ARM64, X86] Control IOVA allocation for PCI devices.
> +			Format: { "0" | "1" }
> +			0 - Try to allocate a 32-bit DMA address first, before
> +			  falling back to the full range if needed.
> +			1 - Allocate directly from the full usable range,
> +			  forcing Dual Address Cycle for PCI cards supporting
> +			  greater than 32-bit addressing.
> +
>   	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>   			Format: { "0" | "1" }
>   			0 - Lazy mode.
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9ab6ee22c110..260bf3de1992 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -52,6 +52,17 @@ struct iommu_dma_cookie {
>   };
>   
>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> +bool iommu_dma_forcedac __read_mostly;
> +
> +static int __init iommu_dma_forcedac_setup(char *str)
> +{
> +	int ret = kstrtobool(str, &iommu_dma_forcedac);
> +
> +	if (!ret && iommu_dma_forcedac)
> +		pr_info("Forcing DAC for PCI devices\n");

I seem to remember some disagreement on this sort of print some other 
time :)

> +	return ret;
> +}
> +early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>   
>   void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>   		struct iommu_domain *domain)
> @@ -438,7 +449,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
