Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB03E15DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhHENky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:40:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3596 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhHENkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:40:53 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgV9H5QV2z6F8WF;
        Thu,  5 Aug 2021 21:40:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 15:40:37 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 14:40:36 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
Date:   Thu, 5 Aug 2021 14:40:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2021 12:24, Robin Murphy wrote:
> On 2021-06-21 17:36, John Garry wrote:
>> Members of struct "llq" will be zero-inited, apart from member 
>> max_n_shift.
>> But we write llq.val straight after the init, so it was pointless to zero
>> init those other members. As such, separately init member max_n_shift
>> only.
>>
>> In addition, struct "head" is initialised to "llq" only so that member
>> max_n_shift is set. But that member is never referenced for "head", so
>> remove any init there.
>>
>> Removing these initializations is seen as a small performance 
>> optimisation,
>> as this code is (very) hot path.
> 
> I looked at this and immediately thought "surely the compiler can see 
> that all the prod/cons/val fields are written anyway and elide the 
> initialisation?", so I dumped the before and after disassembly, and... oh.
> 
> You should probably clarify that it's zero-initialising all the 
> cacheline padding which is both pointless and painful. With that,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> However, having looked this closely I'm now tangentially wondering why 
> max_n_shift isn't inside the padded union? It's read at the same time as 
> both prod and cons by queue_has_space(), and never updated, so there 
> doesn't appear to be any benefit to it being in a separate cacheline all 
> by itself, and llq is already twice as big as it needs to be.

I think that the problem is if the prod+cons 64b value and the shift are 
on the same cacheline, then we have a chance of accessing a stale 
cacheline twice:

static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
				       u64 *cmds, int n, bool sync)
{
	u64 cmd_sync[CMDQ_ENT_DWORDS];
	u32 prod;
	unsigned long flags;
	bool owner;
	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
	struct arm_smmu_ll_queue llq = {
		.max_n_shift = cmdq->q.llq.max_n_shift,	// here
	}, head = llq;
	int ret = 0;

	/* 1. Allocate some space in the queue */
	local_irq_save(flags);
	llq.val = READ_ONCE(cmdq->q.llq.val);	// and again here


since cmdq->q.llq is per-SMMU. If max_n_shift is on a separate 
cacheline, then it should never be stale.

I suppose they could be combined into a smaller sub-struct and loaded in 
a single operation, but it looks messy, and prob without much gain.

Thanks,
John

> Sorting 
> that would also be a good opportunity to store the value of interest in 
> its appropriate form so we're not needlessly recalculating 1 << shift 
> every flippin' time...
> 
> Robin.
> 
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 54b2f27b81d4..8a8ad49bb7fd 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -727,11 +727,11 @@ static int arm_smmu_cmdq_issue_cmdlist(struct 
>> arm_smmu_device *smmu,
>>       unsigned long flags;
>>       bool owner;
>>       struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
>> -    struct arm_smmu_ll_queue llq = {
>> -        .max_n_shift = cmdq->q.llq.max_n_shift,
>> -    }, head = llq;
>> +    struct arm_smmu_ll_queue llq, head;
>>       int ret = 0;
>> +    llq.max_n_shift = cmdq->q.llq.max_n_shift;
>> +
>>       /* 1. Allocate some space in the queue */
>>       local_irq_save(flags);
>>       llq.val = READ_ONCE(cmdq->q.llq.val);
>>
> .

