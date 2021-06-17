Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954953AB2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhFQLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFQLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:40:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2A9C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:38:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d9so4370401qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdk2K6YNuHKJ6sAQSHbbeZM3FdkcC1jUn1HPsXDQrYs=;
        b=NATwsH0MXZ8ptooy1rdEXZ9P9/6iQo7OWrWaefdx8x3l0zx/JF1XMLHloh58tz7qfB
         jcN6FX8BdnoDC5fR/973ZoDQKdjctdB0YqhIKFyG3fWdITs4BWdbdEmkGy3NaJ6iJYR+
         3iJUtrAGKMDIeADBYulbStwssW/RhnKWucQY0Lr1LGLxsgRNXO5TpzbZytUlvp+0KWhz
         wQZo1ioGePEuklWmSzvgh4tILW+BDb12x2BKBisA+zyeoHI/xUbdhM5kPAisCQ0wRbxy
         TbQE7CjIfQ15pwBE2kgSjkK0OXmbE8SPdXQbatyILWmmtLt653mTNU1D3bSOJNrPWZJu
         qz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdk2K6YNuHKJ6sAQSHbbeZM3FdkcC1jUn1HPsXDQrYs=;
        b=omOCt5VOsDavNVb0H7zxUOzaA6wDqaEBevH0vOb6Iy8lHJ7gQOONRGqRgarCGMEztC
         gYnuyaGcqqUOVokwHVZ2A7rOQgNjsqz2A8Wud1fR4sVeNH/E/dwJzvhmwpvmTjmwrIZt
         Kmqag+fkZvpWtzUonbr833KRhvozzO6Ivx7TPtUMMjyM+0paYvEV8snD4LPnt/vpu/LY
         +gHrWRZ8GxcOj+ivdQ9VQPkXNH2CTDRr7JeORNNOKJxxsd1C+Oj696F7yy7YJU8GGehU
         PMrbYHWtP/KvZxBc79Teybo3dd1qUALxcDXKj1ZFkf7kEahuJi9wrqll0eiyaA28mmoC
         muaA==
X-Gm-Message-State: AOAM530Ft1GDPSNXQ7JK9wtT6iEkc130T1UFv5ODj8g/UZtehdf5to9z
        3qlZYyXbnA+GeMFKvp7rwgWhAAlb1RumXvSzYX2Gtg==
X-Google-Smtp-Source: ABdhPJxxHL8NMTqFW3cHSYDHh2fPjkrEnNFvrLFNsItjM2EAtS7aSKtfmcXBYvaZy5awOj13fDDhgAY6SR5a327Ksgs=
X-Received: by 2002:ac8:5dce:: with SMTP id e14mr4504876qtx.43.1623929912762;
 Thu, 17 Jun 2021 04:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210512181836.GA3445257@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Z+7qPaanHNQc4nZ-mCfbqm8B0uiG7OtsgdB34ER-vDYA@mail.gmail.com>
 <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
