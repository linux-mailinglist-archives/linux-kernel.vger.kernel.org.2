Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82D30EF56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhBDJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235050AbhBDJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:08:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDBB064F6C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612429689;
        bh=RdRTA1bK03wgF0azG6vQt0cA0pFZ5TxrKA+/4paCnfM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YcRB4w2TOUIlFypOXY6eignZ1ECEidZFodrjT0tA8cgJFQ+Eu0hwnkyrYl7ptBEq/
         ISCzaawtb4/yUko9nMZT5PQgo4L77qcofmkDuKh8u+sZ7YuObJON/oHqrE1sVVWYJ9
         4kMNzDiquJY0OI8oYJG9Cg9CfBX7UYLyql0lbt2t8+2AFyJUI4fxKM7T3gF1y10PH/
         D6+5C3us3YyWIpTYwB6o5hOvjjYgY6DJ7/9m5VoYdszz2iqmDEtKezMjlQuKp99TOC
         KegwQJU8RuK2TdO/foNzwyzAUb27JticFMkOyZ+OtfYgtbBXDHb8nTGHTnETqOGtO/
         5LHOWjiktYN6Q==
Received: by mail-ot1-f53.google.com with SMTP id 63so2740297oty.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 01:08:09 -0800 (PST)
X-Gm-Message-State: AOAM531zJqNn3OlE/MsqKd1PMBNnHmVfe7kxjA1czmIm7NeS/gDqoGyZ
        zuUex3JoGgiC61rwlES+Bw/g3DKJT1ny+15RRl4=
X-Google-Smtp-Source: ABdhPJx52+NR8bVmZHjdU/a3f0g575496/HNnbBjoikVb9ytscH2P0c9wBKYPT5QqdH1pMMa6Im/7HWvIqFxoQ0G+fM=
X-Received: by 2002:a05:6830:1614:: with SMTP id g20mr4909627otr.77.1612429688987;
 Thu, 04 Feb 2021 01:08:08 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
In-Reply-To: <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 10:07:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
Message-ID: <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 09:43, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hi Ard,
>
> Please see the bisection report below about a boot failure on
> rk3288 with next-20210203.  It was also bisected on
> imx6q-var-dt6customboard with next-20210202.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
>
> The kernel is most likely crashing very early on, so there's
> nothing in the logs.  Please let us know if you need some help
> with debugging or trying a fix on these platforms.
>

Thanks for the report.

Mind trying the following fix?

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -617,8 +617,10 @@ not_relocated:     mov     r0, #0
                @ cache_clean_flush() redundant. In other cases, the clean is
                @ performed by set/way and R0/R1 are ignored.
                @
-               mov     r0, #0
-               mov     r1, #0
+               get_inflated_image_size r1, r2, r3
+
+               mov     r0, r4                  @ start of decompressed kernel
+               add     r1, r1, r0              @ end of kernel BSS
                bl      cache_clean_flush

                get_inflated_image_size r1, r2, r3




