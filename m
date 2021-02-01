Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0812A30A742
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhBAMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:09:28 -0500
Received: from foss.arm.com ([217.140.110.172]:58130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBAMJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:09:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF1DED1;
        Mon,  1 Feb 2021 04:08:38 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B853F718;
        Mon,  1 Feb 2021 04:08:36 -0800 (PST)
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register
 spaces
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9904b39d-f328-14d6-b5d8-8b9e8a1437b6@arm.com>
Date:   Mon, 1 Feb 2021 12:08:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210130071414.1575-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-30 07:14, Zhen Lei wrote:
> According to the SMMUv3 specification:
> Each PMCG counter group is represented by one 4KB page (Page 0) with one
> optional additional 4KB page (Page 1), both of which are at IMPLEMENTATION
> DEFINED base addresses.
> 
> This means that the PMCG register spaces may be within the 64KB pages of
> the SMMUv3 register space. When both the SMMU and PMCG drivers reserve
> their own resources, a resource conflict occurs.
> 
> To avoid this conflict, don't reserve the PMCG regions.

I said my review on v3 stood either way, but for the avoidance of doubt,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I hadn't considered that a comment is a very good idea, in case the 
cleanup-script crew find this in future and try to "simplify" it :)

Thanks,
Robin.

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 74474bb322c3f26..5e894f957c7b935 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -793,17 +793,30 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>   	};
>   
> -	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
> -	if (IS_ERR(smmu_pmu->reg_base))
> -		return PTR_ERR(smmu_pmu->reg_base);
> +	/*
> +	 * The register spaces of the PMCG may be in the register space of
> +	 * other devices. For example, SMMU. Therefore, the PMCG resources are
> +	 * not reserved to avoid resource conflicts with other drivers.
> +	 */
> +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_0)
> +		return ERR_PTR(-EINVAL);
> +	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start, resource_size(res_0));
> +	if (!smmu_pmu->reg_base)
> +		return ERR_PTR(-ENOMEM);
>   
>   	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
>   
>   	/* Determine if page 1 is present */
>   	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
> -		if (IS_ERR(smmu_pmu->reloc_base))
> -			return PTR_ERR(smmu_pmu->reloc_base);
> +		struct resource *res_1;
> +
> +		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		if (!res_1)
> +			return ERR_PTR(-EINVAL);
> +		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start, resource_size(res_1));
> +		if (!smmu_pmu->reloc_base)
> +			return ERR_PTR(-ENOMEM);
>   	} else {
>   		smmu_pmu->reloc_base = smmu_pmu->reg_base;
>   	}
> 
