Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535934033A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhIHFIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:08:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15250 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhIHFIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:08:12 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H498H3zbjz1DGQQ;
        Wed,  8 Sep 2021 13:06:07 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 13:06:58 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 8 Sep 2021 13:06:58 +0800
Subject: Re: [question] Assign multiple devices from different SMMUs to a
 arm_smmu_domain
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Linux IOMMU" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
        "Keqian Zhu" <zhukeqian1@huawei.com>
References: <bbfcb875-0da1-c303-ed48-fdaa890c89b3@huawei.com>
 <202f32cd-8036-563e-028b-781b999766be@arm.com>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <d788d448-f2f2-1cb5-440c-d59dbdd27eab@huawei.com>
Date:   Wed, 8 Sep 2021 13:06:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202f32cd-8036-563e-028b-781b999766be@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/7 17:43, Robin Murphy wrote:
> On 2021-09-07 08:41, Kunkun Jiang wrote:
>> Hi all,
>>
>> I am working on VFIO DMA dirty pages tracking based on ARM SMMU HTTU,
>> and have done a lot of testing.In the test, I found a problem that 
>> greatly affects
>> performance of VFIO DMA dirty pages tracking.
>>
>> According to the current arm-smmu-v3 driver, multiple VFIO pass-through
>> device comes from different SMMUs will be assigned to different
>> arm_smmu_domain. It will create page table for each arm_smmu_domain,
>> even though these page tables are exactly the same. Bacause dirty pages
>> tracking needs to traverse the page table, multiple page tables will 
>> make
>> performance worse.
>>
>> I learned the ARM SMMUv3 spec and had some exchanges with my colleagues
>> who work on SMMU hardware. I did not find the restriction that multiple
>> SMMUs cannot share the same page table. We migth be able to do this like
>> x86 IOMMU. If I have missed something, please point it out.
>
> Sure, it's not impossible, there are just a lot of fiddly 
> considerations, mostly around how to handle SMMU instances with 
> different capabilities. We haven't had a strong need to support this 
> case so far, so we've simply been avoiding all that complexity.
Yes, there's a lot to consider here. I'll try to analyze it carefully. 
We can discuss
some of the difficulties in the future. From the perspective of 
improving the
performance of VFIO DMA dirty pages tracking, it is worth supporting 
this feature.

Thanks,
Kunkun Jiang
>
> Robin.
>
>> Looking forward to your suggestions.😁
>>
>> Thanks,
>> Kunkun Jiang
>>
> .


