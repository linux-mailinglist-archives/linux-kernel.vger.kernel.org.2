Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9810308663
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhA2HYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:24:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12348 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhA2HY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:24:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DRph05WCwz7cjq;
        Fri, 29 Jan 2021 15:22:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 29 Jan 2021
 15:23:28 +0800
Subject: Re: [PATCH v5 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache
 controller
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
 <20210116032740.873-5-thunder.leizhen@huawei.com>
 <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <20dac713-25b7-cddf-cc42-69a834487c71@huawei.com>
Date:   Fri, 29 Jan 2021 15:23:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1OqUn5A4F4hT4K=bzQwJuifVFZkvFoK6NMg+m9FjoKzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/28 22:24, Arnd Bergmann wrote:
> On Sat, Jan 16, 2021 at 4:27 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
>> +
>> +static void l3cache_maint_common(u32 range, u32 op_type)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
>> +       reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
>> +       reg |= range | op_type;
>> +       reg |= L3_MAINT_STATUS_START;
>> +       writel(reg, l3_ctrl_base + L3_MAINT_CTRL);
> 
> Are there contents of L3_MAINT_CTRL that need to be preserved
> across calls and can not be inferred? A 'readl()' is often expensive,
> so it might be more efficient if you can avoid that.

Right, this readl() can be replaced with readl_relaxed(). Thanks.

I'll check and correct the readl() and writel() in other places.

> 
>> +static inline void l3cache_flush_all_nolock(void)
>> +{
>> +       l3cache_maint_common(L3_MAINT_RANGE_ALL, L3_MAINT_TYPE_FLUSH);
>> +}
>> +
>> +static void l3cache_flush_all(void)
>> +{
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&l3cache_lock, flags);
>> +       l3cache_flush_all_nolock();
>> +       spin_unlock_irqrestore(&l3cache_lock, flags);
>> +}
> 
> I see that cache-l2x0 uses raw_spin_lock_irqsave() instead of
> spin_lock_irqsave(), to avoid preemption in the middle of a cache
> operation. This is probably a good idea here as well.

I don't think there's any essential difference between the two! I don't know
if the compiler or tool will do anything extra. I checked the git log of the
l2x0 driver and it used raw_spin_lock_irqsave() at the beginning. Maybe
there's a description in 2.6. Since you mentioned this potential risk, I'll
change it to raw_spin_lock_irqsave.

include/linux/spinlock.h：
static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
{
        return &lock->rlock;
}

#define spin_lock_irqsave(lock, flags)                          \
do {                                                            \
        raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
} while (0)

> 
> I also see that l2x0 uses readl_relaxed(), to avoid a deadlock
> in l2x0_cache_sync(). This may also be beneficial for performance
> reasons, so it might be helpful to compare performance
> overhead. On the other hand, readl()/writel() are usually the
> safe choice, as those avoid the need to argue over whether
> the relaxed versions are safe in all corner cases.
> 
>> +static int __init l3cache_init(void)
>> +{
>> +       u32 reg;
>> +       struct device_node *node;
>> +
>> +       node = of_find_matching_node(NULL, l3cache_ids);
>> +       if (!node)
>> +               return -ENODEV;
> 
> I think the initcall should return '0' to indicate success when running
> a kernel with this driver built-in on a platform that does not have
> this device.

I have added "depends on ARCH_KUNPENG50X" for this driver. But it's OK to
return 0.

> 
>> diff --git a/arch/arm/mm/cache-kunpeng-l3.h b/arch/arm/mm/cache-kunpeng-l3.h
>> new file mode 100644
>> index 000000000000000..9ef6a53e7d4db49
>> --- /dev/null
>> +++ b/arch/arm/mm/cache-kunpeng-l3.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __CACHE_KUNPENG_L3_H
>> +#define __CACHE_KUNPENG_L3_H
>> +
>> +#define L3_CACHE_LINE_SHITF            6
> 
> I would suggest moving the contents of the header file into the .c file,
> since there is only a single user of these macros.

Okay, I'll move it.

> 
>           Arnd
> 
> .
> 

