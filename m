Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC53AFD16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFVGfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:35:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:33:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c23so1261526qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3G07ZNwIzU+ekJbLHOs00ib6qVxDlz3JM+F3J6xC1VQ=;
        b=jKqpgD4yA9cuEYebdehqoN/4ATuFrsOEVPr9AQ5t96viSK7Gylxyt1jFqPZTLLoM06
         vq54t8y8ppo0lrT/x8SS9m8oh5UJRrSeJu1kSOqpFPch0TpvLT4jybKzsBEEpDKEDp8T
         S2wH7e+Ogv4VnIN/zbT79124WGEL01zGOwsWjfCH7EfnWN0WQuC3GW51flsmYJ+B4lly
         /8XBWR1IHzg3dwJ2RHr3HSaLKlWAitB4paMs5rdW7YqLFVQzTErlTQzDQl6AJaEDiB+c
         ST6NkemR1CYfXzmN4N4ULK+bT5BedGNxahYdShGWXX01sBr8BaShvZGblRbzkyeFn5U+
         0J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3G07ZNwIzU+ekJbLHOs00ib6qVxDlz3JM+F3J6xC1VQ=;
        b=nM9Mz/yx+7gLFc+5uCGr2URoVAni2PHwS+e6zcmvGXmDda6vuutzWBx5oZvEHr8LD/
         +EVEEi6HvAJ1L1BMIEhZ8rUv5+Ply2DkwZDdbEZnFkoUWe6xvZAij1ldr4Mlf345l27g
         fsDKXzwRxpCkDB+55LKJeLmOq8ec7WReiGb4BfSY+4RhyubWUGVYP9rmmxHgcaLH+KDj
         eVXePG8pir3F8XBfS8k45d+FKgml7tK236Yp9KzZgKUE8wa6bWyhP3K3EL5gqdgKBd1l
         Kw7LeDyXbjRaGFqcdA11pIjeAIGhKm1TgjJk8jwLwwZK4Csv/GcSTckvKoLbFw/9KDeb
         BOCg==
X-Gm-Message-State: AOAM533p6j7xoBgyZJS1DL34EZIx77/AEforzu+yZqKU58n0/1PN1PHU
        PYI+2TUrsx57ICtWr9LJu8s+btfjBd6keqIjh+IJ5w==
X-Google-Smtp-Source: ABdhPJxVKXy0+vQ65WTdy5zpfWg+hichPpJB2vohQAtI+rXc5LgE+bqVivVM63tvkM219P6jh6RypYiiTZqp1ogxEr4=
X-Received: by 2002:a37:8081:: with SMTP id b123mr2615763qkd.231.1624343592648;
 Mon, 21 Jun 2021 23:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210512181836.GA3445257@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Z+7qPaanHNQc4nZ-mCfbqm8B0uiG7OtsgdB34ER-vDYA@mail.gmail.com>
 <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com> <YMyC/Dy7XoxTeIWb@elver.google.com>
 <CACT4Y+YTh=ND_cshGyVi98KiY=pkg3WKrpE__Cn+K0Wgmuyv+w@mail.gmail.com> <8069d809-b133-edbf-4323-45c45a1c3c9d@redhat.com>
