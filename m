Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20F44C622
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhKJRqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKJRqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:46:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F6DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:43:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d3so5395921wrh.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/HycvNCB34/xdYOHnt+wT2oilNf61VQEBagu7b9/H0=;
        b=TFGa9Tteoxl+FrsLUJDcW3zqFTZQpIYagnB11lyM0oQP+8FCohxCS6+wdeAY5UVpeg
         2IRt0R7SovCnTuhUwLIs88YXfLVIT6yHEdWn8s4K0+5dUM1wQmHkMgcAcrge2lkqESLv
         dtJALp26jLrqSlLJq/MeNd804P7z7/hOoUxhm6nYDWmauGA4g49EhaitRap8LQDxBTVt
         iIxd++2V8WaOBwOZCYaN63f9eDOWL204Y475hYPSE/R518oS1wu7i2uUheNvNXvBhuO9
         z5rJgh4YlqZ6KrxSN55S1DXbaoMWqZJJnJy8h1zEy2xjrmil1a/WrtdNlQLIHlvPhVH1
         smDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/HycvNCB34/xdYOHnt+wT2oilNf61VQEBagu7b9/H0=;
        b=Tq4uzOszGAI9wvQ8DtL+V17NJ+Tw3KL8ThZuEFWP8u7QzlEyAAdBOGGpPFZCSOlgV0
         H0EqhObBUyStXhntpmPS003KlhkZzg3fPH8FR/aDHKvOuvFQmEqhetfesokp3fcftqTE
         sdM4DC3iIvyiKrk0dVG5qiR6x2RuWnRjZFK7LX/P6VTe9a/I3s2x+nEPR691FL7PKmVt
         ejzzub4obM8QdCaQaQ1Rfmsoj+gvZIDHuuq1Qo1hCB1p9pxcB4/XUdUyfrS8WhQZ6uwI
         ARVAC0ReDC4bVsDV6wip2CTzlDRHmb8XA9wf6cWCPI0w0HcqVsyCWAp/jNSh2aPzhmcB
         oAMQ==
X-Gm-Message-State: AOAM533bjjVaPvBqyqIIXOEDwfGPXOqnc7dEmCxXd0t/DlN42GZpZ3yx
        +ryWuvv0gEuMxVRjT1GqgyPovdc/8pgtTfZD0ZBaFa9dmdQIYWrB
X-Google-Smtp-Source: ABdhPJyCP46pjtoIZCgSJuKrg6d5/8D3VwMyLEeMwPCgg45LURy8bNHHwNTkKGXKEooSn07Bac68o+dHf+sKdBA4WMA=
X-Received: by 2002:adf:f40b:: with SMTP id g11mr991302wro.296.1636566232638;
 Wed, 10 Nov 2021 09:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com> <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
 <CAMj1kXF8makQnZaWDpyzQc2ZiwQEU1ACYhrA91UaFT6S-6RXaQ@mail.gmail.com>
 <CANn89i+STEwQkEN4hF-gx0WWrL8x5xg=8EDb5O_jf9f3MNVPEQ@mail.gmail.com> <CAMj1kXFOznCFN=P-6PMv+GN8w1=pYNL0gpC4S6ke5aCBmh3wTA@mail.gmail.com>
In-Reply-To: <CAMj1kXFOznCFN=P-6PMv+GN8w1=pYNL0gpC4S6ke5aCBmh3wTA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Nov 2021 09:43:39 -0800
Message-ID: <CANn89iKAhZx3xRBO4gH-4SCZzUJoZy0HwkB8d5-zcA_uGQ4b1g@mail.gmail.com>
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

On Wed, Nov 10, 2021 at 9:06 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 10 Nov 2021 at 16:22, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 2:24 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 10 Nov 2021 at 09:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Nov 09, 2021 at 05:09:06PM -0800, Eric Dumazet wrote:
> > > > > From: Eric Dumazet <edumazet@google.com>
> > > > >
> > > > > With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
> > > > > used for the control path.
> > > > >
> > > > > Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
> > > > > Otherwise we place them out of the way to increase data locality.
> > > > >
> > > > > This patch adds __static_key to centralize this new policy.
> > > > >
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > ---
> > > > >  arch/x86/kvm/lapic.c       |  4 ++--
> > > > >  arch/x86/kvm/x86.c         |  2 +-
> > > > >  include/linux/jump_label.h | 25 +++++++++++++++++--------
> > > > >  kernel/events/core.c       |  2 +-
> > > > >  kernel/sched/fair.c        |  2 +-
> > > > >  net/core/dev.c             |  8 ++++----
> > > > >  net/netfilter/core.c       |  2 +-
> > > > >  net/netfilter/x_tables.c   |  2 +-
> > > > >  8 files changed, 28 insertions(+), 19 deletions(-)
> > > > >
> > > >
> > > > Hurmph, it's a bit cumbersome to always have to add this __static_key
> > > > attribute to every definition, and in fact you seem to have missed some.
> > > >
> > > > Would something like:
> > > >
> > > >         typedef struct static_key __static_key static_key_t;
> > > >
> > > > work? I forever seem to forget the exact things you can make a typedef
> > > > do :/
> > >
> > > No, that doesn't work. Section placement is an attribute of the symbol
> > > not of its type. So we'll need to macro'ify this.
> >
> > Yes, this is also why I chose a short __static_key (initially I was
> > using something more descriptive but longer)
> >
> > >
> > > But I'm not sure I understand why we need different policies here.
> > > Static keys are inherently __read_mostly (unless they are not writable
> > > to begin with), so keeping them all together in one place in the
> > > binary should be sufficient, no?
> >
> > It is not optimal for CONFIG_JUMP_LABEL=n cases.
> >
> > For instance, networking will prefer having rps_needed / rfs_needed in
> > the same cache lines than other hot read_mostly stuff,
> > instead of being far away in other locations.
> >
> > ffffffff830e0f80 D dev_weight_tx_bias
> > ffffffff830e0f84 D dev_rx_weight
> > ffffffff830e0f88 D dev_tx_weight
> > ffffffff830e0f8c D gro_normal_batch
> > ffffffff830e0f90 D rps_sock_flow_table
> > ffffffff830e0f98 D rps_cpu_mask
> > ffffffff830e0f9c D rps_needed
> > ffffffff830e0fa0 D rfs_needed
> > ffffffff830e0fa4 D netdev_flow_limit_table_len
> > ffffffff830e0fa8 d netif_napi_add.__print_once
> > ffffffff830e0fac D netdev_unregister_timeout_secs
> > ffffffff830e0fb0 D ptype_base
> >
> >
> > When CONFIG_JUMP_LABEL=y, rps_needed/xps_needed being in a remote
> > location is a win because it 'saves' 32 bytes than can be used better
>
> I understand that you want the key out of the way for
> CONFIG_JUMP_LABEL=n, but the question was why we shouldn't do that
> unconditionally. If we put all the keys together in a section, they
> will only share cachelines with each other.
>
> Also, what is the performance impact on a real world use case of this change?

Yes, this matters for low latency stuff, mostly.

For CONFIG_JUMP_LABEL=n, I suggest we do not change the current layout,
there is no need to. I do not want to risk performance regressions for
no good reason.

Unless you have something in mind _requiring_ all these atomic_t being
grouped together ?
