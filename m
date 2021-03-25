Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA73485BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhCYAJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbhCYAJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:09:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B82C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 17:09:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g20so194117qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78CDgaxrZTIr41sSVDj1fBtlubpuPpSTAwtrrbeR5UQ=;
        b=fA8x9ZXJBKg0jZfv7u1lNWsJwJFWzfWSl/Gycoq8KtDr4kQsLkTTgRq9bq0OSEXH7v
         2n6XfRl9CEe32/eW5LO5H//CoMbr78lG+kUfsoz6AwXtULi4ymNYz1gsYltjaBuz6l1E
         jfy+iPrEP9lhrUEa9n5KTdlf/ThdQDGD02AapBUDnu0xfr7SYZZ/XK2sBbB4R7Nbu4YY
         ZD8LupGFnHx94EIKmM80ORxhfB5zuiqI/dbS3qNMjrlz7FMP5TstGnk1NsOgyknNTzOc
         1HxlDiylWQkHu2trkcp23tKdmyRxxTQgqGkBpoqmm1tEWvJVBC7KdtILcp4IoWizUkiu
         A9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=78CDgaxrZTIr41sSVDj1fBtlubpuPpSTAwtrrbeR5UQ=;
        b=PqSmQadtgso7/X8Bue0FidA8NiaZZ3A4N53Db5JdXQD1I5/w00zhIxy4FL7RA1RLdR
         IPWUowGLXolQBvfL2Nn9yl8Fzz2VWqwepFEuIrUZg+g78MFxbm9NcCfWHWihNe1h+qUH
         9WWAHW6zKHPiz3O63UKwkdmsz4R82Y6dcqgu1AYnBv4i8oGO1DSz9j79Z5SutvMKNWox
         04cGkUk/RoUDrZmY+i11zVjHirW06HN8Uo4UUf7z2mO8EqmJsE/Jh3txzBXnDK0TMq2W
         G1B5DOYBD9bEprLL3/g3cKEtgHoVS+CvPlfGUMhw+OCiPyw5E/NZn9u6b2PYSsF0ZmKZ
         KNRA==
X-Gm-Message-State: AOAM530fY/xwdqbVyO7igvzdeqLYZKm6UZEX4QNzbmx/b1RV1h35svna
        FTsTrc14JdVGa8s3tzcrY5S+UKd37F1vIQ==
X-Google-Smtp-Source: ABdhPJyWxoJuJwWxwAivJWWdntosZIaTqCy9w81407yrR2azG8rjhzKPK16bQRDILyi2dGCsRXO56A==
X-Received: by 2002:a05:620a:22b7:: with SMTP id p23mr5842991qkh.365.1616630952199;
        Wed, 24 Mar 2021 17:09:12 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id n6sm2396514qtx.22.2021.03.24.17.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:09:11 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Wed, 24 Mar 2021 20:09:06 -0400
Message-ID: <2598523.FcGXNBlX6l@ubuntu-mate-laptop>
In-Reply-To: <CAMuHMdU+27du_WVSzWQF3O7Y2E2TDHRfpYzspH2XQXhgd+XZJA@mail.gmail.com>
References: <20210320001518.93149-1-julianbraha@gmail.com> <20857798.apSVmgY6Dz@ubuntu-mate-laptop> <CAMuHMdU+27du_WVSzWQF3O7Y2E2TDHRfpYzspH2XQXhgd+XZJA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 24, 2021 4:12:34 AM EDT you wrote:
> Hi Julian,
> 
> On Wed, Mar 24, 2021 at 7:48 AM Julian Braha <julianbraha@gmail.com> wrote:
> > On Monday, March 22, 2021 3:43:41 AM EDT you wrote:
> > > On Sun, Mar 21, 2021 at 11:40 PM Julian Braha <julianbraha@gmail.com> wrote:
> > > > On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> > > > > On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > > > > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > > > > > is disabled, Kbuild gives the following warning:
> > > > > >
> > > > > > WARNING: unmet direct dependencies detected for FRAME_POINTER
> > > > > >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> > > > > >   Selected by [y]:
> > > > > >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > >
> > > > > > This is because LATENCYTOP selects FRAME_POINTER,
> > > > > > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > > > > > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> > > > > >
> > > > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- a/lib/Kconfig.debug
> > > > > > +++ b/lib/Kconfig.debug
> > > > > > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> > > > > >         depends on DEBUG_KERNEL
> > > > > >         depends on STACKTRACE_SUPPORT
> > > > > >         depends on PROC_FS
> > > > > > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > >
> > > > > ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> > > > > architecture-specific configuration, and must not be overridden:
> > > > >
> > > > >     # Select this config option from the architecture Kconfig, if it
> > > > >     # is preferred to always offer frame pointers as a config
> > > > >     # option on the architecture (regardless of KERNEL_DEBUG):
> > > > >
> > > > > Probably this should be turned into a depends instead?
> > > > >
> > > > > >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > > > >         select KALLSYMS
> > > > > >         select KALLSYMS_ALL
> > >
> > > > Making this a 'depends' causes a recursive dependency error.
> > > > Any other ideas?
> > >
> > > What about
> > >
> > >     -select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE &&
> > > !ARM && !ARC && !X86
> > >     +depends on FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE
> > > && !ARM && !ARC && !X86
> > >
> > > ?
> >
> > Sadly, this won't work either. In Kconfig, 'depends' cannot have an 'if' after it (only 'select' can.)
> > Kbuild gives an error for this.
> 
> Oops
> 
>     select FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM
> || ARC || X86
> 
> of course.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

Hi Geert,

I think it's a typo, but if you meant:
select FRAME_POINTER if MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
Then that works.

- Julian Braha



