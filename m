Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07C405738
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357693AbhIINcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357686AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A252611ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631192134;
        bh=YQmcNYr+cZNJfeWxvOAqqq5sOLrBSpLtT8APgEd7LCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cB/PNnL/OcDRDFz5fIgBPaGsqQKZRjuQgQrYcmOZAIvi9HH/NhmrVSDetcZ96lVup
         fL98MHx3E8VsGhaKSDjl7fAlIrG9OFLd/sUPUssTkJX1e3NuH9EHNqy3D2OcW08Aeg
         cYgujanbIVF7a/Rd0OEdcclkD9nlBAmravLlHmKI4PN48xzo7F1w8r1lcJb+3cmSW6
         YdqVBWTOCUm50Hr7Z/zvBp0Wo25PpI1p7+BPAuNQuqw6U36P5p+xidVZij2cz/1Xtr
         nyPcTIcicQgwuxtX89MB1lrHbzaNqcjs/FPJVaqtJc8svQ6p1abzVx9VSOT+GC6Fuq
         Fca7e+yj0QSeQ==
Received: by mail-wr1-f44.google.com with SMTP id u16so2430068wrn.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:55:34 -0700 (PDT)
X-Gm-Message-State: AOAM530ZBofL61Y+eWB1REz2aPceqxhrDi5PnueekW0qoGD3dmnCGF+Z
        YRUlApsJLWCy54Ys+ousN1LICOH/r0AumInL0m4=
X-Google-Smtp-Source: ABdhPJyTVsi87qlqI/1eHcSEVZZZYViKabS97DzZRj/RHn7Ww0YW7zgh7w8tzbCK1GPtuNjyZV+4KTFRU6DZQKEU4dc=
X-Received: by 2002:adf:f884:: with SMTP id u4mr3278238wrp.411.1631192132894;
 Thu, 09 Sep 2021 05:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161> <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
 <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
 <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com> <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
In-Reply-To: <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 9 Sep 2021 14:55:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2--kfvs-+qkZdpea94ccgcY6QpdHMfVFgY0F2Z=GBhyw@mail.gmail.com>
Message-ID: <CAK8P3a2--kfvs-+qkZdpea94ccgcY6QpdHMfVFgY0F2Z=GBhyw@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Marco Elver <elver@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:43 PM Marco Elver <elver@google.com> wrote:
> On Thu, 9 Sept 2021 at 13:00, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Thu, Sep 9, 2021 at 12:54 PM Marco Elver <elver@google.com> wrote:
> > > On Thu, 9 Sept 2021 at 07:59, Christoph Hellwig <hch@infradead.org> wrote:
> > > > On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> > > > > It'd be good to avoid. It has helped uncover build issues with KASAN in
> > > > > the past. Or at least make it dependent on the problematic architecture.
> > > > > For example if arm is a problem, something like this:
> > > >
> > > > I'm also seeing quite a few stack size warnings with KASAN on x86_64
> > > > without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> > > > few warnings without KASAN, but with KASAN there are a lot more.
> > > > I'll try to find some time to dig into them.
> > >
> > > Right, this reminded me that we actually at least double the real
> > > stack size for KASAN builds, because it inherently requires more stack
> > > space. I think we need Wframe-larger-than to match that, otherwise
> > > we'll just keep having this problem:
> > >
> > > https://lkml.kernel.org/r/20210909104925.809674-1-elver@google.com
> >
> > The problem with this is that it completely defeats the point of the
> > stack size warnings in allmodconfig kernels when they have KASAN
> > enabled and end up missing obvious code bugs in drivers that put
> > large structures on the stack. Let's not go there.
>
> Sure, but the reality is that the real stack size is already doubled
> for KASAN. And that should be reflected in Wframe-larger-than.

I don't think "double" is an accurate description of what is going on,
it's much more complex than this. There are some functions
that completely explode with KASAN_STACK enabled on clang,
and many other functions instances that don't grow much at all.

I've been building randconfig kernels for a long time with KASAN_STACK
enabled on gcc, and the limit increased to 1440 bytes for 32-bit
and not increased beyond the normal 2048 bytes for 64-bit. I have
some patches to address the outliers and should go through and
resend some of those.

With the same limits and patches using clang, and KASAN=y but
KASAN_STACK=n I also get no warnings in randconfig builds,
but KASAN_STACK on clang doesn't really seem to have a good
limit that would make an allmodconfig kernel build with no warnings.

These are the worst offenders I see based on configuration, using
an 32-bit ARM allmodconfig with my fixups:

gcc-11, KASAN, no KASAN_STACK, FRAME_WARN=1024:
(nothing)

