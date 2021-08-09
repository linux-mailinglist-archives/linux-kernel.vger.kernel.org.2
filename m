Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1943E3FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhHIGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:20:29 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37294 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233210AbhHIGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:20:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UiMSubG_1628490005;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UiMSubG_1628490005)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Aug 2021 14:20:05 +0800
Subject: Re: [PATCH] riscv: add ARCH_DMA_MINALIGN support
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
 <20210809003044.6692ddce@xhacker>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <c09fc86d-1e6a-3315-7489-9e269935ba55@linux.alibaba.com>
Date:   Mon, 9 Aug 2021 14:20:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210809003044.6692ddce@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/9 上午12:30, Jisheng Zhang 写道:
> On Sat,  7 Aug 2021 22:55:37 +0800
> Xianting Tian <xianting.tian@linux.alibaba.com> wrote:
>
>> Introduce ARCH_DMA_MINALIGN to riscv arch.
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   arch/riscv/include/asm/cache.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
>> index 9b58b1045..2945bbe2b 100644
>> --- a/arch/riscv/include/asm/cache.h
>> +++ b/arch/riscv/include/asm/cache.h
>> @@ -11,6 +11,8 @@
>>   
>>   #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>>   
>> +#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
> It's not a good idea to blindly set this for all riscv. For "coherent"
> platforms, this is not necessary and will waste memory.

I checked ARCH_DMA_MINALIGN definition,  "If an architecture isn't fully 
DMA-coherent, ARCH_DMA_MINALIGN must be set".

so that the memory allocator makes sure that kmalloc'ed buffer doesn't 
share a cache line with the others.

Documentation/core-api/dma-api-howto.rst

2) ARCH_DMA_MINALIGN

    Architectures must ensure that kmalloc'ed buffer is
    DMA-safe. Drivers and subsystems depend on it. If an architecture
    isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
    the CPU cache is identical to data in main memory),
    ARCH_DMA_MINALIGN must be set so that the memory allocator
    makes sure that kmalloc'ed buffer doesn't share a cache line with
    the others. See arch/arm/include/asm/cache.h as an example.

    Note that ARCH_DMA_MINALIGN is about DMA memory alignment
    constraints. You don't need to worry about the architecture data
    alignment constraints (e.g. the alignment constraints about 64-bit
    objects).

>
>> +
>>   /*
>>    * RISC-V requires the stack pointer to be 16-byte aligned, so ensure that
>>    * the flat loader aligns it accordingly.
