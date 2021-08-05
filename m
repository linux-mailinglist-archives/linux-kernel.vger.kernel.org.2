Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362973E128A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhHEKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:23:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3594 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbhHEKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:23:02 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgPn36gKWz6F8JB;
        Thu,  5 Aug 2021 18:22:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 12:22:47 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 11:22:46 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bebc7b1b-e60c-d5e6-812a-63580d7029cc@huawei.com>
Date:   Thu, 5 Aug 2021 11:22:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2021 17:36, John Garry wrote:
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
> 

Hi Will,

Any chance you can pick up this small optimisation?

Cheers

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

