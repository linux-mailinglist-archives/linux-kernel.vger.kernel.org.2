Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318D83A1992
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhFIPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:32:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3190 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhFIPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:32:01 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0W1T6RGvz6J9WM;
        Wed,  9 Jun 2021 23:17:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 17:30:04 +0200
Received: from [10.47.80.201] (10.47.80.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 16:30:03 +0100
Subject: Re: [PATCH v11 1/3] iommu: Enhance IOMMU default DMA mode build
 options
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>
CC:     <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <iommu@lists.linux-foundation.org>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
 <1623158308-180604-2-git-send-email-john.garry@huawei.com>
 <b9575a44-24c7-a05b-6f02-0495e95a4cec@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bef59822-71ab-a82e-ed95-0e139cf1fbf0@huawei.com>
Date:   Wed, 9 Jun 2021 16:24:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b9575a44-24c7-a05b-6f02-0495e95a4cec@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.201]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 16:03, Robin Murphy wrote:
> On 2021-06-08 14:18, John Garry wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
>> opportunity to set {lazy|strict} mode as default at build time. Then put
>> the two config options in a choice, as they are mutually exclusive.
>>
>> [jpg: Make choice between strict and lazy only (and not passthrough)]
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/iommu/Kconfig | 35 +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c |  3 ++-
>>   2 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 1f111b399bca..369a3af9e5bf 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -90,6 +90,41 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>         If unsure, say N here.
>> +choice
>> +    prompt "IOMMU default DMA mode"
>> +    depends on IOMMU_API
>> +    depends on X86 || IA64 || X86_64 || ARM || ARM64
> 
> Simply "depends on IOMMU_DMA" should suffice, since that's now the only 
> place where flush queues matter.

I suppose so.

Configs ARM64, AMD_IOMMU, and INTEL_IOMMU all select this.

> 
>> +
>> +    default IOMMU_DEFAULT_STRICT
>> +    help
>> +      This option allows an IOMMU DMA mode to be chosen at build 
>> time, to
>> +      override the default DMA mode of each ARCH, removing the need to
>> +      pass in kernel parameters through command line. It is still 
>> possible
>> +      to provide ARCH-specific or common boot options to override this
>> +      option.
>> +
>> +      If unsure, keep the default.
>> +
>> +config IOMMU_DEFAULT_LAZY
>> +    bool "lazy"
>> +    help
>> +      Support lazy mode, where for every IOMMU DMA unmap operation, the
>> +      flush operation of IOTLB and the free operation of IOVA are 
>> deferred.
>> +      They are only guaranteed to be done before the related IOVA 
>> will be
>> +      reused.
>> +
>> +config IOMMU_DEFAULT_STRICT
>> +    bool "strict"
>> +    help
>> +      For every IOMMU DMA unmap operation, the flush operation of 
>> IOTLB and
>> +      the free operation of IOVA are guaranteed to be done in the unmap
>> +      function.
>> +
>> +      This mode is safer than lazy mode, but it may be slower in some 
>> high
>> +      performance scenarios.
> 
> FWIW, as an end user who doesn't care much about the implementation 
> details I'd probably appreciate the actual implications being clearer, 
> i.e. what does "safer" mean in practice and what is it relative to?
> 

Fine, I can mention that lazy mode means that we have reduced device 
isolation and a dangerous window can be created between device driver 
DMA unmap and zapping the mapping in the IOMMU; however still much safer 
than passthrough/no IOMMU, which means no isolation at all.

Thanks,
John