In-Reply-To: <8069d809-b133-edbf-4323-45c45a1c3c9d@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Jun 2021 08:33:00 +0200
Message-ID: <CACT4Y+ZWwT8Fk2T58saPaK-yfJ_Zxtvg57KE2ubsKG9Jn2TSng@mail.gmail.com>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:39 AM Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> On 6/19/21 1:08 PM, Dmitry Vyukov wrote:
> > On Fri, Jun 18, 2021 at 1:26 PM Marco Elver <elver@google.com> wrote:
> >>
> >> On Fri, Jun 18, 2021 at 09:58AM +0200, Daniel Bristot de Oliveira wrote:
> >>> On 6/17/21 1:20 PM, Marco Elver wrote:
> >>>> [+Daniel, just FYI. We had a discussion about "functional coverage"
> >>>> and fuzzing, and I've just seen your wonderful work on RV. If you have
> >>>> thought about fuzzing with RV and how coverage of the model impacts
> >>>> test generation, I'd be curious to hear.]
> >>>
> >>> One aspect of RV is that we verify the actual execution of the system instead of
> >>> a complete model of the system, so we depend of the testing to cover all the
> >>> aspects of the system <-> model.
> >>>
> >>> There is a natural relation with testing/fuzzing & friends with RV.
> >>>
> >>>> Looks like there is ongoing work on specifying models and running them
> >>>> along with the kernel: https://lwn.net/Articles/857862/
> >>>>
> >>>> Those models that are run alongside the kernel would have their own
> >>>> coverage, and since there's a mapping between real code and model, a
> >>>> fuzzer trying to reach new code in one or the other will ultimately
> >>>> improve coverage for both.
> >>>
> >>> Perfect!
> >>>
> >>>> Just wanted to document this here, because it seems quite relevant.
> >>>> I'm guessing that "functional coverage" would indeed be a side-effect
> >>>> of a good RV model?
> >>>
> >>> So, let me see if I understood the terms. Functional coverage is a way to check
> >>> if all the desired aspects of a code/system/subsystem/functionality were covered
> >>> by a set of tests?
> >>
> >> Yes, unlike code/structural coverage (which is what we have today via
> >> KCOV) functional coverage checks if some interesting states were reached
> >> (e.g. was buffer full/empty, did we observe transition a->b etc.).
> >>
> >> Functional coverage is common in hardware verification, but of course
> >> software verification would benefit just as much -- just haven't seen it
> >> used much in practice yet.
> >> [ Example for HW verification: https://www.chipverify.com/systemverilog/systemverilog-functional-coverage ]
> >>
> >> It still requires some creativity from the designer/developer to come up
> >> with suitable functional coverage. State explosion is a problem, too,
> >> and naturally it is impractical to capture all possible states ... after
> >> all, functional coverage is meant to direct the test generator/fuzzer
> >> into more interesting states -- we're not doing model checking after all.
> >>
> >>> If that is correct, we could use RV to:
> >>>
> >>>  - create an explicit model of the states we want to cover.
> >>>  - check if all the desired states were visited during testing.
> >>>
> >>> ?
> >>
> >> Yes, pretty much. On one hand there could be an interface to query if
> >> all states were covered, but I think this isn't useful out-of-the box.
> >> Instead, I was thinking we can simply get KCOV to help us out: my
> >> hypothesis is that most of this would happen automatically if dot2k's
> >> generated code has distinct code paths per transition.
> >>
> >> If KCOV covers the RV model (since it's executable kernel C code), then
> >> having distinct code paths for "state transitions" will effectively give
> >> us functional coverage indirectly through code coverage (via KCOV) of
> >> the RV model.
> >>
> >> From what I can tell this doesn't quite happen today, because
> >> automaton::function is a lookup table as an array. Could this just
> >> become a generated function with a switch statement? Because then I
> >> think we'd pretty much have all the ingredients we need.
> >>
> >> Then:
> >>
> >> 1. Create RV models for states of interests not covered by normal code
> >>    coverage of code under test.
> >>
> >> 2. Enable KCOV for everything.
> >>
> >> 3. KCOV's coverage of the RV model will tell us if we reached the
> >>    desired "functional coverage" (and can be used by e.g. syzbot to
> >>    generate better tests without any additional changes because it
> >>    already talks to KCOV).
> >>
> >> Thoughts?
> >
> > I think there is usually already some code for any important state
> > transitions. E.g. I can't imagine how a socket can transition to
> > active/listen/shutdown/closed states w/o any code.
>
> makes sense...
>
> > I see RV to be potentially more useful for the "coverage dimensions"
> > idea. I.e. for sockets that would be treating coverage for a socket
> > function X as different coverage based on the current socket state,
> > effectively consider (PC,state) as feedback signal.
>
> How can RV subsystem talk with KCOV?

KCOV collects a trace of covered PCs. One natural way for this
interface would be a callback that allows injecting RV state events
into the KCOV trace. To make it possible to associate states with
code, these events need to be scoped, e.g.:

void kcov_state_start(int model, int state);
void kcov_state_end(int model, int state);

There is no prior art that I am aware of, so I assume it will require
some experimentation and research work to figure out exactly what
interface works best, if it works at all, how much it helps fuzzing,
is it a good metric for assessing testing coverage, etc.

> > But my concern is that we don't want to simply consider combinations
> > of all kernel code multiplied by all combinations of states of all RV
> > models.
>
> I agree! Also because RV monitors will generally monitor an specific part of the
> code (with exceptions for models like the preemption one).
>
> Most likely this will lead to severe feedback signal
> > explosion.So the question is: how do we understand that the socket
> > model relates only to this restricted set of code?
> >
> Should we annotate a model, saying which subsystem it monitors/verify?

Yes. The main question I see: how to specify what "subsystem" is.

Besides dynamic scoping we could use static mapping of models to code.
E.g. socket model covers net/core/*.c and net/tpc/*.c. Then maybe we
don't need dynamic scopes (?) however then it becomes tricker for
models that are associated with objects. Namely, if we traced
different states for different objects, what object does current
executions belong to? Does it belong to any of these at all?
