Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C63AD9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhFSLKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhFSLKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:10:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B67C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:08:31 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x6so4959284qvx.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1d3OtLRBli45MN6wZ1Rv/xKIXGyvei6DXrZPdGqY9R0=;
        b=cb8Ghqd51COU6Mo2a48EBvC2DMrbDxgGZj31ReKSVAErnXzEDUDkXgFy8Jb8c8bfx2
         ir/7pTTEyDP1ukUVzg0srD5+Q3KYSg+WNS1dL/12ER/q0oZpAFQFHKfPVody9mtHBs4B
         LxRb81F5PLFmnWEgeMy91BljyGSUDk1ipoz/4BfyoWtDjNyi73RS/UL+hER7Pfs8IXV4
         Dm6BYNBgDvv4LV9C4AktlSrjQmvs0t3I30xG8nHpqDAi0GqR555j2d8jp87xhwdEbHVo
         S3fjpZLyl0Vp7ZQfARppRdfyDOSgmttl2nGzX/BoHzqLePlG8CUr3M7XeQDUZum+wyP3
         /ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d3OtLRBli45MN6wZ1Rv/xKIXGyvei6DXrZPdGqY9R0=;
        b=GuoLiIzhxof9v7ckUw10fYBP/RFkQjapaEJSpxZyDN2oRZitUYlyqXZ4XRL8s5/tab
         lHKZbkIvsUNRzDZTIawYIDGtAed0hoUl7YyiZZTkfC1+ARV8bd+5lE8oxmjd1+82tCy9
         aLJ1c+rgSOMmjbjFwCRMU5DnD1QA8g8iPmLvwvBEwa0SFljn9pkGre+KGgcHx/opJNl3
         ESUxPOAh17Ei8wtZ+HI0by8ZJGka8ikj36QduSKSWnaNdu9O1zWkjznAq2WjobRICHqG
         fMepKr6DpKL6UswH3mXls54CUD8opcZjm0eXY3bUf/CCQxFm28sSx1+fSzKoqqN9LoaA
         vXyQ==
X-Gm-Message-State: AOAM532CMqFwtve4NJEcgL+Zb5BAn7niuv1of25ZTzytf1zOn296TDls
        60F6PzWa+uR2rBYylrSq3/NuD2WgyxZ2UBuuCOMqig==
X-Google-Smtp-Source: ABdhPJydOhveNb8ThXlUKddeORx+IhZLA3CdzvTJMtNYibGzmYu/0Qnj5PVECB9QDgjl0w03h8VWIbwsb2Gmrc2Edg8=
X-Received: by 2002:a0c:d7ce:: with SMTP id g14mr10178028qvj.23.1624100909875;
 Sat, 19 Jun 2021 04:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210512181836.GA3445257@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Z+7qPaanHNQc4nZ-mCfbqm8B0uiG7OtsgdB34ER-vDYA@mail.gmail.com>
 <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com> <YMyC/Dy7XoxTeIWb@elver.google.com>
In-Reply-To: <YMyC/Dy7XoxTeIWb@elver.google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 19 Jun 2021 13:08:18 +0200
Message-ID: <CACT4Y+YTh=ND_cshGyVi98KiY=pkg3WKrpE__Cn+K0Wgmuyv+w@mail.gmail.com>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Marco Elver <elver@google.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 1:26 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Jun 18, 2021 at 09:58AM +0200, Daniel Bristot de Oliveira wrote:
> > On 6/17/21 1:20 PM, Marco Elver wrote:
> > > [+Daniel, just FYI. We had a discussion about "functional coverage"
> > > and fuzzing, and I've just seen your wonderful work on RV. If you have
> > > thought about fuzzing with RV and how coverage of the model impacts
> > > test generation, I'd be curious to hear.]
> >
> > One aspect of RV is that we verify the actual execution of the system instead of
> > a complete model of the system, so we depend of the testing to cover all the
> > aspects of the system <-> model.
> >
> > There is a natural relation with testing/fuzzing & friends with RV.
> >
> > > Looks like there is ongoing work on specifying models and running them
> > > along with the kernel: https://lwn.net/Articles/857862/
> > >
> > > Those models that are run alongside the kernel would have their own
> > > coverage, and since there's a mapping between real code and model, a
> > > fuzzer trying to reach new code in one or the other will ultimately
> > > improve coverage for both.
> >
> > Perfect!
> >
> > > Just wanted to document this here, because it seems quite relevant.
> > > I'm guessing that "functional coverage" would indeed be a side-effect
> > > of a good RV model?
> >
> > So, let me see if I understood the terms. Functional coverage is a way to check
> > if all the desired aspects of a code/system/subsystem/functionality were covered
> > by a set of tests?
>
> Yes, unlike code/structural coverage (which is what we have today via
> KCOV) functional coverage checks if some interesting states were reached
> (e.g. was buffer full/empty, did we observe transition a->b etc.).
>
> Functional coverage is common in hardware verification, but of course
> software verification would benefit just as much -- just haven't seen it
> used much in practice yet.
> [ Example for HW verification: https://www.chipverify.com/systemverilog/systemverilog-functional-coverage ]
>
> It still requires some creativity from the designer/developer to come up
> with suitable functional coverage. State explosion is a problem, too,
> and naturally it is impractical to capture all possible states ... after
> all, functional coverage is meant to direct the test generator/fuzzer
> into more interesting states -- we're not doing model checking after all.
>
> > If that is correct, we could use RV to:
> >
> >  - create an explicit model of the states we want to cover.
> >  - check if all the desired states were visited during testing.
> >
> > ?
>
> Yes, pretty much. On one hand there could be an interface to query if
> all states were covered, but I think this isn't useful out-of-the box.
> Instead, I was thinking we can simply get KCOV to help us out: my
> hypothesis is that most of this would happen automatically if dot2k's
> generated code has distinct code paths per transition.
>
> If KCOV covers the RV model (since it's executable kernel C code), then
> having distinct code paths for "state transitions" will effectively give
> us functional coverage indirectly through code coverage (via KCOV) of
> the RV model.
>
> From what I can tell this doesn't quite happen today, because
> automaton::function is a lookup table as an array. Could this just
> become a generated function with a switch statement? Because then I
> think we'd pretty much have all the ingredients we need.
>
> Then:
>
> 1. Create RV models for states of interests not covered by normal code
>    coverage of code under test.
>
> 2. Enable KCOV for everything.
>
> 3. KCOV's coverage of the RV model will tell us if we reached the
>    desired "functional coverage" (and can be used by e.g. syzbot to
>    generate better tests without any additional changes because it
>    already talks to KCOV).
>
> Thoughts?

I think there is usually already some code for any important state
transitions. E.g. I can't imagine how a socket can transition to
active/listen/shutdown/closed states w/o any code.

I see RV to be potentially more useful for the "coverage dimensions"
idea. I.e. for sockets that would be treating coverage for a socket
function X as different coverage based on the current socket state,
effectively consider (PC,state) as feedback signal.
But my concern is that we don't want to simply consider combinations
of all kernel code multiplied by all combinations of states of all RV
models. Most likely this will lead to severe feedback signal
explosion. So the question is: how do we understand that the socket
model relates only to this restricted set of code?
