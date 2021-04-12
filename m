Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D842635C7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhDLNdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhDLNc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:32:57 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F653C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:32:39 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 66so6626726vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vhdrbo5cW0iQQU8Syu+n0QhsPOGMfq6mSgBHWlPP528=;
        b=ueVUhz0sd6BJkNgSHXPp+0sU1TwRLfgE2GCXap2xGE8HkAe515b6tkk3JH2gQJ1K9W
         +phEgmnP0LoeI5cifulcAMzfM+q6s0ExBpBog9SQ8hWkwarTSCyC1RfizD1C1fNoYLOz
         gXwJ3UKZRMxckE2f6JSJTK4Qx/sLfyEZRUYKb9wXVU8yH2tXkJlWRCa5hxwBAQkytEZY
         PR+JAyz7KVTjJ2bnhAlwPiuVM3lD56fBDpc5nrmelUNOzSVIeD1J02YC+z0IMQUPqQUA
         WAOLcnlAcOeCtQaAltca69uvNtqBpTDegUR/w52hY98bUsL5A1ae8lnOkqKGt4Q5ktls
         /8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vhdrbo5cW0iQQU8Syu+n0QhsPOGMfq6mSgBHWlPP528=;
        b=tdpo22ij3XMhwF8LWT5/skftflWH0qLfrbwao519D78xRBqu59BK3BrppwuLKvl7yc
         lyI4NjX1yQdrw1w4hGwZpdqBu/a8o+UI1UuUxMgSpVP4C5McUC+8BXrlsUXIGcqbZo/U
         lth/aMCwdwBXQHC+pszmE/t2jgWo1EGGw+cq25FbjbsdGwpen0CRHMViG2rdoRUUAxbJ
         PalGvUGa7JquCNWQJWTa4a11S8OFd86pB3wMTr0zka1m3neQeZJMAwXXDlpPW+cGnq89
         wYGyG+/TAYXfMQfdQxwTXVrw0yiyYDz/rLIirK9TydTg/qRcQj+W6vZn+LXqjWMLUY79
         ZdOw==
X-Gm-Message-State: AOAM532frGEImKqruZB4l3yseMLZ5oSDFrhYS65In/hxplUVAcI3tQ6V
        5b94xdta/HkKsNrXdnUyJeJbWH7dIsyQnRSSZS3nWaiz0puliA==
X-Google-Smtp-Source: ABdhPJwRhelRdjPWLmvk2eMgmDX4qmmTGqkLpvWzd4OAcoqeTSD9QiAeYoeobeVebcrtpWwaM0DNv9KF8QhQxQTkajE=
X-Received: by 2002:a67:7786:: with SMTP id s128mr4661759vsc.30.1618234358422;
 Mon, 12 Apr 2021 06:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com>
 <mhng-0bf68290-a014-43d7-b193-8ac839c5433a@palmerdabbelt-glaptop>
