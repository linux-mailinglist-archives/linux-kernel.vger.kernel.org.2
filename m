Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C18307987
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhA1PUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:20:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11467 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhA1PTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:19:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRPH86F54zjDTK;
        Thu, 28 Jan 2021 23:17:56 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 23:18:46 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
 <aac11411-f6cd-f990-fe53-db0d8c07f3a0@huawei.com>
 <1bfd1ca0-953e-e943-f87e-144d5537bd0c@arm.com>
 <20210126101230.GA29204@willie-the-truck>
 <8a9685ec-67aa-824f-5429-f408bf79c5ab@huawei.com>
 <32f4752f-6954-183a-a0c1-b5d719c85b67@huawei.com>
 <319e3532-4555-7431-9d6f-3c3b7c11a5d9@arm.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <d3aaa7e7-edb0-f867-0519-9a4e0bee35d2@huawei.com>
Date:   Thu, 28 Jan 2021 23:18:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <319e3532-4555-7431-9d6f-3c3b7c11a5d9@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/27 17:39, Robin Murphy wrote:
> On 2021-01-27 07:36, Keqian Zhu wrote:
>>
>>
>> On 2021/1/27 10:01, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2021/1/26 18:12, Will Deacon wrote:
>>>> On Mon, Jan 25, 2021 at 08:23:40PM +0000, Robin Murphy wrote:
>>>>> Now we probably will need some degreee of BBML feature awareness for the
>>>>> sake of SVA if and when we start using it for CPU pagetables, but I still
>>>>> cannot see any need to consider it in io-pgtable.
>>>>
>>>> Agreed; I don't think this is something that io-pgtable should have to care
>>>> about.
>> Hi,
>>
>> I have a question here :-).
>> If the old table is not live, then the break procedure seems unnecessary. Do I miss something?
> 
> The MMU is allowed to prefetch translations at any time, so not following the proper update procedure could still potentially lead to a TLB conflict, even if there's no device traffic to worry about disrupting.
> 
> Robin.

Thanks. Does the MMU you mention here includes MMU and SMMU? I know that at SMMU side, ATS can prefetch translation.

Keqian
> 
>> Thanks,
>> Keqian
>>
>>>
>>> Yes, the SVA works in stall mode, and the failed device access requests are not
>>> discarded.
>>>
>>> Let me look for examples. The BBML usage scenario was told by a former colleague.
>>>
>>>>
>>>> Will
>>>>
>>>> .
>>>>
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>> .
>>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> .
> 
