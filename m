Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056673E13CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbhHELYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:24:54 -0400
Received: from foss.arm.com ([217.140.110.172]:43080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240623AbhHELYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:24:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67151FB;
        Thu,  5 Aug 2021 04:24:39 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A99A63F719;
        Thu,  5 Aug 2021 04:24:38 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To:     John Garry <john.garry@huawei.com>, will@kernel.org
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
Date:   Thu, 5 Aug 2021 12:24:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-21 17:36, John Garry wrote:
> Members of struct "llq" will be zero-inited, apart from member max_n_shift.
> But we write llq.val straight after the init, so it was pointless to zero
> init those other members. As such, separately init member max_n_shift
> only.
> 
> In addition, struct "head" is initialised to "llq" only so that member
> max_n_shift is set. But that member is never referenced for "head", so
> remove any init there.
> 
> Removing these initializations is seen as a small performance optimisation,
> as this code is (very) hot path.

I looked at this and immediately thought "surely the compiler can see 
that all the prod/cons/val fields are written anyway and elide the 
initialisation?", so I dumped the before and after disassembly, and... oh.

You should probably clarify that it's zero-initialising all the 
cacheline padding which is both pointless and painful. With that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

However, having looked this closely I'm now tangentially wondering why 
max_n_shift isn't inside the padded union? It's read at the same time as 
both prod and cons by queue_has_space(), and never updated, so there 
doesn't appear to be any benefit to it being in a separate cacheline all 
by itself, and llq is already twice as big as it needs to be. Sorting 
that would also be a good opportunity to store the value of interest in 
its appropriate form so we're not needlessly recalculating 1 << shift 
every flippin' time...

Robin.

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 54b2f27b81d4..8a8ad49bb7fd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -727,11 +727,11 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	unsigned long flags;
>   	bool owner;
>   	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
> -	struct arm_smmu_ll_queue llq = {
> -		.max_n_shift = cmdq->q.llq.max_n_shift,
> -	}, head = llq;
> +	struct arm_smmu_ll_queue llq, head;
>   	int ret = 0;
>   
> +	llq.max_n_shift = cmdq->q.llq.max_n_shift;
> +
>   	/* 1. Allocate some space in the queue */
>   	local_irq_save(flags);
>   	llq.val = READ_ONCE(cmdq->q.llq.val);
> 