In-Reply-To: <mhng-0bf68290-a014-43d7-b193-8ac839c5433a@palmerdabbelt-glaptop>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Mon, 12 Apr 2021 15:32:27 +0200
Message-ID: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock implementation
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 11:11 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 24 Mar 2021 05:53:51 PDT (-0700), anup@brainfault.org wrote:
> > On Wed, Mar 24, 2021 at 6:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Wed, Mar 24, 2021 at 05:58:58PM +0530, Anup Patel wrote:
> >> > On Wed, Mar 24, 2021 at 3:45 PM <guoren@kernel.org> wrote:
> >> > >
> >> > > From: Guo Ren <guoren@linux.alibaba.com>
> >> > >
> >> > > This patch introduces a ticket lock implementation for riscv, along the
> >> > > same lines as the implementation for arch/arm & arch/csky.
> >> > >
> >> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> > > Cc: Will Deacon <will.deacon@arm.com>
> >> > > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> >> > > Cc: Anup Patel <anup@brainfault.org>
> >> > > Cc: Arnd Bergmann <arnd@arndb.de>
> >> > > ---
> >> > >  arch/riscv/Kconfig                      |   1 +
> >> > >  arch/riscv/include/asm/Kbuild           |   1 +
> >> > >  arch/riscv/include/asm/spinlock.h       | 158 ++++++++++++--------------------
> >> > >  arch/riscv/include/asm/spinlock_types.h |  19 ++--
> >> >
> >> > NACK from myside.
> >> >
> >> > Linux ARM64 has moved away from ticket spinlock to qspinlock.
> >> >
> >> > We should directly go for qspinlock.
> >>
> >> I think it is a sensible intermediate step, even if you want to go
> >> qspinlock. Ticket locks are more or less trivial and get you fairness
> >> and all that goodness without the mind bending complexity of qspinlock.
> >>
> >> Once you have the ticket lock implementation solid (and qrwlock) and
> >> everything, *then* start to carefully look at qspinlock.
> >
> > I do understand qspinlock are relatively complex but the best thing
> > about qspinlock is it tries to ensure each CPU spins on it's own location.
> >
> > Instead of adding ticket spinlock now and later replacing it with qspinlock,
> > it is better to straight away explore qspinlock hence my NACK.
> >
> >>
> >> Now, arguably arm64 did the heavy lifting of making qspinlock good on
> >> weak architectures, but if you want to do it right, you still have to
> >> analyze the whole thing for your own architecture.
> >
> > Most of the RISC-V implementations are weak memory ordering so it
> > makes more sense to explore qspinlock first.
>
> I know I'm somewhat late to the party here.  I talked with Will (and
> to a lesser extent Peter) about this a week or two ago and it seems the
> best way to go here is to start with ticket locks.  They're simpler, and
> in Arm land they performed better until we got to the larger systems.
> Given that we don't have any high performance implementations of the
> RISC-V memory model (and likely won't any time soon) it's hard to reason
> about the performance of anything like this, but at a bare minimum
> having fair locks is a pretty big positive and ticket locks should have
> very little overhead while providing fairness.
>
> IMO the decision between ticket and queueing locks is really more of a
> property of the hardware/workload than the ISA, though there are of
> course some pretty deep ISA dependencies than can make one saner than
> the other.  It seems best to me to just allow users to pick their own
> flavor of locks, and at least PPC is already doing that.  I threw
> together a quick asm-generic ticket lock that can be selected at compile
> time, but I want to spend some more time playing with the other
> architectures before sending anything out.

This discussion came up again a few weeks ago because I've been stumbling over
the test-and-set implementation and was wondering if nobody cared to
improve that yet.
Then I saw, that there have been a few attempts so far, but they did not land.
So I brought this up in RVI's platform group meeting and the attendees
showed big
interest to get at least fairness. I assume Guo sent out his new
patchset as a reaction
to this call (1 or 2 days later).

We have the same situation on OpenSBI, where we've agreed (with Anup)
to go for a ticket lock implementation.
A series for that can be found here (the implementation was tested in
the kernel):
http://lists.infradead.org/pipermail/opensbi/2021-April/000789.html

In the mentioned RVI call, I've asked the question if ticket locks or
MCF locks are preferred.
And the feedback was to go for qspinlock/qrwlock. One good argument to
do so would be,
to not have to maintain an RV-specific implementation, but to use a
well-tested in-kernel mechanism.

The feedback in the call is also aligned with the previous attempts to
enable MCF-locks on RV.
However, the kernel's implementation requires sub-word atomics. And
here is, where we are.
The discussion last week was about changing the generic kernel code to
loosen its requirements
(not accepted because of performance regressions on e.g. x86) and if
RV actually can provide
sub-word atomics in form of LL/SC loops (yes, that's possible).
Providing sub-word xchg() can be done within a couple of hours (some
solutions are already on the list),
but that was not enough from the initial patchset from Michael on
(e.g. Christoph Hellwig asked back then
for moving arch-independent parts into lib, which is a good idea given
other archs do the same).
So I expect this might require some more time until there is a
solution, that's accepted by
a broad range of maintainers.

I've been working on a new MCF-lock series last week.
It is working, but I did not publish it yet, because I wanted to go
through the 130+ emails
on the riscv-linux list and check for overseen review comments and
validate the patch authors.
You can find the current state here:
https://github.com/cmuellner/linux/pull/new/riscv-spinlocks
So, if you insist on ticket locks, then let's coordinate who will do
that and how it will be tested
(RV32/RV64, qemu vs real hw).