> On 04/02/2021 04:25, KernelCI bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > next/master bisection: baseline.login on rk3288-rock2-square
> >
> > Summary:
> >   Start:      58b6c0e507b7 Add linux-next specific files for 20210203
> >   Plain log:  https://storage.kernelci.org/next/master/next-20210203/arm/multi_v7_defconfig/clang-11/lab-collabora/baseline-rk3288-rock2-square.txt
> >   HTML log:   https://storage.kernelci.org/next/master/next-20210203/arm/multi_v7_defconfig/clang-11/lab-collabora/baseline-rk3288-rock2-square.html
> >   Result:     5a29552af92d ARM: 9052/1: decompressor: cover BSS in cache clean and reorder with MMU disable on v7
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       next
> >   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   Branch:     master
> >   Target:     rk3288-rock2-square
> >   CPU arch:   arm
> >   Lab:        lab-collabora
> >   Compiler:   clang-11
> >   Config:     multi_v7_defconfig
> >   Test case:  baseline.login
> >
> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 5a29552af92dbd62c2b6fd1cddf7dad1ef7555b2
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Sun Jan 24 18:03:45 2021 +0100
> >
> >     ARM: 9052/1: decompressor: cover BSS in cache clean and reorder with MMU disable on v7
> >
> >     Commit 401b368caaec ("ARM: decompressor: switch to by-VA cache maintenance
> >     for v7 cores") replaced the by-set/way cache maintenance in the decompressor
> >     with by-VA cache maintenance, which is more appropriate for the task at
> >     hand, especially under virtualization on hosts with non-architected system
> >     caches that are not affected by by-set/way maintenance at all.
> >
> >     On such systems, that commit inadvertently removed the cache clean and
> >     invalidate of all of the guest's memory that is performed by KVM on behalf
> >     of the guest after its MMU is disabled (but only if any by-set/way cache
> >     maintenance instructions were issued first). This resulted in various
> >     erroneous behaviors observed by Russell, all involving the mini-stack
> >     used by the core kernel's v7 boot code, and which resides in BSS. It
> >     seems intractable to figure out exactly what goes wrong in each of these
> >     cases, but some small experiments did suggest that the lack of a cache
> >     clean and invalidate *after* disabling the MMU and caches is what
> >     triggers the errors, presumably because cachelines are being allocated
> >     or reallocated while the first cache clean and invalidate is in progress.
> >
> >     To ensure that no cache lines cover any of the data that is accessed by
> >     the booting kernel with the MMU off, include the uncompressed kernel's
> >     BSS region in the cache clean operation.
> >
> >     Also, to ensure that no cachelines are allocated while the cache is being
> >     cleaned, perform the cache clean operation *after* disabling the MMU and
> >     caches when running on v7 or later, by making a tail call to the clean
> >     routine from the cache_off routine. This requires passing the VA range
> >     to cache_off(), which means some care needs to be taken to preserve
> >     R0 and R1 across the call to cache_off().
> >
> >     Since this makes the first cache clean redundant, call it with the
> >     range reduced to zero. This only affects v7, as all other versions
> >     ignore R0/R1 entirely.
> >
> >     Link: https://lore.kernel.org/linux-arm-kernel/20210122152012.30075-1-ardb@kernel.org
> >
> >     Fixes: 401b368caaec ("ARM: decompressor: switch to by-VA cache maintenance for v7 cores")
> >     Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> >     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> > index d9cce7238a36..5f231b6f0d1a 100644
> > --- a/arch/arm/boot/compressed/head.S
> > +++ b/arch/arm/boot/compressed/head.S
> > @@ -609,11 +609,24 @@ not_relocated:  mov     r0, #0
> >               mov     r3, r7
> >               bl      decompress_kernel
> >
> > +             @
> > +             @ Perform a cache clean before disabling the MMU entirely.
> > +             @ In cases where the MMU needs to be disabled first (v7+),
> > +             @ the clean is performed again by cache_off(), using by-VA
> > +             @ operations on the range [R0, R1], making this prior call to
> > +             @ cache_clean_flush() redundant. In other cases, the clean is
> > +             @ performed by set/way and R0/R1 are ignored.
> > +             @
> > +             mov     r0, #0
> > +             mov     r1, #0
> > +             bl      cache_clean_flush
> > +
> >               get_inflated_image_size r1, r2, r3
> > +             ldr     r2, =_kernel_bss_size
> > +             add     r1, r1, r2
> >
> > -             mov     r0, r4                  @ start of inflated image
> > -             add     r1, r1, r0              @ end of inflated image
> > -             bl      cache_clean_flush
> > +             mov     r0, r4                  @ start of decompressed kernel
> > +             add     r1, r1, r0              @ end of kernel BSS
> >               bl      cache_off
> >
> >  #ifdef CONFIG_ARM_VIRT_EXT
> > @@ -1124,12 +1137,14 @@ proc_types:
> >   * reading the control register, but ARMv4 does.
> >   *
> >   * On exit,
> > - *  r0, r1, r2, r3, r9, r12 corrupted
> > + *  r0, r1, r2, r3, r9, r10, r11, r12 corrupted
> >   * This routine must preserve:
> >   *  r4, r7, r8
> >   */
> >               .align  5
> >  cache_off:   mov     r3, #12                 @ cache_off function
> > +             mov     r10, r0
> > +             mov     r11, r1
> >               b       call_cache_fn
> >
> >  __armv4_mpu_cache_off:
> > @@ -1176,7 +1191,9 @@ __armv7_mmu_cache_off:
> >               mcr     p15, 0, r0, c7, c5, 6   @ invalidate BTC
> >               mcr     p15, 0, r0, c7, c10, 4  @ DSB
> >               mcr     p15, 0, r0, c7, c5, 4   @ ISB
> > -             mov     pc, lr
> > +
> > +             mov     r0, r10
> > +             b       __armv7_mmu_cache_flush
> >
> >  /*
> >   * Clean and flush the cache to maintain consistency.
> > -------------------------------------------------------------------------------
> >
> >
> > Git bisection log:
> >
> > -------------------------------------------------------------------------------
> > git bisect start
> > # good: [62c31574cdb770c78f67e7aa6e0b0244ad122901] Merge tag 'imx-fixes-5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
> > git bisect good 62c31574cdb770c78f67e7aa6e0b0244ad122901
> > # bad: [58b6c0e507b7421b03b2f2a92bddbb8c6fa1b2f6] Add linux-next specific files for 20210203
> > git bisect bad 58b6c0e507b7421b03b2f2a92bddbb8c6fa1b2f6
> > # bad: [18c1afa6bb9b6277d20910eb7cdc5eb01d9d87f2] Merge remote-tracking branch 'net-next/master'
> > git bisect bad 18c1afa6bb9b6277d20910eb7cdc5eb01d9d87f2
> > # bad: [58d92989a8d24b6aaaabee52624d891b5103e04a] Merge remote-tracking branch 'parisc-hd/for-next'
> > git bisect bad 58d92989a8d24b6aaaabee52624d891b5103e04a
> > # bad: [b0b5c935b4dcf824ef30f6ddf719b49f729c2795] Merge remote-tracking branch 'sound-current/for-linus'
> > git bisect bad b0b5c935b4dcf824ef30f6ddf719b49f729c2795
> > # good: [d3921cb8be29ce5668c64e23ffdaeec5f8c69399] mm: fix initialization of struct page for holes in memory layout
> > git bisect good d3921cb8be29ce5668c64e23ffdaeec5f8c69399
> > # good: [c64396cc36c6e60704ab06c1fb1c4a46179c9120] Merge tag 'locking-urgent-2021-01-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect good c64396cc36c6e60704ab06c1fb1c4a46179c9120
> > # good: [2ba1c4d1a4b5fb9961452286bdcad502b0c8b78a] Merge tag 'block-5.11-2021-01-29' of git://git.kernel.dk/linux-block
> > git bisect good 2ba1c4d1a4b5fb9961452286bdcad502b0c8b78a
> > # good: [88bb507a74ea7d75fa49edd421eaa710a7d80598] Merge tag 'media/v5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> > git bisect good 88bb507a74ea7d75fa49edd421eaa710a7d80598
> > # good: [2e02677e961fd4b96d8cf106b5979e6a3cdb7362] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> > git bisect good 2e02677e961fd4b96d8cf106b5979e6a3cdb7362
> > # bad: [d3aa3465622d6d96645611b331312b773806d1a7] Merge remote-tracking branch 'arm64-fixes/for-next/fixes'
> > git bisect bad d3aa3465622d6d96645611b331312b773806d1a7
> > # good: [245a7d47066ac0a266004110bd4d57d0d1329823] scripts: switch some more scripts explicitly to Python 3
> > git bisect good 245a7d47066ac0a266004110bd4d57d0d1329823
> > # bad: [199a427c3a3da01c5db4784a75b37251e7befa64] ARM: ensure the signal page contains defined contents
> > git bisect bad 199a427c3a3da01c5db4784a75b37251e7befa64
> > # good: [538eea5362a1179dfa7770dd2b6607dc30cc50c6] ARM: 9043/1: tegra: Fix misplaced tegra_uart_config in decompressor
> > git bisect good 538eea5362a1179dfa7770dd2b6607dc30cc50c6
> > # bad: [d80cd9abcd942eb217b6c68e5bd0d5c3feb2f956] ARM: decompressor: tidy up register usage
> > git bisect bad d80cd9abcd942eb217b6c68e5bd0d5c3feb2f956
> > # bad: [5a29552af92dbd62c2b6fd1cddf7dad1ef7555b2] ARM: 9052/1: decompressor: cover BSS in cache clean and reorder with MMU disable on v7
> > git bisect bad 5a29552af92dbd62c2b6fd1cddf7dad1ef7555b2
> > # first bad commit: [5a29552af92dbd62c2b6fd1cddf7dad1ef7555b2] ARM: 9052/1: decompressor: cover BSS in cache clean and reorder with MMU disable on v7
> > -------------------------------------------------------------------------------
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#6431): https://groups.io/g/kernelci-results/message/6431
> > Mute This Topic: https://groups.io/mt/80373377/924702
> > Group Owner: kernelci-results+owner@groups.io
> > Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
>
