Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40343DACA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhJ1FhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:37:12 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50344
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhJ1FhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:37:11 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 751183F165
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635399284;
        bh=lNwK2X60c7f9X7KPf6h2ScbG4X9q5dg3Bv4L43p8gyc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=VR6NgBZSdn17dt4WZtBnwIcF+UYQO4Fy2DIfnhwzmgrJ9siB0Dtkdqls7jzpXcMIq
         eeuYzrkajXBEH5x0v0avekOhFu5Bo/D9LdNf0FMfCH//9kdpyjnIplIqUHhAMGUYL6
         6lUfcCMbPy4asWiWNuUl85L1awn0cKsg75dd1RDhEnEeqP9BJn4Z5vBuLVySxtIruV
         aLB6wBd3IJ5Moxer0r5/gx9eXbGxdnqSVmpgDTZG3akB6m8OSSsiq7wFygdFlcwcIi
         HnaaXG7kXtR10ZkzlmH0FYMHz+cZD4gloob3jv4LpqyNi/vp2w+bPnHyljYPxlxiL3
         Jirda2nj0FLMw==
Received: by mail-ed1-f69.google.com with SMTP id f4-20020a50e084000000b003db585bc274so4444442edl.17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 22:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNwK2X60c7f9X7KPf6h2ScbG4X9q5dg3Bv4L43p8gyc=;
        b=YaWdoTCJFWrjWW67UlMPVparNmy8mgnF5F/ufb23C8lk4eNbGSbfOcJXKTz5CD5Pt0
         Yv6i7LCJOhHyaCPB0dWC67eC6egm2YuQ+8mskz1lXOpbgS2W3qutSQJx0J9mdXqaW35T
         z2hrurzklcHDQVuBcUwMlshVFqi/4nCrnj/bfxuFRxjTQaCxMJeBL9sy5kXpvV/5JQr6
         Bnw6KTKK4gEMvVmO6yZwAnw+sIB5zB7y7yxKZ5ehEobLZwbuucWECbM8uquol40B9S5I
         2GS8qywYzfMshMhFlVfZ7nVsvI21rqdOCIIcAx5DnBWBinUWUbTPvoMswpFQZL/NtgSL
         DGhA==
X-Gm-Message-State: AOAM533PvR6UAHkC1GTvNMTLIcMEjGNZ12FDXNN4XdJp1ZbBKzr3ESN9
        Q0wRgZTPDtiGtnMYucgXiEBBttr0vDGmuDozBJBPyr16WwwhPNx8tiw2PMdt0NS+fXCHqlnKf0j
        rDsPs5hCeFrSq90ozcZRFZVYadF7pWaJVfaEo32dyyW0KQ9aXcZUlkiLIMQ==
X-Received: by 2002:a17:907:d22:: with SMTP id gn34mr2588261ejc.463.1635399284146;
        Wed, 27 Oct 2021 22:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlcFK3g0aghHl1OqGtK1Bhn/y6XrnUQws1ghf+7gXW2GywHn20ADq7fIm32Iz1kaJxVTbcmDaMD6qhdD4uHhc=
X-Received: by 2002:a17:907:d22:: with SMTP id gn34mr2588238ejc.463.1635399283919;
 Wed, 27 Oct 2021 22:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zEjCuUCxqTtbox2K8c=ymHC8X97LV6CSO3ydJKgRR9cBXUEw@mail.gmail.com>
 <mhng-897d082f-5ca4-4d77-a69d-4efaa456bf3b@palmerdabbelt-glaptop> <CA+zEjCvF7yCbA9KvsD+OaGXhEAF4x_jBB+OZ3C-Q6RctYSjd7w@mail.gmail.com>
In-Reply-To: <CA+zEjCvF7yCbA9KvsD+OaGXhEAF4x_jBB+OZ3C-Q6RctYSjd7w@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 28 Oct 2021 07:34:32 +0200
Message-ID: <CA+zEjCus8+jzn074GwqhJ54Y180RASr_YaC=6zdBZSzonEtjDA@mail.gmail.com>
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

