Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9073943DABF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1Fdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:33:38 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50268
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhJ1Fdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:33:37 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C82F33F178
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635399069;
        bh=noNS8SKbWs06fUT37mVtwhaSupIHvr5prwGIHsMJYxw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XmNKvwNbWLK+bOP6uiq6HEv6d6Qd/y30OZ9bsCt0jonBZtcm/UNvBUFX+pa2FDf6z
         /6lWe8ND2SfjrUhHu4Md980Nos75tsMm4ku9Ws6DDzYwzrZREZS4STgy1tktTLpqs4
         Lpt8px1vE2u6Hy4Gewk3E7qakXRF4bW6jz8teaRbr9IB9aMBWHjdPg331Chdc2dZim
         Extoedj44x7naj3ubHGM0igiAUecT5V1Ldc6dZ/LUw/MjiblQmSLvI45iy/CuSArTt
         4alfsb9Aak791wJ16LXQFMpuEtiuQZo8VSZgOLMqV8TS1ztORXY5ckbtGmL7+Qec1Q
         8NEZmjAf+QNmw==
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a05640250d000b003dd8167857aso4521350edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 22:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noNS8SKbWs06fUT37mVtwhaSupIHvr5prwGIHsMJYxw=;
        b=lGbKhb83Nqwrvua553GlmmYKQ4OCK6LZGx92QG0rR3sklEWa975yuPqSTI93ZuPgJV
         mkCdPuhR4k0zAB7XZq5tL32StrvLLYlknV56vLEhfz07JOu+hrTMoHl90l+ed46h6XzV
         sVX7XcYl2tl5c3lY0OvjoRKn1Nog+VKJF1IrRx+ueFq8EN0B+DA9s2UKC9Z1s3TKAM17
         nrnV3Q1KVLGCv8XzufAfmToFKGEFU/T/ap0Ni2XPJ+N9mFk/R8gSqyg0e2aZ/dpNObnf
         h+f2I8XY/46awFdEfzVjVzqK8kc7ybVqrYkYqsufL8CERIMUNCiWQ7clHJfgIHTB7JOG
         llcg==
X-Gm-Message-State: AOAM531KjCpMur9nR8aPVr2gUqhmS8QTkvWAMj6hJglMn5v1dKCnk6QT
        IUqkC6fZ8YbWg6L5i6MZOuuNvXyIG4IOlduz/tL+apNpGHQfXOVkwpjSNXYfuvnn/DG7PLNWsCE
        N52w0haGlhIiZ47/91YigG73z8tZJ9KAP5KAaWZE+UlPIg9gV7v3j7+zd4g==
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr3208497edz.20.1635399069429;
        Wed, 27 Oct 2021 22:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEUJQkO9YMhMwSNt7uEYM8v75MpFk32+ztyU/ggxjoL6rKZE/Q857v/2Xu8+SA5aTcN9XFyBw7AWTV/dWC93U=
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr3208483edz.20.1635399069250;
 Wed, 27 Oct 2021 22:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zEjCuUCxqTtbox2K8c=ymHC8X97LV6CSO3ydJKgRR9cBXUEw@mail.gmail.com>
 <mhng-897d082f-5ca4-4d77-a69d-4efaa456bf3b@palmerdabbelt-glaptop>
In-Reply-To: <mhng-897d082f-5ca4-4d77-a69d-4efaa456bf3b@palmerdabbelt-glaptop>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 28 Oct 2021 07:30:58 +0200
Message-ID: <CA+zEjCvF7yCbA9KvsD+OaGXhEAF4x_jBB+OZ3C-Q6RctYSjd7w@mail.gmail.com>
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

