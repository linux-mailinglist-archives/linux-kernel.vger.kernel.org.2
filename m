Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFDD307A84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhA1QS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:18:27 -0500
Received: from foss.arm.com ([217.140.110.172]:35152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhA1QSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:18:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 548D513D5;
        Thu, 28 Jan 2021 08:17:37 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37ACE3F7C3;
        Thu, 28 Jan 2021 08:17:36 -0800 (PST)
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
To:     Keqian Zhu <zhukeqian1@huawei.com>, Will Deacon <will@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
 <aac11411-f6cd-f990-fe53-db0d8c07f3a0@huawei.com>
 <1bfd1ca0-953e-e943-f87e-144d5537bd0c@arm.com>
 <20210126101230.GA29204@willie-the-truck>
 <8a9685ec-67aa-824f-5429-f408bf79c5ab@huawei.com>
 <32f4752f-6954-183a-a0c1-b5d719c85b67@huawei.com>
 <319e3532-4555-7431-9d6f-3c3b7c11a5d9@arm.com>
 <d3aaa7e7-edb0-f867-0519-9a4e0bee35d2@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <301590f1-817b-d8eb-1585-31208cba18af@arm.com>
Date:   Thu, 28 Jan 2021 16:17:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d3aaa7e7-edb0-f867-0519-9a4e0bee35d2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 15:18, Keqian Zhu wrote:
> 
> 
> On 2021/1/27 17:39, Robin Murphy wrote:
>> On 2021-01-27 07:36, Keqian Zhu wrote:
>>>
>>>
>>> On 2021/1/27 10:01, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2021/1/26 18:12, Will Deacon wrote:
>>>>> On Mon, Jan 25, 2021 at 08:23:40PM +0000, Robin Murphy wrote:
>>>>>> Now we probably will need some degreee of BBML feature awareness for the
>>>>>> sake of SVA if and when we start using it for CPU pagetables, but I still
>>>>>> cannot see any need to consider it in io-pgtable.
>>>>>
>>>>> Agreed; I don't think this is something that io-pgtable should have to care
>>>>> about.
>>> Hi,
>>>
>>> I have a question here :-).
>>> If the old table is not live, then the break procedure seems unnecessary. Do I miss something?
>>
>> The MMU is allowed to prefetch translations at any time, so not following the proper update procedure could still potentially lead to a TLB conflict, even if there's no device traffic to worry about disrupting.
>>
>> Robin.
> 
> Thanks. Does the MMU you mention here includes MMU and SMMU? I know that at SMMU side, ATS can prefetch translation.

Yes, both - VMSAv8 allows speculative translation table walks, so SMMUv3 
inherits from there (per 3.21.1 "Translation tables and TLB invalidation 
completion behavior").

Robin.

> 
> Keqian
>>
>>> Thanks,
>>> Keqian
>>>
>>>>
>>>> Yes, the SVA works in stall mode, and the failed device access requests are not
>>>> discarded.
>>>>
>>>> Let me look for examples. The BBML usage scenario was told by a former colleague.
>>>>
>>>>>
>>>>> Will
>>>>>
>>>>> .
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>> .
>>>>
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>
>> .
>>
