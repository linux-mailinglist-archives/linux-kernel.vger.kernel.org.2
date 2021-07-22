Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA153D2B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGVQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:59:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhGVQ7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:59:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42693106F;
        Thu, 22 Jul 2021 10:40:24 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120373F694;
        Thu, 22 Jul 2021 10:40:22 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com> <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
Date:   Thu, 22 Jul 2021 18:40:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPmUoBk9u+tU2rbS@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-22 16:54, Ming Lei wrote:
[...]
>> If you are still keen to investigate more, then can try either of these:
>>
>> - add iommu.strict=0 to the cmdline
>>
>> - use perf record+annotate to find the hotspot
>>    - For this you need to enable psuedo-NMI with 2x steps:
>>      CONFIG_ARM64_PSEUDO_NMI=y in defconfig
>>      Add irqchip.gicv3_pseudo_nmi=1
>>
>>      See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n1745
>>      Your kernel log should show:
>>      [    0.000000] GICv3: Pseudo-NMIs enabled using forced ICC_PMR_EL1
>> synchronisation
> 
> OK, will try the above tomorrow.

Thanks, I was also going to suggest the latter, since it's what 
arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most 
indicative of where the slowness most likely stems from.

FWIW I would expect iommu.strict=0 to give a proportional reduction in 
SMMU overhead for both cases since it should effectively mean only 1/256 
as many invalidations are issued.

Could you also check whether the SMMU platform devices have "numa_node" 
properties exposed in sysfs (and if so whether the values look right), 
and share all the SMMU output from the boot log?

I still suspect that the most significant bottleneck is likely to be 
MMIO access across chips, incurring the CML/CCIX latency twice for every 
single read, but it's also possible that the performance of the SMMU 
itself could be reduced if its NUMA affinity is not described and we end 
up allocating stuff like pagetables on the wrong node as well.

>> But my impression is that this may be a HW implementation issue, considering
>> we don't see such a huge drop off on our HW.
> 
> Except for mpere-mtjade, we saw bad nvme performance on ThunderX2® CN99XX too,
> but I don't get one CN99XX system to check if the issue is same with
> this one.

I know Cavium's SMMU implementation didn't support MSIs, so that case 
would quite possibly lean towards the MMIO polling angle as well (albeit 
with a very different interconnect).

Robin.
