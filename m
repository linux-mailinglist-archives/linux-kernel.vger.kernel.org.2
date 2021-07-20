Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E9F3D03E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhGTUtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhGTUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 16:49:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E3C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:29:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e14so249980ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lD7MSr2tHShwP24PsDQ+AQ045DheEanjMiBeVzyowZM=;
        b=V1vQhpEk0nUsfOn4JiW4a32yiqit8hnxNX8BpCSbJi8H1nLmRPdqpupHi3VLsfwDNq
         KC1UZap1tiEKAda3Lre4Ew+fUaQgN2M3Gp79qdhjjje2HPrUgZ/8i+6T40p6gkTjwftW
         CZudVHWWpuz3VjviDdQzffdJ+7DS5iB2Pjy09Kd3FRjKYJxE/+ecdC0L/N+hH3qTG4Ey
         mwOPbrvidz9LL8rCluTRyTTkfQLRfge6+FRY/0/jSFgaId0VJi0zqM3/SQeEvXFr6uDf
         EuwrKROyGHF1BFxtFUyEHgG54uHnQDud0pgFqVhPnWT/rXBA3f6i6HUa1+SY0fqCsSv4
         TzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lD7MSr2tHShwP24PsDQ+AQ045DheEanjMiBeVzyowZM=;
        b=QDbJbeedCs005nX6wqDOnYZfZMICuhyoUMsPUPPnzbYm3nMgUqxksl3cMtSeOZssyo
         xdEYuwwqPCblPYE50CQQj+82FZzmTYX2MecBSRUmLaw2Xc/f2751pjHMyZVJE+cJaYh/
         X0eNFjDzeiQckkNuvj36IyXyce6/6WjtOdZCEvC9RImihLCQBV6aEFKFjs98N/Nve+AW
         zWCK9xuUf5ZmMbl3aC7/KVNXJS7Lz3UhvlGWTeL/tLhQ9xgqApM3G3Hfl4at0ouqxsks
         VBc5E2LZL2cyCFowW9TEF/tIkfVBGUvluxK+hPVjWmL3MwjTJsYgZSYn8tC3ighxg3rr
         I18w==
X-Gm-Message-State: AOAM530+2SV6v6MDlar/We9ElyFQGXlx5xmzpP1TQGm5DiytS61A34R4
        XYhZYaNbW1vaeI6wyPIJP+A5nLFyEuDwz+VULxMIHQ==
X-Google-Smtp-Source: ABdhPJy2KiMdz7KfGiMYgZETgo0ONCU5xQ7QpOBa3+v9uTiyXYesMI5VQvqBe24MELTiidv9lgno9qVT59w6KSkowow=
X-Received: by 2002:a2e:a911:: with SMTP id j17mr28176107ljq.341.1626816585818;
 Tue, 20 Jul 2021 14:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210708232522.3118208-1-ndesaulniers@google.com>
 <20210708232522.3118208-3-ndesaulniers@google.com> <CAK7LNARye5Opc0AdXpn+DHB7hTaphoRSCUWxJgXu+sjuNjWUCg@mail.gmail.com>
 <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Jul 2021 14:29:35 -0700
Message-ID: <CAKwvOdkvju7heeNpk87brsjkhXHbdKFsUgf63KWhXox9rDkQsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for
 LLVM=1 LLVM_IAS=1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But clang has become a primary compiler for some kernel communities,
> and I think it might be time to just re-visit that entirely.
>
> In particular, I think we should just make it a Kconfig option. I hate
> the command flag stuff so much, that my clang tree literally has this
> patch in it:
>
>     -CC = $(CROSS_COMPILE)gcc
>     +CC = $(CROSS_COMPILE)clang
>
> so that I can just do the same "make -j128" in both my gcc tree and my
> clang tree.
>
> But each build tree already has its own .config file, so it would be a
> lot more convenient if that was how the compiler was chosen, and then
> "make oldconfig" would just DTRT.
>
> We do most of the other heavy lifting in this area in Kconfig anyway,
> why not add that compiler choice?
>
> Obviously it would be gated by the tests to see which compilers are
> _installed_ (and that they are valid versions), so that it doesn't ask
> stupid things ("do you want gcc or clang" when only one of them is
> installed and/or viable).
>
> Hmm? So then any "LLVM=1" thing would be about the "make config"
> stage, not the actual build stage.
>
> (It has annoyed me for years that if you want to cross-compile, you
> first have to do "make ARCH=xyz config" and then remember to do "make
> ARCH=xyz" for the build too, but I cross-compile so seldom that I've
> never really cared).
>
> Let the flame wars^H^Hpolite discussions ensue..

I will concede that "why do I need to respecify all of my command line
args/env vars to make when I already did so for a configure step?" is
a reasonable question to ask, and may be worth pursuing.

There's still some that we can eliminate for BOTH configure and actual
build, like CROSS_COMPILE. :^)
-- 
Thanks,
~Nick Desaulniers
