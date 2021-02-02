Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF930BE15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhBBMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:19:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11674 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBBMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:19:41 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVP2R6VTVzlDtZ;
        Tue,  2 Feb 2021 20:17:19 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Feb 2021
 20:18:51 +0800
Subject: Re: [PATCH v7 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache
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
References: <20210202071648.1776-1-thunder.leizhen@huawei.com>
 <20210202071648.1776-5-thunder.leizhen@huawei.com>
 <CAK8P3a1HuXx7qpOPAdcGadtWCkNOp75bgO8cLSpXnobULHU6ZQ@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <99b8672c-467c-9698-40e7-aed7dc5d2ee2@huawei.com>
Date:   Tue, 2 Feb 2021 20:18:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1HuXx7qpOPAdcGadtWCkNOp75bgO8cLSpXnobULHU6ZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/2 16:44, Arnd Bergmann wrote:
> On Tue, Feb 2, 2021 at 8:16 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>> +
>> +/*
>> + * All read and write operations on L3 cache registers are protected by the
>> + * spinlock, except for l3cache_init(). Each time the L3 cache operation is
>> + * performed, all related information is filled into its registers. Therefore,
>> + * there is no memory order problem when only _relaxed() functions are used.
> 
> Thank you for including the text.
> 
> I don't think the explanation with the spin_lock() explains why this
> can be considered safe though, as spin_lock() only contains serialization
> against other CPUs (smp_mb()) rather than the stronger DMA barriers
> implied by readl and writel. As Russell previously explained, these
> barriers are the L1 cache operations (e.g. v7_dma_inv_range) do
> include stronger barriers, so it would be better to come up with a
> justification based on those.

Okay, I'll correct the description.

> 
>> + * This can help us achieve some performance improvement:
>> + * 1) The readl_relaxed() is about 20ns faster than readl().
>> + * 2) The writel_relaxed() is about 123ns faster than writel().
> 
> These are not really the performance numbers I asked for, as a
> low-level benchmark comparing the instructions is rather meaningless.
> The time spent waiting for the barrier depends on what else is going
> on around the barrier. Also, most of the time would likely be
> spent spinning in the loop around readl() while the cache operations
> are in progress, so the latency of a single readl() is not necessarily
> significant.
> 
> To have a more useful performance number, try mentioning the
> most performance sensitive non-coherent DMA master on one
> of the chips that has this cache controller, and a high-level
> performance number such as "1.2% more network packets per
> second" if that is something you can measure easily.

It's not easy. My board only have debugging NIC, only the downstream
products have high-speed service NIC. Software needs to be packaged
layer by layer.

> 
> Of course, if all high-speed DMA masters on this chip are
> cache coherent, there is no need for performance numbers, just
> mention that we don't care about speed in that case.

It's not cache coherent, otherwise, the L3 cache does not need to be
operated.

> 
>         Arnd
> 
> .
> 

