Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411F43EA305
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhHLKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:38:39 -0400
Received: from foss.arm.com ([217.140.110.172]:41732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235428AbhHLKig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3761042;
        Thu, 12 Aug 2021 03:38:09 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828633F718;
        Thu, 12 Aug 2021 03:38:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
To:     David Stevens <stevensd@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-3-stevensd@google.com>
 <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
 <CAD=HUj7RLtRkKwRHOAeuJXiiLp9WujOysYAoU0s2Nx5qR1_B7g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f13552b1-b582-8134-a87d-c3fca494a86d@arm.com>
Date:   Thu, 12 Aug 2021 11:38:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7RLtRkKwRHOAeuJXiiLp9WujOysYAoU0s2Nx5qR1_B7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-12 10:21, David Stevens wrote:
> On Thu, Aug 12, 2021 at 3:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-11 03:42, David Stevens wrote:
>>> From: David Stevens <stevensd@chromium.org>
>>>
>>> When calling arch_sync_dma, we need to pass it the memory that's
>>> actually being used for dma. When using swiotlb bounce buffers, this is
>>> the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
>>> helper, so it can use the bounce buffer address if necessary. This also
>>> means it is no longer necessary to call iommu_dma_sync_sg_for_device in
>>> iommu_dma_map_sg for untrusted devices.
>>>
>>> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
>>> Signed-off-by: David Stevens <stevensd@chromium.org>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 16 +++++++---------
>>>    1 file changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 54e103b989d9..4f0cc4a0a61f 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>>                memset(padding_start, 0, padding_size);
>>>        }
>>>
>>> +     if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>>
>> Make that an "else if" - otherwise you're just reintroducing the same
>> thing that the third hunk is trying to clean up.
> 
> swiotlb_tbl_map_single only copies into the swiotlb buffer, it doesn't
> do any architectural syncing. So this block is necessary in the
> swiotlb case as well, for iommu_dma_map_page to work properly.

Urgh, apologies again - I had a mental short-circuit and was convinced 
that the SWIOTLB call already did its own cache maintenance. I really 
should have learned by now not to review fiddly patches like these while 
tired...
> The third chunk is a separate optimization, so I'll split it out into
> its own patch.

It's still a logical part of this change - cleaning up the potentially 
wrong sync while you make sure the right one happens. Even more so if 
you make the fix the better way by having iommu_dma_map_sg_swiotlb() 
call iommu_dma_map_page().

Robin.
