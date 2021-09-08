Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B83540405C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 22:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352312AbhIHU4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 16:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235437AbhIHU4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:56:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9036F61158;
        Wed,  8 Sep 2021 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631134506;
        bh=qOW+3a3Dux7smy1XbXVLU/2hKyGfpH9x0I1DZ65HpVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxBnw5yjqB4WfqYxEYLloni2ogPLLAwqUOSEl8oPgGQ1uEdOPEXLKyZFtEGu2BXvN
         RUDvnIa2W1610J/TBRdKY4JTHOTvC7oHRulXeMud+pAkQGBGOQyG8nD2pQcNfGxh7L
         7+WWBHJ1Qs/Q1sKb/G/RJHyfmagLTHpevpJ4b/L56MGWkKln4C+e8B09eUQ6QmAVOK
         JGF/HlSaakxxxQAbQw5gHUcelXX/GfGQt1GJ2N/DgZ1syxtzpICNloVfVhzvSeGUkn
         enSQ6QhBEV7uD/UvVU1hSMErO764GNSs74xWxPJcG0DpC2NORcW9V+1KgQRYdV5s7v
         qCMrqpBziSF5w==
Date:   Wed, 8 Sep 2021 13:55:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <YTkjJPCdR1VGaaVm@archlinux-ax161>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Sep 07, 2021 at 11:11:17AM +0200, Arnd Bergmann wrote:
> On Tue, Sep 7, 2021 at 4:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > arm32-allmodconfig.log: crypto/wp512.c:782:13: error: stack frame size (1176) exceeds limit (1024) in function 'wp512_process_buffer' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:294:12: error: stack frame size (1256) exceeds limit (1024) in function 'bpmp_debug_show' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:357:16: error: stack frame size (1264) exceeds limit (1024) in function 'bpmp_debug_store' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1384) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5560) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/mtd/chips/cfi_cmdset_0001.c:1872:12: error: stack frame size (1064) exceeds limit (1024) in function 'cfi_intelext_writev' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in function 'idt_scan_mws' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:902:12: error: stack frame size (1072) exceeds limit (1024) in function 'fbtft_init_display_from_property' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:992:5: error: stack frame size (1064) exceeds limit (1024) in function 'fbtft_init_display' [-Werror,-Wframe-larger-than]
> > arm32-allmodconfig.log: drivers/staging/rtl8723bs/core/rtw_security.c:1288:5: error: stack frame size (1040) exceeds limit (1024) in function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
> > arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1376) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
> > arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5384) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
> >
> > Aside from the dce_calcs.c warnings, these do not seem too bad. I
> > believe allmodconfig turns on UBSAN but it could also be aggressive
> > inlining by clang. I intend to look at all -Wframe-large-than warnings
> > closely later.
> 
> I've had them close to zero in the past, but a couple of new ones came in.
> 
> The amdgpu ones are probably not fixable unless they stop using 64-bit
> floats in the kernel for
> random calculations. The crypto/* ones tend to be compiler bugs, but hard to fix

I have started taking a look at these. Most of the allmodconfig ones
appear to be related to CONFIG_KASAN, which is now supported for
CONFIG_ARM.

The two in bpmp-debugfs.c appear regardless of CONFIG_KASAN and it turns
out that you actually submitted a patch for these:

https://lore.kernel.org/r/20201204193714.3134651-1-arnd@kernel.org/

Is it worth resending or pinging that?

The dce_calcs.c ones also appear without CONFIG_KASAN, which you noted
is probably unavoidable.

The other ones only appear with CONFIG_KASAN. I have not investigated
each instance to see exactly how much KASAN makes the stack blow up.
Perhaps it is worth setting the default of CONFIG_FRAME_WARN to a higher
value with clang+COMPILE_TEST+KASAN?

> > It appears that both Arch Linux and Fedora define CONFIG_FRAME_WARN
> > as 1024, below its default of 2048. I am not sure these look particurly
> > scary (although there are some that are rather large that need to be
> > looked at).
> 
> For 64-bit, you usually need 1280 bytes stack space to get a
> reasonably clean build,
> anything that uses more than that tends to be a bug in the code but we
> never warned
> about those by default as the default warning limit in defconfig is 2048.
> 
> I think the distros using 1024 did that because they use a common base config
> for 32-bit and 64-bit targets.

That is a fair explanation.

> > I suspect this is a backend problem because these do not really appear
> > in any other configurations (might also be something with a sanitizer?)
> 
> Agreed. Someone needs to bisect the .config or the compiler flags to see what
> triggers them.

For other people following along, there were a lot of
-Wframe-larger-than instances from RISC-V allmodconfig.

Turns out this is because CONFIG_KASAN_STACK is not respected with
RISC-V. They do not set CONFIG_KASAN_SHADOW_OFFSET so following along in
scripts/Makefile.kasan, CFLAGS_KASAN_SHADOW does not get set to
anything, which means that only '-fsanitize=kernel-address' gets added
to the command line, with none of the other parameters.

I guess there are a couple of ways to tackle this:

1. RISC-V could implement CONFIG_KASAN_SHADOW_OFFSET. They mention that
   the logic of KASAN_SHADOW_OFFSET was taken from arm64 but they did
   not borrow the Kconfig logic it seems.

2. asan-stack could be hoisted out of the else branch so that it is
   always enabled/disabled regardless of KASAN_SHADOW_OFFSET being
   defined, which resolved all of these warnings for me in my testing.

I am adding the KASAN and RISC-V folks to CC for this reason.

Cheers,
Nathan
