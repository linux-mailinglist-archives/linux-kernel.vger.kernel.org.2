Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36DF413662
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhIUPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234168AbhIUPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:43:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26BBB611EF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632238937;
        bh=fsjbdWhaoEfRC8WZUJZWmQoz3Z1K+BhTC5bgPI2OUwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXUMi4NIgwLQOL+Z4ntN4uOoLwSNGI40VmjgFyfwXArIXfQtBD198OPkpEg50vPp/
         sazNC/1O1+aPrBQ4bvEs4uDmghxKDrW48JV8W+tWRU3mEbDsJ01/5VAiazVRYKJQsv
         hC53Pf1CaHbhUJhQtrEUsTOhPihI2hxe/Uq3TM3HMQgRfmnoJU+FaVO5CQ7QW/Ar9r
         hY5jYq6cry1j5jnGytW02loW1rVaNrqguU5BT9+INaYSQpHAwTQ24oBURjKnbSBzwd
         ySCv3olsMR4+2WLO0KTKdoSpzEFh8ynMbuMxPSvtm8LmeO+HU2Ahe9Sp+k53A3I6qP
         4kc5pcym+RWGQ==
Received: by mail-wr1-f49.google.com with SMTP id g16so40501646wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:42:17 -0700 (PDT)
X-Gm-Message-State: AOAM530w/fdX1JVKHtvxxt+u86Dk9i5pBWo298I5wbmvaQk8p9U8onAU
        wYl0He/0JHGXd0p8oFPyB9GIDGJ1rT/UKHKlqsg=
X-Google-Smtp-Source: ABdhPJxGTopYiF3OBAqRLkSep1+4ZT7zRaVkA2do2C6Qe3HFsc8eV27bRIwi9KNJqEZq+iitDSLyD3XEYzWG5Cg6+sg=
X-Received: by 2002:a05:600c:3209:: with SMTP id r9mr5344103wmp.35.1632238935395;
 Tue, 21 Sep 2021 08:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
In-Reply-To: <YTkjJPCdR1VGaaVm@archlinux-ax161>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 21 Sep 2021 17:41:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0tswcc1icb99cmdX7w0nBc4CAXjaAKJMuYSdJC1MS8YQ@mail.gmail.com>
Message-ID: <CAK8P3a0tswcc1icb99cmdX7w0nBc4CAXjaAKJMuYSdJC1MS8YQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 10:55 PM Nathan Chancellor <nathan@kernel.org> wrote:
> On Tue, Sep 07, 2021 at 11:11:17AM +0200, Arnd Bergmann wrote:
> > On Tue, Sep 7, 2021 at 4:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
> > > arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1376) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
> > > arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5384) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
> > >
> > > Aside from the dce_calcs.c warnings, these do not seem too bad. I
> > > believe allmodconfig turns on UBSAN but it could also be aggressive
> > > inlining by clang. I intend to look at all -Wframe-large-than warnings
> > > closely later.
> >
> > I've had them close to zero in the past, but a couple of new ones came in.
> >
> > The amdgpu ones are probably not fixable unless they stop using 64-bit
> > floats in the kernel for
> > random calculations. The crypto/* ones tend to be compiler bugs, but hard to fix
>
> I have started taking a look at these. Most of the allmodconfig ones
> appear to be related to CONFIG_KASAN, which is now supported for
> CONFIG_ARM.
>
> The two in bpmp-debugfs.c appear regardless of CONFIG_KASAN and it turns
> out that you actually submitted a patch for these:
>
> https://lore.kernel.org/r/20201204193714.3134651-1-arnd@kernel.org/
>
> Is it worth resending or pinging that?

I'm now restarting from a clean tree for my randconfig patches to see which
ones are actually needed, will hopefully get to that.

> The dce_calcs.c ones also appear without CONFIG_KASAN, which you noted
> is probably unavoidable.

(adding amdgpu folks to Cc here)

Harry Wentland did a nice rework for dcn_calcs.c that should also be
portable to dce_calcs.c, I hope that he will be able to get to that as well.

Looking at my older patches now, I found that I had only suppressed that one
and given up fixing it, but I did put my analysis into
https://bugs.llvm.org/show_bug.cgi?id=42551, which should be helpful
for addressing it in either the kernel or the compiler.

        Arnd
