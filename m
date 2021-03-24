Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13153471DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhCXGtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhCXGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:48:32 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEEC0613DA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:48:32 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g24so16828620qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FugaGB3OHbWIsqHtMsVejAC91QFrntOLFBJOpWT+RNU=;
        b=KWKCeLjhof0R6IB/gEPkbbs5my9qGuBNcIdCJie7dGEYl9FgtJFgNB9SPXMo89xgA9
         27SaZs8p7DVNuyybrRaMRW+/PcgWw426YSFYak5EOvgPSelpCuzXDoJtGvNsT4u5GgYD
         IevI2ufzmnGXd1oE5co51Tr43SHZZJ7K+k0T5PQXshUrNRBVgU0pntZwB9GFopQJS5ul
         3ExeHuUFL+l7s4efU9U6Y2ZW+ufN0c13nTFOl0mgcXbSmL092Rc9WnAVUFvacuC3JhUg
         cKQgyR+OcXQWs2I/NMBlE/bSupQa5sF4+C7scxbgyv5HUT5npjO4kJ2U4NX63lCEatU1
         Dikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FugaGB3OHbWIsqHtMsVejAC91QFrntOLFBJOpWT+RNU=;
        b=Z4QY6c9fktQ+6aP7xoJ0DhhTrKzNWYDFFyHMUbMXQpj+YDnNqaZZBYNpxCUinBcPYc
         dFxwP76keiXQpxOuABl9uGIEGjbiBx/x2huCjY5Qcfn2qW4pbUyVYQbssxPv5a/Eth6n
         ZKYX5Q/y3cX+s0k/hf45XGtsJ3KKcIsPAzbT9S5XDIL2Wbobiugsyozz8P+X+eznJXNm
         8tAtak0wkRqp8lvislWWlylvDVJzuGO5ycKYuF/7opLdSRKMvcgCWRy077kJ1buz8yWs
         0rfDW4S/dyr9dvNPFoGeDV/8+V+qa6gQHabv8S84wFCgkM3c10DoNuwcEvjW4V4EjANA
         +yyQ==
X-Gm-Message-State: AOAM530E51zRZR27ikd+9jldL4PUSJnzfzfwSnBhVBU9d4VTOH8EuPE/
        QdxZjluiPl0HXMSr8e+3w1FNMmTS0DnjBA==
X-Google-Smtp-Source: ABdhPJzaIEM/Sd8KYIGOCccvg3yiLn1OV55wd1we5Ox6+KygxnJ0xWnww1yQmAbez1c+63Gc1SIgkw==
X-Received: by 2002:aed:31e2:: with SMTP id 89mr1709553qth.19.1616568511676;
        Tue, 23 Mar 2021 23:48:31 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id c5sm1051101qkg.105.2021.03.23.23.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 23:48:31 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Wed, 24 Mar 2021 02:48:26 -0400
Message-ID: <20857798.apSVmgY6Dz@ubuntu-mate-laptop>
In-Reply-To: <CAMuHMdVyiAQC9G_-jMOU7Wk7CU9EWjCg3k71cwW1wHMi3=oy6A@mail.gmail.com>
References: <20210320001518.93149-1-julianbraha@gmail.com> <2439979.pz5sKB06L4@ubuntu-mate-laptop> <CAMuHMdVyiAQC9G_-jMOU7Wk7CU9EWjCg3k71cwW1wHMi3=oy6A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 22, 2021 3:43:41 AM EDT you wrote:
> Hi Julian,
> 
> On Sun, Mar 21, 2021 at 11:40 PM Julian Braha <julianbraha@gmail.com> wrote:
> > On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> > > On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > > > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > > > is disabled, Kbuild gives the following warning:
> > > >
> > > > WARNING: unmet direct dependencies detected for FRAME_POINTER
> > > >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> > > >   Selected by [y]:
> > > >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > >
> > > > This is because LATENCYTOP selects FRAME_POINTER,
> > > > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > > > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> > > >
> > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> > > >         depends on DEBUG_KERNEL
> > > >         depends on STACKTRACE_SUPPORT
> > > >         depends on PROC_FS
> > > > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > >
> > > ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> > > architecture-specific configuration, and must not be overridden:
> > >
> > >     # Select this config option from the architecture Kconfig, if it
> > >     # is preferred to always offer frame pointers as a config
> > >     # option on the architecture (regardless of KERNEL_DEBUG):
> > >
> > > Probably this should be turned into a depends instead?
> > >
> > > >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> > > >         select KALLSYMS
> > > >         select KALLSYMS_ALL
> 
> > Making this a 'depends' causes a recursive dependency error.
> > Any other ideas?
> 
> What about
> 
>     -select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE &&
> !ARM && !ARC && !X86
>     +depends on FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE
> && !ARM && !ARC && !X86
> 
> ?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

Hi Geert,

Sadly, this won't work either. In Kconfig, 'depends' cannot have an 'if' after it (only 'select' can.)
Kbuild gives an error for this.

- Julian Braha



