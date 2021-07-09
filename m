Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78003C2236
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGIK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:29:44 -0400
Received: from foss.arm.com ([217.140.110.172]:49652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbhGIK3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:29:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53F5ED1;
        Fri,  9 Jul 2021 03:26:59 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37B33F5A1;
        Fri,  9 Jul 2021 03:26:58 -0700 (PDT)
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <YOgK8fdv7dOQtkET@T590>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
Date:   Fri, 9 Jul 2021 11:26:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOgK8fdv7dOQtkET@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-09 09:38, Ming Lei wrote:
> Hello,
> 
> I observed that NVMe performance is very bad when running fio on one
> CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> 
> Please see the test result[1] 327K vs. 34.9K.
> 
> Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
> 1111 nsecs vs 25437 nsecs.

Are you able to dig down further into that? iommu_dma_unmap_sg() itself 
doesn't do anything particularly special, so whatever makes a difference 
is probably happening at a lower level, and I suspect there's probably 
an SMMU involved. If for instance it turns out to go all the way down to 
__arm_smmu_cmdq_poll_until_consumed() because polling MMIO from the 
wrong node is slow, there's unlikely to be much you can do about that 
other than the global "go faster" knobs (iommu.strict and 
iommu.passthrough) with their associated compromises.

Robin.

> [1] fio test & results
> 
> 1) fio test result:
> 
> - run fio on local CPU
> taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> IOPS: 327K
> avg latency of iommu_dma_unmap_sg(): 1111 nsecs
> 
> 
> - run fio on remote CPU
> taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> 
> IOPS: 34.9K
> avg latency of iommu_dma_unmap_sg(): 25437 nsecs
> 
> 2) system info
> [root@ampere-mtjade-04 ~]# lscpu | grep NUMA
> NUMA node(s):                    2
> NUMA node0 CPU(s):               0-79
> NUMA node1 CPU(s):               80-159
> 
> lspci | grep NVMe
> 0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 
> [root@ampere-mtjade-04 ~]# cat /sys/block/nvme1n1/device/device/numa_node
> 0
> 
> 
> 
> Thanks,
> Ming
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
