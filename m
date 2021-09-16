Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7840D13A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhIPBeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhIPBeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 505E5611EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631755974;
        bh=EZUqyiFqMWPQYu1agznmvJd23FYTdk+UAyU6XzSvcJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EgNNAmpzu9i7yJm0cZHK36sBCBZmvB09twTwUwQ/F9YXaOLPfuUeXS62cDBa+vTaN
         iHJzAZVobHIGgOVNKKjGBJry1flwMlWSbKge7odewf+YAchywON8xk5IdzEgMQ2RUo
         k2AI66SXpdYKntCmTc5FI5IrYkU83p8Ubc0A/3AFEd5kVGXHiLPWhWAg7ImrVIyFUs
         ft3CoKW6COBxDLTvOSj8ZmjjmQfzJ7P7axkkTmUBjC6v3gIwfkpyfkbw1y2FIaApU9
         HHQoK45m9AlDkpDZrLhM59i8clNz5bQl16hMIGG2iaIqi+Mx1N8M+BWNJGSWQQf7K+
         tfFVNgYdqKOtA==
Received: by mail-lf1-f47.google.com with SMTP id i25so11916448lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:32:54 -0700 (PDT)
X-Gm-Message-State: AOAM531EDSHL3EidWrCGLIz+DGx+LESbQwjtD/YMiJikR7YDB6esy3Cf
        MnHVGK0jvVpIz5I3YdbtzV2qWPpl3HWw7eRbLxY=
X-Google-Smtp-Source: ABdhPJwLMtZmUEAMGSs3H9QZxFOEyu1LsKdSwSHV7UNOnFJABj6XzJsbEwUWd0CdAT/tmiokofKp1xCGyzxN/9m0Azk=
X-Received: by 2002:a05:651c:b0b:: with SMTP id b11mr2599411ljr.72.1631755972643;
 Wed, 15 Sep 2021 18:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210911092139.79607-1-guoren@kernel.org> <20210911092139.79607-5-guoren@kernel.org>
 <20210915075007.GD20024@lst.de>
In-Reply-To: <20210915075007.GD20024@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 16 Sep 2021 09:32:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSgbmff7aTjwTD+rhQroWeaXfjepGeEAmooBV6d4u70kg@mail.gmail.com>
Message-ID: <CAJF2gTSgbmff7aTjwTD+rhQroWeaXfjepGeEAmooBV6d4u70kg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 4/6] RISC-V: Implement arch_sync_dma* functions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Sep 11, 2021 at 05:21:37PM +0800, guoren@kernel.org wrote:
> > +static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> > +{
> > +     if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> > +             dma_cache_sync->cache_invalidate(paddr, size);
> > +     else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> > +             dma_cache_sync->cache_clean(paddr, size);
> > +     else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> > +             dma_cache_sync->cache_flush(paddr, size);
> > +}
>
> Despite various snipplets this is a still pretty much the broken previous
> versions.  These need to use the CMO instructions directly which are
> about to go into review, and then your SBI can trap on those can call
> whatever non-standard mess you're using.
I think you mean put an ALTERNATIVE slot in the prologue of __dma_sync?

#define ALT_DMA_SYNC()                                           \
asm(ALTERNATIVE(".rept 64\n nop\n .endr\n", "<vendor code>",
XXX_VENDOR_ID,        \
                ERRATA_XXX, CONFIG_ERRATA_XXX)  \
                : : : "memory")

static void __dma_sync(phys_addr_t paddr, size_t size, enum
dma_data_direction dir)
{
        ALT_DMA_SYNC();

        /* future cmo codes */
}




-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