On Thu, Oct 28, 2021 at 7:02 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 27 Oct 2021 21:15:28 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> > On Thu, Oct 28, 2021 at 1:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> >> > Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
> >> > Kconfig, it prevents asan-stack from getting disabled with clang even
> >> > when CONFIG_KASAN_STACK is disabled: fix this by defining the
> >> > corresponding config.
> >> >
> >> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> >> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> >> > ---
> >> >  arch/riscv/Kconfig             | 6 ++++++
> >> >  arch/riscv/include/asm/kasan.h | 3 +--
> >> >  arch/riscv/mm/kasan_init.c     | 3 +++
> >> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> > index c1abbc876e5b..79250b1ed54e 100644
> >> > --- a/arch/riscv/Kconfig
> >> > +++ b/arch/riscv/Kconfig
> >> > @@ -162,6 +162,12 @@ config PAGE_OFFSET
> >> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> >> >       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> >> >
> >> > +config KASAN_SHADOW_OFFSET
> >> > +     hex
> >> > +     depends on KASAN_GENERIC
> >> > +     default 0xdfffffc800000000 if 64BIT
> >> > +     default 0xffffffff if 32BIT
> >>
> >> I thought I posted this somewhere, but this is exactly what my first
> >> guess was.  The problem is that it's hanging on boot for me.  I don't
> >> really have anything exotic going on, it's just a defconfig with
> >> CONFIG_KASAN=y running in QEMU.
> >>
> >> Does this boot for you?
> >
> > Yes with the 2nd patch of this series which fixes the issue
> > encountered here. And that's true I copied/pasted this part of your
> > patch which was better than what I had initially done, sorry I should
> > have mentioned you did that, please add a Codeveloped-by or something
> > like that.
>
> Not sure if I'm missing something, but it's still not booting for me.
> I've put what I'm testing on palmer/to-test, it's these two on top of
> fixes and merged into Linus' tree
>
>     *   6d7d351902ff - (HEAD -> to-test, palmer/to-test) Merge remote-tracking branch 'palmer/fixes' into to-test (7 minutes ago) <Palmer Dabbelt>
>     |\
>     | * 782551edf8f8 - (palmer/fixes) riscv: Fix CONFIG_KASAN_STACK build (6 hours ago) <Alexandre Ghiti>
>     | * 47383e5b3c4f - riscv: Fix asan-stack clang build (6 hours ago) <Alexandre Ghiti>
>     | * 64a19591a293 - (riscv/fixes) riscv: fix misalgned trap vector base address (9 hours ago) <Chen Lu>
>     * |   1fc596a56b33 - (palmer/master, linus/master, linus/HEAD, master) Merge tag 'trace-v5.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (11 hours ago) <Linus Torvalds>
>
> Am I missing something else?

Hmm, that's weird, I have just done the same: cherry-picked both my
commits on top of fixes (64a19591a293) and it boots fine with KASAN
enabled. Maybe a config thing? I pushed my branch here:
https://github.com/AlexGhiti/riscv-linux/tree/int/alex/kasan_stack_fixes_rebase

>
> >
> > Thanks,
> >
> > Alex
> >
> >>
> >> > +
> >> >  config ARCH_FLATMEM_ENABLE
> >> >       def_bool !NUMA
> >> >
> >> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> >> > index a2b3d9cdbc86..b00f503ec124 100644
> >> > --- a/arch/riscv/include/asm/kasan.h
> >> > +++ b/arch/riscv/include/asm/kasan.h
> >> > @@ -30,8 +30,7 @@
> >> >  #define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
> >> >  #define KASAN_SHADOW_START   KERN_VIRT_START
> >> >  #define KASAN_SHADOW_END     (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> >> > -#define KASAN_SHADOW_OFFSET  (KASAN_SHADOW_END - (1ULL << \
> >> > -                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
> >> > +#define KASAN_SHADOW_OFFSET  _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> >> >
> >> >  void kasan_init(void);
> >> >  asmlinkage void kasan_early_init(void);
> >> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> >> > index d7189c8714a9..8175e98b9073 100644
> >> > --- a/arch/riscv/mm/kasan_init.c
> >> > +++ b/arch/riscv/mm/kasan_init.c
> >> > @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
> >> >       uintptr_t i;
> >> >       pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
> >> >
> >> > +     BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
> >> > +             KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
> >> > +
> >> >       for (i = 0; i < PTRS_PER_PTE; ++i)
> >> >               set_pte(kasan_early_shadow_pte + i,
> >> >                       mk_pte(virt_to_page(kasan_early_shadow_page),
