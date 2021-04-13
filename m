Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6735DBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhDMJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhDMJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:55:42 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:55:23 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id r196so3492465vkd.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yvct8sOOJLGBQfDBsMmriT1SNCcaI/UvFZTnUoJlLes=;
        b=n5wJ519jpRHUsozl9EpZB85GUIDa6knTZm1cVVHtYhv7emYXNIYffN0LA5ODUrfJrs
         otkcLOEXj4gQwYeauLJ+mON0Shjm3cDhqf6eFCyO5TzuarbNXcfFA+WM0pvNZF1LZVRA
         JNxSjwEZ8ZcNJ/p3PFysFdHdqEcgqOfMbmOl/thAacljqF7qFJaJ3G9DrkCpx6yPPG6c
         OBxTdpQvSUrSg4De7eaSyIIKPzMJ1tAEcpWvJqmDf2fO6fhVGYTYA1xsbQMqTKSYSzY5
         3wZrwr6eWOPELGTvi12uqmOm5FrirISHqZBbidjzi3WVN0yBN7TSIy0RJQqbSHgHW34z
         zYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yvct8sOOJLGBQfDBsMmriT1SNCcaI/UvFZTnUoJlLes=;
        b=nZvTiuR6fD0NoMX0TpKNSm33o3v8qvoI6y7/82ApVklKT5yjVaodBXTz//ycC00dn6
         NglhQKBlMLIDq+dl86w3uCREQYXlZ3dlAiSRxYVoRjZid+dA9fsk3uKB41Ld5p0DV4pF
         nrxXJ0+1XaB2bLAXEbkytxxrkkixV4bjkd2NVlkXhLTfCnhFPyQHj1UXL50P2m6D47cL
         3JVjxyGAu6z3FCr08WhpOLIuAXmrShsHIDpzJ1zzU9+E+T/vHbDOFH3QPirLpJYqzijj
         5uIHpF81i+/6niqzZhY/4YHCTYitGMj36rsURyZHHsA6371xEIJaZLS5to1ffBifpP1q
         7MPQ==
X-Gm-Message-State: AOAM53300SVw/ls7GJ3l2Hf/HPTlrqpL6JwmKeM/lWte29CpqxhD1dTE
        zba6oMXhxU5Fd3KTVBUIbUOVMiutbpk9sDbjECnJnSq+qOxq6Q==
X-Google-Smtp-Source: ABdhPJwkB9gsXdYcwpLg+R/UQ27PkC7ft/YcKcFQBaZX8rf2MyQfdpHzq4CpISmuQpYkEqrOt08phUOao1p245wLzrA=
X-Received: by 2002:a1f:1184:: with SMTP id 126mr13321709vkr.21.1618307721975;
 Tue, 13 Apr 2021 02:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <20210413093059.GB15806@arm.com>
In-Reply-To: <20210413093059.GB15806@arm.com>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Tue, 13 Apr 2021 11:55:11 +0200
Message-ID: <CAHB2gtQAtcud3tKaJ0QnsQq1KP7iceRW9HZRpf30Qz+w=nMadg@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, will.deacon@arm.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:31 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph M=C3=BCllner wrote:
> > On Tue, Apr 13, 2021 at 10:03 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
> > > On Mon, Apr 12, 2021 at 11:54:55PM +0200, Christoph M=C3=BCllner wrot=
e:
> > > > On Mon, Apr 12, 2021 at 7:33 PM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
> > > > > My plan is to add a generic ticket-based lock, which can be selec=
ted at
> > > > > compile time.  It'll have no architecture dependencies (though it=
'll
> > > > > likely have some hooks for architectures that can make this go fa=
ster).
> > > > > Users can then just pick which spinlock flavor they want, with th=
e idea
> > > > > being that smaller systems will perform better with ticket locks =
and
> > > > > larger systems will perform better with queued locks.  The main g=
oal
> > > > > here is to give the less widely used architectures an easy way to=
 have
> > > > > fair locks, as right now we've got a lot of code duplication beca=
use any
> > > > > architecture that wants ticket locks has to do it themselves.
> > > >
> > > > In the case of LL/SC sequences, we have a maximum of 16 instruction=
s
> > > > on RISC-V. My concern with a pure-C implementation would be that
> > > > we cannot guarantee this (e.g. somebody wants to compile with -O0)
> > > > and I don't know of a way to abort the build in case this limit exc=
eeds.
> > > > Therefore I have preferred inline assembly for OpenSBI (my initial =
idea
> > > > was to use closure-like LL/SC macros, where you can write the loop
> > > > in form of C code).
> > >
> > > For ticket locks you really only needs atomic_fetch_add() and
> > > smp_store_release() and an architectural guarantees that the
> > > atomic_fetch_add() has fwd progress under contention and that a sub-w=
ord
> > > store (through smp_store_release()) will fail the SC.
> > >
> > > Then you can do something like:
> > >
> > > void lock(atomic_t *lock)
> > > {
> > >         u32 val =3D atomic_fetch_add(1<<16, lock); /* SC, gives us RC=
sc */
> > >         u16 ticket =3D val >> 16;
> > >
> > >         for (;;) {
> > >                 if (ticket =3D=3D (u16)val)
> > >                         break;
> > >                 cpu_relax();
> > >                 val =3D atomic_read_acquire(lock);
> > >         }
> > > }
> > >
> > > void unlock(atomic_t *lock)
> > > {
> > >         u16 *ptr =3D (u16 *)lock + (!!__BIG_ENDIAN__);
> > >         u32 val =3D atomic_read(lock);
> > >
> > >         smp_store_release(ptr, (u16)val + 1);
> > > }
> > >
> > > That's _almost_ as simple as a test-and-set :-) It isn't quite optima=
l
> > > on x86 for not being allowed to use a memop on unlock, since its bein=
g
> > > forced into a load-store because of all the volatile, but whatever.
> >
> > What about trylock()?
> > I.e. one could implement trylock() without a loop, by letting
> > trylock() fail if the SC fails.
> > That looks safe on first view, but nobody does this right now.
>
> Not familiar with RISC-V but I'd recommend that a trylock only fails if
> the lock is locked (after LR). A SC may fail for other reasons
> (cacheline eviction; depending on the microarchitecture) even if the
> lock is unlocked. At least on arm64 we had this issue with an
> implementation having a tendency to always fail the first STXR.

Interesting data point.
Thanks!
