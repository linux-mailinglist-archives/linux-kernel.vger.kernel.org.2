Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE43E4CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhHITTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhHITTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:19:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:19:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p145so31501790ybg.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5FbAj8r6tE8vWXCnXxzRL0+yywGEKOj7p8jnbK86Ew=;
        b=rXNDKWW1qrP9MQi43TIvNTtXHxgAHW7/OVH9i6E3+nr2TNdcOl1DnLemafRNeAuOni
         YcwihQFrpM6HC8mFNB2dZlgPpKBiLGWEuq1ao1Hlza/AXJ7vjsKhrlU18G9xC4SeGtiY
         p093jZkWPWdrMkL7vhazLsCVFXN+IpacvQiD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5FbAj8r6tE8vWXCnXxzRL0+yywGEKOj7p8jnbK86Ew=;
        b=VlpuF8N2OOOEHsub0RV3EqA9RXAevn+rupGs6DtqVWe7p5xgKcfe2vc/s0pU05jVXU
         Cj1UFegwEscvqaVvBxt/NXQBh9K7SHLJYDc5mtEsxXthAcPLRZDJ9X5+tm9dvUn3DFAh
         cKpl2N+vZ2heJGa4/kkwh9sVtPGUY0fE9WNJ7qzZIZ+R0o6Nai7GnCwPoN5qAjTrjCYD
         aUOH7QnJOOh3BF+pHcinnyQ8LSJD2YeT8eC1+BgWGwRwZ0Bk+zWeErqF2UNdrnmejZQC
         Zg/QAa4UBrEAFeHNvq0TD/D5ADMlWLp8L2ySfkUS/bpyEzBeAPUhI9lT7CdM+tNU+A1R
         U0XA==
X-Gm-Message-State: AOAM5315wDv/VDS5dY7l/rM5b/rqigESytt02vGAw3JZCXw54CG7FtX+
        qGecmC4lzsAhKrZlwr/BW19kGp1VrNNYFeAZCcoB
X-Google-Smtp-Source: ABdhPJz4U2Wrj5qOv21GHijYD7/uOCOLFk5QRJH7kt2VLiP2xkxjDpNwOXkCNZ8vTCfggjjfAZ6Mbl3nP+Tavrxks5Y=
X-Received: by 2002:a25:7a03:: with SMTP id v3mr33382775ybc.202.1628536771106;
 Mon, 09 Aug 2021 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
 <20210809003044.6692ddce@xhacker> <c09fc86d-1e6a-3315-7489-9e269935ba55@linux.alibaba.com>
 <CAK8P3a1wyhLp1hUUotzwqc1pyCyfWhO7O_pvt5O_U=qZp-ZhnA@mail.gmail.com>
In-Reply-To: <CAK8P3a1wyhLp1hUUotzwqc1pyCyfWhO7O_pvt5O_U=qZp-ZhnA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 9 Aug 2021 12:19:20 -0700
Message-ID: <CAOnJCU+YQOF2+_FNa5Hpig_dnymNA-ZvtgU4-B5eisTyB9GT6Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: add ARCH_DMA_MINALIGN support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Xianting TIan <xianting.tian@linux.alibaba.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 12:50 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Aug 9, 2021 at 8:20 AM Xianting TIan
> <xianting.tian@linux.alibaba.com> wrote:
> >
> > >> +#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> > > It's not a good idea to blindly set this for all riscv. For "coherent"
> > > platforms, this is not necessary and will waste memory.
> >
> > I checked ARCH_DMA_MINALIGN definition,  "If an architecture isn't fully
> > DMA-coherent, ARCH_DMA_MINALIGN must be set".
> >
> > so that the memory allocator makes sure that kmalloc'ed buffer doesn't
> > share a cache line with the others.
> >
> > Documentation/core-api/dma-api-howto.rst
> >
> > 2) ARCH_DMA_MINALIGN
> >
> >     Architectures must ensure that kmalloc'ed buffer is
> >     DMA-safe. Drivers and subsystems depend on it. If an architecture
> >     isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
> >     the CPU cache is identical to data in main memory),
> >     ARCH_DMA_MINALIGN must be set so that the memory allocator
> >     makes sure that kmalloc'ed buffer doesn't share a cache line with
> >     the others. See arch/arm/include/asm/cache.h as an example.
> >
> >     Note that ARCH_DMA_MINALIGN is about DMA memory alignment
> >     constraints. You don't need to worry about the architecture data
> >     alignment constraints (e.g. the alignment constraints about 64-bit
> >     objects).
>
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

Can we add a new DT property to indicate the system is fully cache-coherent ?
That will be helpful for RISC-V as well. We already have platforms like hifive
unleashed/unmatched that are coherent while beagleV is not.

The workaround to support both platforms in a single image was not
very pretty [1].

[1] https://patchwork.kernel.org/project/linux-riscv/list/?series=520541

>
>        Arnd
>
> [1] https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spec.adoc#architecture
> [2] https://lore.kernel.org/linux-arm-kernel/20210527124356.22367-1-will@kernel.org/
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
