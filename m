Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6332510B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhBYN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:56:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2606 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBYN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:56:51 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DmYzH6zGtz67rV8;
        Thu, 25 Feb 2021 21:48:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 14:56:05 +0100
Received: from [10.47.1.158] (10.47.1.158) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 25 Feb
 2021 13:56:04 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To:     Robin Murphy <robin.murphy@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
Message-ID: <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
Date:   Thu, 25 Feb 2021 13:54:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.1.158]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2021 12:03, Robin Murphy wrote:
> On 2021-01-29 09:48, Leizhen (ThunderTown) wrote:
>>
>> Currently, we are thinking about the solution to the problem. However, 
>> because the end time of v5.11 is approaching, this patch is sent first.
> 
> However, that commit was made for a reason - how do we justify that one 
> thing being slow is more important than another thing being completely 
> broken? It's not practical to just keep doing the patch hokey-cokey 
> based on whoever shouts loudest :(
> 
>> On 2021/1/29 17:21, Zhen Lei wrote:
>>> This reverts commit 4e89dce725213d3d0b0475211b500eda4ef4bf2f.
>>>
>>> We find that this patch has a great impact on performance. According to
>>> our test: the iops decreases from 1655.6K to 893.5K, about half.
>>>
>>> Hardware: 1 SAS expander with 12 SAS SSD
>>> Command:  Only the main parameters are listed.
>>>            fio bs=4k rw=read iodepth=128 cpus_allowed=0-127
> 
> FWIW, I'm 99% sure that what you really want is [1], but then you get to 
> battle against an unknown quantity of dodgy firmware instead.
>

Something which has not been said before is that this only happens for 
strict mode.

Anyway, we see ~50% throughput regression, which is intolerable. As seen 
in [0], I put this down to the fact that we have so many IOVA requests 
which exceed the rcache size limit, which means many RB tree accesses 
for non-cacheble IOVAs, which are now slower.

On another point, as for longterm IOVA aging issue, it seems that there 
is no conclusion there. However I did mention the issue of IOVA sizes 
exceeding rcache size for that issue, so maybe we can find a common 
solution. Similar to a fixed rcache depot size, it seems that having a 
fixed rcache max size range value (at 6) doesn't scale either.

As for 4e89dce72521, so even if it's proper to retry for a failed alloc, 
it is not always necessary. I mean, if we're limiting ourselves to 32b 
subspace for this SAC trick and we fail the alloc, then we can try the 
space above 32b first (if usable). If that fails, then retry there. I 
don't see a need to retry the 32b subspace if we're not limited to it. 
How about it? We tried that idea and it looks to just about restore 
performance.

Thanks,
John

[0] 
https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
