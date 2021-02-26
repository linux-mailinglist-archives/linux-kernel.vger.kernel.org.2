Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A2325DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBZHDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBZHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:03:00 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B19C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:02:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u4so12400043lfs.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x49OuNAA7q3ldYJSjcOEu3pJBfD36s7mXciQbRekJb0=;
        b=tMITdCHDdLuCxy3S/32qbXJZ86+VHkC0uFyR4ush6nMHiwC+xi4CKRwZq6S2zpQXM6
         fOwNrbN/hMHOc8r4+Q51MED5+s0jQWAa+UdhKZIzEVCLzfRftEkO4+R8YfqBsBH2D3dr
         yrStgOKlSXeZ86dKL8c3dz9qO0PxJCpMXYdqtqnoGxWVjBjGhkwOWIefZdGk7/A6+pOs
         xMEIuV1xsao2iTJVwUlvMEuq/kkSCPiX307gxmUGlySik8LsTVulgPBFxyod7n9hQOaT
         No5tmxAVrKpvClXxIIbmzuLyTSo/WDFGBEMqorUBwDkRBFp04tDaonVX9R8r8Q6ABZ/J
         /7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x49OuNAA7q3ldYJSjcOEu3pJBfD36s7mXciQbRekJb0=;
        b=UBXrkv8GQAvipq5nS7iwyvh+4FhNEvE/DfnZUnQuWK08q7wYjWEI7s1JwPan8in8rR
         Vqvw/KTYr25U9+4Ufdw/qi8u/T/9l0uyNV6aJz+Npy0ekJDWOA8w2szFuwUu82HxWfVe
         M8xhDTZyuacTxC7dZJDyrYKNodvZgNpWtkvOp5ZohEAGQ7mmQEhU79FGZaR9hA2oeL4k
         0MmgTfGGBXqinUSlCXLa8ZYp97SPh7j08cAJvIPEB43HcHNUdDA0UkXXb3nzv5BQKvnt
         WScWEz5PTGLNX9Uj7meZSDdyjH5z0uU1pumT+wl+D9tCApkCs5yZDjTjCuLxMS2S93kL
         DcRw==
X-Gm-Message-State: AOAM533cjDVL/EWyrxbbLepbfOBVebt3kDMLobcstL3uIhmY8dc42wsj
        REYUVlmDSSGyd/MqPnvi+x9dvHpCr4hYwvWe9/U2Gw==
X-Google-Smtp-Source: ABdhPJyFWiSTpK+1nRF6cL4mPPftIJJKu6Qpz/fRdVSz3dAHo0tnGwHqxfIs6AGlHV0PG60Z0ALrbSyX+iSP2Sffn1g=
X-Received: by 2002:ac2:5295:: with SMTP id q21mr947778lfm.108.1614322938536;
 Thu, 25 Feb 2021 23:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20210224081652.587785-1-sumit.garg@linaro.org> <20210225155607.634snzzq3w62kpkn@maple.lan>
In-Reply-To: <20210225155607.634snzzq3w62kpkn@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Feb 2021 12:32:07 +0530
Message-ID: <CAFA6WYMYDNk2S=7crfYsrbP7XONTA-ytEypoqeo1GTpxf8NhAQ@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix to kill breakpoints on initmem after boot
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ stable ML

On Thu, 25 Feb 2021 at 21:26, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Feb 24, 2021 at 01:46:52PM +0530, Sumit Garg wrote:
> > Currently breakpoints in kernel .init.text section are not handled
> > correctly while allowing to remove them even after corresponding pages
> > have been freed.
> >
> > Fix it via killing .init.text section breakpoints just prior to initmem
> > pages being freed.
> >
> > Suggested-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I saw Andrew has picked this one up. That's ok for me:
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> I already enriched kgdbtest to cover this (and they pass) so I guess
> this is also:
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
>

Thanks Daniel.

> BTW this is not Cc:ed to stable and I do wonder if it crosses the
> threshold to be considered a fix rather than a feature. Normally I
> consider adding safety rails for kgdb to be a new feature but, in this
> case, the problem would easily ensnare an inexperienced developer who is
> doing nothing more than debugging their own driver (assuming they
> correctly marked their probe function as .init) so I think this weighs
> in favour of being a fix.
>

Makes sense, Cc:ed stable.

-Sumit

>
> Daniel.
>
>
> > ---
> >  include/linux/kgdb.h      |  2 ++
> >  init/main.c               |  1 +
> >  kernel/debug/debug_core.c | 11 +++++++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index 57b8885708e5..3aa503ef06fc 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -361,9 +361,11 @@ extern atomic_t                  kgdb_active;
> >  extern bool dbg_is_early;
> >  extern void __init dbg_late_init(void);
> >  extern void kgdb_panic(const char *msg);
> > +extern void kgdb_free_init_mem(void);
> >  #else /* ! CONFIG_KGDB */
> >  #define in_dbg_master() (0)
> >  #define dbg_late_init()
> >  static inline void kgdb_panic(const char *msg) {}
> > +static inline void kgdb_free_init_mem(void) { }
> >  #endif /* ! CONFIG_KGDB */
> >  #endif /* _KGDB_H_ */
> > diff --git a/init/main.c b/init/main.c
> > index c68d784376ca..a446ca3d334e 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1417,6 +1417,7 @@ static int __ref kernel_init(void *unused)
> >       async_synchronize_full();
> >       kprobe_free_init_mem();
> >       ftrace_free_init_mem();
> > +     kgdb_free_init_mem();
> >       free_initmem();
> >       mark_readonly();
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 229dd119f430..319381e95d1d 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -465,6 +465,17 @@ int dbg_remove_all_break(void)
> >       return 0;
> >  }
> >
> > +void kgdb_free_init_mem(void)
> > +{
> > +     int i;
> > +
> > +     /* Clear init memory breakpoints. */
> > +     for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> > +             if (init_section_contains((void *)kgdb_break[i].bpt_addr, 0))
> > +                     kgdb_break[i].state = BP_UNDEFINED;
> > +     }
> > +}
> > +
> >  #ifdef CONFIG_KGDB_KDB
> >  void kdb_dump_stack_on_cpu(int cpu)
> >  {
> > --
> > 2.25.1
