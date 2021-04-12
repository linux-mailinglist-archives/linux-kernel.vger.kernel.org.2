Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9735D28A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhDLVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbhDLVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:22:24 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEC9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:22:04 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id p206so650398vkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GlZ6fpp1sRl5oo/cSJn2gmwB5FdWA1BS8ZVLxQB9aUY=;
        b=Trel/2tBoFIUjmTO0Ab8vXU0ikbpVKZtwsEV7BI31Lb9HYqZZbQ2R/Jnxoupvn5VJc
         zIujh3gSk2zhDcIZ5+5pDsHfpTm79CLQ+co8d/4q7Uh7JztGXxYYdvi5x5QRZan+tpAV
         pM3PBjk9fdb0bXF95oQwgZhzGCBiCq3vIsgCEFVVh2XU8exunbxA9QMW5yf7u2cgHFmK
         Mz32fumdbdQPvqtHNiUfGhpcOQ481adbKW8xr57B3ezB1fUL2Z92612TPjnfrC5lrOBt
         xdvto+eaAfvuuiaSeZbcLOKNS1wmqU/ibQz/b2gmVw7dSskAdZ+A9ORfy/ZVqNcHooXm
         RxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GlZ6fpp1sRl5oo/cSJn2gmwB5FdWA1BS8ZVLxQB9aUY=;
        b=dw7Nvk3BtzCe1s5w0iIqnuuj8KlmylYLlcV0CIUIafkIr+fJcLBFaS6zpVgmarZaQX
         /Sr7JWzV976Ywv9c1Jp1q6UtZ6K7m7GgODhKp+Ba2JpkuZqNfCSJKRuCcp5BOTuDQI38
         5Cmj9EqjxTZswpjcQofDdCDJghn3pM5AYDtWhRRUU3MIRKQs1cy5MrM0582GIdZX4CKn
         HgPE3CVIIpsi9KyrKQayeg/YoG7moN2K0WsIujwc7iFlfJ0rreW+Ke8DlxLZmX7Ldp9r
         qJ7jSGa/aBArcYQ8FW8I9HlpY8oOWnjRs7BqoU1lDHGU7B0VlN1ZBCPVLblyb+BaSVzg
         keEw==
X-Gm-Message-State: AOAM530JT17dGrxnbQ22abuDeJLM4rj3bUsl1Ue3wswjh/o4JNzENe4v
        CR+evBiIjGZj4V5c2BV9z0zJsFuSooCtg2xiL8uaJqXHrNIvk262
X-Google-Smtp-Source: ABdhPJzfCUW/YY6jX6qnMxCs36AiTlEvtpqWbO8D5fJ/UamVl3opz/IIaFmryZqPV4oojB0xFVHidXHFxHy4u1FJdf4=
X-Received: by 2002:a1f:5682:: with SMTP id k124mr21070410vkb.20.1618262523924;
 Mon, 12 Apr 2021 14:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com>
 <mhng-0bf68290-a014-43d7-b193-8ac839c5433a@palmerdabbelt-glaptop>
 <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com> <YHRei8/8cIe6BNtE@hirez.programming.kicks-ass.net>
In-Reply-To: <YHRei8/8cIe6BNtE@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Mon, 12 Apr 2021 23:21:52 +0200
Message-ID: <CAHB2gtT2+eFaMxtt9MP2r_5t=t9DeT9h4bOrkHPAFrJbGL1oZw@mail.gmail.com>
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

