Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4143E4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJ1PNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhJ1PNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:13:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C98C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:11:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x7so1258844pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=259aXqiOnA5iWuUV4ETs5uC0oUlsrJdMmweeqlD6Flw=;
        b=FSE7WAV8W97zgFBcxdpzW8qW6M4y5zLcv98iJDuq/vvHWgDfXsqVXKXCpuHZotL7Mg
         Ie3ZPWMKBqGUy6jF5Hg+dCQfBXlSRIWLMh9AbOrkraAM6pJDNwkDfuqlNnULGZhQeCZQ
         JpRFu0QBrCpzg8FzzgEm5jdfVtoME+pTfxYPXjpSIuo68ZXU4Pp/uNLUjaMO7Uvk9MzO
         VRWtxYVGNm0xrDpc1VJ3QogOPi2SNcx7ym6EQTr2dlDn7Se9TYgZkZuRBxwUB2VJ4GuM
         HQ+LXIjfLQHWkeACsjm+70PRgXVFmfPNcEF4Hq/wtI6dEMAo77D23kG+vuNlPYCk/PAz
         ViTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=259aXqiOnA5iWuUV4ETs5uC0oUlsrJdMmweeqlD6Flw=;
        b=iawknWa54rxwvzMi5Jt3nPGY6+tfRCh2YJ2Vf0LhPwjNLLtOXGtGIIp+T46vuLRTI9
         ey/uOgROkMcUxyum5PhD4Jx1e0nZMQH22nzAxSDE5RKtIY+4sEKSEwq+iCyqaN1sHhcv
         diFqAuOdHBKPetx3IsIBcjiVYZe/HHNXcCLVSwz1sL7vBbbQmc/hW/JQGKxYwDMtLZEw
         89zPJmXuNh2v+XPcPkZJ6/oNMGBpTgI36Lc8PLDeo9sNZmFFCuYFVeu1B5vhweT1xSmI
         MBTzK8CnqotMsGkq+U9EINAF0C57iXrIMY69DznsZWVUNDd38nNyuTIQzpbNCSKVdofe
         VMHw==
X-Gm-Message-State: AOAM533UFW6n/QaIVRwfRBfpYJpcTELq6A78BJovGPiVcKifXC9AUqZr
        FGDPYcGXv5/rvPWYu/u1F5HP6A==
X-Google-Smtp-Source: ABdhPJwKglkHjgwMStiVm2swRxL2R5ugLP4vxahA1WyfTlvuNO3MAlOeWJ5SytvsYU+mCPBpiPv54g==
X-Received: by 2002:a63:3446:: with SMTP id b67mr3614765pga.258.1635433871085;
        Thu, 28 Oct 2021 08:11:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f14sm2956300pfv.5.2021.10.28.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:11:10 -0700 (PDT)
