Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354003C9BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhGOJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:35:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7017 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbhGOJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:34:55 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQTWx2F59zXj5y;
        Thu, 15 Jul 2021 17:26:21 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 17:32:00 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 15 Jul 2021 17:31:59 +0800
Subject: Re: [PATCH v7 10/15] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>, <will@kernel.org>,
        <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <isaacm@codeaurora.org>,
        <baolu.lu@linux.intel.com>, <pratikp@codeaurora.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <djakov@kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-11-git-send-email-quic_c_gdjako@quicinc.com>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <f0c8e5d4-a8af-69a1-b14b-99309857f82f@huawei.com>
Date:   Thu, 15 Jul 2021 17:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-11-git-send-email-quic_c_gdjako@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/16 21:38, Georgi Djakov wrote:
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
>
> Implement the unmap_pages() callback for the ARM LPAE io-pgtable
> format.
>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 120 +++++++++++++++++++++++++----------------
>   1 file changed, 74 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index ea66b10c04c4..fe8fa0ee9c98 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -46,6 +46,9 @@
>   #define ARM_LPAE_PGD_SIZE(d)						\
>   	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
>   
> +#define ARM_LPAE_PTES_PER_TABLE(d)					\
> +	(ARM_LPAE_GRANULE(d) >> ilog2(sizeof(arm_lpae_iopte)))
> +
>   /*
>    * Calculate the index at level l used to map virtual address a using the
>    * pagetable in d.
> @@ -239,22 +242,19 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>   				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>   }
>   
> -static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
> -			       int num_entries, struct io_pgtable_cfg *cfg)
> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
>   {
> -	int i;
>   
> -	for (i = 0; i < num_entries; i++)
> -		ptep[i] = pte;
> +	*ptep = 0;
>   
>   	if (!cfg->coherent_walk)
> -		__arm_lpae_sync_pte(ptep, num_entries, cfg);
> +		__arm_lpae_sync_pte(ptep, 1, cfg);
>   }
>   
Thank you for providing this patchset, I am updating my patches based on it.

But can we keep __arm_lpae_set_pte()? I think it's better to remove 
'num_entries'.
I am really need it. If you remove it, I have to add it back.😅

Thanks,
Kunkun Jiang
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			       struct iommu_iotlb_gather *gather,
> -			       unsigned long iova, size_t size, int lvl,
> -			       arm_lpae_iopte *ptep);
> +			       unsigned long iova, size_t size, size_t pgcount,
> +			       int lvl, arm_lpae_iopte *ptep);
>   
>   static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   				phys_addr_t paddr, arm_lpae_iopte prot,
> @@ -298,7 +298,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>   
>   			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
> -			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
> +			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
>   					     lvl, tblp) != sz) {
>   				WARN_ON(1);
>   				return -EINVAL;
> @@ -526,14 +526,15 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   				       struct iommu_iotlb_gather *gather,
>   				       unsigned long iova, size_t size,
>   				       arm_lpae_iopte blk_pte, int lvl,
> -				       arm_lpae_iopte *ptep)
> +				       arm_lpae_iopte *ptep, size_t pgcount)
>   {
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>   	arm_lpae_iopte pte, *tablep;
>   	phys_addr_t blk_paddr;
>   	size_t tablesz = ARM_LPAE_GRANULE(data);
>   	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
> -	int i, unmap_idx = -1;
> +	int ptes_per_table = ARM_LPAE_PTES_PER_TABLE(data);
> +	int i, unmap_idx_start = -1, num_entries = 0, max_entries;
>   
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>   		return 0;
> @@ -542,15 +543,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   	if (!tablep)
>   		return 0; /* Bytes unmapped */
>   
> -	if (size == split_sz)
> -		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	if (size == split_sz) {
> +		unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +		max_entries = ptes_per_table - unmap_idx_start;
> +		num_entries = min_t(int, pgcount, max_entries);
> +	}
>   
>   	blk_paddr = iopte_to_paddr(blk_pte, data);
>   	pte = iopte_prot(blk_pte);
>   
> -	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz) {
> +	for (i = 0; i < ptes_per_table; i++, blk_paddr += split_sz) {
>   		/* Unmap! */
> -		if (i == unmap_idx)
> +		if (i >= unmap_idx_start && i < (unmap_idx_start + num_entries))
>   			continue;
>   
>   		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
> @@ -568,76 +572,92 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   			return 0;
>   
>   		tablep = iopte_deref(pte, data);
> -	} else if (unmap_idx >= 0) {
> -		io_pgtable_tlb_add_page(&data->iop, gather, iova, size);
> -		return size;
> +	} else if (unmap_idx_start >= 0) {
> +		for (i = 0; i < num_entries; i++)
> +			io_pgtable_tlb_add_page(&data->iop, gather, iova + i * size, size);
> +
> +		return num_entries * size;
>   	}
>   
> -	return __arm_lpae_unmap(data, gather, iova, size, lvl, tablep);
> +	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl, tablep);
>   }
>   
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			       struct iommu_iotlb_gather *gather,
> -			       unsigned long iova, size_t size, int lvl,
> -			       arm_lpae_iopte *ptep)
> +			       unsigned long iova, size_t size, size_t pgcount,
> +			       int lvl, arm_lpae_iopte *ptep)
>   {
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> +	int i = 0, num_entries, max_entries, unmap_idx_start;
>   
>   	/* Something went horribly wrong and we ran out of page table */
>   	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>   		return 0;
>   
> -	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	ptep += unmap_idx_start;
>   	pte = READ_ONCE(*ptep);
>   	if (WARN_ON(!pte))
>   		return 0;
>   
>   	/* If the size matches this level, we're in the right place */
>   	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> -		__arm_lpae_set_pte(ptep, 0, 1, &iop->cfg);
> -
> -		if (!iopte_leaf(pte, lvl, iop->fmt)) {
> -			/* Also flush any partial walks */
> -			io_pgtable_tlb_flush_walk(iop, iova, size,
> -						  ARM_LPAE_GRANULE(data));
> -			ptep = iopte_deref(pte, data);
> -			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
> -		} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
> -			/*
> -			 * Order the PTE update against queueing the IOVA, to
> -			 * guarantee that a flush callback from a different CPU
> -			 * has observed it before the TLBIALL can be issued.
> -			 */
> -			smp_wmb();
> -		} else {
> -			io_pgtable_tlb_add_page(iop, gather, iova, size);
> +		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
> +		num_entries = min_t(int, pgcount, max_entries);
> +
> +		while (i < num_entries) {
> +			pte = READ_ONCE(*ptep);
> +			if (WARN_ON(!pte))
> +				break;
> +
> +			__arm_lpae_clear_pte(ptep, &iop->cfg);
> +
> +			if (!iopte_leaf(pte, lvl, iop->fmt)) {
> +				/* Also flush any partial walks */
> +				io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
> +							  ARM_LPAE_GRANULE(data));
> +				__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> +			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
> +				/*
> +				 * Order the PTE update against queueing the IOVA, to
> +				 * guarantee that a flush callback from a different CPU
> +				 * has observed it before the TLBIALL can be issued.
> +				 */
> +				smp_wmb();
> +			} else {
> +				io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
> +			}
> +
> +			ptep++;
> +			i++;
>   		}
>   
> -		return size;
> +		return i * size;
>   	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
>   		/*
>   		 * Insert a table at the next level to map the old region,
>   		 * minus the part we want to unmap
>   		 */
>   		return arm_lpae_split_blk_unmap(data, gather, iova, size, pte,
> -						lvl + 1, ptep);
> +						lvl + 1, ptep, pgcount);
>   	}
>   
>   	/* Keep on walkin' */
>   	ptep = iopte_deref(pte, data);
> -	return __arm_lpae_unmap(data, gather, iova, size, lvl + 1, ptep);
> +	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl + 1, ptep);
>   }
>   
> -static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> -			     size_t size, struct iommu_iotlb_gather *gather)
> +static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>   	arm_lpae_iopte *ptep = data->pgd;
>   	long iaext = (s64)iova >> cfg->ias;
>   
> -	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
> +	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
>   		return 0;
>   
>   	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> @@ -645,7 +665,14 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>   	if (WARN_ON(iaext))
>   		return 0;
>   
> -	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);
> +	return __arm_lpae_unmap(data, gather, iova, pgsize, pgcount,
> +				data->start_level, ptep);
> +}
> +
> +static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> +			     size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	return arm_lpae_unmap_pages(ops, iova, size, 1, gather);
>   }
>   
>   static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> @@ -761,6 +788,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>   	data->iop.ops = (struct io_pgtable_ops) {
>   		.map		= arm_lpae_map,
>   		.unmap		= arm_lpae_unmap,
> +		.unmap_pages	= arm_lpae_unmap_pages,
>   		.iova_to_phys	= arm_lpae_iova_to_phys,
>   	};
>   


