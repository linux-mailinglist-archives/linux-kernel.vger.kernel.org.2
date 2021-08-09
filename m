Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440F3E4112
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhHIHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233533AbhHIHt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:49:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 029DE61056
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628495376;
        bh=q/S/ccLXHytgWzYsEEYPeb1axvMFlx+hkfDx9JyqjhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZXkLPeDSnu/5fSVRxKq0MAg7wIhU9SY3SUjybAvltMCLBCcoXhz08WyVaEetNEy8O
         eyMorI6OqeuXLwlS4DFnzwkr/53N5tAv/hau8SIZ2UcyM00eKIEXtPQapzBSomI/s6
         IB0VrFfCIJV4LcEnhMlmTJArCU0HpC3W/D3EaNtEqG7jXOMJ/7jTcM5ELT7KXHAQgO
         3kC8CaJKV3XrUVg+/Fzds11q7/0sDUpAS2UZoxvHra0RbbxZTmZoQgtVO+li9uoVdr
         ZbD7NiTkgToVF3oc4zdn63svc3dtk75DvHp5JKmqdPRhn68B2iAxM13/xy9KMk+AdI
         wFhqRAgwA/Pug==
Received: by mail-wr1-f47.google.com with SMTP id k29so7332456wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:49:35 -0700 (PDT)
X-Gm-Message-State: AOAM533DZVYV14bImdZ2uFVI5m6vrq7oS8lMl/k8tfJIF5N/dypBFfRb
        AgO7/S/5hN5PXowQKipOx6TgOU6SRswMzwBq1+8=
X-Google-Smtp-Source: ABdhPJwK0fcoyVP2S8sGrZY8yRoZXSzaTqRROq5Jut72S+v1w47Bga5OiaWNKFfeoKGo83RQrK3xtnVhG0enY+78Ey0=
X-Received: by 2002:adf:fd90:: with SMTP id d16mr24684354wrr.105.1628495374617;
 Mon, 09 Aug 2021 00:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
 <20210809003044.6692ddce@xhacker> <c09fc86d-1e6a-3315-7489-9e269935ba55@linux.alibaba.com>
In-Reply-To: <c09fc86d-1e6a-3315-7489-9e269935ba55@linux.alibaba.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 9 Aug 2021 09:49:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1wyhLp1hUUotzwqc1pyCyfWhO7O_pvt5O_U=qZp-ZhnA@mail.gmail.com>
Message-ID: <CAK8P3a1wyhLp1hUUotzwqc1pyCyfWhO7O_pvt5O_U=qZp-ZhnA@mail.gmail.com>
Subject: Re: [PATCH] riscv: add ARCH_DMA_MINALIGN support
To:     Xianting TIan <xianting.tian@linux.alibaba.com>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 8:20 AM Xianting TIan
<xianting.tian@linux.alibaba.com> wrote:
>
> >> +#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> > It's not a good idea to blindly set this for all riscv. For "coherent"
> > platforms, this is not necessary and will waste memory.
>
> I checked ARCH_DMA_MINALIGN definition,  "If an architecture isn't fully
> DMA-coherent, ARCH_DMA_MINALIGN must be set".
>
> so that the memory allocator makes sure that kmalloc'ed buffer doesn't
> share a cache line with the others.
>
> Documentation/core-api/dma-api-howto.rst
>
> 2) ARCH_DMA_MINALIGN
>
>     Architectures must ensure that kmalloc'ed buffer is
>     DMA-safe. Drivers and subsystems depend on it. If an architecture
>     isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
>     the CPU cache is identical to data in main memory),
>     ARCH_DMA_MINALIGN must be set so that the memory allocator
>     makes sure that kmalloc'ed buffer doesn't share a cache line with
>     the others. See arch/arm/include/asm/cache.h as an example.
>
>     Note that ARCH_DMA_MINALIGN is about DMA memory alignment
>     constraints. You don't need to worry about the architecture data
>     alignment constraints (e.g. the alignment constraints about 64-bit
>     objects).

The platform spec [1] says about this:

| Memory accesses by I/O masters can be coherent or non-coherent
| with respect to all hart-related caches.

So the kernel in its default configuration can not assume that DMA is
cache coherent on RISC-V. Making this configurable implies that
a kernel that is configured for cache-coherent machines can no longer
run on all hardware that follows the platform spec.

We have the same problem on arm64, where most of the server parts
are cache coherent, but the majority of the low-end embedded devices
are not, and we require that a single kernel ran run on all of the above.

One idea that we have discussed several times is to start the kernel
without the small kmalloc caches and defer their creation until a
later point in the boot process after determining whether any
non-coherent devices have been discovered. Any in-kernel structures
that have an explicit ARCH_DMA_MINALIGN alignment won't
benefit from this, but any subsequent kmalloc() calls can use the
smaller caches. The tricky bit is finding out whether /everything/ on
the system is cache-coherent or not, since we do not have a global
flag for that in the DT. See [2] for a recent discussion.

       Arnd

[1] https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spec.adoc#architecture
[2] https://lore.kernel.org/linux-arm-kernel/20210527124356.22367-1-will@kernel.org/