Date:   Thu, 28 Oct 2021 08:11:10 -0700 (PDT)
X-Google-Original-Date: Thu, 28 Oct 2021 08:11:05 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Fix asan-stack clang build
In-Reply-To: <CA+zEjCv+whmnL_SFf20j06NpikaMtA7MNQ9+o8Zz7=1_nAtTqw@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        nathan@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-4c43fe14-f36b-4232-a316-530a4d041d49@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 00:13:06 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> On Thu, Oct 28, 2021 at 8:45 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 27 Oct 2021 22:34:32 PDT (-0700), alexandre.ghiti@canonical.com wrote:
>> > On Thu, Oct 28, 2021 at 7:30 AM Alexandre Ghiti
>> > <alexandre.ghiti@canonical.com> wrote:
>> >>
>> >> On Thu, Oct 28, 2021 at 7:02 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >> >
>> >> > On Wed, 27 Oct 2021 21:15:28 PDT (-0700), alexandre.ghiti@canonical.com wrote:
>> >> > > On Thu, Oct 28, 2021 at 1:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >> > >>
>> >> > >> On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
>> >> > >> > Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
>> >> > >> > Kconfig, it prevents asan-stack from getting disabled with clang even
>> >> > >> > when CONFIG_KASAN_STACK is disabled: fix this by defining the
>> >> > >> > corresponding config.
>> >> > >> >
>> >> > >> > Reported-by: Nathan Chancellor <nathan@kernel.org>
>> >> > >> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
>> >> > >> > ---
>> >> > >> >  arch/riscv/Kconfig             | 6 ++++++
>> >> > >> >  arch/riscv/include/asm/kasan.h | 3 +--
>> >> > >> >  arch/riscv/mm/kasan_init.c     | 3 +++
>> >> > >> >  3 files changed, 10 insertions(+), 2 deletions(-)
>> >> > >> >
>> >> > >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> >> > >> > index c1abbc876e5b..79250b1ed54e 100644
>> >> > >> > --- a/arch/riscv/Kconfig
>> >> > >> > +++ b/arch/riscv/Kconfig
>> >> > >> > @@ -162,6 +162,12 @@ config PAGE_OFFSET
>> >> > >> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>> >> > >> >       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>> >> > >> >
>> >> > >> > +config KASAN_SHADOW_OFFSET
>> >> > >> > +     hex
>> >> > >> > +     depends on KASAN_GENERIC
>> >> > >> > +     default 0xdfffffc800000000 if 64BIT
>> >> > >> > +     default 0xffffffff if 32BIT
>> >> > >>
>> >> > >> I thought I posted this somewhere, but this is exactly what my first
>> >> > >> guess was.  The problem is that it's hanging on boot for me.  I don't
>> >> > >> really have anything exotic going on, it's just a defconfig with
>> >> > >> CONFIG_KASAN=y running in QEMU.
>> >> > >>
>> >> > >> Does this boot for you?
>> >> > >
>> >> > > Yes with the 2nd patch of this series which fixes the issue
>> >> > > encountered here. And that's true I copied/pasted this part of your
>> >> > > patch which was better than what I had initially done, sorry I should
>> >> > > have mentioned you did that, please add a Codeveloped-by or something
>> >> > > like that.
>>
>> OK, those should probably be in the opposite order (though it looks like
>> they're inter-dependent, which makes things a bit trickier).
>>
>> >> >
>> >> > Not sure if I'm missing something, but it's still not booting for me.
>> >> > I've put what I'm testing on palmer/to-test, it's these two on top of
>> >> > fixes and merged into Linus' tree
>> >> >
>> >> >     *   6d7d351902ff - (HEAD -> to-test, palmer/to-test) Merge remote-tracking branch 'palmer/fixes' into to-test (7 minutes ago) <Palmer Dabbelt>
>> >> >     |\
>> >> >     | * 782551edf8f8 - (palmer/fixes) riscv: Fix CONFIG_KASAN_STACK build (6 hours ago) <Alexandre Ghiti>
>> >> >     | * 47383e5b3c4f - riscv: Fix asan-stack clang build (6 hours ago) <Alexandre Ghiti>
>> >> >     | * 64a19591a293 - (riscv/fixes) riscv: fix misalgned trap vector base address (9 hours ago) <Chen Lu>
>> >> >     * |   1fc596a56b33 - (palmer/master, linus/master, linus/HEAD, master) Merge tag 'trace-v5.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (11 hours ago) <Linus Torvalds>
>> >> >
>> >> > Am I missing something else?
>> >>
>> >> Hmm, that's weird, I have just done the same: cherry-picked both my
>> >> commits on top of fixes (64a19591a293) and it boots fine with KASAN
>> >> enabled. Maybe a config thing? I pushed my branch here:
>> >> https://github.com/AlexGhiti/riscv-linux/tree/int/alex/kasan_stack_fixes_rebase
>> >
>> > I pushed the config I use and that boots in that branch, maybe there's
>> > another issue somewhere.
>>
>> CONFIG_KASAN_VMALLOC=n is what's causing the failure.  I'm testing both
>> polarities of that, looks like your config has =y.  I haven't looked any
>> further as I'm pretty much cooked for tonight, but if you don't have
>> time then I'll try to find some time tomorrow.
>>
>
> Arf, that was obvious and just under my nose: without KASAN_VMALLOC,
> kasan_populate_early_shadow is called and creates the same issue that
> the second patch fixes.
>
> I'll send a v2 today and try to swap both patches to avoid having a
> non-bootable kernel commit.

Thanks.

>
> Alex
>
>> >
>> >>
>> >> >
>> >> > >
>> >> > > Thanks,
>> >> > >
>> >> > > Alex
>> >> > >
>> >> > >>
>> >> > >> > +
>> >> > >> >  config ARCH_FLATMEM_ENABLE
>> >> > >> >       def_bool !NUMA
>> >> > >> >
>> >> > >> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
>> >> > >> > index a2b3d9cdbc86..b00f503ec124 100644
>> >> > >> > --- a/arch/riscv/include/asm/kasan.h
>> >> > >> > +++ b/arch/riscv/include/asm/kasan.h
>> >> > >> > @@ -30,8 +30,7 @@
>> >> > >> >  #define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
>> >> > >> >  #define KASAN_SHADOW_START   KERN_VIRT_START
>> >> > >> >  #define KASAN_SHADOW_END     (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
>> >> > >> > -#define KASAN_SHADOW_OFFSET  (KASAN_SHADOW_END - (1ULL << \
>> >> > >> > -                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
>> >> > >> > +#define KASAN_SHADOW_OFFSET  _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>> >> > >> >
>> >> > >> >  void kasan_init(void);
>> >> > >> >  asmlinkage void kasan_early_init(void);
>> >> > >> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>> >> > >> > index d7189c8714a9..8175e98b9073 100644
>> >> > >> > --- a/arch/riscv/mm/kasan_init.c
>> >> > >> > +++ b/arch/riscv/mm/kasan_init.c
>> >> > >> > @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
>> >> > >> >       uintptr_t i;
>> >> > >> >       pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
>> >> > >> >
>> >> > >> > +     BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
>> >> > >> > +             KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>> >> > >> > +
>> >> > >> >       for (i = 0; i < PTRS_PER_PTE; ++i)
>> >> > >> >               set_pte(kasan_early_shadow_pte + i,
>> >> > >> >                       mk_pte(virt_to_page(kasan_early_shadow_page),
