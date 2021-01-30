Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AAF309367
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhA3Jal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:30:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11917 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhA3DnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:43:03 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DSJbc0hn6zjFBn;
        Sat, 30 Jan 2021 10:50:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 10:51:14 +0800
Subject: Re: [PATCH v5 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache
 controller
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
 <20210116032740.873-5-thunder.leizhen@huawei.com>
 <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
 <20dac713-25b7-cddf-cc42-69a834487c71@huawei.com>
 <CAK8P3a3Hj0Hyc8mVdGYhB7AEuHCYbhGxHnhNk1xWonEmxZOxRw@mail.gmail.com>
 <CAK8P3a1j+mr3bCp2uCuuYzW0ygjTmGv9vELuNy7v-iQ=WoDMOw@mail.gmail.com>
 <20210129103340.GW1551@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b236bcbc-8610-dfc4-50f2-a4b71162735d@huawei.com>
Date:   Sat, 30 Jan 2021 10:51:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210129103340.GW1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/29 18:33, Russell King - ARM Linux admin wrote:
> On Fri, Jan 29, 2021 at 11:26:38AM +0100, Arnd Bergmann wrote:
>> Another clarification, as there are actually two independent
>> points here:
>>
>> * if you can completely remove the readl() above and just write a
>>   hardcoded value into the register, or perhaps read the original
>>   value once at boot time, that is probably a win because it
>>   avoids one of the barriers in the beginning. The datasheet should
>>   tell you if there are any bits in the register that have to be
>>   preserved
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
> For L2 cache code, I would say the opposite, actually, because it is
> all too easy to get into a deadlock otherwise.
> 
> If you implement the sync callback, that will be called from every
> non-relaxed accessor, which means if you need to take some kind of
> lock in the sync callback and elsewhere in the L2 cache code, you will
> definitely deadlock.
> 
> It is safer to put explicit barriers where it is necessary.
> 
> Also remember that the barrier in readl() etc is _after_ the read, not
> before, and the barrier in writel() is _before_ the write, not after.
> The point is to ensure that DMA memory accesses are properly ordered
> with the IO-accessing instructions.

Yes, I known it. writel() must be used for the write operations that control
"start/stop" or "enable/disable" function, to ensure that the data of previous
write operations reaches the target. I've met this kind of problem before.

> 
> So, using readl_relaxed() with a read-modify-write is entirely sensible
> provided you do not access DMA memory inbetween.

Actually, I don't think this register is that complicated. I copied the code
back below. All the bits of L3_MAINT_CTRL are not affected by DMA access operations.
The software change the "range | op_type" to specify the operation type and scope,
the set the bit "L3_MAINT_STATUS_START" to start the operation. Then wait for that
bit to change from 1 to 0 by hardware.

+	reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
+	reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
+	reg |= range | op_type;
+	reg |= L3_MAINT_STATUS_START;
+	writel(reg, l3_ctrl_base + L3_MAINT_CTRL);
+
+	/* Wait until the hardware maintenance operation is complete. */
+	do {
+		cpu_relax();
+		reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
+	} while ((reg & L3_MAINT_STATUS_MASK) != L3_MAINT_STATUS_END);

> 

