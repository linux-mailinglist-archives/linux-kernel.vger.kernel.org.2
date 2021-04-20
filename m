Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541DC36534D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDTHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:33:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16142 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhDTHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:33:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPb0y06cXzpZP2;
        Tue, 20 Apr 2021 15:29:38 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 15:32:26 +0800
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
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
 <20210413085457.25400-3-zhukeqian1@huawei.com>
 <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
 <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
 <bc2da48b-f4f7-5a46-2696-2c412a83d190@linux.intel.com>
 <ac966fbc-7bc6-9d88-e53e-bcd92d536fdb@huawei.com>
 <3c34baf1-6a57-5666-38a2-0c9d6188b8b8@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <a09830f8-b08f-9b80-8f75-17f13088ff6d@huawei.com>
Date:   Tue, 20 Apr 2021 15:32:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <3c34baf1-6a57-5666-38a2-0c9d6188b8b8@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

Cheers for the your quick reply.

On 2021/4/20 10:09, Lu Baolu wrote:
> Hi Keqian,
> 
> On 4/20/21 9:25 AM, Keqian Zhu wrote:
>> Hi Baolu,
>>
>> On 2021/4/19 21:33, Lu Baolu wrote:
>>> Hi Keqian,
>>>
>>> On 2021/4/19 17:32, Keqian Zhu wrote:
>>>>>> +EXPORT_SYMBOL_GPL(iommu_split_block);
>>>>> Do you really have any consumers of this interface other than the dirty
>>>>> bit tracking? If not, I don't suggest to make this as a generic IOMMU
>>>>> interface.
>>>>>
>>>>> There is an implicit requirement for such interfaces. The
>>>>> iommu_map/unmap(iova, size) shouldn't be called at the same time.
>>>>> Currently there's no such sanity check in the iommu core. A poorly
>>>>> written driver could mess up the kernel by misusing this interface.
>>>> Yes, I don't think up a scenario except dirty tracking.
>>>>
>>>> Indeed, we'd better not make them as a generic interface.
>>>>
>>>> Do you have any suggestion that underlying iommu drivers can share these code but
>>>> not make it as a generic iommu interface?
>>>>
>>>> I have a not so good idea. Make the "split" interfaces as a static function, and
>>>> transfer the function pointer to start_dirty_log. But it looks weird and inflexible.
>>>
>>> I understand splitting/merging super pages is an optimization, but not a
>>> functional requirement. So is it possible to let the vendor iommu driver
>>> decide whether splitting super pages when starting dirty bit tracking
>>> and the opposite operation during when stopping it? The requirement for
>> Right. If I understand you correct, actually that is what this series does.
> 
> I mean to say no generic APIs, jut do it by the iommu subsystem itself.
> It's totally transparent to the upper level, just like what map() does.
> The upper layer doesn't care about either super page or small page is
> in use when do a mapping, right?
> 
> If you want to consolidate some code, how about putting them in
> start/stop_tracking()?

Yep, this reminds me. What we want to reuse is the logic of "chunk by chunk" in split().
We can implement switch_dirty_log to be "chunk by chunk" too (just the same as sync/clear),
then the vendor iommu driver can invoke it's own private implementation of split().
So we can completely remove split() in the IOMMU core layer.

example code logic

iommu.c:
switch_dirty_log(big range) {
    for_each_iommu_page(big range) {
          ops->switch_dirty_log(iommu_pgsize)
    }
}

vendor iommu driver:
switch_dirty_log(iommu_pgsize) {

    if (enable) {
        ops->split_block(iommu_pgsize)
        /* And other actions, such as enable hardware capability */
    } else {
        for_each_continuous_physical_address(iommu_pgsize)
            ops->merge_page()
    }
}

Besides, vendor iommu driver can invoke split() in clear_dirty_log instead of in switch_dirty_log.
The benefit is that we usually clear dirty log gradually during dirty tracking, then we can split
large page mapping gradually, which speedup start_dirty_log and make less side effect on DMA performance.

Does it looks good for you?

Thanks,
Keqian
