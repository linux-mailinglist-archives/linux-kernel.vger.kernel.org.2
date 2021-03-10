Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5663345BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhCJRwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:52:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2677 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhCJRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:52:39 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dwfdq1XQyz67wf3;
        Thu, 11 Mar 2021 01:46:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 18:52:37 +0100
Received: from [10.47.10.208] (10.47.10.208) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 17:52:36 +0000
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
From:   John Garry <john.garry@huawei.com>
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
 <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
 <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
 <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
 <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
 <c58abbec-7220-b440-98d4-d1026a8feed4@huawei.com>
Message-ID: <8b526177-758e-eee4-74ee-6aa855072e70@huawei.com>
Date:   Wed, 10 Mar 2021 17:50:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c58abbec-7220-b440-98d4-d1026a8feed4@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.208]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 16:22, John Garry wrote:
> 
>>
>>>> While max32_alloc_size indirectly tracks the largest*contiguous* 
>>>> available space, one of the ideas from which it grew was to simply keep
>>>> count of the total number of free PFNs. If you're really spending
>>>> significant time determining that the tree is full, as opposed to just
>>>> taking longer to eventually succeed, then it might be relatively
>>>> innocuous to tack on that semi-redundant extra accounting as a
>>>> self-contained quick fix for that worst case.
>>>>
> 
> ...

So since the retry means that we search through the complete pfn range 
most of the time (due to poor success rate quoted), we should be able to 
do a better job at maintaining an accurate max alloc size, by 
calculating it during the failed search, and not relying on max alloc 
failed or resetting it frequently. Hopefully that would mean that we're 
smarter about quickly failing the allocation.

I'll further look at that.

Thanks,
John
