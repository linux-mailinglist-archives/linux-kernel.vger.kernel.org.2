Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81A348A08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCYHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:21:40 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:37624 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCYHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:21:11 -0400
Received: by mail-vs1-f42.google.com with SMTP id e5so373532vse.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMarrIE38dJEGoCFm+8xTDCMMQZuIlyX+BPxsk59mEM=;
        b=RVJqOQ6973WcVsWLDMDHvlgrX5p6N/P+8t4JfQh1aL+nD4ci5TZD5N1ojRscKxziCT
         slzTM7i7mfOtpXFUILoACdiwfztY3HyKvg2S7Vtgoo8K/3pqTSQ6JRm4zG0zIt3K6kJw
         M7sTa3YVyzeT2rWOKqCCkIt/Av5AQBnskdo9QdO/Jd80wpIzNtlyPohdfp0m9TeXp2i5
         K4xcpyQm+oVcITbvKqSGGp4yeg5PfgE/6sjX9Wnw5SkmOXiBbHRfKnP9Mc9FbkShVv6g
         uWUsOraz25MFLjScHr3Ub7mSyfYN2hOk2RjJLB2nSpc0yoEd4lQaCsYkrICwUoYxDx72
         rr0w==
X-Gm-Message-State: AOAM533vO+/r6zIf4XCmrODMZKhyrDp/prMlBiYXHu8gjzwxvz2y9iF2
        FT/W8hNByOAKFEH7uRgqRf7emA25t9cEOjnwy5d2PaUqIZU=
X-Google-Smtp-Source: ABdhPJykN2WtoS5LVmYgNfg4/Q5c6loOf7Fd249EzTP/ih6CQbx/XPfYAkF0/xjyek7EuV4nxyPmii6zZXhX840+1+0=
X-Received: by 2002:a67:8883:: with SMTP id k125mr4290806vsd.18.1616656870193;
 Thu, 25 Mar 2021 00:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210320001518.93149-1-julianbraha@gmail.com> <20857798.apSVmgY6Dz@ubuntu-mate-laptop>
 <CAMuHMdU+27du_WVSzWQF3O7Y2E2TDHRfpYzspH2XQXhgd+XZJA@mail.gmail.com> <2598523.FcGXNBlX6l@ubuntu-mate-laptop>
In-Reply-To: <2598523.FcGXNBlX6l@ubuntu-mate-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Mar 2021 08:20:59 +0100
Message-ID: <CAMuHMdVaByX=ph82etGn5a0hV6+rGitD=gG8Y1zNkz7+UO+Uew@mail.gmail.com>
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On Thu, Mar 25, 2021 at 1:09 AM Julian Braha <julianbraha@gmail.com> wrote:
> On Wednesday, March 24, 2021 4:12:34 AM EDT you wrote:

> > On Wed, Mar 24, 2021 at 7:48 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > On Monday, March 22, 2021 3:43:41 AM EDT you wrote:
> > > > On Sun, Mar 21, 2021 at 11:40 PM Julian Braha <julianbraha@gmail.com> wrote:
> > > > > On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> > > > > > On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > > > > > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > > > > > > is disabled, Kbuild gives the following warning:
> > > > > > >
> > > > > > > WARNING: unmet direct dependencies detected for FRAME_POINTER
> > > > > > >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> > > > > > >   Selected by [y]:
> > > > > > >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > > >
> > > > > > > This is because LATENCYTOP selects FRAME_POINTER,
> > > > > > > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > > > > > > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> > > > > > >
> > > > > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > > > > >
> > > > > > Thanks for your patch!
> > > > > >
> > > > > > > --- a/lib/Kconfig.debug
> > > > > > > +++ b/lib/Kconfig.debug
> > > > > > > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> > > > > > >         depends on DEBUG_KERNEL
> > > > > > >         depends on STACKTRACE_SUPPORT
> > > > > > >         depends on PROC_FS
> > > > > > > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > >
> > > > > > ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> > > > > > architecture-specific configuration, and must not be overridden:
> > > > > >
> > > > > >     # Select this config option from the architecture Kconfig, if it
> > > > > >     # is preferred to always offer frame pointers as a config
> > > > > >     # option on the architecture (regardless of KERNEL_DEBUG):
> > > > > >
> > > > > > Probably this should be turned into a depends instead?
> > > > > >
> > > > > > >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > > >         select KALLSYMS
> > > > > > >         select KALLSYMS_ALL
> > > >
> > > > > Making this a 'depends' causes a recursive dependency error.
> > > > > Any other ideas?
> > > >
> > > > What about
> > > >
> > > >     -select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE &&
> > > > !ARM && !ARC && !X86
> > > >     +depends on FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE
> > > > && !ARM && !ARC && !X86
> > > >
> > > > ?
> > >
> > > Sadly, this won't work either. In Kconfig, 'depends' cannot have an 'if' after it (only 'select' can.)
> > > Kbuild gives an error for this.
> >
> > Oops
> >
> >     select FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM
> > || ARC || X86
> >
> > of course.

> I think it's a typo, but if you meant:
> select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
> Then that works.

(Bummer, I shouldn't reply to emails before my morning coffee)
Yes, it is a typo.  I meant:

    depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE ||
ARM || ARC || X86

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
