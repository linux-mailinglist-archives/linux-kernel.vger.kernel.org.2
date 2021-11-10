Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4244C5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhKJRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhKJRJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:09:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E45E61261
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636564002;
        bh=LSNqX4XlH2DA2EfyUuc+0taTvvtbGQbiqRrxnTIhyIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bpqxczzrxFE0G02fm6uopqnHqfx87M9nhh2fQoHCbOZuO5npceTFIcgpLd29Lp7L8
         0xtQIuO4ezu55+4xmNUNwp9S6N5PYPlCb/JJhI8k17b9WJOz0qqP4UVB3Zc+yCT60l
         9aZVhiWmVO3cs4eBxOboySYlJQ+1DVh9SwuPJrODbx4HvcDELkMrODkhJ1C1gS42z+
         BdMM3jN/D0507dfd4X4cAMUOwPelbLCJRiNDPa2uTVWruNw2ilAJtxVGvJFBjRJk+R
         twgujpZpETO+lCmWzBBMpqYtRAQ9oziIclYlT1+jlc8gjqA99GWMivFSSbQrAoy/LT
         XfP+X6wXqeZqA==
Received: by mail-oi1-f174.google.com with SMTP id n66so6417860oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:06:42 -0800 (PST)
X-Gm-Message-State: AOAM532JuZJ4P1O4lMO6eL9MhplOAUhmi2R1k2iEWnIOBNgd7y2dAYmt
        Okkojtx2RBIOhXHxX/uBEndaO+e/2h7Hreh4cH4=
X-Google-Smtp-Source: ABdhPJzpvQYPooMirF8dxQpK5PrmQUKJ5x+FAd4QDHdAAj2fYW7JaS5KSHeTypBKnXildhgozkTt6C33NOVv/dwwiNk=
X-Received: by 2002:a05:6808:12:: with SMTP id u18mr599162oic.174.1636564001416;
 Wed, 10 Nov 2021 09:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com> <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
 <CAMj1kXF8makQnZaWDpyzQc2ZiwQEU1ACYhrA91UaFT6S-6RXaQ@mail.gmail.com> <CANn89i+STEwQkEN4hF-gx0WWrL8x5xg=8EDb5O_jf9f3MNVPEQ@mail.gmail.com>
In-Reply-To: <CANn89i+STEwQkEN4hF-gx0WWrL8x5xg=8EDb5O_jf9f3MNVPEQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Nov 2021 18:06:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFOznCFN=P-6PMv+GN8w1=pYNL0gpC4S6ke5aCBmh3wTA@mail.gmail.com>
Message-ID: <CAMj1kXFOznCFN=P-6PMv+GN8w1=pYNL0gpC4S6ke5aCBmh3wTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] jump_label: refine placement of static_keys
To:     Eric Dumazet <edumazet@google.com>
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

On Wed, 10 Nov 2021 at 16:22, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 10, 2021 at 2:24 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 10 Nov 2021 at 09:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 09, 2021 at 05:09:06PM -0800, Eric Dumazet wrote:
> > > > From: Eric Dumazet <edumazet@google.com>
> > > >
> > > > With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
> > > > used for the control path.
> > > >
> > > > Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
> > > > Otherwise we place them out of the way to increase data locality.
> > > >
> > > > This patch adds __static_key to centralize this new policy.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  arch/x86/kvm/lapic.c       |  4 ++--
> > > >  arch/x86/kvm/x86.c         |  2 +-
> > > >  include/linux/jump_label.h | 25 +++++++++++++++++--------
> > > >  kernel/events/core.c       |  2 +-
> > > >  kernel/sched/fair.c        |  2 +-
> > > >  net/core/dev.c             |  8 ++++----
> > > >  net/netfilter/core.c       |  2 +-
> > > >  net/netfilter/x_tables.c   |  2 +-
> > > >  8 files changed, 28 insertions(+), 19 deletions(-)
> > > >
> > >
> > > Hurmph, it's a bit cumbersome to always have to add this __static_key
> > > attribute to every definition, and in fact you seem to have missed some.
> > >
> > > Would something like:
> > >
> > >         typedef struct static_key __static_key static_key_t;
> > >
> > > work? I forever seem to forget the exact things you can make a typedef
> > > do :/
> >
> > No, that doesn't work. Section placement is an attribute of the symbol
> > not of its type. So we'll need to macro'ify this.
>
> Yes, this is also why I chose a short __static_key (initially I was
> using something more descriptive but longer)
>
> >
> > But I'm not sure I understand why we need different policies here.
> > Static keys are inherently __read_mostly (unless they are not writable
> > to begin with), so keeping them all together in one place in the
> > binary should be sufficient, no?
>
> It is not optimal for CONFIG_JUMP_LABEL=n cases.
>
> For instance, networking will prefer having rps_needed / rfs_needed in
> the same cache lines than other hot read_mostly stuff,
> instead of being far away in other locations.
>
> ffffffff830e0f80 D dev_weight_tx_bias
> ffffffff830e0f84 D dev_rx_weight
> ffffffff830e0f88 D dev_tx_weight
> ffffffff830e0f8c D gro_normal_batch
> ffffffff830e0f90 D rps_sock_flow_table
> ffffffff830e0f98 D rps_cpu_mask
> ffffffff830e0f9c D rps_needed
> ffffffff830e0fa0 D rfs_needed
> ffffffff830e0fa4 D netdev_flow_limit_table_len
> ffffffff830e0fa8 d netif_napi_add.__print_once
> ffffffff830e0fac D netdev_unregister_timeout_secs
> ffffffff830e0fb0 D ptype_base
>
>
> When CONFIG_JUMP_LABEL=y, rps_needed/xps_needed being in a remote
> location is a win because it 'saves' 32 bytes than can be used better

I understand that you want the key out of the way for
CONFIG_JUMP_LABEL=n, but the question was why we shouldn't do that
unconditionally. If we put all the keys together in a section, they
will only share cachelines with each other.

Also, what is the performance impact on a real world use case of this change?
