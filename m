Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A4402601
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbhIGJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244735AbhIGJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:12:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9F5C61101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631005895;
        bh=S0VkxnJMNpivLZBvnVxOr1eyvWG/NwqYQsLL6zGXVnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uPozHVMFTMRocTJATS8t//+LSfOBZwueRKB/sR4PEa4D/4kC7rBzMaeQUEZ8ZOEuL
         zlZKjXbWBYgnsdrjFBOl3J97VpeL2n91h2KglgPf84DXoCADi8L2Syy4lSapswWYiW
         1gllL8Bl2EPr0gF1QBcVQ8YiQhp1WwFpXE4tLBZ3S6jQFTiwHI3SW2j5T2E0la2rJU
         i3m8XNy+zlB4mDn6QnZl8DqInwidhDYruX4erWYH7M7XLuTDX+ElfsWaJZbHHB+LLO
         mv0+xcEFNnZzvfKkxgQc6MqTZTZL458x8SCpZ+AaJwE3RKKfXo0xdWugIQKAqlKOwp
         LboZ08Js0Ss0Q==
Received: by mail-wm1-f54.google.com with SMTP id i3so6276090wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:11:34 -0700 (PDT)
X-Gm-Message-State: AOAM533mN9pxkMRy+dhndm3qO9Qd0hB2JB20NKe425MZH6uwGMixU8Wb
        rmgen8lfljstPq/xVOpMcQFJcnasgpvcHa5L9KY=
X-Google-Smtp-Source: ABdhPJzprj3zVpwhH3Ua58Oxcp3NI9VfmErdqoYm82dMTRWwpW9xSTyyRl+0KKway8+dUdeb1Re5rIBjrLprnFgsjnQ=
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr2829045wme.173.1631005893474;
 Tue, 07 Sep 2021 02:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
In-Reply-To: <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 7 Sep 2021 11:11:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
Message-ID: <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> arm32-allmodconfig.log: crypto/wp512.c:782:13: error: stack frame size (1176) exceeds limit (1024) in function 'wp512_process_buffer' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:294:12: error: stack frame size (1256) exceeds limit (1024) in function 'bpmp_debug_show' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:357:16: error: stack frame size (1264) exceeds limit (1024) in function 'bpmp_debug_store' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1384) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5560) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/mtd/chips/cfi_cmdset_0001.c:1872:12: error: stack frame size (1064) exceeds limit (1024) in function 'cfi_intelext_writev' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in function 'idt_scan_mws' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:902:12: error: stack frame size (1072) exceeds limit (1024) in function 'fbtft_init_display_from_property' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:992:5: error: stack frame size (1064) exceeds limit (1024) in function 'fbtft_init_display' [-Werror,-Wframe-larger-than]
> arm32-allmodconfig.log: drivers/staging/rtl8723bs/core/rtw_security.c:1288:5: error: stack frame size (1040) exceeds limit (1024) in function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
> arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1376) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
> arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5384) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
>
> Aside from the dce_calcs.c warnings, these do not seem too bad. I
> believe allmodconfig turns on UBSAN but it could also be aggressive
> inlining by clang. I intend to look at all -Wframe-large-than warnings
> closely later.

I've had them close to zero in the past, but a couple of new ones came in.

The amdgpu ones are probably not fixable unless they stop using 64-bit
floats in the kernel for
random calculations. The crypto/* ones tend to be compiler bugs, but hard to fix

> It appears that both Arch Linux and Fedora define CONFIG_FRAME_WARN
> as 1024, below its default of 2048. I am not sure these look particurly
> scary (although there are some that are rather large that need to be
> looked at).

For 64-bit, you usually need 1280 bytes stack space to get a
reasonably clean build,
anything that uses more than that tends to be a bug in the code but we
never warned
about those by default as the default warning limit in defconfig is 2048.

I think the distros using 1024 did that because they use a common base config
for 32-bit and 64-bit targets.

> I suspect this is a backend problem because these do not really appear
> in any other configurations (might also be something with a sanitizer?)

Agreed. Someone needs to bisect the .config or the compiler flags to see what
triggers them.

> s390x-defconfig.log: include/asm-generic/io.h:464:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:477:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:490:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:501:33: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:511:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:521:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:609:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:617:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:625:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:634:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:643:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
> s390x-defconfig.log: include/asm-generic/io.h:652:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>
> This affected all s390x configs I test. fs/btrfs force enables W=1 so we
> get these. This is known and had a solution rejected at pull time:
>
> https://github.com/ClangBuiltLinux/linux/issues/1285
> https://lore.kernel.org/r/20210510145234.594814-1-schnelle@linux.ibm.com/
> https://lore.kernel.org/r/CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com/

I posted a new idea for a patch, but it needs more work. I'm happy to work with
any volunteers that want to help tighten the Kconfig dependencies to ensure that
those drivers are only built on architectures that provide I/O port accesses.

> x86_64-allmodconfig-O3.log:drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c:566:5: error: stack frame size (2504) exceeds limit (2048) in function 'sparx5_config_dsm_calendar' [-Werror,-Wframe-larger-than]
>
> Probably aggressive inlining due to testing -O3.

If inlining causes it, it was already bad without the inlining. It
looks like there are
some large arrays on the stack of some of the called functions, so a driver fix
is needed anyway.

> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: error: stack frame size (1800) exceeds limit (1280) in function 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: error: stack frame size (1352) exceeds limit (1280) in function 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
> x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1676:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml31_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
> x86_64-alpine.log:drivers/vhost/scsi.c:1831:12: error: stack frame size (1320) exceeds limit (1280) in function 'vhost_scsi_release' [-Werror,-Wframe-larger-than]
>
> Another instance where distros lower CONFIG_FRAME_WARN below the 2048
> default. Again, none look particularly scary but should still probably
> be dealt with.

I would argue that they are still scary and should be addressed in the
code, it's just that
we don't see them on build bots that use the 2048 byte default.

        Arnd
