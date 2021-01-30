Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5AD3093BA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhA3JvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:51:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11915 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhA3DCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:02:08 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSJnq6wzSzjDkH;
        Sat, 30 Jan 2021 10:59:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 11:00:03 +0800
Subject: Re: [PATCH v5 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache
 controller
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
 <20210116032740.873-5-thunder.leizhen@huawei.com>
 <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
 <20dac713-25b7-cddf-cc42-69a834487c71@huawei.com>
 <CAK8P3a3Hj0Hyc8mVdGYhB7AEuHCYbhGxHnhNk1xWonEmxZOxRw@mail.gmail.com>
 <CAK8P3a1j+mr3bCp2uCuuYzW0ygjTmGv9vELuNy7v-iQ=WoDMOw@mail.gmail.com>
 <6c4d3650-0040-06d4-4342-79392738877b@huawei.com>
Message-ID: <cfec45df-b14e-3768-e22e-3585c8c8bab0@huawei.com>
Date:   Sat, 30 Jan 2021 11:00:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6c4d3650-0040-06d4-4342-79392738877b@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/29 21:54, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/1/29 18:26, Arnd Bergmann wrote:
>> On Fri, Jan 29, 2021 at 9:16 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>> On Fri, Jan 29, 2021 at 8:23 AM Leizhen (ThunderTown)
>>> <thunder.leizhen@huawei.com> wrote:
>>>> On 2021/1/28 22:24, Arnd Bergmann wrote:
>>>>> On Sat, Jan 16, 2021 at 4:27 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
>>>>>> +
>>>>>> +static void l3cache_maint_common(u32 range, u32 op_type)
>>>>>> +{
>>>>>> +       u32 reg;
>>>>>> +
>>>>>> +       reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
>>>>>> +       reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
>>>>>> +       reg |= range | op_type;
>>>>>> +       reg |= L3_MAINT_STATUS_START;
>>>>>> +       writel(reg, l3_ctrl_base + L3_MAINT_CTRL);
>>>>>
>>>>> Are there contents of L3_MAINT_CTRL that need to be preserved
>>>>> across calls and can not be inferred? A 'readl()' is often expensive,
>>>>> so it might be more efficient if you can avoid that.
>>>>
>>>> Right, this readl() can be replaced with readl_relaxed(). Thanks.
>>>>
>>>> I'll check and correct the readl() and writel() in other places.
>>>
>>> What I meant is that if you want to replace them, you should provide
>>> performance numbers that show how much difference this makes
>>> and add comments in the source code explaining how you proved that
>>> the _relaxed() version is actually correct.
>>
>> Another clarification, as there are actually two independent
>> points here:
>>
>> * if you can completely remove the readl() above and just write a
>>   hardcoded value into the register, or perhaps read the original
>>   value once at boot time, that is probably a win because it
>>   avoids one of the barriers in the beginning. The datasheet should
>>   tell you if there are any bits in the register that have to be
>>   preserved
> 
> Code coupling will become very strong.
> 
>>
>> * Regarding the _relaxed() accessors, it's a lot harder to know
>>   whether that is safe, as you first have to show, in particular in case
>>   any of the accesses stop being guarded by the spinlock in that
>>   case, and whether there may be a case where you have to
>>   serialize the memory access against accesses that are still in the
>>   store queue or prefetched.
>>
>> Whether this matters at all depends mostly on the type of devices
>> you are driving on your SoC. If you have any high-speed network
>> interfaces that are unable to do cache coherent DMA, any extra
>> instruction here may impact the number of packets you can transfer,
>> but if all your high-speed devices are connected to a coherent
>> interconnect, I would just go with the obvious approach and use
>> the safe MMIO accessors everywhere.
> 
> In fact, this driver has been running on an earlier version for several years
> and has not received any feedback about the performance issue. So I didn't
> try to optimize it when I first sent these patches. I had to reconsider it
> until you noticed it.
> 
> How about keeping it unchanged for the moment? It'll take a lot of time and
> energy to retest.

In the spirit of code excellence, it's still necessary to optimize it.
Yesterday, my family urged me to go back, I wrote it in a hurry.

> 
>>
>>        Arnd
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 

