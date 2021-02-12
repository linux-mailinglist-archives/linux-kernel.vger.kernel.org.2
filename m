Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825B131A2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhBLQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 11:41:57 -0500
Received: from foss.arm.com ([217.140.110.172]:39678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhBLQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:39:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111971063;
        Fri, 12 Feb 2021 08:38:41 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16743F73B;
        Fri, 12 Feb 2021 08:38:39 -0800 (PST)
Subject: Re: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com>
Date:   Fri, 12 Feb 2021 16:38:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-12 14:54, Shameerali Kolothum Thodi wrote:
> Hi Robin/Joerg,
> 
>> -----Original Message-----
>> From: Shameer Kolothum [mailto:shameerali.kolothum.thodi@huawei.com]
>> Sent: 01 February 2021 12:41
>> To: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org
>> Cc: joro@8bytes.org; robin.murphy@arm.com; jean-philippe@linaro.org;
>> will@kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
>> linuxarm@openeuler.org
>> Subject: [Linuxarm] [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx
>> functions
>>
>> The device iommu probe/attach might have failed leaving dev->iommu
>> to NULL and device drivers may still invoke these functions resulting
>> in a crash in iommu vendor driver code. Hence make sure we check that.
>>
>> Also added iommu_ops to the "struct dev_iommu" and set it if the dev
>> is successfully associated with an iommu.
>>
>> Fixes: a3a195929d40 ("iommu: Add APIs for multiple domains per device")
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>> v1 --> v2:
>>   -Added iommu_ops to struct dev_iommu based on the discussion with Robin.
>>   -Rebased against iommu-tree core branch.
> 
> A gentle ping on this...

Is there a convincing justification for maintaining yet another copy of 
the ops pointer rather than simply dereferencing iommu_dev->ops at point 
of use?

Robin.

> Thanks,
> Shameer
> 
>> ---
>>   drivers/iommu/iommu.c | 19 +++++++------------
>>   include/linux/iommu.h |  2 ++
>>   2 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index fd76e2f579fe..6023d0b7c542 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -217,6 +217,7 @@ static int __iommu_probe_device(struct device *dev,
>> struct list_head *group_list
>>   	}
>>
>>   	dev->iommu->iommu_dev = iommu_dev;
>> +	dev->iommu->ops = iommu_dev->ops;
>>
>>   	group = iommu_group_get_for_dev(dev);
>>   	if (IS_ERR(group)) {
>> @@ -2865,10 +2866,8 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>>    */
>>   int iommu_dev_enable_feature(struct device *dev, enum
>> iommu_dev_features feat)
>>   {
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> -
>> -	if (ops && ops->dev_enable_feat)
>> -		return ops->dev_enable_feat(dev, feat);
>> +	if (dev->iommu && dev->iommu->ops->dev_enable_feat)
>> +		return dev->iommu->ops->dev_enable_feat(dev, feat);
>>
>>   	return -ENODEV;
>>   }
>> @@ -2881,10 +2880,8 @@
>> EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
>>    */
>>   int iommu_dev_disable_feature(struct device *dev, enum
>> iommu_dev_features feat)
>>   {
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> -
>> -	if (ops && ops->dev_disable_feat)
>> -		return ops->dev_disable_feat(dev, feat);
>> +	if (dev->iommu && dev->iommu->ops->dev_disable_feat)
>> +		return dev->iommu->ops->dev_disable_feat(dev, feat);
>>
>>   	return -EBUSY;
>>   }
>> @@ -2892,10 +2889,8 @@
>> EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
>>
>>   bool iommu_dev_feature_enabled(struct device *dev, enum
>> iommu_dev_features feat)
>>   {
>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>> -
>> -	if (ops && ops->dev_feat_enabled)
>> -		return ops->dev_feat_enabled(dev, feat);
>> +	if (dev->iommu && dev->iommu->ops->dev_feat_enabled)
>> +		return dev->iommu->ops->dev_feat_enabled(dev, feat);
>>
>>   	return false;
>>   }
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 524ffc2ff64f..ff0c76bdfb67 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -354,6 +354,7 @@ struct iommu_fault_param {
>>    * @fault_param: IOMMU detected device fault reporting data
>>    * @fwspec:	 IOMMU fwspec data
>>    * @iommu_dev:	 IOMMU device this device is linked to
>> + * @ops:	 iommu-ops for talking to the iommu_dev
>>    * @priv:	 IOMMU Driver private data
>>    *
>>    * TODO: migrate other per device data pointers under iommu_dev_data,
>> e.g.
>> @@ -364,6 +365,7 @@ struct dev_iommu {
>>   	struct iommu_fault_param	*fault_param;
>>   	struct iommu_fwspec		*fwspec;
>>   	struct iommu_device		*iommu_dev;
>> +	const struct iommu_ops		*ops;
>>   	void				*priv;
>>   };
>>
>> --
>> 2.17.1
>> _______________________________________________
>> Linuxarm mailing list -- linuxarm@openeuler.org
>> To unsubscribe send an email to linuxarm-leave@openeuler.org
