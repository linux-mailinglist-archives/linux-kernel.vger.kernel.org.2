Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6949C454C64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbhKQRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:49:39 -0500
Received: from foss.arm.com ([217.140.110.172]:33122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232034AbhKQRti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:49:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE52D6E;
        Wed, 17 Nov 2021 09:46:39 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D453F5A1;
        Wed, 17 Nov 2021 09:46:38 -0800 (PST)
Message-ID: <a2b45243-7e0a-a2ac-4e14-5256a3e7abb4@arm.com>
Date:   Wed, 17 Nov 2021 17:46:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix table descriptor paddr
 formatting
Content-Language: en-GB
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Will Deacon <will@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20211117171213.243584-1-marcan@marcan.st>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211117171213.243584-1-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-17 17:12, Hector Martin wrote:
> Table descriptors were being installed without properly formatting the
> address using paddr_to_iopte, which does not match up with the
> iopte_deref in __arm_lpae_map. This is incorrect for the LPAE pte
> format, as it does not handle the high bits properly.

Oh, I guess whatever system it was tested on can't have exercised it all
that thoroughly. IIRC I couldn't test it myself since at the time none
of the Fast Model builds with SMMUs actually implemented any memory
above 48 bits.

> This was found on Apple T6000 DARTs, which require a new pte format
> (different shift); adding support for that to
> paddr_to_iopte/iopte_to_paddr caused it to break badly, as even <48-bit
> addresses would end up incorrect in that case.

...I look forward to not wanting to look at that patch :)

> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/iommu/io-pgtable-arm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index dd9e47189d0d..b636e2737607 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -315,12 +315,12 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
>   					     arm_lpae_iopte *ptep,
>   					     arm_lpae_iopte curr,
> -					     struct io_pgtable_cfg *cfg)
> +					     struct arm_lpae_io_pgtable *data)
>   {

Please just define a local "cfg" variable here like in most other
places, to avoid the rest of the churn in this function. Other than
that,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Also,

Fixes: 6c89928ff7a0 ("iommu/io-pgtable-arm: Support 52-bit physical address")

Thanks,
Robin.
(currently elbow-deep in other parts of io-pgtable-arm...)

>   	arm_lpae_iopte old, new;
>   
> -	new = __pa(table) | ARM_LPAE_PTE_TYPE_TABLE;
> -	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
> +	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
>   		new |= ARM_LPAE_PTE_NSTABLE;
>   
>   	/*
> @@ -332,11 +332,11 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
>   
>   	old = cmpxchg64_relaxed(ptep, curr, new);
>   
> -	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
> +	if (data->iop.cfg.coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
>   		return old;
>   
>   	/* Even if it's not ours, there's no point waiting; just kick it */
> -	__arm_lpae_sync_pte(ptep, 1, cfg);
> +	__arm_lpae_sync_pte(ptep, 1, &data->iop.cfg);
>   	if (old == curr)
>   		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
>   
> @@ -380,7 +380,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   		if (!cptep)
>   			return -ENOMEM;
>   
> -		pte = arm_lpae_install_table(cptep, ptep, 0, cfg);
> +		pte = arm_lpae_install_table(cptep, ptep, 0, data);
>   		if (pte)
>   			__arm_lpae_free_pages(cptep, tblsz, cfg);
>   	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
> @@ -592,7 +592,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
>   	}
>   
> -	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
> +	pte = arm_lpae_install_table(tablep, ptep, blk_pte, data);
>   	if (pte != blk_pte) {
>   		__arm_lpae_free_pages(tablep, tablesz, cfg);
>   		/*
> 
