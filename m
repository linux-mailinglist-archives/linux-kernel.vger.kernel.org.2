Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD130A85E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhBANLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:11:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11668 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhBANLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:11:13 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTpDN2p5dzlF09;
        Mon,  1 Feb 2021 21:08:52 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 21:10:21 +0800
Subject: Re: [PATCH v4 1/2] perf/smmuv3: Don't reserve the PMCG register
 spaces
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210130071414.1575-1-thunder.leizhen@huawei.com>
 <20210130071414.1575-2-thunder.leizhen@huawei.com>
 <20210201125412.GA14772@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c69665cc-2804-7984-ef2d-b8602965a605@huawei.com>
Date:   Mon, 1 Feb 2021 21:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210201125412.GA14772@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/1 20:54, Will Deacon wrote:
> On Sat, Jan 30, 2021 at 03:14:13PM +0800, Zhen Lei wrote:
>> According to the SMMUv3 specification:
>> Each PMCG counter group is represented by one 4KB page (Page 0) with one
>> optional additional 4KB page (Page 1), both of which are at IMPLEMENTATION
>> DEFINED base addresses.
>>
>> This means that the PMCG register spaces may be within the 64KB pages of
>> the SMMUv3 register space. When both the SMMU and PMCG drivers reserve
>> their own resources, a resource conflict occurs.
>>
>> To avoid this conflict, don't reserve the PMCG regions.
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++------
>>  1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>> index 74474bb322c3f26..5e894f957c7b935 100644
>> --- a/drivers/perf/arm_smmuv3_pmu.c
>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>> @@ -793,17 +793,30 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>>  	};
>>  
>> -	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
>> -	if (IS_ERR(smmu_pmu->reg_base))
>> -		return PTR_ERR(smmu_pmu->reg_base);
>> +	/*
>> +	 * The register spaces of the PMCG may be in the register space of
>> +	 * other devices. For example, SMMU. Therefore, the PMCG resources are
>> +	 * not reserved to avoid resource conflicts with other drivers.
>> +	 */
>> +	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res_0)
>> +		return ERR_PTR(-EINVAL);
> 
> I tried to apply this, but you've got your return type in a muddle:

I'm dizzy. I don't know how this bug patch came out. I just pinched my leg, like I'm still in the real world.

The "ERR_PTR()" of the four ERR_PTR(xxx) should be removed. Can you help me? Or I send a new one.

> 
> @@ @@
> +drivers/perf/arm_smmuv3_pmu.c: In function ‘smmu_pmu_probe’:
> +drivers/perf/arm_smmuv3_pmu.c:803:10: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
> +  803 |   return ERR_PTR(-EINVAL);
> +      |          ^~~~~~~~~~~~~~~~
> +drivers/perf/arm_smmuv3_pmu.c:803:31: warning: incorrect type in return expression (different base types) [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:803:31:    expected int [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:803:31:    got void * [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:806:10: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
> +  806 |   return ERR_PTR(-ENOMEM);
> +      |          ^~~~~~~~~~~~~~~~
> +drivers/perf/arm_smmuv3_pmu.c:806:31: warning: incorrect type in return expression (different base types) [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:806:31:    expected int [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:806:31:    got void * [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:816:11: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
> +  816 |    return ERR_PTR(-EINVAL);
> +      |           ^~~~~~~~~~~~~~~~
> +drivers/perf/arm_smmuv3_pmu.c:816:39: warning: incorrect type in return expression (different base types) [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:816:39:    expected int [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:816:39:    got void * [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:819:11: warning: returning ‘void *’ from a function with return type ‘int’ makes integer from pointer without a cast [-Wint-conversion]
> +  819 |    return ERR_PTR(-ENOMEM);
> +      |           ^~~~~~~~~~~~~~~~
> +drivers/perf/arm_smmuv3_pmu.c:819:39: warning: incorrect type in return expression (different base types) [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:819:39:    expected int [sparse]
> +drivers/perf/arm_smmuv3_pmu.c:819:39:    got void * [sparse]
> 
> Will
> 
> .
> 

