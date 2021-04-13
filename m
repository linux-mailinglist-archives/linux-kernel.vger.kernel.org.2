Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7735DC73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbhDMKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243397AbhDMKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:25:32 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4077C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:25:12 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 2so8254332vsh.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0lVf0nl5+qZIZ/jwfGQvy92YMy+Bwdb1xbccBw3TFn4=;
        b=OQucTICyR/tvEMXOZVjDg+CuM65o1aglrPM1pxZwsPXp1hq20Ab1ovqvtWIGG24X+0
         fa8WvN4zl0fWpYqVcXRaQSaRvwZP28mJyVG6tjv6u/oqP5CDONyT4OoUbgqf7iVrzPss
         ZXxDcWSEUkdupAb3uez+3j+IAeZXETzsvlf+0nUM4oQk0RG+7GpkEYm2AiTNMWqQHwe7
         oV079OC27O+PVqHKUUuni8LlJiYch4KoCaksdtWX8vWfpHUeoHDdCWyJp3223DAbe1Y+
         dhuO3xPCWjkggaeGDmyiXboig1YavxvI5GAsv5rrBt5qJR/R6TvavU6R5RFR7hDYmqD+
         NAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0lVf0nl5+qZIZ/jwfGQvy92YMy+Bwdb1xbccBw3TFn4=;
        b=cvmc4fHwBxKySZP263pThNIu8yxUuKVHW6sO1kof6oR+gCbj2Opqb3SVphFTY6jbmE
         E+PEBy52P+Cqk5JzDTPR6RVlkFoFeGEoDKa0Pwz317KabejpxTYWHPRuUqLdQK7eKxrn
         b/Sjwisle547VaEfBgJ+49v2xfHo+hLW+ODWSZbqc5ojUnH88Ba3LCN4cndjeoOXh0nR
         5i8NQanU4FvbHDLIRcpPNT170l9a9abgGXP06rIL9qRde3U20QJu5uHfJB+yyHV+v4Ba
         S7Dj1myibhS9wou2Hm1y9YrfCf3JZN15iQG/H43C+AEemwwmz6pddrZe1oqL8KVZu2Kb
         ECZw==
X-Gm-Message-State: AOAM530CjHEl2vq/3YkytO5I5b/JhIZVt5Qv4lC7mcoy5grNxW2K/TGS
        uEphGwPMH7BipzjINCUAm+iwfFOqttEeWd9Ha78=
X-Google-Smtp-Source: ABdhPJxnF09LZHIgut/aICnbMhcpqGlRpleSNRviOgql/+Uc9Wy5Lxs0pjY/bNLdVZZrBYZ78aDIZG9tURDVo9wKp1s=
X-Received: by 2002:a67:e40b:: with SMTP id d11mr6143063vsf.23.1618309511657;
 Tue, 13 Apr 2021 03:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net> <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
 <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net>
In-Reply-To: <YHVl8fFfdQDn+QYW@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Tue, 13 Apr 2021 12:25:00 +0200
Message-ID: <CAHB2gtTzEuD7j-+5ztui0eV6UNiEisBTgoK+2Sr=Z0b4PPXRyA@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:37 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Tue, Apr 13, 2021 at 11:22:40AM +0200, Christoph M=C3=BCllner wrote:
>
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
> Generic code has to use cmpxchg(), and then you get something like this:
>
> bool trylock(atomic_t *lock)
> {
>         u32 old =3D atomic_read(lock);
>
>         if ((old >> 16) !=3D (old & 0xffff))
>                 return false;
>
>         return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for =
RCsc */
> }

This approach requires two loads (atomic_read() and cmpxchg()), which
is not required.
Detecting this pattern and optimizing it in a compiler is quite unlikely.

A bit less generic solution would be to wrap the LL/SC (would be
mandatory in this case)
instructions and do something like this:

uint32_t __smp_load_acquire_reserved(void*);
int __smp_store_release_conditional(void*, uint32_t);

typedef union {
    uint32_t v32;
    struct {
        uint16_t owner;
        uint16_t next;
    };
} arch_spinlock_t;

int trylock(arch_spinlock_t *lock)
{
    arch_spinlock_t l;
    int success;
    do {
        l.v32 =3D __smp_load_acquire_reserved(lock);
        if (l.owner !=3D l.next)
            return 0;
        l.next++;
        success =3D __smp_store_release_conditional(lock, l.v32);
    } while (!success);
    return success;
}

But here we can't tell the compiler to optimize the code between LL and SC.=
..

>
> That will try and do the full LL/SC loop, because it wants to complete
> the cmpxchg, but in generic code we have no other option.
>
> (Is this what C11's weak cmpxchg is for?)
