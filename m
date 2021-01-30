Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44E309390
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhA3Jl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:41:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11960 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhA3Jh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:37:58 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSQrr1fm0zjFDr;
        Sat, 30 Jan 2021 15:32:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 15:33:02 +0800
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register
 spaces
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <139a573b-a8ab-c494-0f4c-0fd720ce82db@huawei.com>
Date:   Sat, 30 Jan 2021 15:33:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210130071414.1575-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robin:
  Can you review this patch again?


On 2021/1/30 15:14, Zhen Lei wrote:
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
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index 74474bb322c3f26..5e894f957c7b935 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -793,17 +793,30 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	};
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
>  	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
>  
>  	/* Determine if page 1 is present */
>  	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
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
>  	} else {
>  		smmu_pmu->reloc_base = smmu_pmu->reg_base;
>  	}
> 

