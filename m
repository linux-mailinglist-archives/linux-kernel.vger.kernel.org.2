Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB0244C44F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhKJPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKJPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:25:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53603C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:22:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o29so2555317wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 07:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVisaRti7NFa9yhvUdiqXQvmi2dDDWJNlCuijgPtngA=;
        b=mYm26OggpdJRF+3j/ObGMOoEn8buavasWLX608adsfYeSCQSiodm6+kv89jqVAjYcT
         EOPuC0gZoSHe2qeT7xMh8aU4Qe5fuPn3nrQojMkLFbshOKMuhM9t0wug2XwwzDrwtIBk
         28A//MMVtzwSOv2QbrmgAO/2nI7v7CMscH01Y/z9+P6h0mFALc0pN9L3Yx2ki+vVH0tv
         IccsLTET77RRPmOaXIxM9vRcysdLWLChrBbpc+rxU0+9qFCVzFVL9mzIU9ybHevANoxB
         QhhIB+oJ1ElAG3/2FyXPAPYj39fVOgJD8DF9BoPCBv1Db76V064w5Tw5oC6I22e/ICAc
         Jc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVisaRti7NFa9yhvUdiqXQvmi2dDDWJNlCuijgPtngA=;
        b=IifSRznwYppFae38Q29/04vrJHQ4BGkdcfp2jo3QU4WYo30So+3hCDD8vPXQKdPxCK
         VNrC8VTdEXVG488VhZztPqS8eqGxyR00KU9RdKMUujQRlNSI57MkUkrAzwMwvLti0dkq
         AvMS87zbTLr9gkCibQkNt9Rgz0LtnUogImnl4hx0cchB7BCJzDj1Y2eClFUgRqtysG05
         PbIuu2/zjewzu/bhA3fbKAY5BcKRlZQMXRn0K9XUQMn3+Xx6c3A62Ns7NL9BHxyZ9WfA
         L+U980vNUUABac5i5EAjMb8A3VD58GYPI/e/DI6WuIZDcOZd8ltAJ6Kb01yPtSil6G/b
         /Tpg==
X-Gm-Message-State: AOAM531k/Mt3Y4AtIkN5FoCzTMpK+BtEsYrWJRLgiPouyA4slcOi6mmc
        50Ax1dUebF3XZYZqqRmWxosT4CvoNj15sRlnzcSyBg==
X-Google-Smtp-Source: ABdhPJxqTRdsAZjIcbVUvkLZhidokD7qPp3VdRemneycNKj+9HXAuzG9Hf+jsUP4BN7GDcDsA71Gbk00M9spdG3HFbY=
X-Received: by 2002:a05:600c:1f13:: with SMTP id bd19mr1236688wmb.9.1636557770583;
 Wed, 10 Nov 2021 07:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com> <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
 <CAMj1kXF8makQnZaWDpyzQc2ZiwQEU1ACYhrA91UaFT6S-6RXaQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF8makQnZaWDpyzQc2ZiwQEU1ACYhrA91UaFT6S-6RXaQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Nov 2021 07:22:37 -0800
Message-ID: <CANn89i+STEwQkEN4hF-gx0WWrL8x5xg=8EDb5O_jf9f3MNVPEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] jump_label: refine placement of static_keys
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 2:24 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 10 Nov 2021 at 09:36, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 05:09:06PM -0800, Eric Dumazet wrote:
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
> > > used for the control path.
> > >
> > > Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
> > > Otherwise we place them out of the way to increase data locality.
> > >
> > > This patch adds __static_key to centralize this new policy.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  arch/x86/kvm/lapic.c       |  4 ++--
> > >  arch/x86/kvm/x86.c         |  2 +-
> > >  include/linux/jump_label.h | 25 +++++++++++++++++--------
> > >  kernel/events/core.c       |  2 +-
> > >  kernel/sched/fair.c        |  2 +-
> > >  net/core/dev.c             |  8 ++++----
> > >  net/netfilter/core.c       |  2 +-
> > >  net/netfilter/x_tables.c   |  2 +-
> > >  8 files changed, 28 insertions(+), 19 deletions(-)
> > >
> >
> > Hurmph, it's a bit cumbersome to always have to add this __static_key
> > attribute to every definition, and in fact you seem to have missed some.
> >
> > Would something like:
> >
> >         typedef struct static_key __static_key static_key_t;
> >
> > work? I forever seem to forget the exact things you can make a typedef
> > do :/
>
> No, that doesn't work. Section placement is an attribute of the symbol
> not of its type. So we'll need to macro'ify this.

Yes, this is also why I chose a short __static_key (initially I was
using something more descriptive but longer)

>
> But I'm not sure I understand why we need different policies here.
> Static keys are inherently __read_mostly (unless they are not writable
> to begin with), so keeping them all together in one place in the
> binary should be sufficient, no?

It is not optimal for CONFIG_JUMP_LABEL=n cases.

For instance, networking will prefer having rps_needed / rfs_needed in
the same cache lines than other hot read_mostly stuff,
instead of being far away in other locations.

ffffffff830e0f80 D dev_weight_tx_bias
ffffffff830e0f84 D dev_rx_weight
ffffffff830e0f88 D dev_tx_weight
ffffffff830e0f8c D gro_normal_batch
ffffffff830e0f90 D rps_sock_flow_table
ffffffff830e0f98 D rps_cpu_mask
ffffffff830e0f9c D rps_needed
ffffffff830e0fa0 D rfs_needed
ffffffff830e0fa4 D netdev_flow_limit_table_len
ffffffff830e0fa8 d netif_napi_add.__print_once
ffffffff830e0fac D netdev_unregister_timeout_secs
ffffffff830e0fb0 D ptype_base


When CONFIG_JUMP_LABEL=y, rps_needed/xps_needed being in a remote
location is a win because it 'saves' 32 bytes than can be used better
