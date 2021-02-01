Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934FA30A6B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBALjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:39:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11965 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhBALjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:39:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DTmCZ2P9TzjGDg;
        Mon,  1 Feb 2021 19:38:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 19:38:57 +0800
Subject: Re: [PATCH v6 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache
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
References: <20210201033601.1642-1-thunder.leizhen@huawei.com>
 <20210201033601.1642-5-thunder.leizhen@huawei.com>
 <CAK8P3a0=Aj0Ss3xbgh1ELyB+4d94ybugbza_xUqW_=yVsMwEqg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <301c82eb-68ce-1a96-a0b8-d46a29bf6f36@huawei.com>
Date:   Mon, 1 Feb 2021 19:38:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0=Aj0Ss3xbgh1ELyB+4d94ybugbza_xUqW_=yVsMwEqg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/1 16:31, Arnd Bergmann wrote:
> On Mon, Feb 1, 2021 at 4:36 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> Add support for the Hisilicon Kunpeng L3 cache controller as used with
>> Kunpeng506 and Kunpeng509 SoCs.
>>
>> These Hisilicon SoCs support LPAE, so the physical addresses is wider than
>> 32-bits, but the actual bit width does not exceed 36 bits. When the cache
>> operation is performed based on the address range, the upper 30 bits of
>> the physical address are recorded in registers L3_MAINT_START and
>> L3_MAINT_END, and ignore the lower 6 bits cacheline offset.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> If you add one more thing:
> 
>> +static void l3cache_maint_common(u32 range, u32 op_type)
>> +{
>> +       u32 reg;
>> +
>> +       reg = readl_relaxed(l3_ctrl_base + L3_MAINT_CTRL);
>> +       reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
>> +       reg |= range | op_type;
>> +       reg |= L3_MAINT_STATUS_START;
>> +       writel(reg, l3_ctrl_base + L3_MAINT_CTRL);
>> +
>> +       /* Wait until the hardware maintenance operation is complete. */
>> +       do {
>> +               cpu_relax();
>> +               reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
>> +       } while ((reg & L3_MAINT_STATUS_MASK) != L3_MAINT_STATUS_END);
>> +}
>> +
>> +static void l3cache_maint_range(phys_addr_t start, phys_addr_t end, u32 op_type)
>> +{
>> +       start = start >> L3_CACHE_LINE_SHITF;
>> +       end = ((end - 1) >> L3_CACHE_LINE_SHITF) + 1;
>> +
>> +       writel_relaxed(start, l3_ctrl_base + L3_MAINT_START);
>> +       writel_relaxed(end, l3_ctrl_base + L3_MAINT_END);
>> +
>> +       l3cache_maint_common(L3_MAINT_RANGE_ADDR, op_type);
>> +}
> 
> As mentioned, I'd like to see a code comment that explains the use
> the of relaxed() vs non-relaxed MMIO accessors, as it will be impossible
> for a reader to later understand why you picked a mix of the two,
> and it also ensures that you have considered which one is the best
> option to use here and that your explanation matches what you do.

OK, I'll test the performance and add the comment.

> 
> Based on Russell's comments, I had expected that you would use
> only relaxed accessors, plus explicit barriers if you change it, matching
> what l2x0 does (l2x0 has to do it because of __l2c210_cache_sync(),
> while you don't have a sync callback and don't need to).

I might have been a little conservative, I'll change all of them to _relaxed and then test it. Thanks.

> 
>       Arnd
> 
> .
> 

