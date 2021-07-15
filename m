Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA123C95BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhGOByK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:54:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6821 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhGOByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:54:09 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQHJJ1NH6zXtG7;
        Thu, 15 Jul 2021 09:45:36 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 09:51:14 +0800
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Georgi Djakov <djakov@kernel.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, <will@kernel.org>,
        <robin.murphy@arm.com>
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
 <4d466ea9-2c1a-2e19-af5b-0434441ee7cb@linux.intel.com>
CC:     <isaacm@codeaurora.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <pratikp@codeaurora.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <edfff22f-251d-e07d-fdbc-0eb00c821f15@hisilicon.com>
Date:   Thu, 15 Jul 2021 09:51:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4d466ea9-2c1a-2e19-af5b-0434441ee7cb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/7/15 9:23, Lu Baolu 写道:
> On 7/14/21 10:24 PM, Georgi Djakov wrote:
>> On 16.06.21 16:38, Georgi Djakov wrote:
>>> When unmapping a buffer from an IOMMU domain, the IOMMU framework 
>>> unmaps
>>> the buffer at a granule of the largest page size that is supported by
>>> the IOMMU hardware and fits within the buffer. For every block that
>>> is unmapped, the IOMMU framework will call into the IOMMU driver, and
>>> then the io-pgtable framework to walk the page tables to find the entry
>>> that corresponds to the IOVA, and then unmaps the entry.
>>>
>>> This can be suboptimal in scenarios where a buffer or a piece of a
>>> buffer can be split into several contiguous page blocks of the same 
>>> size.
>>> For example, consider an IOMMU that supports 4 KB page blocks, 2 MB 
>>> page
>>> blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is 
>>> being
>>> unmapped at IOVA 0. The current call-flow will result in 4 indirect 
>>> calls,
>>> and 2 page table walks, to unmap 2 entries that are next to each 
>>> other in
>>> the page-tables, when both entries could have been unmapped in one shot
>>> by clearing both page table entries in the same call.
>>>
>>> The same optimization is applicable to mapping buffers as well, so
>>> these patches implement a set of callbacks called unmap_pages and
>>> map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
>>> an IOVA range that consists of a number of pages of the same
>>> page size that is supported by the IOMMU hardware, and allows for
>>> manipulating multiple page table entries in the same set of indirect
>>> calls. The reason for introducing these callbacks is to give other 
>>> IOMMU
>>> drivers/io-pgtable formats time to change to using the new 
>>> callbacks, so
>>> that the transition to using this approach can be done piecemeal.
>>
>> Hi Will,
>>
>> Did you get a chance to look at this patchset? Most patches are already
>> acked/reviewed and all still applies clean on rc1.
>
> I also have the ops->[un]map_pages implementation for the Intel IOMMU
> driver. I will post them once the iommu/core part get applied.

I also implement those callbacks on ARM SMMUV3 based on this series, and 
use dma_map_benchmark to have a test on
the latency of map/unmap as follows, and i think it promotes much on the 
latency of map/unmap. I will also plan to post
the implementations for ARM SMMUV3 after this series are applied.

t = 1(thread = 1):
                    before opt(us)   after opt(us)
g=1(4K size)        0.1/1.3          0.1/0.8
g=2(8K size)        0.2/1.5          0.2/0.9
g=4(16K size)       0.3/1.9          0.1/1.1
g=8(32K size)       0.5/2.7          0.2/1.4
g=16(64K size)      1.0/4.5          0.2/2.0
g=32(128K size)     1.8/7.9          0.2/3.3
g=64(256K size)     3.7/14.8         0.4/6.1
g=128(512K size)    7.1/14.7         0.5/10.4
g=256(1M size)      14.0/53.9        0.8/19.3
g=512(2M size)      0.2/0.9          0.2/0.9
g=1024(4M size)     0.5/1.5          0.4/1.0

t = 10(thread = 10):
                    before opt(us)   after opt(us)
g=1(4K size)        0.3/7.0          0.1/5.8
g=2(8K size)        0.4/6.7          0.3/6.0
g=4(16K size)       0.5/6.3          0.3/5.6
g=8(32K size)       0.5/8.3          0.2/6.3
g=16(64K size)      1.0/17.3         0.3/12.4
g=32(128K size)     1.8/36.0         0.2/24.2
g=64(256K size)     4.3/67.2         1.2/46.4
g=128(512K size)    7.8/93.7         1.3/94.2
g=256(1M size)      14.7/280.8       1.8/191.5
g=512(2M size)      3.6/3.2          1.5/2.5
g=1024(4M size)     2.0/3.1          1.8/2.6


>
> Best regards,
> baolu
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> .
>


