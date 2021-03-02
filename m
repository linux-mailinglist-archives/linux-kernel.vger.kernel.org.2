Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80E32A62B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578298AbhCBOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:09:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2617 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443708AbhCBMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:33:32 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DqbtX75nlz67rNr;
        Tue,  2 Mar 2021 20:25:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 13:32:47 +0100
Received: from [10.47.2.166] (10.47.2.166) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Mar 2021
 12:32:45 +0000
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
From:   John Garry <john.garry@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
 <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
 <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
 <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
Message-ID: <0cb64d74-0ec1-2284-f67a-b1619a3eb138@huawei.com>
Date:   Tue, 2 Mar 2021 12:30:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.166]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2021 15:48, John Garry wrote:
>>
>> While max32_alloc_size indirectly tracks the largest*contiguous* 
>> available space, one of the ideas from which it grew was to simply keep
>> count of the total number of free PFNs. If you're really spending
>> significant time determining that the tree is full, as opposed to just
>> taking longer to eventually succeed, then it might be relatively
>> innocuous to tack on that semi-redundant extra accounting as a
>> self-contained quick fix for that worst case.
>>
>>> Anyway, we see ~50% throughput regression, which is intolerable. As seen
>>> in [0], I put this down to the fact that we have so many IOVA requests
>>> which exceed the rcache size limit, which means many RB tree accesses
>>> for non-cacheble IOVAs, which are now slower.
> 
> I will attempt to prove this by increasing RCACHE RANGE, such that all 
> IOVA sizes may be cached.

About this one, as expected, we restore performance by increasing the 
RCACHE RANGE.

Some figures:
Baseline v5.12-rc1

strict mode:
600K IOPs

Revert "iommu/iova: Retry from last rb tree node if iova search fails":
1215K

Increase IOVA RCACHE range 6 -> 10 (All IOVAs size requests now 
cacheable for this experiment):
1400K

Reduce LLDD max SGE count 124 -> 16:
1288K

non-strict mode
1650K

So ideally we can work towards something for which IOVAs of all size 
could be cached.

Cheers,
John
