Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF084343ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCVHoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:44:05 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:46611 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:43:53 -0400
Received: by mail-vk1-f171.google.com with SMTP id u144so3569940vkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8d1jAgckfxjuuMFamou6Yc9DxlDdKTJfg01fu8kdwVM=;
        b=C/zaU99K+tpbjEkwA2BhGgbyJSB9dIAlRjrFAcBb5Ia4xLHCbRSxgXo0g2hy3oAC35
         QZ/SwOe4xH7LA/LYoZ6wsPqNbAEb7GWrKFu1oXU8fNitan74fUuuSmb680NHE0fOWENv
         RUacKzrJwhb5PQ+2p4tgrc2vz5cx7XjXx1BiSwIPRHoNQIhCQaXCwETRssEzaVijeJCq
         cQr6v5l6+hJfMUDRgzOvWEq3QGsKY6ty+JU9zvequFIffyHxCxfOFoacCD/5nLxSpLzb
         L7VUa7iDpIb42lB86CsUoVUgDfoBPk3gHKWcT53I41YfGWvjC7c6c190LTbB24Z6IMDB
         gApQ==
X-Gm-Message-State: AOAM531DILPzejtY8fd8y4gPUpVYXrZTh7LfrO/J/j0UCPRG6jaihd1U
        LchBYPnf3PyLt/qkYRttIH+NpryUcVK+JctZ5RM=
X-Google-Smtp-Source: ABdhPJzwW47Lke10n/3zmeOGwi15oQx4I9WGpf3VORxfc4Mkpasxcl4E1RNdLrp3G8BH6u4OMvYrr+etK7C2/sLvf7A=
X-Received: by 2002:ac5:cbee:: with SMTP id i14mr7962732vkn.1.1616399032462;
 Mon, 22 Mar 2021 00:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210320001518.93149-1-julianbraha@gmail.com> <CAMuHMdW1YVmKd4+MJEZvpF0iovP3b8ukh4ExpFdDUR6+UXf6WQ@mail.gmail.com>
 <2439979.pz5sKB06L4@ubuntu-mate-laptop>
In-Reply-To: <2439979.pz5sKB06L4@ubuntu-mate-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Mar 2021 08:43:41 +0100
Message-ID: <CAMuHMdVyiAQC9G_-jMOU7Wk7CU9EWjCg3k71cwW1wHMi3=oy6A@mail.gmail.com>
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On Sun, Mar 21, 2021 at 11:40 PM Julian Braha <julianbraha@gmail.com> wrote:
> On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> > On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > > is disabled, Kbuild gives the following warning:
> > >
> > > WARNING: unmet direct dependencies detected for FRAME_POINTER
> > >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> > >   Selected by [y]:
> > >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > >
> > > This is because LATENCYTOP selects FRAME_POINTER,
> > > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> > >
> > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> > >         depends on DEBUG_KERNEL
> > >         depends on STACKTRACE_SUPPORT
> > >         depends on PROC_FS
> > > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> >
> > ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> > architecture-specific configuration, and must not be overridden:
> >
> >     # Select this config option from the architecture Kconfig, if it
> >     # is preferred to always offer frame pointers as a config
> >     # option on the architecture (regardless of KERNEL_DEBUG):
> >
> > Probably this should be turned into a depends instead?
> >
> > >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > >         select KALLSYMS
> > >         select KALLSYMS_ALL

> Making this a 'depends' causes a recursive dependency error.
> Any other ideas?

What about

    -select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE &&
!ARM && !ARC && !X86
    +depends on FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE
&& !ARM && !ARC && !X86

?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
