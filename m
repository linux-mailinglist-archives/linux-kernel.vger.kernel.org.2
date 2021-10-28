Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5443DBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJ1HPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:15:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52126
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhJ1HPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:15:47 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC3F03F177
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635405197;
        bh=odvfeEDaRD9GtVNTdM8NO1Yqau879jijgr+/mlFCwcA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SG2iTgh7c6spKgqgMTgh+SrMKJ4rhy5ZSVyCrZhprfI9sUa0ARNWxjN+7anJ050dz
         icglZblkbXvg86BX9dRq3tXo4j6/X6l6Mt4zPzxqzqzKAbHpuJtlLkT9PfH16RpJ+P
         DwvxctV6L6petw75K0IrMGoZEayFNzRqvHSM5qdLmpCQq8jZVn/GgSQ5j/OkDjbNYN
         wVtpGRv6Af97Gd8hM5ZSjJ0mHdBEud9RT1Bq2zjduMszj9+i9Bo30TFTBvh/52yrQj
         aqJwGtP/F4qdXnb3x5Cj3XbNsk+eI2ZoUXaLMp/DvJy0pOEaGZ+cxNltsz9pv7Fyij
         VW8RBChlUHN6w==
Received: by mail-ed1-f69.google.com with SMTP id f21-20020a0564021e9500b003dd77985601so4694955edf.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 00:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odvfeEDaRD9GtVNTdM8NO1Yqau879jijgr+/mlFCwcA=;
        b=XyHUmrnQFTt789bvf5WDH2BwZpY6eoPS/7/A0M2qCiNbTWb9XiMDF7z0thml5uVyHa
         AenRwIXhbBYeWNXB+50N+jCH6tzRosk4GA/1nKYj5rkTk3u75VJd1iCdK9CEnHZlvByG
         iSWvlQaColAd7fyybx869hU/vxg1SvGUSPXcKYLtZMsBCDqYs5tAI3t83z3FKU9vcsX6
         PiCpAiMh64TH/mpPE4l4Cv+ocgaUqUDh0chpooGpYJ2QHa8TXBDh7mMMwQVT1pO15ukS
         r51AfTCfsEI58iVEGrk6Kw0z+Hzmb6BWBOgHAh7M8NLnb/bzADLa1x6+jLzKfUYW1TOg
         5JCg==
X-Gm-Message-State: AOAM533cMK1nCFweMFD2wUyNGGBzbzHFam4bon7WhCzYAGN/siHk3tQQ
        57x4oGHAQ7/zMy5GRjHZ09WBhpbB6OIXzmOAnzJbbAe4XiSnxdsyyIgasjj4l2nT6obiGjbnSoe
        wVM1wfO9RTi8lvufQVp7PqquGi6Lu1jt2hkKeqhyt2vR/QPAwhY7wemPCeA==
X-Received: by 2002:a17:907:d22:: with SMTP id gn34mr3130409ejc.463.1635405197382;
        Thu, 28 Oct 2021 00:13:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk0nDAbtD9AECmNiTtn739UUuuAZr9AaFxmOTmd5txuEcfp070z9krdc2LVyf0o8fVCZ78hEjrwvUXJC465xw=
X-Received: by 2002:a17:907:d22:: with SMTP id gn34mr3130368ejc.463.1635405197149;
 Thu, 28 Oct 2021 00:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zEjCus8+jzn074GwqhJ54Y180RASr_YaC=6zdBZSzonEtjDA@mail.gmail.com>
 <mhng-3ac5b2b9-c9da-42e5-bc56-d779fb4dd1dd@palmerdabbelt-glaptop>
In-Reply-To: <mhng-3ac5b2b9-c9da-42e5-bc56-d779fb4dd1dd@palmerdabbelt-glaptop>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 28 Oct 2021 09:13:06 +0200
Message-ID: <CA+zEjCv+whmnL_SFf20j06NpikaMtA7MNQ9+o8Zz7=1_nAtTqw@mail.gmail.com>
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

