Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1B40D30C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhIPGLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhIPGLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:11:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36D9D611EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631772588;
        bh=WpCTyflIvR2GCah2tu1TLBIUfnLMEvfUIk5rmhHFD3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LDvNNowUHWWkhpO5L9nq7efRWsTq9iSl+yV0Rf5J3BSRjKAT/kwIqyu8naFu/+mYR
         j2fSHCiUY5g9dGskbS5Nqj5H25OE0qGzpX2RKEUdUErUmNttyz1q10wxun422JmluE
         s1dEqLVu9XP37wlqAqNkbqS9vGpRrl4GPm1NLXfFNS/stX+WfFNgDL8iK73VTgMLEU
         7raRryO8CrP4kcKA2nwbssbj/d2oc3w+czKhFTrQQ/eVEQ3sBcSsd/WaP8FvCUw2mF
         ILsB6ay95t7hNs961Ar/D5uBTvPgqG+6greVXFYlVnLV2ok7MlTvxsWjRBq/ZkMVmU
         Uoz7uOz76n4EQ==
Received: by mail-lf1-f49.google.com with SMTP id x27so14088811lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:09:48 -0700 (PDT)
X-Gm-Message-State: AOAM533W0TK7NycapcIiKWE20+VPC+S0MBN/wO/zNPQZym91SUgdrioJ
        TsWLvyOeFdXroWc+eeFu1xQnIPW6POC/jabP1nE=
X-Google-Smtp-Source: ABdhPJyQKLWWyvgHdFEFDT/acgjD6ikFrjGMpQuRznVMMp6RoNUEL9fsKLoz+Yx0T6A5C1Hp4yPnF01bRX6yFhfDO0A=
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr2060364lfu.637.1631772586518;
 Wed, 15 Sep 2021 23:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-4-guoren@kernel.org>
 <20210915074827.GC20024@lst.de> <CAJF2gTSZLieg1kYA6a0CPajPukHzwN0wvPuh4RQ-t45fciFOYA@mail.gmail.com>
 <CAOnJCULyEHdyr9=Ez-NxRGKow3_RbNym_wg9RcZGWv-vJ-0B9Q@mail.gmail.com>
In-Reply-To: <CAOnJCULyEHdyr9=Ez-NxRGKow3_RbNym_wg9RcZGWv-vJ-0B9Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 16 Sep 2021 14:09:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRS=6i6zgdM8-WsdrzbiSrQkrmu+Xx-h6D4puKZqu1ruQ@mail.gmail.com>
Message-ID: <CAJF2gTRS=6i6zgdM8-WsdrzbiSrQkrmu+Xx-h6D4puKZqu1ruQ@mail.gmail.com>
Subject: Re: [RFC PATCH V4 3/6] RISC-V: Support a new config option for
 non-coherent DMA
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:39 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Sep 15, 2021 at 6:21 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Wed, Sep 15, 2021 at 3:48 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Sat, Sep 11, 2021 at 05:21:36PM +0800, guoren@kernel.org wrote:
> > > > +     select DMA_GLOBAL_POOL
> > > > +     select DMA_DIRECT_REMAP
> > >
> > > No need to select DMA_GLOBAL_POOL when DMA_DIRECT_REMAP is select.
> > If we want to support PBMT & global_dma_pool both in riscv. Could they
> > work together in arch/riscv with [1]?
>
> We don't have to worry about it as the next version of my series will
> use the simpler
> dma_uncached functionality to support uncached window approach taken
> by starlight socs.
Sounds good, thx.

>
> I was supposed to send it sooner but got busy with PMU stuff and a bad flu :(.
Take good care of yourself and hope you feel better soon.

>
> >
> > [1]: https://lore.kernel.org/lkml/20210818142715.GA10755@lst.de/T/
> >
> > >
> > > Also a patch just to add a option that is not selected and won't build
> > > if selected does not make sense.
> > I just want to rebase on Atish's patch and append DMA_DIRECT_REMAP.
> > Okay, DMA_DIRECT_REMAP & DMA_GLOBAL_POOL should be separated from the
> > patch.
> >
> >
> >
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -156,9 +156,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >
> >   if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> >      !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > +    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> >      !dev_is_dma_coherent(dev))
> >   return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
> >
> > + if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> > +    !dev_is_dma_coherent(dev))
> > + return dma_alloc_from_global_coherent(dev, size, dma_handle);
> > +
> >   /*
> >   * Remapping or decrypting memory may block. If either is required and
> >   * we can't block, allocate the memory from the atomic pools.
> > @@ -255,11 +260,19 @@ void dma_direct_free(struct device *dev, size_t size,
> >
> >   if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> >      !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > +    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> >      !dev_is_dma_coherent(dev)) {
> >   arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
> >   return;
> >   }
> >
> > + if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> > +    !dev_is_dma_coherent(dev)) {
> > + if (!dma_release_from_global_coherent(page_order, cpu_addr))
> > + WARN_ON_ONCE(1);
> > + return;
> > + }
> > +
> > Here CONFIG_DMA_GLOBAL_POOL is independent from CONFIG_DMA_DIRECT_REMAP.
> >
> >   /* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
> >   if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> >      dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
