Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF735DB05
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbhDMJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbhDMJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:23:11 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:22:52 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id s2so5102169uap.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3+fqnoLwxyQPHQHnoLLAVQBCiytVesKrPDDSyoe7Zqg=;
        b=QvOv1wOuaUSs/Qm4R+41uWhRkCEcpDeQWbvMM4smQD31kuqRumI1NyigCeageOAdaE
         I4fMOa0DXTfi3G0aTmh+6redYSzmYSvn8w1B5m4CkzgrE1W2t4OgOv4eyq2cYPzWfwTz
         ziCG1/UxTtcjZk1PiQGSv+YSBhCa60yNjLGDBnBzHiz7iq4+huRbuMkc9o7OuiZlcs+e
         C29ixSkYJdx6sW5Sc3JLDZHPth1M6RhsT9dxzGuZPWDvD5pbavGh/7DMz7bTR1hVrQAD
         iF2bMOhKSFDXoePtFFDYzCla4ZcIR0HKbs4gY10KtaZ2rEmnHxnp4NvnoOWcyEsqVz4X
         qD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3+fqnoLwxyQPHQHnoLLAVQBCiytVesKrPDDSyoe7Zqg=;
        b=BATPbLSf0Kq6qtEZpRjaW4OJbenMt0ckSPguNjzSTb0OoIIxc2Yb3PcJj5TRCgWFoa
         9+WKIjGxTZn2qf7GrO+SmeUGOJO9rb7bKY5jU/v9XezYFPGUIY/yeW6ubThY/2FWssfZ
         v0n7CnNjewMWXaUnDqnxbkWC5lB4CRvvLwcoeR7DgtEW5ghEh1VQ+DYQYkblvwqytkiO
         cbPrHH/B552oMo6r72Ivp8HWJLSSUzN1E8JvIVPbNlMdhkhXQ2UnWh4r43veyThlgxmV
         xYapZUY4prgr7NZhr2hOK4ClPnOtuqbeJYAEnP+jOT5SUQG23DdQFCkYPTyAeRdCwfvV
         aReg==
X-Gm-Message-State: AOAM533VHCIXzCEisCFpin5zEhaxOTIsgIsffy4V3LkNVCUYJoIOn/bw
        7FmLPCqi5jNyQa6+YNsDXsaWPbP7Ips3jQONfao=
X-Google-Smtp-Source: ABdhPJwCsSi4s4YrIkf6QDZ0+X7eoYdJ+MGzKe+aVa0JddnDAt4pwi6WTWzy1mAn31Yln4iO8o5BWzyJHJW8fmDzKTc=
X-Received: by 2002:a9f:2c90:: with SMTP id w16mr22430324uaj.88.1618305771239;
 Tue, 13 Apr 2021 02:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com> <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
In-Reply-To: <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Tue, 13 Apr 2021 11:22:40 +0200
Message-ID: <CAHB2gtTmGt=V4cUgbt3zGgi+y5h0f5ON0n+MdRC8P=su670qhQ@mail.gmail.com>
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

On Tue, Apr 13, 2021 at 10:03 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
> On Mon, Apr 12, 2021 at 11:54:55PM +0200, Christoph M=C3=BCllner wrote:
> > On Mon, Apr 12, 2021 at 7:33 PM Palmer Dabbelt <palmer@dabbelt.com> wro=
te:
>
> > > My plan is to add a generic ticket-based lock, which can be selected =
at
> > > compile time.  It'll have no architecture dependencies (though it'll
> > > likely have some hooks for architectures that can make this go faster=
).
> > > Users can then just pick which spinlock flavor they want, with the id=
ea
> > > being that smaller systems will perform better with ticket locks and
> > > larger systems will perform better with queued locks.  The main goal
> > > here is to give the less widely used architectures an easy way to hav=
e
> > > fair locks, as right now we've got a lot of code duplication because =
any
> > > architecture that wants ticket locks has to do it themselves.
> >
> > In the case of LL/SC sequences, we have a maximum of 16 instructions
> > on RISC-V. My concern with a pure-C implementation would be that
> > we cannot guarantee this (e.g. somebody wants to compile with -O0)
> > and I don't know of a way to abort the build in case this limit exceeds=
.
> > Therefore I have preferred inline assembly for OpenSBI (my initial idea
> > was to use closure-like LL/SC macros, where you can write the loop
> > in form of C code).
>
> For ticket locks you really only needs atomic_fetch_add() and
> smp_store_release() and an architectural guarantees that the
> atomic_fetch_add() has fwd progress under contention and that a sub-word
> store (through smp_store_release()) will fail the SC.
>
> Then you can do something like:
>
> void lock(atomic_t *lock)
> {
>         u32 val =3D atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc *=
/
>         u16 ticket =3D val >> 16;
>
>         for (;;) {
>                 if (ticket =3D=3D (u16)val)
>                         break;
>                 cpu_relax();
>                 val =3D atomic_read_acquire(lock);
>         }
> }
>
> void unlock(atomic_t *lock)
> {
>         u16 *ptr =3D (u16 *)lock + (!!__BIG_ENDIAN__);
>         u32 val =3D atomic_read(lock);
>
>         smp_store_release(ptr, (u16)val + 1);
> }
>
> That's _almost_ as simple as a test-and-set :-) It isn't quite optimal
> on x86 for not being allowed to use a memop on unlock, since its being
> forced into a load-store because of all the volatile, but whatever.

What about trylock()?
I.e. one could implement trylock() without a loop, by letting
trylock() fail if the SC fails.
That looks safe on first view, but nobody does this right now.