In-Reply-To: <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Jun 2021 13:38:21 +0200
Message-ID: <CACT4Y+YEVQQ7sGePt_k=byu91tXh=OB=vZ13PB3Q3=G91b4oog@mail.gmail.com>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, bristot@redhat.com,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 1:20 PM 'Marco Elver' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> [+Daniel, just FYI. We had a discussion about "functional coverage"
> and fuzzing, and I've just seen your wonderful work on RV. If you have
> thought about fuzzing with RV and how coverage of the model impacts
> test generation, I'd be curious to hear.]
>
> Looks like there is ongoing work on specifying models and running them
> along with the kernel: https://lwn.net/Articles/857862/
>
> Those models that are run alongside the kernel would have their own
> coverage, and since there's a mapping between real code and model, a
> fuzzer trying to reach new code in one or the other will ultimately
> improve coverage for both.
>
> Just wanted to document this here, because it seems quite relevant.
> I'm guessing that "functional coverage" would indeed be a side-effect
> of a good RV model?

Ha! That's interesting. RV can indeed be a source of high-quality
meaningful states.

The idea behind states is to "multiply" code coverage by the dimension
of states, right? Instead of checking "have we covered this code?", we
will be checking "have we covered this code in this state or not?".
This will require some way of figuring what code is affected by what
model, right? Otherwise it still can lead to state explosion I think.
E.g. if we have 5 models with 5 states each, it will increase the
amount of effective coverage by 5^5.

The preemption model in the example is "global" (per-task), but there
are also per-object models. I remember we discussed sockets as an
example on LPC. But I don't remember what was proposed API for tieing
states to objects. Maybe that API will help with code regions as
well?...


> Previous discussion below.
>
> Thanks,
> -- Marco
>
> On Wed, 19 May 2021 at 22:24, Marco Elver <elver@google.com> wrote:
> > On Wed, 19 May 2021 at 20:53, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Wed, May 19, 2021 at 11:02:43AM +0200, Marco Elver wrote:
> > > > On Tue, 18 May 2021 at 22:42, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > [...]
> > > > > > All the above sound like "functional coverage" to me, and could be
> > > > > > implemented on top of a well-thought-out functional coverage API.
> > > > > > Functional coverage is common in the hardware verification space to
> > > > > > drive simulation and model checking; for example, functional coverage
> > > > > > could be "buffer is full" vs just structural (code) coverage which
> > > > > > cannot capture complex state properties like that easily.
> > > > > >
> > > > > > Similarly, you could then say things like "number of held locks" or
> > > > > > even alluding to your example (5) above, "observed race on address
> > > > > > range". In the end, with decent functional coverage abstractions,
> > > > > > anything should hopefully be possible.
> > > > >
> > > > > Those were in fact the lines along which I was thinking.
> > > > >
> > > > > > I've been wondering if this could be something useful for the Linux
> > > > > > kernel, but my guess has always been that it'd not be too-well
> > > > > > received because people don't like to see strange annotations in their
> > > > > > code. But maybe I'm wrong.
> > > > >
> > > > > I agree that it is much easier to get people to use a tool that does not
> > > > > require annotations.  In fact, it is best if it requires nothing at all
> > > > > from them...
> > > >
> > > > While I'd like to see something like that, because it'd be beneficial
> > > > to see properties of the code written down to document its behaviour
> > > > better and at the same time machine checkable, like you say, if it
> > > > requires additional effort, it's a difficult sell. (Although the same
> > > > is true for all other efforts to improve reliability that require a
> > > > departure from the "way it used to be done", be it data_race(), or
> > > > even efforts introducing whole new programming languages to the
> > > > kernel.)
> > >
> > > Fair point!  But what exactly did you have in mind?
> >
> > Good question, I'll try to be more concrete -- most of it are
> > half-baked ideas and questions ;-), but if any of it makes sense, I
> > should maybe write a doc to summarize.
> >
> > What I had in mind is a system to write properties for both functional
> > coverage, but also checking more general properties of the kernel. The
> > latter I'm not sure about how useful. But all this isn't really used
> > for anything other than in debug builds.
> >
> > Assume we start with macros such as "ASSERT_COVER(...)" (for
> > functional coverage) and "ASSERT(...)" (just plain-old assertions).
> > The former is a way to document potentially interesting states (useful
> > for fuzzers to reach them), and the latter just a way to just specify
> > properties of the system (useful for finding the actual bugs).
> > Implementation-wise the latter is trivial, the former requires some
> > thought on how to expose that information to fuzzers and how to use
> > (as Dmitry suggested it's not trivial). I'd also imagine we can have
> > module-level variants ("GLOBAL_ASSERT*(...)") that monitor some global
> > state, and also add support for some subset of temporal properties
> > like "GLOBAL_ASSERT_EVENTUALLY(precond, eventually_holds)" as
> > suggested below.
> >
> > I guess maybe I'd have to take a step back and just ask why we have no
> > way to write plain and simple assertions that are removed in non-debug
> > builds? Some subsystems seem to roll their own, which a 'git grep
> > "#define ASSERT"' tells me.
> >
> > Is there a fundamental reason why we shouldn't have them, perhaps
> > there was some past discussion? Today we have things like
> > lockdep_assert_held(), but nothing to even write a simple assert
> > otherwise. If I had to guess why something like ASSERT is bad, it is
> > because it gives people a way to check for unexpected conditions, but
> > if those checks disappear in non-debug builds, the kernel might be
> > unstable. Therefore every possible state must be handled and we must
> > always be able to recover. The argument in favor is, if the ASSERT()s
> > are proven invariants or conditions where we'd recover either way, and
> > are only there to catch accidental regressions during testing; and in
> > non-debug builds we don't suffer the performance overheads.
> ..
> > > > > > My ideal abstractions I've been thinking of isn't just for coverage,
> > > > > > but to also capture temporal properties (which should be inspired by
> > > > > > something like LTL or such), on top of which you can also build
> > > > > > coverage. Then we can specify things like "if I observe some state X,
> > > > > > then eventually we observe state Y", and such logic can also just be
> > > > > > used to define functional coverage of interest (again all this
> > > > > > inspired by what's already done in hardware verification).
> > > > >
> > > > > Promela/spin provides an LTL interface, but of course cannot handle
> > > > > much of RCU, let alone of the entire kernel.  And LTL can be quite
> > > > > useful.  But in a runtime system, how do you decide when "eventually"
> > > > > has arrived?  The lockdep system does so by tracking entry to idle
> > > > > and to userspace execution, along with exit from interrupt handlers.
> > > > > Or did you have something else in mind?
> > > >
> > > > For coverage, one could simply await the transition to the "eventually
> > > > state" indefinitely; once reached we have coverage.
> > > >
> > > > But for verification, because unlike explicit state model checkers
> > > > like Spin, we don't have the complete state and can't build an
> > > > exhaustive state-graph, we'd have to approximate. And without knowing
> > > > exactly what it is we're waiting for, the simplest option would be to
> > > > just rely on a timeout, either part of the property or implicit. What
> > > > the units of that timeout are I'm not sure, because a system might
> > > > e.g. be put to sleep.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss%3DEZ4xAbrHnMwdt5g%40mail.gmail.com.
