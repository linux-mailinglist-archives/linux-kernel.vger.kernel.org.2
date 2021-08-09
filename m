Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35B3E41F3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhHIJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:01:00 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46309 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233940AbhHIJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:00:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UiPJFgZ_1628499636;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UiPJFgZ_1628499636)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Aug 2021 17:00:37 +0800
Subject: Re: [PATCH] riscv: add ARCH_DMA_MINALIGN support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
 <20210809003044.6692ddce@xhacker>
 <c09fc86d-1e6a-3315-7489-9e269935ba55@linux.alibaba.com>
 <CAK8P3a1wyhLp1hUUotzwqc1pyCyfWhO7O_pvt5O_U=qZp-ZhnA@mail.gmail.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <5b7bfc3f-4fe8-bd7e-561b-0f99cf1df9b0@linux.alibaba.com>
Date:   Mon, 9 Aug 2021 17:00:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1wyhLp1hUUotzwqc1pyCyfWhO7O_pvt5O_U=qZp-ZhnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/9 下午3:49, Arnd Bergmann 写道:
> On Mon, Aug 9, 2021 at 8:20 AM Xianting TIan
> <xianting.tian@linux.alibaba.com> wrote:
>>>> +#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
>>> It's not a good idea to blindly set this for all riscv. For "coherent"
>>> platforms, this is not necessary and will waste memory.
>> I checked ARCH_DMA_MINALIGN definition,  "If an architecture isn't fully
>> DMA-coherent, ARCH_DMA_MINALIGN must be set".
>>
>> so that the memory allocator makes sure that kmalloc'ed buffer doesn't
>> share a cache line with the others.
>>
>> Documentation/core-api/dma-api-howto.rst
>>
>> 2) ARCH_DMA_MINALIGN
>>
>>      Architectures must ensure that kmalloc'ed buffer is
>>      DMA-safe. Drivers and subsystems depend on it. If an architecture
>>      isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
>>      the CPU cache is identical to data in main memory),
>>      ARCH_DMA_MINALIGN must be set so that the memory allocator
>>      makes sure that kmalloc'ed buffer doesn't share a cache line with
>>      the others. See arch/arm/include/asm/cache.h as an example.
>>
>>      Note that ARCH_DMA_MINALIGN is about DMA memory alignment
>>      constraints. You don't need to worry about the architecture data
>>      alignment constraints (e.g. the alignment constraints about 64-bit
>>      objects).
> The platform spec [1] says about this:
>
> | Memory accesses by I/O masters can be coherent or non-coherent
> | with respect to all hart-related caches.
>
> So the kernel in its default configuration can not assume that DMA is
> cache coherent on RISC-V. Making this configurable implies that
> a kernel that is configured for cache-coherent machines can no longer
> run on all hardware that follows the platform spec.
>
> We have the same problem on arm64, where most of the server parts
> are cache coherent, but the majority of the low-end embedded devices
> are not, and we require that a single kernel ran run on all of the above.
>
> One idea that we have discussed several times is to start the kernel
> without the small kmalloc caches and defer their creation until a
> later point in the boot process after determining whether any
> non-coherent devices have been discovered. Any in-kernel structures
> that have an explicit ARCH_DMA_MINALIGN alignment won't
> benefit from this, but any subsequent kmalloc() calls can use the
> smaller caches. The tricky bit is finding out whether /everything/ on
> the system is cache-coherent or not, since we do not have a global
> flag for that in the DT. See [2] for a recent discussion.
>
>         Arnd
>
> [1] https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spec.adoc#architecture
> [2] https://lore.kernel.org/linux-arm-kernel/20210527124356.22367-1-will@kernel.org/
Arnd, thanks for info,  according to the description, seems we need to 
apply this patch to riscv.
