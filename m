Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4239B4BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhFDIVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:21:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3153 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDIVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:21:48 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FxFrl428tz6G7N6;
        Fri,  4 Jun 2021 16:13:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 10:20:00 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 09:20:00 +0100
Subject: Re: [PATCH v10 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <chenxiang66@hisilicon.com>
References: <1622728715-209296-1-git-send-email-john.garry@huawei.com>
 <1622728715-209296-2-git-send-email-john.garry@huawei.com>
 <0e54ff0f-c668-354e-1ec8-7536c701d3a8@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <285ba65e-4c65-4320-13d9-60c4d72d82cb@huawei.com>
Date:   Fri, 4 Jun 2021 09:19:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <0e54ff0f-c668-354e-1ec8-7536c701d3a8@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   
>>   	  If unsure, say N here.
>>   
>> +choice
>> +	prompt "IOMMU default DMA mode"
>> +	depends on IOMMU_API
> 
> config INTEL_IOMMU
>          depends on PCI_MSI && ACPI && (X86 || IA64)
> 
> config AMD_IOMMU
>          depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
> 
> config ARM_SMMU_V3
>          depends on ARM64
> 
> "depends on ARM_SMMU_V3 || INTEL_IOMMU || AMD_IOMMU" may need to be added, because it doesn't work on other platforms.
> 
> or "depends on X86 || IA64 || X86_64 || ARM64"

I suppose so. But I don't think that any other archs use the value from 
iommu_dma_strict anyway.

> 
>> +
>> +	default IOMMU_DEFAULT_STRICT
>> +	help
>> +	  This option allows an IOMMU DMA mode to be chosen at build time, to
>> +	  override the default DMA mode of each ARCH, removing the need to
>> +	  pass in kernel parameters through command line. It is still possible
>> +	  to provide ARCH-specific or common boot options to override this
>> +	  option.
>> +
>> +	  If unsure, keep the default.
>> +
>> +config IOMMU_DEFAULT_LAZY
>> +	bool "lazy"
>> +	help
>> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
>> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
>> +	  They are only guaranteed to be done before the related IOVA will be
>> +	  reused.
>> +
>> +config IOMMU_DEFAULT_STRICT
>> +	bool "strict"
>> +	help
>> +	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
>> +	  the free operation of IOVA are guaranteed to be done in the unmap
>> +	  function.
>> +
>> +	  This mode is safer than the two above, but it maybe slower in some
>> +	  high performace scenarios.
>> +
>> +endchoice
>> +
>>   config OF_IOMMU
>>   	def_bool y
>>   	depends on OF && IOMMU_API
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 966426a96520..177b0dafc535 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
>>   static DEFINE_IDA(iommu_group_ida);
>>   
>>   static unsigned int iommu_def_domain_type __read_mostly;
>> -static bool iommu_dma_strict __read_mostly = true;
>> +static bool iommu_dma_strict __read_mostly =
>> +			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
> 
> Currently, a maximum of 100 columns are allowed in a row.

Sure, but some people still prefer limiting to 80, and codingstyle
doc mentions a preference for 80.

But if you really think I should change, then that's ok.

Thanks,
John
