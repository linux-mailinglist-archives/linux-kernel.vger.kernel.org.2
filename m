Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742C3C2373
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGIMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:37:03 -0400
Received: from foss.arm.com ([217.140.110.172]:51796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhGIMhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:37:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AF14ED1;
        Fri,  9 Jul 2021 05:34:19 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E83543F5A1;
        Fri,  9 Jul 2021 05:34:17 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1789d6b2-8332-0f26-2c5e-40181d09ebd6@arm.com>
Date:   Fri, 9 Jul 2021 13:34:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-09 12:04, John Garry wrote:
> On 09/07/2021 11:26, Robin Murphy wrote:
>> n 2021-07-09 09:38, Ming Lei wrote:
>>> Hello,
>>>
>>> I observed that NVMe performance is very bad when running fio on one
>>> CPU(aarch64) in remote numa node compared with the nvme pci numa node.
>>>
>>> Please see the test result[1] 327K vs. 34.9K.
>>>
>>> Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
>>> 1111 nsecs vs 25437 nsecs.
>>
>> Are you able to dig down further into that? iommu_dma_unmap_sg() 
>> itself doesn't do anything particularly special, so whatever makes a 
>> difference is probably happening at a lower level, and I suspect 
>> there's probably an SMMU involved. If for instance it turns out to go 
>> all the way down to __arm_smmu_cmdq_poll_until_consumed() because 
>> polling MMIO from the wrong node is slow, there's unlikely to be much 
>> you can do about that other than the global "go faster" knobs 
>> (iommu.strict and iommu.passthrough) with their associated compromises.
> 
> There was also the disable_msipolling option:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#n42 
> 
> 
> But I am not sure if that platform even supports MSI polling (or has 
> smmu v3).

Hmm, I suppose in principle the MSI polling path could lead to a bit of 
cacheline ping-pong with the SMMU fetching and writing back to the sync 
command, but I'd rather find out more details of where exactly the extra 
time is being spent in this particular situation than speculate much 
further.

> You could also try iommu.forcedac=1 cmdline option. But I doubt it will 
> help since the issue was mentioned to be NUMA related.

Plus that shouldn't make any difference to unmaps anyway.

>>> [1] fio test & results
>>>
>>> 1) fio test result:
>>>
>>> - run fio on local CPU
>>> taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
>>> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri 
>>> --iodepth=64 --iodepth_batch_submit=16 
>>> --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 
>>> --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
>>>
>>> IOPS: 327K
>>> avg latency of iommu_dma_unmap_sg(): 1111 nsecs
>>>
>>>
>>> - run fio on remote CPU
>>> taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
>>> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri 
>>> --iodepth=64 --iodepth_batch_submit=16 
>>> --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 
>>> --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
>>>
>>> IOPS: 34.9K
>>> avg latency of iommu_dma_unmap_sg(): 25437 nsecs
>>>
>>> 2) system info
>>> [root@ampere-mtjade-04 ~]# lscpu | grep NUMA
>>> NUMA node(s):                    2
>>> NUMA node0 CPU(s):               0-79
>>> NUMA node1 CPU(s):               80-159
>>>
>>> lspci | grep NVMe
>>> 0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co 
>>> Ltd NVMe SSD Controller SM981/PM981/PM983
>>>
>>> [root@ampere-mtjade-04 ~]# cat 
>>> /sys/block/nvme1n1/device/device/numa_node 
> 
> Since it's ampere, I guess it's smmu v3.
> 
> BTW, if you remember, I did raise a performance issue of smmuv3 with 
> NVMe before:
> https://lore.kernel.org/linux-iommu/b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com/ 

It doesn't seem like the best-case throughput is of concern in this case 
though, and my hunch is that a ~23x discrepancy in SMMU unmap 
performance depending on locality probably isn't specific to NVMe.

Robin.

> I did have this series to improve performance for systems with lots of 
> CPUs, like above, but not accepted:
> https://lore.kernel.org/linux-iommu/1598018062-175608-1-git-send-email-john.garry@huawei.com/ 
> 
> 
> Thanks,
> John
> 
