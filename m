Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1363E171E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhHEOmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:42:21 -0400
Received: from foss.arm.com ([217.140.110.172]:47416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhHEOmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:42:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C9A531B;
        Thu,  5 Aug 2021 07:42:04 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A733F66F;
        Thu,  5 Aug 2021 07:42:03 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To:     John Garry <john.garry@huawei.com>, will@kernel.org
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
 <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
Date:   Thu, 5 Aug 2021 15:41:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 14:40, John Garry wrote:
> On 05/08/2021 12:24, Robin Murphy wrote:
>> On 2021-06-21 17:36, John Garry wrote:
>>> Members of struct "llq" will be zero-inited, apart from member 
>>> max_n_shift.
>>> But we write llq.val straight after the init, so it was pointless to 
>>> zero
>>> init those other members. As such, separately init member max_n_shift
>>> only.
>>>
>>> In addition, struct "head" is initialised to "llq" only so that member
>>> max_n_shift is set. But that member is never referenced for "head", so
>>> remove any init there.
>>>
>>> Removing these initializations is seen as a small performance 
>>> optimisation,
>>> as this code is (very) hot path.
>>
>> I looked at this and immediately thought "surely the compiler can see 
>> that all the prod/cons/val fields are written anyway and elide the 
>> initialisation?", so I dumped the before and after disassembly, and... 
>> oh.
>>
>> You should probably clarify that it's zero-initialising all the 
>> cacheline padding which is both pointless and painful. With that,
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> However, having looked this closely I'm now tangentially wondering why 
>> max_n_shift isn't inside the padded union? It's read at the same time 
>> as both prod and cons by queue_has_space(), and never updated, so 
>> there doesn't appear to be any benefit to it being in a separate 
>> cacheline all by itself, and llq is already twice as big as it needs 
>> to be.
> 
> I think that the problem is if the prod+cons 64b value and the shift are 
> on the same cacheline, then we have a chance of accessing a stale 
> cacheline twice:
> 
> static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>                         u64 *cmds, int n, bool sync)
> {
>      u64 cmd_sync[CMDQ_ENT_DWORDS];
>      u32 prod;
>      unsigned long flags;
>      bool owner;
>      struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
>      struct arm_smmu_ll_queue llq = {
>          .max_n_shift = cmdq->q.llq.max_n_shift,    // here
>      }, head = llq;
>      int ret = 0;
> 
>      /* 1. Allocate some space in the queue */
>      local_irq_save(flags);
>      llq.val = READ_ONCE(cmdq->q.llq.val);    // and again here
> 
> 
> since cmdq->q.llq is per-SMMU. If max_n_shift is on a separate 
> cacheline, then it should never be stale.

Ah, right, even though the accesses are always going to be close 
together, I suppose it could still technically cause some false sharing 
if someone else is trying to update prod at exactly the right time. I 
guess that might be why we need the explicit padding there in the first 
place, it's just a shame that it ends up wasting even more space with 
implicit padding at the end too (and I have a vague memory that trying 
to force member alignment and structure packing at the same time doesn't 
work well). Oh well.

> I suppose they could be combined into a smaller sub-struct and loaded in 
> a single operation, but it looks messy, and prob without much gain.

Indeed I wouldn't say that saving memory is the primary concern here, 
and any more convoluted code is hardly going to help performance. Plus 
it still wouldn't help the other cases where we're just copying the size 
into a fake queue to do some prod arithmetic - I hadn't fully clocked 
what was going on there when I skimmed through things earlier.

Disregarding the bogus layout change, though, do you reckon the rest of 
my idea makes sense?

Cheers,
Robin.
