Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41F343569
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 23:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhCUWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 18:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhCUWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 18:40:09 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC36C061762
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:40:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 94so11093922qtc.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1gQOrs/ZpD4A1Mlz2tYlO7V7Jm5o1P9ufuoYoj7rvo=;
        b=YuYux+KFgYgcTeMRluVC4kYpXXLwlcQe7QHZfN+jndhBfWQcoFniYAQRdug1VoxnXt
         OPcorrA+TTtJN61EuFr7PCpKjpmEhn06y4Zs+gaV8BD0vDhvIgmySgqP3zksPUcSdM1c
         K+WyBZ/gi7lSm1+aPpMM2HHu7tBpchh3mTuxTv9b3v19c/5o1NeLEIsTjejvTQpkH/rZ
         r14oyDyBh1+P8hhYB+KiyXw/IgNgpmidRJ1UU8wdLUgv4Hw+HdMVs5Yo4vTpXqmjQZC2
         oGBrMTXX5LOaC3Z+nitY+h6jrqoPLoLRuOh25G9rW+jlUomJWDsEi7sckYW/i0COhqJy
         taeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U1gQOrs/ZpD4A1Mlz2tYlO7V7Jm5o1P9ufuoYoj7rvo=;
        b=UOjmCa7ZrC8RYpj0Z2N6n5o7QskoSzsypb3OVelpM43CX00r6pVVzgzBMnXWfF0JZR
         oq4ECWMp8qSBjSZCha5I30VVStXriaE7/3fzWhGD6umM1Boy1DN0bF2AD3e0EBfkj2RE
         HUZ2VTxv+AMPYTBsFwuYbPk2fU3CW8Og7fj/cbl3rEerPkSRmepd5/3IzfuZcCrZDZEH
         aKZS+jilejAxcc1V7lI6Ijtk+cg+QVb8sXy1nkBZtRox2zAQ9AFXUJVzJEbJwjA74tmq
         vXdBmr4oc9UP6xEsbmH2Lq+JXQr4vyYkAgt+LivgfXCYOIpswgUM2zdGMms90eu0qVV5
         sE+A==
X-Gm-Message-State: AOAM531OVGTFWrLhA6/B8npTUyWebUrSeaHWuR4uOeWP6YG+jau6tkKb
        QzPtIEKFitiWoZ9GKH/Iv2E=
X-Google-Smtp-Source: ABdhPJwpBWnZzOhqE3bNUeBYQQD1XbR9fk1wSgLl6YiyJSAfdLpie1Kxt0+3qhMzr0cV5qId4SS+7g==
X-Received: by 2002:ac8:6695:: with SMTP id d21mr7624490qtp.269.1616366408258;
        Sun, 21 Mar 2021 15:40:08 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id 1sm7697219qtw.3.2021.03.21.15.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:40:07 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS
Date:   Sun, 21 Mar 2021 18:40:03 -0400
Message-ID: <2439979.pz5sKB06L4@ubuntu-mate-laptop>
In-Reply-To: <CAMuHMdW1YVmKd4+MJEZvpF0iovP3b8ukh4ExpFdDUR6+UXf6WQ@mail.gmail.com>
References: <20210320001518.93149-1-julianbraha@gmail.com> <CAMuHMdW1YVmKd4+MJEZvpF0iovP3b8ukh4ExpFdDUR6+UXf6WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, March 21, 2021 2:28:43 PM EDT you wrote:
> Hi Julian,
> 
> On Sat, Mar 20, 2021 at 1:17 AM Julian Braha <julianbraha@gmail.com> wrote:
> > When LATENCYTOP is enabled and ARCH_WANT_FRAME_POINTERS
> > is disabled, Kbuild gives the following warning:
> >
> > WARNING: unmet direct dependencies detected for FRAME_POINTER
> >   Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS [=n] || MCOUNT [=n]
> >   Selected by [y]:
> >   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] && PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> >
> > This is because LATENCYTOP selects FRAME_POINTER,
> > without selecting or depending on ARCH_WANT_FRAME_POINTERS,
> > despite FRAME_POINTER depending on ARCH_WANT_FRAME_POINTERS.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1675,6 +1675,7 @@ config LATENCYTOP
> >         depends on DEBUG_KERNEL
> >         depends on STACKTRACE_SUPPORT
> >         depends on PROC_FS
> > +       select ARCH_WANT_FRAME_POINTERS if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> 
> ARCH_WANT_FRAME_POINTERS is a symbol that is only to be selected by
> architecture-specific configuration, and must not be overridden:
> 
>     # Select this config option from the architecture Kconfig, if it
>     # is preferred to always offer frame pointers as a config
>     # option on the architecture (regardless of KERNEL_DEBUG):
> 
> Probably this should be turned into a depends instead?
> 
> >         select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
> >         select KALLSYMS
> >         select KALLSYMS_ALL
> > --
> > 2.25.1
> >
> 
> 
> 

Hi Geert,

Making this a 'depends' causes a recursive dependency error. 
Any other ideas?

- Julian Braha



