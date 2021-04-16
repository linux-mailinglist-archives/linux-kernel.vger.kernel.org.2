Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C6361CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbhDPJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:08:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16469 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhDPJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:08:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FM9K82181zwRnd;
        Fri, 16 Apr 2021 17:05:16 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 16 Apr 2021 17:07:28 +0800
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-2-zhukeqian1@huawei.com>
 <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
 <e42373e3-10d5-5a34-8f33-8bb82d64fb19@huawei.com>
 <56b001fa-b4fe-c595-dc5e-f362d2f07a19@linux.intel.com>
 <88cba608-2f22-eb83-f22e-50cb547b6ee8@huawei.com>
 <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <64c87f67-3687-61bd-1587-724cc2f9cc97@huawei.com>
Date:   Fri, 16 Apr 2021 17:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 2021/4/15 18:21, Lu Baolu wrote:
> Hi,
> 
> On 2021/4/15 15:43, Keqian Zhu wrote:
>>>> design it as not switchable. I will modify the commit message of patch#12, thanks!
>>> I am not sure that I fully get your point. But I can't see any gaps of
>>> using iommu_dev_enable/disable_feature() to switch dirty log on and off.
>>> Probably I missed anything.
>> IOMMU_DEV_FEAT_HWDBM just tells user whether underlying IOMMU driver supports
>> dirty tracking, it is not used to management the status of dirty log tracking.
>>
>> The feature reporting is per device, but the status management is per iommu_domain.
>> Only when all devices in a domain support HWDBM, we can start dirty log for the domain.
> 
> So why not
> 
>     for_each_device_attached_domain()
>         iommu_dev_enable_feature(IOMMU_DEV_FEAT_HWDBM)
Looks reasonable, but the problem is that we just need to enable dirty log once per domain.

> 
> ?
>>
>> And I think we'd better not mix the feature reporting and status management. Thoughts?
>>
> 
> I am worrying about having two sets of APIs for single purpose. From
> vendor iommu driver's point of view, this feature is per device. Hence,
> it still needs to do the same thing.
Yes, we can unify the granule of feature reporting and status management.

The basic granule of dirty tracking is iommu_domain, I think it's very reasonable. We need an
interface to report the feature of iommu_domain, then the logic is much more clear.

Every time we add new device or remove device from the domain, we should update the feature (e.g.,
maintain a counter of unsupported devices).

What do you think about this idea?

Thanks,
Keqian