gcc-11, KASAN_STACK:
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:782:1:
warning: the frame size of 1416 bytes is larger than 1024 bytes
[-Wframe-larger-than=]
drivers/media/dvb-frontends/mxl5xx.c:1575:1: warning: the frame size
of 1240 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/mtd/nftlcore.c:468:1: warning: the frame size of 1232 bytes is
larger than 1024 bytes [-Wframe-larger-than=]
drivers/char/ipmi/ipmi_msghandler.c:4880:1: warning: the frame size of
1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/mtd/chips/cfi_cmdset_0001.c:1870:1: warning: the frame size of
1224 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/net/wireless/ath/ath9k/ar9003_paprd.c:749:1: warning: the
frame size of 1216 bytes is larger than 1024 bytes
[-Wframe-larger-than=]
drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c:136:1: warning:
the frame size of 1216 bytes is larger than 1024 bytes
[-Wframe-larger-than=]
drivers/ntb/hw/idt/ntb_hw_idt.c:1116:1: warning: the frame size of
1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]
net/dcb/dcbnl.c:1172:1: warning: the frame size of 1192 bytes is
larger than 1024 bytes [-Wframe-larger-than=]
fs/select.c:1042:1: warning: the frame size of 1192 bytes is larger
than 1024 bytes [-Wframe-larger-than=]

clang-12 KASAN, no KASAN_STACK, FRAME_WARN=1024:

kernel/trace/trace_events_hist.c:4601:13: error: stack frame size 1384
exceeds limit 1024 in function 'hist_trigger_print_key'
[-Werror,-Wframe-larger-than]
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3045:6:
error: stack frame size 1384 exceeds limit 1024 in function 'bw_calcs'
[-Werror,-Wframe-larger-than]
drivers/staging/fbtft/fbtft-core.c:992:5: error: stack frame size 1208
exceeds limit 1024 in function 'fbtft_init_display'
[-Werror,-Wframe-larger-than]
crypto/wp512.c:782:13: error: stack frame size 1176 exceeds limit 1024
in function 'wp512_process_buffer' [-Werror,-Wframe-larger-than]
drivers/staging/fbtft/fbtft-core.c:902:12: error: stack frame size
1080 exceeds limit 1024 in function 'fbtft_init_display_from_property'
[-Werror,-Wframe-larger-than]
drivers/mtd/chips/cfi_cmdset_0001.c:1872:12: error: stack frame size
1064 exceeds limit 1024 in function 'cfi_intelext_writev'
[-Werror,-Wframe-larger-than]
drivers/staging/rtl8723bs/core/rtw_security.c:1288:5: error: stack
frame size 1040 exceeds limit 1024 in function 'rtw_aes_decrypt'
[-Werror,-Wframe-larger-than]
drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size 1032
exceeds limit 1024 in function 'idt_scan_mws'
[-Werror,-Wframe-larger-than]

clang-12, KASAN_STACK:

drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame
size 20608 exceeds limit 1024 in function 'ocrdma_dbgfs_ops_read'
[-Werror,-Wframe-larger-than]
lib/bitfield_kunit.c:60:20: error: stack frame size 10336 exceeds
limit 10240 in function 'test_bitfields_constants'
[-Werror,-Wframe-larger-than]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9012:13: error: stack
frame size 9952 exceeds limit 1024 in function 'rt2800_init_rfcsr'
[-Werror,-Wframe-larger-than]
drivers/net/usb/r8152.c:7486:13: error: stack frame size 8768 exceeds
limit 1024 in function 'r8156b_hw_phy_cfg'
[-Werror,-Wframe-larger-than]
drivers/media/dvb-frontends/nxt200x.c:915:12: error: stack frame size
8192 exceeds limit 1024 in function 'nxt2004_init'
[-Werror,-Wframe-larger-than]
drivers/net/wan/slic_ds26522.c:203:12: error: stack frame size 8064
exceeds limit 1024 in function 'slic_ds26522_probe'
[-Werror,-Wframe-larger-than]
drivers/firmware/broadcom/bcm47xx_sprom.c:188:13: error: stack frame
size 8064 exceeds limit 1024 in function 'bcm47xx_sprom_fill_auto'
[-Werror,-Wframe-larger-than]
drivers/media/dvb-frontends/drxd_hard.c:2857:12: error: stack frame
size 7584 exceeds limit 1024 in function 'drxd_set_frontend'
[-Werror,-Wframe-larger-than]
drivers/media/dvb-frontends/nxt200x.c:519:12: error: stack frame size
6848 exceeds limit 1024 in function
'nxt200x_setup_frontend_parameters' [-Werror,-Wframe-larger-than]
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:17019:13:
error: stack frame size 6560 exceeds limit 1024 in function
'wlc_phy_workarounds_nphy' [-Werror,-Wframe-larger-than]

> Either that, or we just have to live with the occasional warning (that
> is likely benign). But with WERROR we're now forced to make the
> defaults as sane as possible. If the worry is allmodconfig, maybe we
> do have to make KASAN dependent on !COMPILE_TEST, even though that's
> not great either because it has caught real issues in the past (it'll
> also mean doing the same for all other instrumentation-based tools,
> like KCSAN, UBSAN, etc.).

I would prefer going back to marking KASAN_STACK as broken on clang, it does
not seem like the warnings on the symbol were enough to stop people from
attempting to using it, and the remaining warnings seem fixable with a small
increase of the FRAME_WARN when using KASAN with clang but no KASAN_STACK,
or when using KASAN_STACK with gcc.

      Arnd
