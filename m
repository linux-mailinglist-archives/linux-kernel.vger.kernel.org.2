Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C33653B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhDTIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:04:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:14466 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhDTIEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:04:00 -0400
IronPort-SDR: UEZpNDsqzVzHchKrFGWcQIU7pWP6xyAWAnIk6vFzUjeW9N4/y2ITvvm7xFB8jhajKOIcaHWmPQ
 ujlrufLaHAQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193342073"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="193342073"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 01:03:29 -0700
IronPort-SDR: Z/FXrr1+Q8RHYWYTPCkRgeeVNOB0M1lOdZtfcdF5lOyNzlNN1zJuhw7h+LSq846Ny0wAAABWVv
 KsyxWlidK47A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="426828770"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2021 01:03:24 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-3-zhukeqian1@huawei.com>
 <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
 <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
 <bc2da48b-f4f7-5a46-2696-2c412a83d190@linux.intel.com>
 <ac966fbc-7bc6-9d88-e53e-bcd92d536fdb@huawei.com>
 <3c34baf1-6a57-5666-38a2-0c9d6188b8b8@linux.intel.com>
 <a09830f8-b08f-9b80-8f75-17f13088ff6d@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8a25f78b-9153-d21b-013d-d7f64ab48c54@linux.intel.com>
Date:   Tue, 20 Apr 2021 15:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a09830f8-b08f-9b80-8f75-17f13088ff6d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 3:32 PM, Keqian Zhu wrote:
> Hi Baolu,
> 
> Cheers for the your quick reply.
> 
> On 2021/4/20 10:09, Lu Baolu wrote:
>> Hi Keqian,
>>
>> On 4/20/21 9:25 AM, Keqian Zhu wrote:
>>> Hi Baolu,
>>>
>>> On 2021/4/19 21:33, Lu Baolu wrote:
>>>> Hi Keqian,
>>>>
>>>> On 2021/4/19 17:32, Keqian Zhu wrote:
>>>>>>> +EXPORT_SYMBOL_GPL(iommu_split_block);
>>>>>> Do you really have any consumers of this interface other than the dirty
>>>>>> bit tracking? If not, I don't suggest to make this as a generic IOMMU
>>>>>> interface.
>>>>>>
>>>>>> There is an implicit requirement for such interfaces. The
>>>>>> iommu_map/unmap(iova, size) shouldn't be called at the same time.
>>>>>> Currently there's no such sanity check in the iommu core. A poorly
>>>>>> written driver could mess up the kernel by misusing this interface.
>>>>> Yes, I don't think up a scenario except dirty tracking.
>>>>>
>>>>> Indeed, we'd better not make them as a generic interface.
>>>>>
>>>>> Do you have any suggestion that underlying iommu drivers can share these code but
>>>>> not make it as a generic iommu interface?
>>>>>
>>>>> I have a not so good idea. Make the "split" interfaces as a static function, and
>>>>> transfer the function pointer to start_dirty_log. But it looks weird and inflexible.
>>>>
>>>> I understand splitting/merging super pages is an optimization, but not a
>>>> functional requirement. So is it possible to let the vendor iommu driver
>>>> decide whether splitting super pages when starting dirty bit tracking
>>>> and the opposite operation during when stopping it? The requirement for
>>> Right. If I understand you correct, actually that is what this series does.
>>
>> I mean to say no generic APIs, jut do it by the iommu subsystem itself.
>> It's totally transparent to the upper level, just like what map() does.
>> The upper layer doesn't care about either super page or small page is
>> in use when do a mapping, right?
>>
>> If you want to consolidate some code, how about putting them in
>> start/stop_tracking()?
> 
> Yep, this reminds me. What we want to reuse is the logic of "chunk by chunk" in split().
> We can implement switch_dirty_log to be "chunk by chunk" too (just the same as sync/clear),
> then the vendor iommu driver can invoke it's own private implementation of split().
> So we can completely remove split() in the IOMMU core layer.
> 
> example code logic
> 
> iommu.c:
> switch_dirty_log(big range) {
>      for_each_iommu_page(big range) {
>            ops->switch_dirty_log(iommu_pgsize)
>      }
> }
> 
> vendor iommu driver:
> switch_dirty_log(iommu_pgsize) {
> 
>      if (enable) {
>          ops->split_block(iommu_pgsize)
>          /* And other actions, such as enable hardware capability */
>      } else {
>          for_each_continuous_physical_address(iommu_pgsize)
>              ops->merge_page()
>      }
> }
> 
> Besides, vendor iommu driver can invoke split() in clear_dirty_log instead of in switch_dirty_log.
> The benefit is that we usually clear dirty log gradually during dirty tracking, then we can split
> large page mapping gradually, which speedup start_dirty_log and make less side effect on DMA performance.
> 
> Does it looks good for you?

Yes. It's clearer now.

> 
> Thanks,
> Keqian
> 

Best regards,
baolu
