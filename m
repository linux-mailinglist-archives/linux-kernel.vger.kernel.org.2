Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E01325E51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBZHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:34:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13380 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBZHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:33:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dn1YD6c9mz7pS1;
        Fri, 26 Feb 2021 15:31:12 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Feb 2021 15:32:44 +0800
Subject: Re: [PATCH v14 02/11] x86: kdump: make the lower bound of crash
 kernel reservation consistent
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-3-chenzhou10@huawei.com>
 <20210224143547.GB28965@arm.com> <20210225070717.GG3553@MiWiFi-R3L-srv>
 <20210225144237.GA23418@arm.com> <20210225154446.GI3553@MiWiFi-R3L-srv>
CC:     <mingo@redhat.com>, <tglx@linutronix.de>, <rppt@kernel.org>,
        <dyoung@redhat.com>, <will@kernel.org>, <nsaenzjulienne@suse.de>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <horms@verge.net.au>,
        <robh+dt@kernel.org>, <arnd@arndb.de>, <james.morse@arm.com>,
        <xiexiuqi@huawei.com>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>, <wangkefeng.wang@huawei.com>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <d844360b-35c4-d9e8-12c2-2e6bac9ad911@huawei.com>
Date:   Fri, 26 Feb 2021 15:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210225154446.GI3553@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/25 23:44, Baoquan He wrote:
> On 02/25/21 at 02:42pm, Catalin Marinas wrote:
>> On Thu, Feb 25, 2021 at 03:08:46PM +0800, Baoquan He wrote:
>>> On 02/24/21 at 02:35pm, Catalin Marinas wrote:
>>>> On Sat, Jan 30, 2021 at 03:10:16PM +0800, Chen Zhou wrote:
>>>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>>>> index da769845597d..27470479e4a3 100644
>>>>> --- a/arch/x86/kernel/setup.c
>>>>> +++ b/arch/x86/kernel/setup.c
>>>>> @@ -439,7 +439,8 @@ static int __init reserve_crashkernel_low(void)
>>>>>  			return 0;
>>>>>  	}
>>>>>  
>>>>> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
>>>>> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
>>>>> +			CRASH_ADDR_LOW_MAX);
>>>>>  	if (!low_base) {
>>>>>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>>>>>  		       (unsigned long)(low_size >> 20));
>>>> Is there any reason why the lower bound can't be 0 in all low cases
>>>> here? (Sorry if it's been already discussed, I lost track)
>>> Seems like a good question.
>>>
>>> This reserve_crashkernel_low(), paired with reserve_crashkernel_high(), is
>>> used to reserve memory under 4G so that kdump kernel owns memory for dma
>>> buffer allocation. In that case, kernel usually is loaded in high
>>> memory. In x86_64, kernel loading need be aligned to 16M because of
>>> CONFIG_PHYSICAL_START, please see commit 32105f7fd8faa7b ("x86: find
>>> offset for crashkernel reservation automatically"). But for crashkernel
>>> low memory, there seems to be no reason to ask for 16M alignment, if
>>> it's taken as dma buffer memory.
>>>
>>> So we can make a different alignment for low memory only, e.g 2M. But
>>> 16M alignment consistent with crashkernel,high is also fine to me. The
>>> only affect is smaller alignment can increase the possibility of
>>> crashkernel low reservation.
>> I don't mind the 16M alignment in both low and high base. But is there
>> any reason that the lower bound (third argument) cannot be 0 in both
>> reserve_crashkernel() (the low attempt) and reserve_crashkernel_low()
>> cases? The comment in reserve_crashkernel() only talks about the 4G
>> upper bound but not why we need a 16M lower bound.
> Ah, sorry, I must have mixed this one with the alignment of fixed
> memory region reservation in patch 1 when considering comments.
>
> Hmm, in x86 we always have memory reserved in low 1M, lower bound
> being 0 or 16M (kernel alignment) doesn't make difference on crashkernel
> low reservation. But for crashkernel reservation, the reason should be
> kernel loading alignment being 16M, please see commit 32105f7fd8faa7b
> ("x86: find offset for crashkernel reservation automatically").
Sorry, i didn't mention in the commit message about this.

We discussed about this and the CRASH_ALIGN sounds better, so just use CRASH_ALIGN.
https://lkml.org/lkml/2020/9/4/82

Thanks,
Chen Zhou
>
> So, for crashkernel low, keeping lower bound as 0 looks good to me, the
> only reason is just as patch log tells. And it can skip the unnecessary
> memblock searching under 16M since it will always fail, even though it
> won't matter much. Or changing it to CRASH_ALIGN as this patch is doing,
> and adding code comment, is also fine to me.
>
> Thanks
> Baoquan
>
> .
>

