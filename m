Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31C347338
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhCXINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:13:01 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:34385 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhCXIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:12:46 -0400
Received: by mail-ua1-f46.google.com with SMTP id j4so7577719uan.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 01:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vE3vAl+mcUlo8wEoLHvlvhhXegqG2FMYz+lJtu6OQk4=;
        b=rNyozWrBqUnW0ce0OEXwtbDBrDXWxjh55VDiiTkPgdsRtFG8TXJ4WEvjTqoNLYEu1U
         6njhLjNg7lI3UKGLbyyCHTyQPJu/WGUo5To+kfxe+tMV5tJ/Xe2SzanbAVnIWXtS1OB2
         XywZmbWvjtJuZ4hVOsPoDSwQ6mwMJjXPz87UDLRh1jm8FlVeipyUZBy21XKPceV7irR0
         EBKkHvOl+DSDqaGhfODDpkEYYRG6L8RlDDIMw1Gz23rv+lS/7yZkmyj0vhByTk1m3hJN
         P4i3XfPmb6IYW82DDX7uRq3Va4tQgoPfqfW30aAqBFhJtoKWAvrQM2NwZe/jINrTTZ2k
         4qKg==
X-Gm-Message-State: AOAM533bJJlyykMCSsW9DiIZI9bIGEHaeIeE6/BNB2WLKHadiPDsUoPX
        keoqif+FKu3vykr9ZMfe3gvDKp56tGlCNkhA6Jk=
X-Google-Smtp-Source: ABdhPJyjM0M49hiXRlX7nCKTxROBa+CBsjeWie8gpl5LGJpHq1Nfwzck2qK+kYOSPEl+fcVEcvxOh7PEdJb1Yxlb9Ns=
X-Received: by 2002:ab0:3393:: with SMTP id y19mr844214uap.2.1616573565787;
 Wed, 24 Mar 2021 01:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210320001518.93149-1-julianbraha@gmail.com> <2439979.pz5sKB06L4@ubuntu-mate-laptop>
 <CAMuHMdVyiAQC9G_-jMOU7Wk7CU9EWjCg3k71cwW1wHMi3=oy6A@mail.gmail.com> <20857798.apSVmgY6Dz@ubuntu-mate-laptop>
In-Reply-To: <20857798.apSVmgY6Dz@ubuntu-mate-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Mar 2021 09:12:34 +0100
Message-ID: <CAMuHMdU+27du_WVSzWQF3O7Y2E2TDHRfpYzspH2XQXhgd+XZJA@mail.gmail.com>
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
To:     Julian Braha <julianbraha@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On Wed, Mar 24, 2021 at 7:48 AM Julian Braha <julianbraha@gmail.com> wrote:
> On Monday, March 22, 2021 3:43:41 AM EDT you wrote:
> > On Sun, Mar 21, 2021 at 11:40 PM Julian Braha <julianbraha@gmail.com> wrote:
> > > On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> > > > On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > > > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > > > > is disabled, Kbuild gives the following warning:
> > > > >
> > > > > WARNING: unmet direct dependencies detected for FRAME_POINTER
> > > > >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> > > > >   Selected by [y]:
> > > > >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > >
> > > > > This is because LATENCYTOP selects FRAME_POINTER,
> > > > > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > > > > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> > > > >
> > > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/lib/Kconfig.debug
> > > > > +++ b/lib/Kconfig.debug
> > > > > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> > > > >         depends on DEBUG_KERNEL
> > > > >         depends on STACKTRACE_SUPPORT
> > > > >         depends on PROC_FS
> > > > > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > >
> > > > ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> > > > architecture-specific configuration, and must not be overridden:
> > > >
> > > >     # Select this config option from the architecture Kconfig, if it
> > > >     # is preferred to always offer frame pointers as a config
> > > >     # option on the architecture (regardless of KERNEL_DEBUG):
> > > >
> > > > Probably this should be turned into a depends instead?
> > > >
> > > > >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > >         select KALLSYMS
> > > > >         select KALLSYMS_ALL
> >
> > > Making this a 'depends' causes a recursive dependency error.
> > > Any other ideas?
> >
> > What about
> >
> >     -select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE &&
> > !ARM && !ARC && !X86
> >     +depends on FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE
> > && !ARM && !ARC && !X86
> >
> > ?
>
> Sadly, this won't work either. In Kconfig, 'depends' cannot have an 'if' after it (only 'select' can.)
> Kbuild gives an error for this.

Oops

    select FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM
|| ARC || X86

of course.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
