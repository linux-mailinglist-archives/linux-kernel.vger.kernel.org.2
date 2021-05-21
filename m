Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE48B38C88C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhEUNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:43:42 -0400
Received: from foss.arm.com ([217.140.110.172]:47784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhEUNng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:43:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305F611B3;
        Fri, 21 May 2021 06:42:13 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EE9B3F73B;
        Fri, 21 May 2021 06:42:11 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] iommu: rockchip: Add support for iommu v2
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210521083637.3221304-1-benjamin.gaignard@collabora.com>
 <20210521083637.3221304-5-benjamin.gaignard@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e094347e-5396-dd2c-dad5-79e17feb96a3@arm.com>
Date:   Fri, 21 May 2021 14:42:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521083637.3221304-5-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-21 09:36, Benjamin Gaignard wrote:
> This second version of the hardware block has a different bits
> mapping for page table entries.
> Add the ops matching to this new mapping.
> Define a new compatible to distinguish it from the first version.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 5:
>   - Use internal ops to support v2 hardware block
>   - Use GENMASK macro.
>   - Keep rk_dte_pt_address() and rk_dte_pt_address_v2() separated
>     because I believe that is more readable like this.
>   - Do not duplicate code.
> 
>   drivers/iommu/rockchip-iommu.c | 78 ++++++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index e7b9bcf174b1..23253a2f269e 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -189,6 +189,33 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
>   	return (phys_addr_t)dte & RK_DTE_PT_ADDRESS_MASK;
>   }
>   
> +/*
> + * In v2:
> + * 31:12 - PT address bit 31:0
> + * 11: 8 - PT address bit 35:32
> + *  7: 4 - PT address bit 39:36
> + *  3: 1 - Reserved
> + *     0 - 1 if PT @ PT address is valid
> + */
> +#define RK_DTE_PT_ADDRESS_MASK_V2 GENMASK_ULL(31, 4)
> +#define DTE_HI_MASK1	GENMASK(11, 8)
> +#define DTE_HI_MASK2	GENMASK(7, 4)
> +#define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
> +#define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */

Nit: no harm in doing "#define DTE_HI_SHIFT1 (32 - 8)" etc. for maximum 
clarity if you want.

> +#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
> +#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
> +
> +static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
> +{
> +	u64 dte_v2 = dte;
> +
> +	dte_v2 = ((dte_v2 & DTE_HI_MASK2) << DTE_HI_SHIFT2) |
> +		 ((dte_v2 & DTE_HI_MASK1) << DTE_HI_SHIFT1) |
> +		 (dte_v2 & RK_DTE_PT_ADDRESS_MASK);
> +
> +	return (phys_addr_t)dte_v2;
> +}
> +
>   static inline bool rk_dte_is_pt_valid(u32 dte)
>   {
>   	return dte & RK_DTE_PT_VALID;
> @@ -199,6 +226,15 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
>   	return (pt_dma & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
>   }
>   
> +static inline u32 rk_mk_dte_v2(dma_addr_t pt_dma)
> +{
> +	pt_dma = (pt_dma & RK_DTE_PT_ADDRESS_MASK) |
> +		 ((pt_dma & PAGE_DESC_HI_MASK1) >> DTE_HI_SHIFT1) |
> +		 (pt_dma & PAGE_DESC_HI_MASK2) >> DTE_HI_SHIFT2;
> +
> +	return (pt_dma & RK_DTE_PT_ADDRESS_MASK_V2) | RK_DTE_PT_VALID;
> +}
> +
>   /*
>    * Each PTE has a Page address, some flags and a valid bit:
>    * +---------------------+---+-------+-+
> @@ -240,6 +276,29 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
>   	return page | flags | RK_PTE_PAGE_VALID;
>   }
>   
> +/*
> + * In v2:
> + * 31:12 - Page address bit 31:0
> + *  11:9 - Page address bit 34:32
> + *   8:4 - Page address bit 39:35
> + *     3 - Security
> + *     2 - Readable
> + *     1 - Writable
> + *     0 - 1 if Page @ Page address is valid
> + */
> +#define RK_PTE_PAGE_READABLE_V2      BIT(2)
> +#define RK_PTE_PAGE_WRITABLE_V2      BIT(1)
> +
> +static u32 rk_mk_pte_v2(phys_addr_t page, int prot)
> +{
> +	u32 flags = 0;
> +
> +	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE_V2 : 0;
> +	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE_V2 : 0;
> +
> +	return rk_mk_dte_v2(page) | flags ;
> +}
> +
>   static u32 rk_mk_pte_invalid(u32 pte)
>   {
>   	return pte & ~RK_PTE_PAGE_VALID;
> @@ -480,6 +539,14 @@ static inline phys_addr_t rk_dte_addr_phys(phys_addr_t addr)
>   	return addr;
>   }
>   
> +#define DT_HI_MASK GENMASK_ULL(39, 32)
> +#define DT_SHIFT   28
> +
> +static inline phys_addr_t rk_dte_addr_phys_v2(phys_addr_t addr)
> +{
> +	return (addr & RK_DTE_PT_ADDRESS_MASK) | ((addr & DT_HI_MASK) << DT_SHIFT);
> +}

Are we missing something overall? AFAICS the DT_HI_MASK bits of 
RK_MMU_DTE_ADDR will never actually be used, since rk_iommu_enable() 
just writes the value of dt_dma directly...

> +
>   static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   {
>   	void __iomem *base = iommu->bases[index];
> @@ -1305,10 +1372,21 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
>   	.pt_address_mask = RK_DTE_PT_ADDRESS_MASK,
>   };
>   
> +static struct rk_iommu_ops iommu_data_ops_v2 = {
> +	.pt_address = &rk_dte_pt_address_v2,
> +	.mk_dtentries = &rk_mk_dte_v2,
> +	.mk_ptentries = &rk_mk_pte_v2,
> +	.dte_addr_phys = &rk_dte_addr_phys_v2,
> +	.pt_address_mask = RK_DTE_PT_ADDRESS_MASK_V2,
> +};
> +
>   static const struct of_device_id rk_iommu_dt_ids[] = {
>   	{	.compatible = "rockchip,iommu",
>   		.data = &iommu_data_ops_v1,
>   	},
> +	{	.compatible = "rockchip,rk3568-iommu",
> +		.data = &iommu_data_ops_v2,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
> 

...and I'll bet the reason it appears to work is that we also never 
actually set the IOMMU device's DMA masks anywhere, so what happens in 
practice is that even if pagetable pages are allocated above 32 bits 
they'll just get bounced by the DMA mapping ops and gradually fill up 
the SWIOTLB buffer. That's something you're liable to have a bad time 
with under real-world usage ;)

The overall cleanup is *so* much better though, thanks for that!

Robin.
