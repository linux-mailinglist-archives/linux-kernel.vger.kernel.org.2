Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE81835EACF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhDNC1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231379AbhDNC1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A21613D0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618367232;
        bh=vR+xGgJ1ZvdzE9ADVoHb98+6LJMTwciDUAVKDrWvdhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BHzyfHdblEjat8zBIbZgTT0PLHhMEb8vwhiy0IFBjsvH2dchUibRpAVrZM6KIdVeu
         jfXYuT0yymaRrKXTBjPIrIoZzHIRP3Z5eNGMgrsR97ou4KqGrMyhpNeqwon7s7Mcvg
         tbT8ELBtmzlmpxngU36zG+IkWbm3zZK0wQwzO3r77tq7TPpK90Ojt6cqSKIuo2+XUM
         ynCMaPpYYdsPzWQzFx2OX94Hh/kitZLAx7yR8F/t7UpH/toS8ZvCkbzmBGzDk8PJDK
         WkIo6V8prGyHnUIui/3cj0sNT82zGsyxSiF3BAtwbpOwsBm9WHpx36JRsunJPqrHJw
         4Su1BFaczsHjQ==
Received: by mail-lf1-f48.google.com with SMTP id w8so22084975lfr.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:27:12 -0700 (PDT)
X-Gm-Message-State: AOAM530l53t/+TWFZdJ13Vqk/ENJhUabTq1RTmvB5Do8O/kcWoUP2xfc
        q0iulUhm50fNLY+WTjcYXr/bWpxVd48S4O7fNNY=
X-Google-Smtp-Source: ABdhPJy7VEgmZ+iMoGsQksNaDynISBuYMg7ywSL8k0F1mmkVV8QOLDpxORYNJaXvx2rEWbV2DYsQkOmJebE39XOxVM4=
X-Received: by 2002:ac2:4e84:: with SMTP id o4mr1971646lfr.557.1618367230801;
 Tue, 13 Apr 2021 19:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
In-Reply-To: <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 14 Apr 2021 10:26:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
Message-ID: <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Peter,

On Tue, Apr 13, 2021 at 4:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 13, 2021 at 10:03:01AM +0200, Peter Zijlstra wrote:
>
> > For ticket locks you really only needs atomic_fetch_add() and
> > smp_store_release() and an architectural guarantees that the
> > atomic_fetch_add() has fwd progress under contention and that a sub-word
> > store (through smp_store_release()) will fail the SC.
> >
> > Then you can do something like:
> >
> > void lock(atomic_t *lock)
> > {
> >       u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> >       u16 ticket = val >> 16;
> >
> >       for (;;) {
> >               if (ticket == (u16)val)
> >                       break;
> >               cpu_relax();
> >               val = atomic_read_acquire(lock);
> >       }
Should it be?
       for (;;) {
               if (ticket == (u16)val) {
                       __atomic_acquire_fence();
                       break;
               }

>
> A possibly better might be:
>
>         if (ticket == (u16)val)
>                 return;
Should it be?
         if (ticket == (u16)val) {
                 __atomic_acquire_fence();
                 return;
         }

>
>         atomic_cond_read_acquire(lock, ticket == (u16)VAL);
>
> Since that allows architectures to use WFE like constructs.
>
> > }
> >
> > void unlock(atomic_t *lock)
> > {
> >       u16 *ptr = (u16 *)lock + (!!__BIG_ENDIAN__);
> >       u32 val = atomic_read(lock);
> >
> >       smp_store_release(ptr, (u16)val + 1);
> > }
> >
> > That's _almost_ as simple as a test-and-set :-) It isn't quite optimal
> > on x86 for not being allowed to use a memop on unlock, since its being
> > forced into a load-store because of all the volatile, but whatever.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
