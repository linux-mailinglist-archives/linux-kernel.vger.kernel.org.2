Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675113D923F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhG1Pjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:39:32 -0400
Received: from foss.arm.com ([217.140.110.172]:58924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhG1Pjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:39:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937221FB;
        Wed, 28 Jul 2021 08:39:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750F13F70D;
        Wed, 28 Jul 2021 08:39:28 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com> <YQF1AKS6Y14dLU/A@T590>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e1ec45e5-8e8b-7295-4a95-af6fe92573ee@arm.com>
Date:   Wed, 28 Jul 2021 16:39:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQF1AKS6Y14dLU/A@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-28 16:17, Ming Lei wrote:
> On Wed, Jul 28, 2021 at 11:38:18AM +0100, John Garry wrote:
>> On 28/07/2021 02:32, Ming Lei wrote:
>>> On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
>>>> On 23/07/2021 11:21, Ming Lei wrote:
>>>>>> Thanks, I was also going to suggest the latter, since it's what
>>>>>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>>>>>> indicative of where the slowness most likely stems from.
>>>>> The improvement from 'iommu.strict=0' is very small:
>>>>>
>>>> Have you tried turning off the IOMMU to ensure that this is really just
>>>> an IOMMU problem?
>>>>
>>>> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
>>>> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
>>>> disabling for kernel drivers).
>>> Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
>>> on this issue.
>>
>> A ~90% throughput drop still seems to me to be too high to be a software
>> issue. More so since I don't see similar on my system. And that throughput
>> drop does not lead to a total CPU usage drop, from the fio log.

Indeed, it now sounds like $SUBJECT has been a complete red herring, and 
although the SMMU may be reflecting the underlying slowness it is not in 
fact a significant contributor to it. Presumably perf shows any 
difference in CPU time moving elsewhere once iommu_dma_unmap_sg() is out 
of the picture?

>> Do you know if anyone has run memory benchmark tests on this board to find
>> out NUMA effect? I think lmbench or stream could be used for this.
> 
> https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

Hmm, a ~4x discrepancy in CPU<->memory bandwidth is pretty significant, 
but it's still not the ~10x discrepancy in NVMe throughput. Possibly 
CPU<->PCIe and/or PCIe<->memory bandwidth is even further impacted 
between sockets, or perhaps all the individual latencies just add up - 
that level of detailed performance analysis is beyond my expertise. 
Either way I guess it's probably time to take it up with the system 
vendor to see if there's anything which can be tuned in hardware/firmware.

Robin.
