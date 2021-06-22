Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10993B100A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhFVW1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:27:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:27:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB477ED1;
        Tue, 22 Jun 2021 15:25:21 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08D383F694;
        Tue, 22 Jun 2021 15:25:19 -0700 (PDT)
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com, linux-doc@vger.kernel.org
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
 <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cff9f6ef-0f51-797d-0853-5237f5c10555@arm.com>
Date:   Tue, 22 Jun 2021 23:25:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-21 15:32, Lu Baolu wrote:
> Hi Robin,
> 
> On 2021/6/21 19:59, Robin Murphy wrote:
>> On 2021-06-21 11:34, John Garry wrote:
>>> On 21/06/2021 11:00, Lu Baolu wrote:
>>>>> void iommu_set_dma_strict(bool force)
>>>>> {
>>>>>           if (force == true)
>>>>>          iommu_dma_strict = true;
>>>>>      else if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
>>>>>          iommu_dma_strict = true;
>>>>> }
>>>>>
>>>>> So we would use iommu_set_dma_strict(true) for a) and b), but 
>>>>> iommu_set_dma_strict(false) for c).
>>>>
>>>> Yes. We need to distinguish the "must" and "nice-to-have" cases of
>>>> setting strict mode.
>>>>
>>>>>
>>>>> Then I am not sure what you want to do with the accompanying print 
>>>>> for c). It was:
>>>>> "IOMMU batching is disabled due to virtualization"
>>>>>
>>>>> And now is from this series:
>>>>> "IOMMU batching disallowed due to virtualization"
>>>>>
>>>>> Using iommu_get_dma_strict(domain) is not appropriate here to know 
>>>>> the current mode (so we know whether to print).
>>>>>
>>>>> Note that this change would mean that the current series would 
>>>>> require non-trivial rework, which would be unfortunate so late in 
>>>>> the cycle.
>>>>
>>>> This patch series looks good to me and I have added by reviewed-by.
>>>> Probably we could make another patch series to improve it so that the
>>>> kernel optimization should not override the user setting.
>>>
>>> On a personal level I would be happy with that approach, but I think 
>>> it's better to not start changing things right away in a follow-up 
>>> series.
>>>
>>> So how about we add this patch (which replaces 6/6 "iommu: Remove 
>>> mode argument from iommu_set_dma_strict()")?
>>>
>>> Robin, any opinion?
>>
>> For me it boils down to whether there are any realistic workloads 
>> where non-strict mode *would* still perform better under 
>> virtualisation. The 
> 
> At present, we see that strict mode has better performance in the
> virtualization environment because it will make the shadow page table
> management more efficient. When the hardware supports nested
> translation, we may have to re-evaluate this since there's no need for
> a shadowing page table anymore.

I guess I was assuming that in most cases, proper nested mode could look 
distinct enough that we'd be able to treat it differently in the first 
place. For instance, if it's handing guest tables directly to the 
hardware, would the host have any reason to still set the "caching mode" 
ID bit?

Robin.