On Thu, Oct 28, 2021 at 7:30 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Thu, Oct 28, 2021 at 7:02 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Wed, 27 Oct 2021 21:15:28 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> > > On Thu, Oct 28, 2021 at 1:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >>
> > >> On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> > >> > Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
> > >> > Kconfig, it prevents asan-stack from getting disabled with clang even
> > >> > when CONFIG_KASAN_STACK is disabled: fix this by defining the
> > >> > corresponding config.
> > >> >
> > >> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > >> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > >> > ---
> > >> >  arch/riscv/Kconfig             | 6 ++++++
> > >> >  arch/riscv/include/asm/kasan.h | 3 +--
> > >> >  arch/riscv/mm/kasan_init.c     | 3 +++
> > >> >  3 files changed, 10 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > >> > index c1abbc876e5b..79250b1ed54e 100644
> > >> > --- a/arch/riscv/Kconfig
> > >> > +++ b/arch/riscv/Kconfig
> > >> > @@ -162,6 +162,12 @@ config PAGE_OFFSET
> > >> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> > >> >       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> > >> >
> > >> > +config KASAN_SHADOW_OFFSET
> > >> > +     hex
> > >> > +     depends on KASAN_GENERIC
> > >> > +     default 0xdfffffc800000000 if 64BIT
> > >> > +     default 0xffffffff if 32BIT
> > >>
> > >> I thought I posted this somewhere, but this is exactly what my first
> > >> guess was.  The problem is that it's hanging on boot for me.  I don't
> > >> really have anything exotic going on, it's just a defconfig with
> > >> CONFIG_KASAN=y running in QEMU.
> > >>
> > >> Does this boot for you?
> > >
> > > Yes with the 2nd patch of this series which fixes the issue
> > > encountered here. And that's true I copied/pasted this part of your
> > > patch which was better than what I had initially done, sorry I should
> > > have mentioned you did that, please add a Codeveloped-by or something
> > > like that.
> >
> > Not sure if I'm missing something, but it's still not booting for me.
> > I've put what I'm testing on palmer/to-test, it's these two on top of
> > fixes and merged into Linus' tree
> >
> >     *   6d7d351902ff - (HEAD -> to-test, palmer/to-test) Merge remote-tracking branch 'palmer/fixes' into to-test (7 minutes ago) <Palmer Dabbelt>
> >     |\
> >     | * 782551edf8f8 - (palmer/fixes) riscv: Fix CONFIG_KASAN_STACK build (6 hours ago) <Alexandre Ghiti>
> >     | * 47383e5b3c4f - riscv: Fix asan-stack clang build (6 hours ago) <Alexandre Ghiti>
> >     | * 64a19591a293 - (riscv/fixes) riscv: fix misalgned trap vector base address (9 hours ago) <Chen Lu>
> >     * |   1fc596a56b33 - (palmer/master, linus/master, linus/HEAD, master) Merge tag 'trace-v5.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (11 hours ago) <Linus Torvalds>
> >
> > Am I missing something else?
>
> Hmm, that's weird, I have just done the same: cherry-picked both my
> commits on top of fixes (64a19591a293) and it boots fine with KASAN
> enabled. Maybe a config thing? I pushed my branch here:
> https://github.com/AlexGhiti/riscv-linux/tree/int/alex/kasan_stack_fixes_rebase

I pushed the config I use and that boots in that branch, maybe there's
another issue somewhere.

>
> >
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > >>
> > >> > +
> > >> >  config ARCH_FLATMEM_ENABLE
> > >> >       def_bool !NUMA
> > >> >
> > >> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> > >> > index a2b3d9cdbc86..b00f503ec124 100644
> > >> > --- a/arch/riscv/include/asm/kasan.h
> > >> > +++ b/arch/riscv/include/asm/kasan.h
> > >> > @@ -30,8 +30,7 @@
> > >> >  #define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
> > >> >  #define KASAN_SHADOW_START   KERN_VIRT_START
> > >> >  #define KASAN_SHADOW_END     (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> > >> > -#define KASAN_SHADOW_OFFSET  (KASAN_SHADOW_END - (1ULL << \
> > >> > -                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
> > >> > +#define KASAN_SHADOW_OFFSET  _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> > >> >
> > >> >  void kasan_init(void);
> > >> >  asmlinkage void kasan_early_init(void);
> > >> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> > >> > index d7189c8714a9..8175e98b9073 100644
> > >> > --- a/arch/riscv/mm/kasan_init.c
> > >> > +++ b/arch/riscv/mm/kasan_init.c
> > >> > @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
> > >> >       uintptr_t i;
> > >> >       pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
> > >> >
> > >> > +     BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
> > >> > +             KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
> > >> > +
> > >> >       for (i = 0; i < PTRS_PER_PTE; ++i)
> > >> >               set_pte(kasan_early_shadow_pte + i,
> > >> >                       mk_pte(virt_to_page(kasan_early_shadow_page),
