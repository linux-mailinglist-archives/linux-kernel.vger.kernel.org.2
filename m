Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C051643DA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 06:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhJ1ESL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 00:18:11 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49084
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1ESK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 00:18:10 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3C9043F174
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 04:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635394541;
        bh=5LeZ4qJd1/I0CO3BOhH9jstVrpNoI/oz+UiYuO/v2Z4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=M3QmDFDwvvxEKZsitSwgvH7RdmxBISRHqSZCqlCQnf2VVpw7vkRNELZT8dvSb82ot
         kb0G12MllAK4SCCWL/BhvSruPA/rvUzBEobwX034PZYfIH5omvdKcPeNPtl5ILNKRs
         PaYNfDx+8a2jnOA4hpHd4nvtb+650WhUpqst+sk5obgoCaUTc4oK+IG0ywIrIo4WDJ
         gBHwIncONMSSWHd+HhsLFjI7MdL6zdYykfM+wJSA/A0KFBQFLnKOe32SI+WjOzHZzN
         rdyzGrSJt/gsjEBAFreo7ak2PJQRrk1YrUweGPcii/U706dZJ3YGyqUpZMTlkl/mmP
         0VDnqirforEtw==
Received: by mail-ed1-f70.google.com with SMTP id s18-20020a056402521200b003dd5902f4f3so4279701edd.23
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 21:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LeZ4qJd1/I0CO3BOhH9jstVrpNoI/oz+UiYuO/v2Z4=;
        b=mEn6dO7CG90m5YlaaU8EOgCyrUo7uvRxPPlNiBSZ4k0C1ySVJWQPX2leMcy59s0H7i
         GIQWOzZdeaeiPZ9dMhesz8d8XMLN2RBg4+cSrB0J5dKO0v8QxlrWHtm+BiuX//ceJxTR
         dB1+a4iTfl/mB2TMGYs9UXd5CDuCGdiUL477n777QdFHVK2SXhd8wnyVgvxjaoNZKQ7m
         Ioa1VpChxQ8kG/4+bKL1Q0VEfTRHhchw1O1UHOOohn64myf2gwtO8Kru1eKUGO1IUTZk
         Auth/6bu0lEENz84VmAfCf5f7cJ8GEoqUnnseaKh9A43QO54j5ckwK6jx7VoOjSpo2u4
         ZHFw==
X-Gm-Message-State: AOAM533KYeCRh4MdoywY8sfbZMPgNmDsm0p9Pfxz2LmhOjaJuVYMU+3F
        wdwa+6DTS8ApF7TsFTRUc5OAKwnhc3nv1h/nd2EEsHxnCmuLzhCx+YJCbMGC/jIOuioiUz5zVPc
        LoEegfIJ2t9vDE4TpZfRFUtdlLLzMF+wmliD/6DzHTEswYH/cWaRNyliTKQ==
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr2785990edb.190.1635394540861;
        Wed, 27 Oct 2021 21:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZi39J2kwik0RQhOm5p9MLjprDz5OI4qGnklGMEHC/w9pQt4Nm/adBkMjvmLJBYtF/TOSO3uDCvbbjc4taCh8=
X-Received: by 2002:a05:6402:cb8:: with SMTP id cn24mr2785968edb.190.1635394540704;
 Wed, 27 Oct 2021 21:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211027045843.1770770-1-alexandre.ghiti@canonical.com> <mhng-41b64d3e-5a5a-4d59-86fc-80f2148823e8@palmerdabbelt-glaptop>
In-Reply-To: <mhng-41b64d3e-5a5a-4d59-86fc-80f2148823e8@palmerdabbelt-glaptop>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 28 Oct 2021 06:15:28 +0200
Message-ID: <CA+zEjCuUCxqTtbox2K8c=ymHC8X97LV6CSO3ydJKgRR9cBXUEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Fix asan-stack clang build
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 1:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> > Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
> > Kconfig, it prevents asan-stack from getting disabled with clang even
> > when CONFIG_KASAN_STACK is disabled: fix this by defining the
> > corresponding config.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > ---
> >  arch/riscv/Kconfig             | 6 ++++++
> >  arch/riscv/include/asm/kasan.h | 3 +--
> >  arch/riscv/mm/kasan_init.c     | 3 +++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index c1abbc876e5b..79250b1ed54e 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -162,6 +162,12 @@ config PAGE_OFFSET
> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> >       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> >
> > +config KASAN_SHADOW_OFFSET
> > +     hex
> > +     depends on KASAN_GENERIC
> > +     default 0xdfffffc800000000 if 64BIT
> > +     default 0xffffffff if 32BIT
>
> I thought I posted this somewhere, but this is exactly what my first
> guess was.  The problem is that it's hanging on boot for me.  I don't
> really have anything exotic going on, it's just a defconfig with
> CONFIG_KASAN=y running in QEMU.
>
> Does this boot for you?

Yes with the 2nd patch of this series which fixes the issue
encountered here. And that's true I copied/pasted this part of your
patch which was better than what I had initially done, sorry I should
have mentioned you did that, please add a Codeveloped-by or something
like that.

Thanks,

Alex

>
> > +
> >  config ARCH_FLATMEM_ENABLE
> >       def_bool !NUMA
> >
> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> > index a2b3d9cdbc86..b00f503ec124 100644
> > --- a/arch/riscv/include/asm/kasan.h
> > +++ b/arch/riscv/include/asm/kasan.h
> > @@ -30,8 +30,7 @@
> >  #define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
> >  #define KASAN_SHADOW_START   KERN_VIRT_START
> >  #define KASAN_SHADOW_END     (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> > -#define KASAN_SHADOW_OFFSET  (KASAN_SHADOW_END - (1ULL << \
> > -                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
> > +#define KASAN_SHADOW_OFFSET  _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> >
> >  void kasan_init(void);
> >  asmlinkage void kasan_early_init(void);
> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> > index d7189c8714a9..8175e98b9073 100644
> > --- a/arch/riscv/mm/kasan_init.c
> > +++ b/arch/riscv/mm/kasan_init.c
> > @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
> >       uintptr_t i;
> >       pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
> >
> > +     BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
> > +             KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
> > +
> >       for (i = 0; i < PTRS_PER_PTE; ++i)
> >               set_pte(kasan_early_shadow_pte + i,
> >                       mk_pte(virt_to_page(kasan_early_shadow_page),