On Thu, Oct 28, 2021 at 8:45 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 27 Oct 2021 22:34:32 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> > On Thu, Oct 28, 2021 at 7:30 AM Alexandre Ghiti
> > <alexandre.ghiti@canonical.com> wrote:
> >>
> >> On Thu, Oct 28, 2021 at 7:02 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >> >
> >> > On Wed, 27 Oct 2021 21:15:28 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> >> > > On Thu, Oct 28, 2021 at 1:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >> > >>
> >> > >> On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> >> > >> > Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
> >> > >> > Kconfig, it prevents asan-stack from getting disabled with clang even
> >> > >> > when CONFIG_KASAN_STACK is disabled: fix this by defining the
> >> > >> > corresponding config.
> >> > >> >
> >> > >> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> >> > >> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> >> > >> > ---
> >> > >> >  arch/riscv/Kconfig             | 6 ++++++
> >> > >> >  arch/riscv/include/asm/kasan.h | 3 +--
> >> > >> >  arch/riscv/mm/kasan_init.c     | 3 +++
> >> > >> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >> > >> >
> >> > >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> > >> > index c1abbc876e5b..79250b1ed54e 100644
> >> > >> > --- a/arch/riscv/Kconfig
> >> > >> > +++ b/arch/riscv/Kconfig
> >> > >> > @@ -162,6 +162,12 @@ config PAGE_OFFSET
> >> > >> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> >> > >> >       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> >> > >> >
> >> > >> > +config KASAN_SHADOW_OFFSET
> >> > >> > +     hex
> >> > >> > +     depends on KASAN_GENERIC
> >> > >> > +     default 0xdfffffc800000000 if 64BIT
> >> > >> > +     default 0xffffffff if 32BIT
> >> > >>
> >> > >> I thought I posted this somewhere, but this is exactly what my first
> >> > >> guess was.  The problem is that it's hanging on boot for me.  I don't
> >> > >> really have anything exotic going on, it's just a defconfig with
> >> > >> CONFIG_KASAN=y running in QEMU.
> >> > >>
> >> > >> Does this boot for you?
> >> > >
> >> > > Yes with the 2nd patch of this series which fixes the issue
> >> > > encountered here. And that's true I copied/pasted this part of your
> >> > > patch which was better than what I had initially done, sorry I should
> >> > > have mentioned you did that, please add a Codeveloped-by or something
> >> > > like that.
>
> OK, those should probably be in the opposite order (though it looks like
> they're inter-dependent, which makes things a bit trickier).
>
> >> >
> >> > Not sure if I'm missing something, but it's still not booting for me.
> >> > I've put what I'm testing on palmer/to-test, it's these two on top of
> >> > fixes and merged into Linus' tree
> >> >
> >> >     *   6d7d351902ff - (HEAD -> to-test, palmer/to-test) Merge remote-tracking branch 'palmer/fixes' into to-test (7 minutes ago) <Palmer Dabbelt>
> >> >     |\
> >> >     | * 782551edf8f8 - (palmer/fixes) riscv: Fix CONFIG_KASAN_STACK build (6 hours ago) <Alexandre Ghiti>
> >> >     | * 47383e5b3c4f - riscv: Fix asan-stack clang build (6 hours ago) <Alexandre Ghiti>
> >> >     | * 64a19591a293 - (riscv/fixes) riscv: fix misalgned trap vector base address (9 hours ago) <Chen Lu>
> >> >     * |   1fc596a56b33 - (palmer/master, linus/master, linus/HEAD, master) Merge tag 'trace-v5.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (11 hours ago) <Linus Torvalds>
> >> >
> >> > Am I missing something else?
> >>
> >> Hmm, that's weird, I have just done the same: cherry-picked both my
> >> commits on top of fixes (64a19591a293) and it boots fine with KASAN
> >> enabled. Maybe a config thing? I pushed my branch here:
> >> https://github.com/AlexGhiti/riscv-linux/tree/int/alex/kasan_stack_fixes_rebase
> >
> > I pushed the config I use and that boots in that branch, maybe there's
> > another issue somewhere.
>
> CONFIG_KASAN_VMALLOC=n is what's causing the failure.  I'm testing both
> polarities of that, looks like your config has =y.  I haven't looked any
> further as I'm pretty much cooked for tonight, but if you don't have
> time then I'll try to find some time tomorrow.
>

Arf, that was obvious and just under my nose: without KASAN_VMALLOC,
kasan_populate_early_shadow is called and creates the same issue that
the second patch fixes.

I'll send a v2 today and try to swap both patches to avoid having a
non-bootable kernel commit.

Alex

> >
> >>
> >> >
> >> > >
> >> > > Thanks,
> >> > >
> >> > > Alex
> >> > >
> >> > >>
> >> > >> > +
> >> > >> >  config ARCH_FLATMEM_ENABLE
> >> > >> >       def_bool !NUMA
> >> > >> >
> >> > >> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> >> > >> > index a2b3d9cdbc86..b00f503ec124 100644
> >> > >> > --- a/arch/riscv/include/asm/kasan.h
> >> > >> > +++ b/arch/riscv/include/asm/kasan.h
> >> > >> > @@ -30,8 +30,7 @@
> >> > >> >  #define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
> >> > >> >  #define KASAN_SHADOW_START   KERN_VIRT_START
> >> > >> >  #define KASAN_SHADOW_END     (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> >> > >> > -#define KASAN_SHADOW_OFFSET  (KASAN_SHADOW_END - (1ULL << \
> >> > >> > -                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
> >> > >> > +#define KASAN_SHADOW_OFFSET  _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> >> > >> >
> >> > >> >  void kasan_init(void);
> >> > >> >  asmlinkage void kasan_early_init(void);
> >> > >> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> >> > >> > index d7189c8714a9..8175e98b9073 100644
> >> > >> > --- a/arch/riscv/mm/kasan_init.c
> >> > >> > +++ b/arch/riscv/mm/kasan_init.c
> >> > >> > @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
> >> > >> >       uintptr_t i;
> >> > >> >       pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
> >> > >> >
> >> > >> > +     BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
> >> > >> > +             KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
> >> > >> > +
> >> > >> >       for (i = 0; i < PTRS_PER_PTE; ++i)
> >> > >> >               set_pte(kasan_early_shadow_pte + i,
> >> > >> >                       mk_pte(virt_to_page(kasan_early_shadow_page),
