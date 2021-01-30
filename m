Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79BA3091E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 05:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhA3EoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 23:44:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12050 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhA3EH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:07:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DSHyg6SxHzMPRR;
        Sat, 30 Jan 2021 10:21:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 10:23:20 +0800
Subject: Re: [PATCH v3 1/3] perf/smmuv3: Don't reserve the PMCG register
 spaces
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-2-thunder.leizhen@huawei.com>
 <a794cb2f-599e-c346-042e-d361d5321cce@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d8e2d4ba-e176-5af4-a3a5-7601ef2598d0@huawei.com>
Date:   Sat, 30 Jan 2021 10:23:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a794cb2f-599e-c346-042e-d361d5321cce@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/29 23:06, Robin Murphy wrote:
> On 2021-01-27 11:32, Zhen Lei wrote:
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
> 
> I'm still not a fan of this get_and_ioremap notion in general, especially when the "helper" function ends up over twice the size of all the code it replaces[1], but for the actual functional change here,

OK，I'll change it to [1] and add some comments.

> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/perf/arm_smmuv3_pmu.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>> index 74474bb322c3f26..e5e505a0804fe53 100644
>> --- a/drivers/perf/arm_smmuv3_pmu.c
>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>> @@ -761,6 +761,29 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>>       dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
>>   }
>>   +static void __iomem *
>> +smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
>> +                  unsigned int index,
>> +                  struct resource **res)
>> +{
>> +    void __iomem *base;
>> +    struct resource *r;
>> +
>> +    r = platform_get_resource(pdev, IORESOURCE_MEM, index);
>> +    if (!r) {
>> +        dev_err(&pdev->dev, "invalid resource\n");
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +    if (res)
>> +        *res = r;
>> +
>> +    base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
>> +    if (!base)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    return base;
>> +}
>> +
>>   static int smmu_pmu_probe(struct platform_device *pdev)
>>   {
>>       struct smmu_pmu *smmu_pmu;
>> @@ -793,7 +816,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>           .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>>       };
>>   -    smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
>> +    smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
>>       if (IS_ERR(smmu_pmu->reg_base))
>>           return PTR_ERR(smmu_pmu->reg_base);
>>   @@ -801,7 +824,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>         /* Determine if page 1 is present */
>>       if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
>> -        smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
>> +        smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
>>           if (IS_ERR(smmu_pmu->reloc_base))
>>               return PTR_ERR(smmu_pmu->reloc_base);
>>       } else {
>>
> 
> [1]
> ----->8-----
>  drivers/perf/arm_smmuv3_pmu.c | 35 +++++++++--------------------------
>  1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index e5e505a0804f..c9adbc7b55a1 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -761,33 +761,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>      dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
>  }
> 
> -static void __iomem *
> -smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
> -                  unsigned int index,
> -                  struct resource **res)
> -{
> -    void __iomem *base;
> -    struct resource *r;
> -
> -    r = platform_get_resource(pdev, IORESOURCE_MEM, index);
> -    if (!r) {
> -        dev_err(&pdev->dev, "invalid resource\n");
> -        return ERR_PTR(-EINVAL);
> -    }
> -    if (res)
> -        *res = r;
> -
> -    base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
> -    if (!base)
> -        return ERR_PTR(-ENOMEM);
> -
> -    return base;
> -}
> -
>  static int smmu_pmu_probe(struct platform_device *pdev)
>  {
>      struct smmu_pmu *smmu_pmu;
> -    struct resource *res_0;
> +    struct resource *res_0, *res_1;
>      u32 cfgr, reg_size;
>      u64 ceid_64[2];
>      int irq, err;
> @@ -816,7 +793,10 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>          .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>      };
> 
> -    smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
> +    res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +    if (!res_0)
> +        return ERR_PTR(-EINVAL);
> +    smmu_pmu->reg_base = devm_ioremap(dev, res_0->start, resource_size(res_0));
>      if (IS_ERR(smmu_pmu->reg_base))
>          return PTR_ERR(smmu_pmu->reg_base);
> 
> @@ -824,7 +804,10 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> 
>      /* Determine if page 1 is present */
>      if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
> -        smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
> +        res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +        if (!res_1)
> +            return -EINVAL;
> +        smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start, resource_size(res_1));
>          if (IS_ERR(smmu_pmu->reloc_base))
>              return PTR_ERR(smmu_pmu->reloc_base);
>      } else {
> 
> .
> 

