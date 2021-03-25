Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153CC348E11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhCYKcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCYKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:32:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FCFC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:32:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t5so879739qvs.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riedSrKtxw3fAlSP6DjMpmEAF9/MIT8ZMEFek292R7I=;
        b=YcMr+TvI4OCyWLgDrnHkhv9PzsxmuqCIDPmMKU8XdQq0lWz3VVZpEHHpBG4sZcjE9K
         q/mDJnqzGVAiMGNV5Ch08qUvW7yJLFR7siZWCDmuTKcAajDeJHVmZiJLtpbbzJoqw9JP
         AfCGOasvb0O/XPFzPrBdlP9sae+99QbV4AagFSDwZqZdK6lOh/J61GZF091PvZ9QY+td
         4LqEBxzSi5jAI3yWiUw+jxOGaOrAWGVOCzl9GWVCVuNMCw7PgYDkOgOE8YsJDWX7sdOl
         vN/Rsfwhdblgnd5I2oBFF7VrT3xOW0zzhIYbeIhjR77U7Iqyv+oHdRvpPr1bMu6nmgjr
         Klew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riedSrKtxw3fAlSP6DjMpmEAF9/MIT8ZMEFek292R7I=;
        b=bHiTEiqu9ZvTqu+3dtso7eBMNcEluVUe5ohDIbUAm+sDn5KDRyllFPU1m975/xuO6/
         8Kk6g5JSzvnDA/tZ1kG5vPqlNpsX5BAwZVIobt/OiQfdGp3xmtYPE1lA9U0kjTbul5or
         MXFJNc1SDGHp/IXknvU3C39sNS6b11WVTYxHn0BfRWEgJ5G0ak5DO0Csmne9hSghUPUW
         nRh6j4xWMaruc+aAwTC25MoUfhePLy73y5QoC5BoDiKFwmu4B529oKrWSio9HDtH3C/c
         eTTIsecUoEGzXfvDa496oXR0u6pP+HxIHkL+Y7g2LWpYKqdpKq3nQ+QJhp3g2/PLWyNA
         /eqQ==
X-Gm-Message-State: AOAM5329un6k//STNowDTJVC/K2GJrWWZ7PxZc12uGKtLZNlyfCDUNAd
        /9O1rhQ1kmSeSAj3vz69t1ZJVvlCH9rk/H56RjC2Ee6vmjgi8A==
X-Google-Smtp-Source: ABdhPJxGROXp5MxcFZvufqmTL1sh8SUTKf370i2ucKM2mfF4xF/OXdIVhXNeW6UbM6KFxRZjwlxFUBW/tA6q51kVcmY=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr7366855qvb.23.1616668358041;
 Thu, 25 Mar 2021 03:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210323064923.2098711-1-dvyukov@google.com> <CANn89iJOignHVg-QOtEB_RVqca=pMczJv-k=CEtPRH0d4fSdgA@mail.gmail.com>
 <CACT4Y+YjJBkbi-u6VTikhHO4OjXhdKnQTqDiHxB5BEZG2Qn7qg@mail.gmail.com> <CANn89iJBz4NjRzaAyP8gFGzu1y=3YeLOEZ8CLMqv5aUkP7wRvw@mail.gmail.com>
In-Reply-To: <CANn89iJBz4NjRzaAyP8gFGzu1y=3YeLOEZ8CLMqv5aUkP7wRvw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 11:32:27 +0100
Message-ID: <CACT4Y+bSaYREQgtDX-wCMObjyMO0=8FbWduRHxk5nHAkZFc6WQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: make unregister netdev warning timeout configurable
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Leon Romanovsky <leon@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 9:46 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Mar 25, 2021 at 8:39 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:40 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Tue, Mar 23, 2021 at 7:49 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > netdev_wait_allrefs() issues a warning if refcount does not drop to 0
> > > > after 10 seconds. While 10 second wait generally should not happen
> > > > under normal workload in normal environment, it seems to fire falsely
> > > > very often during fuzzing and/or in qemu emulation (~10x slower).
> > > > At least it's not possible to understand if it's really a false
> > > > positive or not. Automated testing generally bumps all timeouts
> > > > to very high values to avoid flake failures.
> > > > Add net.core.netdev_unregister_timeout_secs sysctl to make
> > > > the timeout configurable for automated testing systems.
> > > > Lowering the timeout may also be useful for e.g. manual bisection.
> > > > The default value matches the current behavior.
> > > >
> > > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=211877
> > > > Cc: netdev@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > >
> > > > ---
> > > > Changes since v1:
> > > >  - use sysctl instead of a config
> > > > ---
> > >
> > > >         },
> > > > +       {
> > > > +               .procname       = "netdev_unregister_timeout_secs",
> > > > +               .data           = &netdev_unregister_timeout_secs,
> > > > +               .maxlen         = sizeof(unsigned int),
> > > > +               .mode           = 0644,
> > > > +               .proc_handler   = proc_dointvec_minmax,
> > > > +               .extra1         = SYSCTL_ZERO,
> > > > +               .extra2         = &int_3600,
> > > > +       },
> > > >         { }
> > > >  };
> > > >
> > >
> > > If we allow the sysctl to be 0, then we risk a flood of pr_emerg()
> > > (one per jiffy ?)
> >
> > My reasoning was that it's up to the user. Some spammy output on the
> > console for rare events is probably not the worst way how root can
> > misconfigure the kernel :)
> > It allows one to check (more or less) if we are reaching
> > unregister_netdevice with non-zero refcount, which may be useful for
> > some debugging maybe.
> > But I don't mind changing it to 1 (or 5) if you prefer. On syzbot we
> > only want to increase it.
> >
>
> Yes, please use a lower limit of one to avoid spurious reports.

This commit is already in net-next and net-next is not rebased, right?
I sent a separate fix as "net: change netdev_unregister_timeout_secs
min value to 1".
