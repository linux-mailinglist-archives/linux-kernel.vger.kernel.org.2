Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3633B1489
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFWHZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:25:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:1857 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWHZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:25:23 -0400
IronPort-SDR: YxqLphSPVDa1R8kxD3TcslnVxLgR3GQzN/4lsiGPQOOSZ4hjUQqWAEUDmwV3RLIsWdFSzSFrso
 KskzXLoT/fAA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194350349"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="194350349"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 00:23:04 -0700
IronPort-SDR: 5p2hsF6F1g10FIA+84l+UYLpV4WLkIZZYHvLdM3kKNv95RLieT9SKgJaHWsSwrvraxNXUaRyTV
 4yFCcsE/s7Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="490587560"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2021 00:23:00 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
 <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
 <cff9f6ef-0f51-797d-0853-5237f5c10555@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3f8b003a-98bd-df7b-eacc-50c04e0177b1@linux.intel.com>
Date:   Wed, 23 Jun 2021 15:21:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cff9f6ef-0f51-797d-0853-5237f5c10555@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 6:25 AM, Robin Murphy wrote:
> On 2021-06-21 15:32, Lu Baolu wrote:
>> Hi Robin,
>>
>> On 2021/6/21 19:59, Robin Murphy wrote:
>>> On 2021-06-21 11:34, John Garry wrote:
>>>> On 21/06/2021 11:00, Lu Baolu wrote:
>>>>>> void iommu_set_dma_strict(bool force)
>>>>>> {
>>>>>>           if (force == true)
>>>>>>          iommu_dma_strict = true;
>>>>>>      else if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>>>>>          iommu_dma_strict = true;
>>>>>> }
>>>>>>
>>>>>> So we would use iommu_set_dma_strict(true) for a) and b), but 
>>>>>> iommu_set_dma_strict(false) for c).
>>>>>
>>>>> Yes. We need to distinguish the "must" and "nice-to-have" cases of
>>>>> setting strict mode.
>>>>>
>>>>>>
>>>>>> Then I am not sure what you want to do with the accompanying print 
>>>>>> for c). It was:
>>>>>> "IOMMU batching is disabled due to virtualization"
>>>>>>
>>>>>> And now is from this series:
>>>>>> "IOMMU batching disallowed due to virtualization"
>>>>>>
>>>>>> Using iommu_get_dma_strict(domain) is not appropriate here to know 
>>>>>> the current mode (so we know whether to print).
>>>>>>
>>>>>> Note that this change would mean that the current series would 
>>>>>> require non-trivial rework, which would be unfortunate so late in 
>>>>>> the cycle.
>>>>>
>>>>> This patch series looks good to me and I have added by reviewed-by.
>>>>> Probably we could make another patch series to improve it so that the
>>>>> kernel optimization should not override the user setting.
>>>>
>>>> On a personal level I would be happy with that approach, but I think 
>>>> it's better to not start changing things right away in a follow-up 
>>>> series.
>>>>
>>>> So how about we add this patch (which replaces 6/6 "iommu: Remove 
>>>> mode argument from iommu_set_dma_strict()")?
>>>>
>>>> Robin, any opinion?
>>>
>>> For me it boils down to whether there are any realistic workloads 
>>> where non-strict mode *would* still perform better under 
>>> virtualisation. The 
>>
>> At present, we see that strict mode has better performance in the
>> virtualization environment because it will make the shadow page table
>> management more efficient. When the hardware supports nested
>> translation, we may have to re-evaluate this since there's no need for
>> a shadowing page table anymore.
> 
> I guess I was assuming that in most cases, proper nested mode could look 
> distinct enough that we'd be able to treat it differently in the first 
> place. For instance, if it's handing guest tables directly to the 
> hardware, would the host have any reason to still set the "caching mode" 
> ID bit?

For Intel VT-d, yes, simply for compatible purpose. The guest kernel
may use page tables that are not compatible with the first level
translation. In this case, we must roll back to shadow page table.

> 
> Robin.

Best regards,
baolu
