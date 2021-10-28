Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3943DAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhJ1FFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhJ1FFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:05:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC9C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 22:02:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v1-20020a17090a088100b001a21156830bso7024270pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 22:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ET9rgc2cPQO0D9fY/bz0XEDC7bhtrK0ZvnRrK6wQ7eU=;
        b=WxFhA8TZckMYBBHxPkT45pXRfhhAuA5TLksn3+jhe2UniPM+VgCSRN9knqFI2+mfR/
         tSsW9UmbE4i8fwnsR9gUbcAc74ThkukJ/QwqzpG7E4MMA05eLavgqwUQBQN5/ICtAUuB
         OXtb9ujB0ObDBev8152CdCY8SaC3C2vV0qUP0ZaW392Gm7lRQ643/jtEM/EeOETL2rGQ
         Qc+Teh5HTCEiWZaq2AsKtucP/FUniW4EG7ptd6qQvAVbT/3cixYp6hShn+hZLHeUkF0i
         XOrafyjMRZHHDCCK1ngLG9flycq1vCZ5RzSy/u4ri0kIP4AbVn5hYaN0p6vceJonlUcc
         jn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ET9rgc2cPQO0D9fY/bz0XEDC7bhtrK0ZvnRrK6wQ7eU=;
        b=luHAZYxO6eRfRISne8SMDsbdIf/VoIK8CuomGb5NjdPTQbdGFCAKYwtLNZRRIk16qI
         AzpsACC/VNtF541HPTpTA2dvQ44j9gLKKTWWICBq4NlJx+h+ZWjWJxcZbvKoc92pvEym
         aH0gXSHYMZMwaTAUbfJuSXj/k7G8cwiDZf/BPNnhXoFU3rvHgG2K5TzPakAl0z5nV0Vd
         mH06mfF5coWWosWKE5bzmrtW8Ydn+/rO2rOlzgcRfHMrvz2vxtvMB6f8zPvUGwR0ofcI
         FwEGhklL0hk8zr8hhv4RTXv813IdLxTV6aQSSQbkR8Km9GctnnzrorWUZT3/EYJDtTXm
         O3Fg==
X-Gm-Message-State: AOAM533lRpk+II9NJURVPx/wsYLvYEW5/shl9mScPbdqAfNVfl/ur81p
        NtznL/AQhmiVUnayvEVXtowLUA==
X-Google-Smtp-Source: ABdhPJz4PU1uvJDhqa5URcYX83sYl0VtkoGCoIUdPAP38/HliPgU7ET3vEC7C0r7sFeERLSU5bOUOw==
X-Received: by 2002:a17:90b:f82:: with SMTP id ft2mr911134pjb.107.1635397363825;
        Wed, 27 Oct 2021 22:02:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y6sm1667005pfi.154.2021.10.27.22.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 22:02:43 -0700 (PDT)
Date:   Wed, 27 Oct 2021 22:02:43 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 22:02:39 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Fix asan-stack clang build
In-Reply-To: <CA+zEjCuUCxqTtbox2K8c=ymHC8X97LV6CSO3ydJKgRR9cBXUEw@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        nathan@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-897d082f-5ca4-4d77-a69d-4efaa456bf3b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 21:15:28 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> On Thu, Oct 28, 2021 at 1:06 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 26 Oct 2021 21:58:42 PDT (-0700), alexandre.ghiti@canonical.com wrote:
>> > Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
>> > Kconfig, it prevents asan-stack from getting disabled with clang even
>> > when CONFIG_KASAN_STACK is disabled: fix this by defining the
>> > corresponding config.
>> >
>> > Reported-by: Nathan Chancellor <nathan@kernel.org>
>> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
>> > ---
>> >  arch/riscv/Kconfig             | 6 ++++++
>> >  arch/riscv/include/asm/kasan.h | 3 +--
>> >  arch/riscv/mm/kasan_init.c     | 3 +++
>> >  3 files changed, 10 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index c1abbc876e5b..79250b1ed54e 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -162,6 +162,12 @@ config PAGE_OFFSET
>> >       default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>> >       default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
>> >
>> > +config KASAN_SHADOW_OFFSET
>> > +     hex
>> > +     depends on KASAN_GENERIC
>> > +     default 0xdfffffc800000000 if 64BIT
>> > +     default 0xffffffff if 32BIT
>>
>> I thought I posted this somewhere, but this is exactly what my first
>> guess was.  The problem is that it's hanging on boot for me.  I don't
>> really have anything exotic going on, it's just a defconfig with
>> CONFIG_KASAN=y running in QEMU.
>>
>> Does this boot for you?
>
> Yes with the 2nd patch of this series which fixes the issue
> encountered here. And that's true I copied/pasted this part of your
> patch which was better than what I had initially done, sorry I should
> have mentioned you did that, please add a Codeveloped-by or something
> like that.

Not sure if I'm missing something, but it's still not booting for me.  
I've put what I'm testing on palmer/to-test, it's these two on top of 
fixes and merged into Linus' tree

    *   6d7d351902ff - (HEAD -> to-test, palmer/to-test) Merge remote-tracking branch 'palmer/fixes' into to-test (7 minutes ago) <Palmer Dabbelt>
    |\
    | * 782551edf8f8 - (palmer/fixes) riscv: Fix CONFIG_KASAN_STACK build (6 hours ago) <Alexandre Ghiti>
    | * 47383e5b3c4f - riscv: Fix asan-stack clang build (6 hours ago) <Alexandre Ghiti>
    | * 64a19591a293 - (riscv/fixes) riscv: fix misalgned trap vector base address (9 hours ago) <Chen Lu>
    * |   1fc596a56b33 - (palmer/master, linus/master, linus/HEAD, master) Merge tag 'trace-v5.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (11 hours ago) <Linus Torvalds>

Am I missing something else?

>
> Thanks,
>
> Alex
>
>>
>> > +
>> >  config ARCH_FLATMEM_ENABLE
>> >       def_bool !NUMA
>> >
>> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
>> > index a2b3d9cdbc86..b00f503ec124 100644
>> > --- a/arch/riscv/include/asm/kasan.h
>> > +++ b/arch/riscv/include/asm/kasan.h
>> > @@ -30,8 +30,7 @@
>> >  #define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
>> >  #define KASAN_SHADOW_START   KERN_VIRT_START
>> >  #define KASAN_SHADOW_END     (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
>> > -#define KASAN_SHADOW_OFFSET  (KASAN_SHADOW_END - (1ULL << \
>> > -                                     (64 - KASAN_SHADOW_SCALE_SHIFT)))
>> > +#define KASAN_SHADOW_OFFSET  _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>> >
>> >  void kasan_init(void);
>> >  asmlinkage void kasan_early_init(void);
>> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>> > index d7189c8714a9..8175e98b9073 100644
>> > --- a/arch/riscv/mm/kasan_init.c
>> > +++ b/arch/riscv/mm/kasan_init.c
>> > @@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
>> >       uintptr_t i;
>> >       pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
>> >
>> > +     BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
>> > +             KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
>> > +
>> >       for (i = 0; i < PTRS_PER_PTE; ++i)
>> >               set_pte(kasan_early_shadow_pte + i,
>> >                       mk_pte(virt_to_page(kasan_early_shadow_page),