On Mon, Apr 12, 2021 at 4:52 PM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
>
> Please fix your mailer to properly flow text. Reflowed it for you.
>
> On Mon, Apr 12, 2021 at 03:32:27PM +0200, Christoph M=C3=BCllner wrote:
>
> > This discussion came up again a few weeks ago because I've been
> > stumbling over the test-and-set implementation and was wondering if
> > nobody cared to improve that yet.
>
> > Then I saw, that there have been a few attempts so far, but they did
> > not land.  So I brought this up in RVI's platform group meeting and
> > the attendees showed big interest to get at least fairness. I assume
> > Guo sent out his new patchset as a reaction to this call (1 or 2 days
> > later).
> >
> > We have the same situation on OpenSBI, where we've agreed (with Anup)
> > to go for a ticket lock implementation.  A series for that can be
> > found here (the implementation was tested in the kernel):
> > http://lists.infradead.org/pipermail/opensbi/2021-April/000789.html
> >
> > In the mentioned RVI call, I've asked the question if ticket locks or
> > MCF locks are preferred.  And the feedback was to go for
> > qspinlock/qrwlock. One good argument to do so would be, to not have to
> > maintain an RV-specific implementation, but to use a well-tested
> > in-kernel mechanism.
>
> qrwlock does not depend on qspinlock; any fair spinlock implementation
> works, including ticket.
>
> > The feedback in the call is also aligned with the previous attempts to
> > enable MCF-locks on RV.  However, the kernel's implementation requires
> > sub-word atomics. And here is, where we are.  The discussion last week
> > was about changing the generic kernel code to loosen its requirements
> > (not accepted because of performance regressions on e.g. x86) and if
> > RV actually can provide sub-word atomics in form of LL/SC loops (yes,
> > that's possible).
>
> So qspinlock is a complex and fickle beast. Yes it works on x86 and
> arm64 (Will and Catalin put a _lot_ of effort into that), but IMO using
> such a complex thing needs to be provably better than the trivial and
> simple thing (tickets, test-and-set).
>
> Part of that is fwd progress, if you don't have that, stay with
> test-and-set. Will fixed a number of issues there, and -RT actually hit
> at least one.
>
> Debugging non-deterministic lock behaviour is not on the fun list.
> Having something simple (ticket) to fall back to to prove it's your lock
> going 'funneh' is very useful.
>
> > Providing sub-word xchg() can be done within a couple of hours (some
> > solutions are already on the list), but that was not enough from the
> > initial patchset from Michael on (e.g. Christoph Hellwig asked back
> > then for moving arch-independent parts into lib, which is a good idea
> > given other archs do the same).  So I expect this might require some
> > more time until there is a solution, that's accepted by a broad range
> > of maintainers.
>
> Using a lib/ cmpxchg based xchg16 is daft. Per the very same arguments I
> made elsewhere in the thread. cmpxchg() based loops have very difficult
> fwd progress guarantees, esp. so on LL/SC architectures.
>
> What I would do is create a common inline helper to compute that {addr,
> mask, val} setup with a comment on how to use it.
>
> (As is, we have at least 2 different ways of dealing with ENDIAN-ness)

Well, that's what I have here:
https://github.com/cmuellner/linux/commit/9d2f6449dd848b5723326ae8be34a3d2d=
41dcff1

> > I've been working on a new MCF-lock series last week.  It is working,
> > but I did not publish it yet, because I wanted to go through the 130+
> > emails on the riscv-linux list and check for overseen review comments
> > and validate the patch authors.
>
> > You can find the current state here:
> > https://github.com/cmuellner/linux/pull/new/riscv-spinlocks
>
> That's not public. But if that's not qspinlock, how are you justifying a
> complex spinlock implementation? Does it perform better than ticket?

I pasted the wrong link. Here is a working one:
https://github.com/cmuellner/linux/tree/riscv-spinlocks
It is basically Guo's v4 with mask-and-set within a LL/SC loop,
commits split up,
non-riscv commits dropped, and commit messages rewritten.

I fully understand your reservations against using MCF locks.
I also agree, that debugging locking issues is not funny.

FWIW:
I've been debugging quite some embedded Linux boards the last years,
where essential basic building blocks showed unreliable/erratic behavior
(caused e.g. by an unstable voltage supply) and every attempt to monitor
the bug causes it to disappear.

Ticket locks are also fine for me. Still, it would be nice to get the
16-bit xchg()
merged, so advanced users can try qspinlocks without much effort.
Otherwise, we just suspend the discussion now and restart it from the begin=
ning
in a year (as is happening right now).

> > So, if you insist on ticket locks, then let's coordinate who will do
> > that and how it will be tested (RV32/RV64, qemu vs real hw).
>
> Real hardware is all that counts :-)

Fully agree, therefore I have written that.
