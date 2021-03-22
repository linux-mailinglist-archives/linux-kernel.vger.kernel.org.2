Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F73451A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCVVSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCVVSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76669619A3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 21:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616447914;
        bh=3oLBjoNBWt0NssVyfXaYTa63nu5lkspGWQiFfkqWL1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n32+ueZW/UW2ffH44egSG6VCgOv8vyhK50R/c57UiBsPtEm6JceDn0VKZdgjKc4LA
         7Oyu2iUdkqinuXGxK48KW8pEiB9n40LLi+x4TXIbSR6JJQbx++oGFHDmUqjPVH/Q2c
         S1Q1dW+Sl1YARPO5JNQue2BN3SihClOabGo61WRF3/B0K8G6jbVUW5s4brWphPghzg
         FCi2XUbPl73pF1LWRhFYzAO0j5JZdgBPnhJxtbr1iugVqq1+Xa6Ke1R2iJvMdLS8Xq
         CetDfJ0yNGVnOoIIF/WXGnfiJXgEB8rWEUScGOYtt74F49uQjZYpbOC9YnBdAh9tts
         mX9k1VgYdvFhg==
Received: by mail-oi1-f175.google.com with SMTP id x2so14636094oiv.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:18:34 -0700 (PDT)
X-Gm-Message-State: AOAM533IRA9y5gr0TtaDrCmxO62DpOtCC9omxrn+d/CmZoWly2HwgJTx
        yCpv855CK5s456gB2NvKJkYDmIFKtcmWohopbNc=
X-Google-Smtp-Source: ABdhPJzIY4WSdob5NsbQ/Xu2yV2JesKh5eJ41rllN6bTAaEZYKqg7DsV2HbaAoIv3C/A5396GJg+T81TnRwcDwepyhk=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr814700oie.4.1616447913693;
 Mon, 22 Mar 2021 14:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210322170711.1855115-1-arnd@kernel.org> <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
In-Reply-To: <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 22:18:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
Message-ID: <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 22, 2021 at 03:32:14PM -0400, Steven Rostedt wrote:
> > On Mon, 22 Mar 2021 18:06:37 +0100
> > Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The __static_call_return0() function is declared to return a 'long',
> > > while it aliases a couple of functions that all return 'int'. When
> > > building with 'make W=1', gcc warns about this:
> > >
> > > kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
> > >  5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
> > >
> > > Change the function to return 'int' as well, but remove the cast to
> > > ensure we get a warning if any of the types ever change.
> >
> > I think the answer is the other way around. That is, to make the functions
> > it references return long instead. __static_call_return0 is part of the
> > dynamic call infrastructure. Perhaps it is currently only used by functions
> > that return int, but what happens when it is used for a function that
> > returns a pointer?

I've done a little testing on the replacement patch now, will send in a bit.

> Steve is correct. Also, why is that warning correct? On x86 we return in
> RAX, and using int will simply not inspect the upper 32 bits there.

I think the code works correctly on all architectures we support because
both 'int' and 'long' are returned in a register with any unused bits cleared.
It is however undefined behavior in C because 'int' and 'long' are not
compatible types, and the calling conventions don't have to allow this.

> And I'm fairly sure I had a pointer user somewhere recently.

I've only tested my series with 5.12-rc so far, but don't get any other
such warnings. Maybe it's in linux-next?

          Arnd
