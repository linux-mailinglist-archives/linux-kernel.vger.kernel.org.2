Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F93A5E00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhFNIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:01:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3227 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhFNIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:01:16 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G3Nmg6Vzhz6H7N7;
        Mon, 14 Jun 2021 15:46:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 14 Jun 2021 09:59:12 +0200
Received: from [10.47.95.26] (10.47.95.26) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 14 Jun
 2021 08:59:11 +0100
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6055cd0d-a1d3-a73a-6831-3837021f3c9c@huawei.com>
Date:   Mon, 14 Jun 2021 08:53:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.26]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2021 03:22, Lu Baolu wrote:
> On 2021/6/11 20:20, John Garry wrote:
>> @@ -453,8 +452,7 @@ static int __init intel_iommu_setup(char *str)
>>               pr_warn("intel_iommu=forcedac deprecated; use 
>> iommu.forcedac instead\n");
>>               iommu_dma_forcedac = true;
>>           } else if (!strncmp(str, "strict", 6)) {
>> -            pr_info("Disable batched IOTLB flush\n");
>> -            intel_iommu_strict = 1;
>> +            iommu_set_dma_strict(true);
> 
> I would like to deprecate this command line and ask users to use
> iommu.strict instead.

ok, but then I should probably make the AMD driver also officially 
support this.

> 
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -436,7 +436,7 @@ static int __init intel_iommu_setup(char *str)
>                          pr_warn("intel_iommu=forcedac deprecated; use 
> iommu.forcedac instead\n");
>                          iommu_dma_forcedac = true;
>                  } else if (!strncmp(str, "strict", 6)) {
> -                       pr_info("Disable batched IOTLB flush\n");
> +                       pr_warn("intel_iommu=strict deprecated; use 
> iommu.strict instead\n");
>                          intel_iommu_strict = 1;
> 
> Also update Documentation/admin-guide/kernel-parameters.txt accordingly.

Thanks,
John
