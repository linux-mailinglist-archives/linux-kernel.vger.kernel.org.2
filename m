Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A53AE4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFUIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:21:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3290 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFUIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:21:10 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7hxk3T1Vz6K7Td;
        Mon, 21 Jun 2021 16:08:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 10:18:54 +0200
Received: from [10.47.93.67] (10.47.93.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 21 Jun
 2021 09:18:53 +0100
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <dwmw2@infradead.org>, <robin.murphy@arm.com>,
        <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, <linux-doc@vger.kernel.org>
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
Date:   Mon, 21 Jun 2021 09:12:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.93.67]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2021 06:17, Lu Baolu wrote:
> On 2021/6/18 19:34, John Garry wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 60b1ec42e73b..ff221d3ddcbc 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>>   }
>>   early_param("iommu.strict", iommu_dma_setup);
>> -void iommu_set_dma_strict(bool strict)
>> +void iommu_set_dma_strict(void)
>>   {
>> -    if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>> -        iommu_dma_strict = strict;
>> +    iommu_dma_strict = true;
>>   }
> 

Hi baolu,

> Sorry for this late comment.
>  > Normally the cache invalidation policy should come from the user. We
> have pre-build kernel option and also a kernel boot command iommu.strict
> to override it. These seem reasonable.
> 
> We also have a helper (iommu_set_dma_strict()) so that the vendor iommu
> driver could squeeze in and change the previous settings mostly due to:
> 
> a) vendor iommu driver specific kernel boot command. (We are about to
>     deprecate those.)
> 
> b) quirky hardware.
> 
> c) kernel optimization (e.x. strict mode in VM environment).
> 
> a) and b) are mandatory, while c) is optional. In any instance should c)
> override the flush mode specified by the user. Hence, probably we should
> also have another helper like:
> 
> void iommu_set_dma_strict_optional()
> {
>      if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>          iommu_dma_strict = true;
> }
> 
> Any thoughts?

What you are suggesting is a change in policy from mainline code. 
Currently for c) we always set strict enabled, regardless of any user 
cmdline input. But now you are saying that you want iommu.strict to 
override in particular scenario, right?

In that case I would think it's better to rework the current API, like 
adding an option to "force" strict mode:

void iommu_set_dma_strict(bool force)
{
      	if (force == true)
		iommu_dma_strict = true;
	else if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
		iommu_dma_strict = true;
}

So we would use iommu_set_dma_strict(true) for a) and b), but 
iommu_set_dma_strict(false) for c).

Then I am not sure what you want to do with the accompanying print for 
c). It was:
"IOMMU batching is disabled due to virtualization"

And now is from this series:
"IOMMU batching disallowed due to virtualization"

Using iommu_get_dma_strict(domain) is not appropriate here to know the 
current mode (so we know whether to print).

Note that this change would mean that the current series would require 
non-trivial rework, which would be unfortunate so late in the cycle.

Thanks,
John
