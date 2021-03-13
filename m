Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0861339DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCMMEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:04:42 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64796 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhCMME0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:04:26 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 12DC3tno015794
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:03:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 12DC3tno015794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615637036;
        bh=GGeYoxOWsCboZGLTbbuYmudfo3GRDTKpAs+FNRS4Jc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g8WpRtKH5zs+eYuqN0roZp8YPUVUPPMmBQPhJu6ameeJh1d/GgS70UgycMadp9Hf1
         4RgL99v0CKvGMEkc56WY5o5LN2NkbUJYoe5483JNy8/N7IjlkPglyxMzcudIAbMtUl
         HpYz1uLU+8dxJb44XrP3Xx4kSvdQi5XPiTliF9GxOtPR9XDemYzF5hrJKJe2yo0yRI
         Y/6sptMlg8ZzUCJeissHh38/51EuQdz5OIOK+r/88T/zYxyt/cR8oSa6ICeT44HIda
         i3YlpWrBfXGXlUqrF+zBjoMeGC9NRq0vLXSO7hLgNIqc/lo0vWcTpTpG+dj1xN9g2D
         HhDAK71Esyicg==
X-Nifty-SrcIP: [209.85.215.169]
Received: by mail-pg1-f169.google.com with SMTP id q5so4915505pgk.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 04:03:56 -0800 (PST)
X-Gm-Message-State: AOAM532+YiIZxWKFCJGuGoyc6IDw0FEAVFasPiEVByS0iNAbIEXeEl1t
        15Re9QEcNfoAFpNzwXf8/ATmwTBRO5J3IzPzaa8=
X-Google-Smtp-Source: ABdhPJzWBuJN5H3fOTd8W32xkT6upOzCcrnJ0SmOT08xlHJKpQJHgJ4OkHdUkrPmdOJwc33szp8ilpU6VRRyHR7/Av0=
X-Received: by 2002:a65:41c6:: with SMTP id b6mr15436838pgq.7.1615637035437;
 Sat, 13 Mar 2021 04:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20210312151411.101942-1-masahiroy@kernel.org> <CAMo8BfL3Zx2_uYD6yJQgju90JJj5=occjsDtcXZY0E2jmqUhow@mail.gmail.com>
In-Reply-To: <CAMo8BfL3Zx2_uYD6yJQgju90JJj5=occjsDtcXZY0E2jmqUhow@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 13 Mar 2021 21:03:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASb4wDk4p7Qk28nNbu0fr9kNa_PaDq-RXRzB_qiJedzQg@mail.gmail.com>
Message-ID: <CAK7LNASb4wDk4p7Qk28nNbu0fr9kNa_PaDq-RXRzB_qiJedzQg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: move CONFIG_CPU_*_ENDIAN defines to Kconfig
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 5:57 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Fri, Mar 12, 2021 at 7:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Move the definition of CONFIG_CPU_*_ENDIAN to Kconfig, the best place
> > for CONFIG options.
> >
> > I slightly simplified the test code. You can use the -P option to suppress
> > linemarker generation. The grep command is unneeded.
> >
> >   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -
> >   # 1 "<stdin>"
> >   # 1 "<built-in>"
> >   # 1 "<command-line>"
> >   # 1 "<stdin>"
> >   1
> >
> >   $ echo __XTENSA_EB__ | xtensa-linux-gcc -E -P -
> >   1
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> > If I understood correctly, xtensa compilers can support either
> > big-endian or little-endian. We cannot change it via a command option.
> > Actually, it does not understand -mbig-endian or -mlittle-endian.
> > (Is this correct?)
>
> This is correct. The idea is that specific xtensa core has fixed endianness,
> but it can be either little or big. The toolchain is configured for the specific
> xtensa core at build time, so there's no need for a runtime endian switch.
>
> >   $ xtensa-linux-gcc   -mbig-endian  /dev/null  -c -o /dev/null
> >   xtensa-linux-gcc: error: unrecognized command-line option '-mbig-endian'
> >
> > I see -mbig-endian / -mlittle-endian in old GCC manual.
> >   https://gcc.gnu.org/onlinedocs/gcc-3.3.5/gcc/Xtensa-Options.html
> > But, I cannot see them in recent gcc manuals.
> > So, I have no idea better than checking __XTENSA_EB__ or __XTENSA_EL__.
> > I just moved the logic to Kconfig from Makefile.
> >
> >
> >  arch/xtensa/Kconfig  | 6 ++++++
> >  arch/xtensa/Makefile | 9 +--------
> >  2 files changed, 7 insertions(+), 8 deletions(-)
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Please let me know if I should take it into the xtensa tree or you will
> carry it in the kbuild tree.


Please apply it to the xtensa tree.


I also submitted 3 patches to clean up xtensa syscall table generation.

https://lore.kernel.org/patchwork/project/lkml/list/?series=487007

They should go to the xtensa tree as well.



-- 
Best Regards
Masahiro Yamada
