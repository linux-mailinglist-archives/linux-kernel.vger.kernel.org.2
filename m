Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6F3C22A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGILO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:14:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3376 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhGILO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:14:29 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GLqyn74LDz6J6X3;
        Fri,  9 Jul 2021 19:03:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 13:11:44 +0200
Received: from [10.47.93.40] (10.47.93.40) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Jul 2021
 12:11:43 +0100
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Robin Murphy <robin.murphy@arm.com>,
        Ming Lei <ming.lei@redhat.com>,
        <linux-nvme@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a44e8a68-d789-e3db-4fbb-404defb431f6@huawei.com>
Date:   Fri, 9 Jul 2021 12:04:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.93.40]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2021 11:26, Robin Murphy wrote:
> n 2021-07-09 09:38, Ming Lei wrote:
>> Hello,
>>
>> I observed that NVMe performance is very bad when running fio on one
>> CPU(aarch64) in remote numa node compared with the nvme pci numa node.
>>
>> Please see the test result[1] 327K vs. 34.9K.
>>
>> Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
>> 1111 nsecs vs 25437 nsecs.
> 
> Are you able to dig down further into that? iommu_dma_unmap_sg() itself 
> doesn't do anything particularly special, so whatever makes a difference 
> is probably happening at a lower level, and I suspect there's probably 
> an SMMU involved. If for instance it turns out to go all the way down to 
> __arm_smmu_cmdq_poll_until_consumed() because polling MMIO from the 
> wrong node is slow, there's unlikely to be much you can do about that 
> other than the global "go faster" knobs (iommu.strict and 
> iommu.passthrough) with their associated compromises.

There was also the disable_msipolling option:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#n42

But I am not sure if that platform even supports MSI polling (or has 
smmu v3).

You could also try iommu.forcedac=1 cmdline option. But I doubt it will 
help since the issue was mentioned to be NUMA related.

> 
> Robin.
> 
>> [1] fio test & results
>>
>> 1) fio test result:
>>
>> - run fio on local CPU
>> taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
>> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri 
>> --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 
>> --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 
>> --rw=randread --name=test --group_reporting
>>
>> IOPS: 327K
>> avg latency of iommu_dma_unmap_sg(): 1111 nsecs
>>
>>
>> - run fio on remote CPU
>> taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
>> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri 
>> --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 
>> --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 
>> --rw=randread --name=test --group_reporting
>>
>> IOPS: 34.9K
>> avg latency of iommu_dma_unmap_sg(): 25437 nsecs
>>
>> 2) system info
>> [root@ampere-mtjade-04 ~]# lscpu | grep NUMA
>> NUMA node(s):                    2
>> NUMA node0 CPU(s):               0-79
>> NUMA node1 CPU(s):               80-159
>>
>> lspci | grep NVMe
>> 0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co 
>> Ltd NVMe SSD Controller SM981/PM981/PM983
>>
>> [root@ampere-mtjade-04 ~]# cat /sys/block/nvme1n1/device/device/numa_node 

Since it's ampere, I guess it's smmu v3.

BTW, if you remember, I did raise a performance issue of smmuv3 with 
NVMe before:
https://lore.kernel.org/linux-iommu/b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com/

I did have this series to improve performance for systems with lots of 
CPUs, like above, but not accepted:
https://lore.kernel.org/linux-iommu/1598018062-175608-1-git-send-email-john.garry@huawei.com/

Thanks,
John

