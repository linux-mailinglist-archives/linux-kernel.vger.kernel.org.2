Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08444BE85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKJK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhKJK1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:27:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75E7161246
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636539864;
        bh=QeVNYL1CDnVnsGgYCWWDeh9BlVaKep9JspI98WE81KQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hi1N5m0lKVCCZVpEKK2WpErMzrO1B9aH44pHFN1lHi6V0THXhZyOmQMbMynDypCN1
         EwTWwwqzqJ2bfvBT379BhRhGsHRDe/wCX9ndAsiMuvQ2ru425W175IYFSN0Wd0PoLK
         rBKaqiZQ1N3e+1au5hejsar8bFxbz2c2X/mE5+uuGqCmfVD1X3dNzOyDt2iclEPf7J
         jzl7HnCXW/RlF2fcyW/nZ3YCul7xHTHLjpEOnfIIKS5nmP6x0NriOlGCbJ8mQzl3Vu
         NhkGmwOTjX6Lh9HQE3snAJ6qVCDKpS8PTavGNLxpe4y2TmyOfVxajJAahWcgYS1DRG
         AAW5DZjwlFT+Q==
Received: by mail-ot1-f44.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso3149991otg.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:24:24 -0800 (PST)
X-Gm-Message-State: AOAM533icfrr8YUTB/izkTPr4Ooeb3vt4oD8RwB1SAU/9wUO4F4dm8Le
        Od2zj3iPR+XemU0yqVYeoTcjZwNjWgkmH+cStOI=
X-Google-Smtp-Source: ABdhPJzpKSeMW3/rqwzqWmvxviEwLNeCA6Xp6S06gu8Uudu/UsATvGwvwlX7d3lW10EU51NZewVH1WGkoZIN/mOwdmA=
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr3992681otp.112.1636539863786;
 Wed, 10 Nov 2021 02:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
 <20211110010906.1923210-3-eric.dumazet@gmail.com> <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
In-Reply-To: <YYuEXQ7Ur9f88pCw@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 10 Nov 2021 11:24:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF8makQnZaWDpyzQc2ZiwQEU1ACYhrA91UaFT6S-6RXaQ@mail.gmail.com>
Message-ID: <CAMj1kXF8makQnZaWDpyzQc2ZiwQEU1ACYhrA91UaFT6S-6RXaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] jump_label: refine placement of static_keys
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 at 09:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 09, 2021 at 05:09:06PM -0800, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > With CONFIG_JUMP_LABEL=y, "struct static_key" content is only
> > used for the control path.
> >
> > Marking them __read_mostly is only needed when CONFIG_JUMP_LABEL=n.
> > Otherwise we place them out of the way to increase data locality.
> >
> > This patch adds __static_key to centralize this new policy.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  arch/x86/kvm/lapic.c       |  4 ++--
> >  arch/x86/kvm/x86.c         |  2 +-
> >  include/linux/jump_label.h | 25 +++++++++++++++++--------
> >  kernel/events/core.c       |  2 +-
> >  kernel/sched/fair.c        |  2 +-
> >  net/core/dev.c             |  8 ++++----
> >  net/netfilter/core.c       |  2 +-
> >  net/netfilter/x_tables.c   |  2 +-
> >  8 files changed, 28 insertions(+), 19 deletions(-)
> >
>
> Hurmph, it's a bit cumbersome to always have to add this __static_key
> attribute to every definition, and in fact you seem to have missed some.
>
> Would something like:
>
>         typedef struct static_key __static_key static_key_t;
>
> work? I forever seem to forget the exact things you can make a typedef
> do :/

No, that doesn't work. Section placement is an attribute of the symbol
not of its type. So we'll need to macro'ify this.

But I'm not sure I understand why we need different policies here.
Static keys are inherently __read_mostly (unless they are not writable
to begin with), so keeping them all together in one place in the
binary should be sufficient, no?
