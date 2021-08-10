Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857663E50A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhHJBbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhHJBbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:31:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6941261058
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628559043;
        bh=S42P87zuOxcShQBFog8uPKE6+86eeoijqysy2RGAP6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXbyQ+/6McNx6XOrHDKr9vnNwpwajhsipBglzuTLxlVf3Ypc3mRGk1PsZOp9Npmuc
         PvbQY/U9I1noVOLzCKG/Rc68/hQ3bQzc6Lh6ySXRaeAdGDQ38ubcQR6z/JiweKLOIl
         CiGArjGM7CtjEZClcLSq3t04xq/f7epiyagr/qn8VI3ddsJ1opNH1F0ruSpdznb1/F
         33T8laf5U30ndMegErBsStj0mhEHJbfyBhLUEkEnUMqqgTgn2eCPMHYPXvDP8lHU/H
         wrnLlVxuQPHvZZsnutZ10+vPWSRPwVp2Q8yULRpV6k5tuhTW0uBc6ZQHQsoTwBiRWt
         63UKy5f+CH75Q==
Received: by mail-lf1-f45.google.com with SMTP id c24so11277271lfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 18:30:43 -0700 (PDT)
X-Gm-Message-State: AOAM533rMFY8t8OHN0na/WyFuWLwh+/BqCPB5m9xvEGxHIEttf9zXaBb
        5RBIbfPP9kQkUrhKUsf5wDrdtRCPq+iTNlKpXA4=
X-Google-Smtp-Source: ABdhPJw9OPdu/bMj6+nQcqx2Of0EJ7zweLdKgPop70koiNNTZpEc8HxMacnrohGa3cIHb1iRqhZg/sL2HKygJpeI0+c=
X-Received: by 2002:ac2:454f:: with SMTP id j15mr20404372lfm.555.1628559041654;
 Mon, 09 Aug 2021 18:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210807145537.124744-1-xianting.tian@linux.alibaba.com>
 <20210809003044.6692ddce@xhacker> <6a189d9d-b35d-3a15-5bfa-172c50e60c8c@linux.alibaba.com>
In-Reply-To: <6a189d9d-b35d-3a15-5bfa-172c50e60c8c@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 10 Aug 2021 09:30:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjBDF9cpN4J=ff2pCLXjc9uoBpfTzeTHhMAwg7OCShfA@mail.gmail.com>
Message-ID: <CAJF2gTTjBDF9cpN4J=ff2pCLXjc9uoBpfTzeTHhMAwg7OCShfA@mail.gmail.com>
Subject: Re: [PATCH] riscv: add ARCH_DMA_MINALIGN support
To:     Xianting TIan <xianting.tian@linux.alibaba.com>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 9:55 AM Xianting TIan
<xianting.tian@linux.alibaba.com> wrote:
>
>
> =E5=9C=A8 2021/8/9 =E4=B8=8A=E5=8D=8812:30, Jisheng Zhang =E5=86=99=E9=81=
=93:
> > On Sat,  7 Aug 2021 22:55:37 +0800
> > Xianting Tian <xianting.tian@linux.alibaba.com> wrote:
> >
> >> Introduce ARCH_DMA_MINALIGN to riscv arch.
> >>
> >> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> >> ---
> >>   arch/riscv/include/asm/cache.h | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/c=
ache.h
> >> index 9b58b1045..2945bbe2b 100644
> >> --- a/arch/riscv/include/asm/cache.h
> >> +++ b/arch/riscv/include/asm/cache.h
> >> @@ -11,6 +11,8 @@
> >>
> >>   #define L1_CACHE_BYTES             (1 << L1_CACHE_SHIFT)
> >>
> >> +#define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> > It's not a good idea to blindly set this for all riscv. For "coherent"
> > platforms, this is not necessary and will waste memory.

quote from slab.h:
 * Some archs want to perform DMA into kmalloc caches and need a guaranteed
 * alignment larger than the alignment of a 64-bit integer.
 * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.

ARCH_DMA_MINALIGN is for the whole system, maybe we could give a
DMA_MINALIGN Kconfig entry in arch/riscv?

> >
> thanks for the reply,
>
> So riscv is the "coherent" platform?
>
> I submit this patch as I got a fix suggestion of another patch to use
> ARCH_DMA_MINALIGN, but riscv doesn't define it.
>
> https://lkml.org/lkml/2021/8/6/723 <https://lkml.org/lkml/2021/8/6/723>
>
> Considering the portability of the code, in my opinion, it is better to
> define it for riscv if it is not "coherent" platform.
>
> >> +
> >>   /*
> >>    * RISC-V requires the stack pointer to be 16-byte aligned, so ensur=
e that
> >>    * the flat loader aligns it accordingly.



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
