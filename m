Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5085B31CB64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBPNqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:46:08 -0500
Received: from foss.arm.com ([217.140.110.172]:35456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhBPNqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:46:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC0E31B;
        Tue, 16 Feb 2021 05:45:16 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E96FF3F694;
        Tue, 16 Feb 2021 05:45:14 -0800 (PST)
Subject: Re: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
 <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com>
 <33cf95925cfb47dda3ee472e00b9846c@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f89f150f-20d3-8f22-c6c5-92c19d3d7e33@arm.com>
Date:   Tue, 16 Feb 2021 13:45:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <33cf95925cfb47dda3ee472e00b9846c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-12 17:28, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Shameerali Kolothum Thodi
>> Sent: 12 February 2021 16:45
>> To: 'Robin Murphy' <robin.murphy@arm.com>; linux-kernel@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: joro@8bytes.org; jean-philippe@linaro.org; will@kernel.org; Zengtao (B)
>> <prime.zeng@hisilicon.com>; linuxarm@openeuler.org
>> Subject: RE: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
>>
>>
>>
>>> -----Original Message-----
>>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>>> Sent: 12 February 2021 16:39
>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org
>>> Cc: joro@8bytes.org; jean-philippe@linaro.org; will@kernel.org; Zengtao (B)
>>> <prime.zeng@hisilicon.com>; linuxarm@openeuler.org
>>> Subject: Re: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx
>> functions
>>>
>>> On 2021-02-12 14:54, Shameerali Kolothum Thodi wrote:
>>>> Hi Robin/Joerg,
>>>>
>>>>> -----Original Message-----
>>>>> From: Shameer Kolothum
>> [mailto:shameerali.kolothum.thodi@huawei.com]
>>>>> Sent: 01 February 2021 12:41
>>>>> To: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org
>>>>> Cc: joro@8bytes.org; robin.murphy@arm.com; jean-philippe@linaro.org;
>>>>> will@kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
>>>>> linuxarm@openeuler.org
>>>>> Subject: [Linuxarm] [PATCH v2] iommu: Check dev->iommu in
>>> iommu_dev_xxx
>>>>> functions
>>>>>
>>>>> The device iommu probe/attach might have failed leaving dev->iommu
>>>>> to NULL and device drivers may still invoke these functions resulting
>>>>> in a crash in iommu vendor driver code. Hence make sure we check that.
>>>>>
>>>>> Also added iommu_ops to the "struct dev_iommu" and set it if the dev
>>>>> is successfully associated with an iommu.
>>>>>
>>>>> Fixes: a3a195929d40 ("iommu: Add APIs for multiple domains per
>> device")
>>>>> Signed-off-by: Shameer Kolothum
>>> <shameerali.kolothum.thodi@huawei.com>
>>>>> ---
>>>>> v1 --> v2:
>>>>>    -Added iommu_ops to struct dev_iommu based on the discussion with
>>> Robin.
>>>>>    -Rebased against iommu-tree core branch.
>>>>
>>>> A gentle ping on this...
>>>
>>> Is there a convincing justification for maintaining yet another copy of
>>> the ops pointer rather than simply dereferencing iommu_dev->ops at point
>>> of use?
>>>
>>
>> TBH, nothing I can think of now. That was mainly the way I interpreted your
>> suggestion
>> from the v1.  Now it looks like you didn’t mean it :). I am Ok to rework it to
>> dereference
>> it from iommu_dev. Please let me know.
> 
> So we can do something like this,
> 
> index fd76e2f579fe..5fd31a3cec18 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2865,10 +2865,12 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>    */
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>   {
> -       const struct iommu_ops *ops = dev->bus->iommu_ops;
> +       if (dev->iommu && dev->iommu->iommu_dev && dev->iommu->iommu_dev->ops)
> +               struct iommu_ops  *ops = dev->iommu->iommu_dev->ops;
>   
> -       if (ops && ops->dev_enable_feat)
> -               return ops->dev_enable_feat(dev, feat);
> +               if (ops->dev_enable_feat)
> +                       return ops->dev_enable_feat(dev, feat);
> +       }
>   
>          return -ENODEV;
>   }
> 
> Again, not sure we need to do the checking for iommu->dev and ops here. If the
> dev->iommu is set, is it safe to assume that we have a valid iommu->iommu_dev
> and ops always? (May be it is safer to do the checking in case something
> else breaks this assumption in future). Please let me know your thoughts.

I think it *could* happen that dev->iommu is set by iommu_fwspec_init() 
but iommu_probe_device() later refuses the device for whatever reason, 
so we would still need to check iommu->iommu_dev to be completely safe. 
We can assume iommu_dev->ops is valid, since if the IOMMU driver has 
returned something bogus from .probe_device then it's a major bug in 
that driver and crashing is the best indicator :)

Robin.

> 
> Thanks,
> Shameer
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
