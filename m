Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F53D7BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhG0RIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:08:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhG0RIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:08:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7981FB;
        Tue, 27 Jul 2021 10:08:11 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11BF3F70D;
        Tue, 27 Jul 2021 10:08:10 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com> <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com> <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com> <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com> <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com> <YPqYDY9/VAhfHNfU@T590>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b74d7025-c452-049f-f9a9-75ba555d029d@arm.com>
Date:   Tue, 27 Jul 2021 18:08:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPqYDY9/VAhfHNfU@T590>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-23 11:21, Ming Lei wrote:
> On Thu, Jul 22, 2021 at 06:40:18PM +0100, Robin Murphy wrote:
>> On 2021-07-22 16:54, Ming Lei wrote:
>> [...]
>>>> If you are still keen to investigate more, then can try either of these:
>>>>
>>>> - add iommu.strict=0 to the cmdline
>>>>
>>>> - use perf record+annotate to find the hotspot
>>>>     - For this you need to enable psuedo-NMI with 2x steps:
>>>>       CONFIG_ARM64_PSEUDO_NMI=y in defconfig
>>>>       Add irqchip.gicv3_pseudo_nmi=1
>>>>
>>>>       See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n1745
>>>>       Your kernel log should show:
>>>>       [    0.000000] GICv3: Pseudo-NMIs enabled using forced ICC_PMR_EL1
>>>> synchronisation
>>>
>>> OK, will try the above tomorrow.
>>
>> Thanks, I was also going to suggest the latter, since it's what
>> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
>> indicative of where the slowness most likely stems from.
> 
> The improvement from 'iommu.strict=0' is very small:
> 
> [root@ampere-mtjade-04 ~]# cat /proc/cmdline
> BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.14.0-rc2_linus root=UUID=cff79b49-6661-4347-b366-eb48273fe0c1 ro nvme.poll_queues=2 iommu.strict=0
> 
> [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=1530MiB/s][r=392k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=2999: Fri Jul 23 06:05:15 2021
>    read: IOPS=392k, BW=1530MiB/s (1604MB/s)(14.9GiB/10001msec)
> 
> [root@ampere-mtjade-04 ~]# taskset -c 80 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> fio-3.27
> Starting 1 process
> Jobs: 1 (f=1): [r(1)][100.0%][r=150MiB/s][r=38.4k IOPS][eta 00m:00s]
> test: (groupid=0, jobs=1): err= 0: pid=3063: Fri Jul 23 06:05:49 2021
>    read: IOPS=38.4k, BW=150MiB/s (157MB/s)(3000MiB/20002msec)

OK, that appears to confirm that the invalidation overhead is more of a 
symptom than the major contributing factor, which also seems to line up 
fairly well with the other information.

>> FWIW I would expect iommu.strict=0 to give a proportional reduction in SMMU
>> overhead for both cases since it should effectively mean only 1/256 as many
>> invalidations are issued.
>>
>> Could you also check whether the SMMU platform devices have "numa_node"
>> properties exposed in sysfs (and if so whether the values look right), and
>> share all the SMMU output from the boot log?
> 
> No found numa_node attribute for smmu platform device, and the whole dmesg log is
> attached.

Thanks, so it seems like the SMMUs have MSI capability and are correctly 
described as coherent, which means completion polling should be 
happening in memory and so hopefully not contributing much more than a 
couple of cross-socket cacheline migrations and/or snoops. Combined with 
the difference in the perf traces looking a lot smaller than the 
order-of-magnitude difference in the overall IOPS throughput, I suspect 
this is overall SMMU overhead exacerbated by the missing NUMA info. If 
every new 4K block touched by the NVMe means a TLB miss where the SMMU 
has to walk pagetables from the wrong side of the system, I'm sure 
that's going to add up.

I'd suggest following John's suggestion and getting some baseline 
figures for just the cross-socket overhead between the CPU and NVMe with 
the SMMU right out of the picture, then have a hack at the firmware (or 
pester the system vendor) to see how much of the difference you can make 
back up by having the SMMU proximity domains described correctly such 
that there's minimal likelihood of the SMMUs having to make non-local 
accesses to their in-memory data. FWIW I don't think it should be *too* 
hard to disassemble the IORT, fill in the proximity domain numbers and 
valid flags on the SMMU nodes, then assemble it again to load as an 
override (it's anything involving offsets in that table that's a real pain).

Note that you might also need to make sure you have CMA set up and sized 
appropriately with CONFIG_DMA_PERNUMA_CMA enabled to get the full benefit.

Robin.
