Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634D835F894
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbhDNQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhDNQBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:01:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D8EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:00:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p3so2039986ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icceXVoPey4hMt6vHFEzNzy5qaMXyxl72j1WHxQLBeE=;
        b=SnmTAeeU+ZxSI3sl84I4BZ480EHA7xilNiFAKbf/Urg7hd/dlTXoWKACukEfT326H6
         vdNgczLU2Wq45TxJGYYmr1nEfR5buOSaDV4NiX/VkcgcPVr27tlsMzyhKokbWB0SJ6YQ
         2vk9lz7suoYHqd183IMIBJ19WJeB1q/i1E+hxW6D4TBa2vnTmGOVsalv3EBAblhaamlR
         4G8eSyl9DJwAW1Dsrazip5mbfI9xfxta2AnNWtoOXJzf8+esgi93OWUlOaeNx6QhIzBu
         IwF5WO8X9nZ4GTtyNQLmtWIBFa33NNxUnjWrRBmLFj5hhbIi2q0uDLcdjHegTBz4PNXm
         z38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icceXVoPey4hMt6vHFEzNzy5qaMXyxl72j1WHxQLBeE=;
        b=uQWgKexuqlSEIDuybbL5IEzamGegYQIMXmkA/2WzCMIAJRV6G6x1vmex+f67FSzANt
         42q9RP1WGg4P2ri564KcZsUkk2c+tPKwO3IgvboTsyat9Fk1+nDvwI1c+JNI+XlIHd5d
         OQe3OyQ3pIVXww3M3eMnCuAHblyyGtF1EKSpYzp3+9z8RKxRo31XRDtwBc6qpLmRmkH2
         MEEjOPfq6pzGs62ftBgY2WcRQXZyqg+V/UfrULFsC7qOcNWLqzw+h8Tqlhw0kVFXODwj
         674NbSyGnZA2CB40sLAHAuVG/LYh8+AZV77psBMhVQv64bwAVZf0wvT9sEo2opfMIPos
         T3Wg==
X-Gm-Message-State: AOAM533lYduI1TVYti6haZnzGRykUrz6msHBDW8bQonSt5mDu8RugLQz
        xQtwatlXzXAUg8e83YVimfH7sgvZFwJ9qjCpCCcJJA==
X-Google-Smtp-Source: ABdhPJx87DRSnJEwPvZspIxNmmiq00LhnbziJGX6aMxsS55kOJowmbp1K3DbUX7u6Nrzy5bK1JoVYD5LnmTqf0wT8kE=
X-Received: by 2002:a25:4244:: with SMTP id p65mr24750079yba.452.1618416039979;
 Wed, 14 Apr 2021 09:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210413162240.3131033-1-eric.dumazet@gmail.com>
 <20210413162240.3131033-4-eric.dumazet@gmail.com> <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
 <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com>
 <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com>
 <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com>
 <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com>
 <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com>
 <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com>
 <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
 <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com>
 <feed2c13dbe34279a03929a588c46c67@AcuMS.aculab.com> <CAOFY-A21tjC5dWwM0W0aXHij40kKj2JNo5Nq4X8mBZZdKwr+AA@mail.gmail.com>
 <2c6885b0241d4127b8cb7e38abbbe1e5@AcuMS.aculab.com>
In-Reply-To: <2c6885b0241d4127b8cb7e38abbbe1e5@AcuMS.aculab.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 14 Apr 2021 18:00:28 +0200
Message-ID: <CANn89iJj9254GORTsabwv6ZBPWzebR4iYAj9VYxuOZSrF99fNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     David Laight <David.Laight@aculab.com>
Cc:     Arjun Roy <arjunroy@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 9:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arjun Roy
> > Sent: 13 April 2021 23:04
> >
> > On Tue, Apr 13, 2021 at 2:19 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > > If we're special-casing 64-bit architectures anyways - unrolling the
> > > > 32B copy_from_user() for struct rseq_cs appears to be roughly 5-10%
> > > > savings on x86-64 when I measured it (well, in a microbenchmark, not
> > > > in rseq_get_rseq_cs() directly). Perhaps that could be an additional
> > > > avenue for improvement here.
> > >
> > > The killer is usually 'user copy hardening'.
> > > It significantly slows down sendmsg() and recvmsg().
> > > I've got measurable performance improvements by
> > > using __copy_from_user() when the buffer since has
> > > already been checked - but isn't a compile-time constant.
> > >
> > > There is also scope for using _get_user() when reading
> > > iovec[] (instead of copy_from_user()) and doing all the
> > > bound checks (etc) in the loop.
> > > That gives a measurable improvement for writev("/dev/null").
> > > I must sort those patches out again.
> > >
> > >         David
> > >
> >
> > In this case I mean replacing copy_from_user(rseq_cs, urseq_cs,
> > sizeof(*rseq_cs)) with  4 (x8B=32 total) unsafe_get_user() (wrapped in
> > user_read_access_begin/end()) which I think would just bypass user
> > copy hardening (as far as I can tell).
>
> Yes that is one advantage over any of the get_user() calls.
> You also lose all the 'how shall we optimise this' checks
> in copy_from_user().
>
> Repeated unsafe_get_user() calls are crying out for an optimisation.
> You get something like:
>         failed = 0;
>         copy();
>         if (failed) goto error;
>         copy();
>         if (failed) goto error;
> Where 'failed' is set by the fault handler.
>
> This could be optimised to:
>         failed = 0;
>         copy();
>         copy();
>         if (failed) goto error;
> Even if it faults on every invalid address it probably
> doesn't matter - no one cares about that path.


On which arch are you looking at ?

On x86_64 at least, code generation is just perfect.
Not even a conditional jmp, it is all handled by exceptions (if any)

stac
copy();
copy();
clac


<out_of_line>
efault_end: do error recovery.



>
> I've not really looked at how it could be achieved though.
>
> It might be that the 'asm goto with outputs' variant
> manages to avoid the compare and jump.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
