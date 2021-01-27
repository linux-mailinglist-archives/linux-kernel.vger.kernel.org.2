Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2406130572D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhA0Jm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:42:57 -0500
Received: from foss.arm.com ([217.140.110.172]:35176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233844AbhA0Jk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:40:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8957131B;
        Wed, 27 Jan 2021 01:39:40 -0800 (PST)
Received: from [10.57.46.236] (unknown [10.57.46.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DC03F66B;
        Wed, 27 Jan 2021 01:39:39 -0800 (PST)
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <319e3532-4555-7431-9d6f-3c3b7c11a5d9@arm.com>
Date:   Wed, 27 Jan 2021 09:39:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <32f4752f-6954-183a-a0c1-b5d719c85b67@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-27 07:36, Keqian Zhu wrote:
> 
> 
> On 2021/1/27 10:01, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/1/26 18:12, Will Deacon wrote:
>>> On Mon, Jan 25, 2021 at 08:23:40PM +0000, Robin Murphy wrote:
>>>> Now we probably will need some degreee of BBML feature awareness for the
>>>> sake of SVA if and when we start using it for CPU pagetables, but I still
>>>> cannot see any need to consider it in io-pgtable.
>>>
>>> Agreed; I don't think this is something that io-pgtable should have to care
>>> about.
> Hi,
> 
> I have a question here :-).
> If the old table is not live, then the break procedure seems unnecessary. Do I miss something?

The MMU is allowed to prefetch translations at any time, so not 
following the proper update procedure could still potentially lead to a 
TLB conflict, even if there's no device traffic to worry about disrupting.

Robin.

> Thanks,
> Keqian
> 
>>
>> Yes, the SVA works in stall mode, and the failed device access requests are not
>> discarded.
>>
>> Let me look for examples. The BBML usage scenario was told by a former colleague.
>>
>>>
>>> Will
>>>
>>> .
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> .
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
