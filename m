Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB335E8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348603AbhDMWEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348594AbhDMWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:04:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC75C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:04:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nm3-20020a17090b19c3b029014e1bbf6c60so5542178pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGxxVWyAs9dyahnM33mN+x7JouMtxM08wbYWDjX4hcA=;
        b=D0DK+/8IgCKY5mLNY64HrrcUKYgT/HIorOeija2J+mmicTQiU7ZdB6ioSl3E6aasXE
         UeCzHig20wQWQFjMlHg/8wI7HRFDf4kmnf85eYuUB+voTOr1UWNxYbArB+pj77OIjG+C
         lIc7uS3AF5XPQcN5Siy4HJypeZ/nxpA6xuC/QLz83JQhUv/ZBBQryFZUbYkrAszGyl33
         s7CqgHJvohgcENP4wCWOOMF9OLv3WHjFhBk08IHcO1MIGTyIwU3sBWq002SMz7MklqFB
         Xj2CUNTqhVxzjUsoNWsVR6+qxC4D2ltb24fmzjhSJb9KxWaMS5Dt336tBBYNMKEqaV77
         pjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGxxVWyAs9dyahnM33mN+x7JouMtxM08wbYWDjX4hcA=;
        b=Yvo5fbFreF1Msjef3hHXnCp3SCNuyZnQjdJK4WfLB0mH+n0DM75v5QBMHaOODBWBhy
         rDIsVoGbIYp2c5JnpR1jRjuVxx+HIDY1E7ip+fSxh6NnYvnDSbs4CLXzTe57XmkZ0Gv9
         Ye5kzN3xQHbnx2Dl0440Pck3UtBz8HMgOuBEfjrhuwGHsZqNkFdB9SeYVmEaP7TZjvwS
         jAwCNEDJc9aSuUm8ti6E+9h9LOftBpKa3gO2DJuUKfQoJHStMACTXPn/AeW+g2hgd8YT
         +e3+8Ax99aDzwWWu0SBQaszhtn1sow/cFlO9U8q0Qnta+X7geglk+IJizJ9hWV4Nl3sX
         Ok2w==
X-Gm-Message-State: AOAM531HDxpMJdZzqexQzV0EY1x5OvjKL0r7CdppkLw2ee6asII3kv4Q
        o9DD6iQOSNjed0Y3b9LJqmHt6II6E3cG+aoTZmGqwA==
X-Google-Smtp-Source: ABdhPJwyyi5IaBAgQwAyh2v2conM6EZGv2l3sL0naEvmBj9nPd6oQXG+C5L1LzQz964XMQPSXa9lphpnH1VPu22hHxc=
X-Received: by 2002:a17:90b:3b4a:: with SMTP id ot10mr2197521pjb.48.1618351445861;
 Tue, 13 Apr 2021 15:04:05 -0700 (PDT)
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
 <CAOFY-A1=2MzHvmqBEo=WBT6gWc=KnmtCWogjLdwZVDTp-zDjBQ@mail.gmail.com> <feed2c13dbe34279a03929a588c46c67@AcuMS.aculab.com>
In-Reply-To: <feed2c13dbe34279a03929a588c46c67@AcuMS.aculab.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Tue, 13 Apr 2021 15:03:54 -0700
Message-ID: <CAOFY-A21tjC5dWwM0W0aXHij40kKj2JNo5Nq4X8mBZZdKwr+AA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
To:     David Laight <David.Laight@aculab.com>
Cc:     Eric Dumazet <edumazet@google.com>,
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

On Tue, Apr 13, 2021 at 2:19 PM David Laight <David.Laight@aculab.com> wrote:
>
> > If we're special-casing 64-bit architectures anyways - unrolling the
> > 32B copy_from_user() for struct rseq_cs appears to be roughly 5-10%
> > savings on x86-64 when I measured it (well, in a microbenchmark, not
> > in rseq_get_rseq_cs() directly). Perhaps that could be an additional
> > avenue for improvement here.
>
> The killer is usually 'user copy hardening'.
> It significantly slows down sendmsg() and recvmsg().
> I've got measurable performance improvements by
> using __copy_from_user() when the buffer since has
> already been checked - but isn't a compile-time constant.
>
> There is also scope for using _get_user() when reading
> iovec[] (instead of copy_from_user()) and doing all the
> bound checks (etc) in the loop.
> That gives a measurable improvement for writev("/dev/null").
> I must sort those patches out again.
>
>         David
>

In this case I mean replacing copy_from_user(rseq_cs, urseq_cs,
sizeof(*rseq_cs)) with  4 (x8B=32 total) unsafe_get_user() (wrapped in
user_read_access_begin/end()) which I think would just bypass user
copy hardening (as far as I can tell).

-Arjun

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
