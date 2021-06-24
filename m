Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC53B2A05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFXILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhFXILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:11:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:09:31 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m6-20020a9d1d060000b029044e2d8e855eso2759916otm.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrQrLGlWaZrBRPZ22+kfBbiExxWlcXw34p0FAskUQY0=;
        b=KfrjwpegVwwOICjPypWOIeutnDe+VuhdP3G06tcO+sPcYCBEiL8qWvItlbxHM3Yf91
         mGG4eOstOoaFS65HpM3RzS1PkwuYPK1qi0i+9fHYEzuiwINp2aRnoRlKfAbeu8LOOCgI
         ivOZq4i5gWUGziXAMXcyI2Yah7GpDcxLKgvqkX+ulAasvP5+uKVaLrmlbs51b9FT1Ce3
         RtLS73hINQnivwkoDhZ/VgXk8sblx3UcfE2+pHXdSaoQ3I9Ap3NRsnTQ1l6KO1cGShxx
         VLut2p0dYAK0H9oN88zIgZIB47zCaAQdXnovD9OtbBIJ2xk9BjOCg8N6eT0RIkANsqAW
         yIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrQrLGlWaZrBRPZ22+kfBbiExxWlcXw34p0FAskUQY0=;
        b=XJUq3lz8inLNbN+KjJEkysxSTEL5Mdkkcgkf0UeVBDKQwPl0q9UblKM50vdDq1++de
         1XHTliqj5OqAAtr0xMBTEVJ/0gYEyxsmC25QEt4Xk58uvS/R2dAGSwKJX4DRk0OC0cZl
         /zJCSnLpaVA2VjojaxkcSLUPxqzLbePfeSuzSJsoGKUE/rYYdv/+IfYZyGhN+Ov9UfPf
         hsME0u+cOiViUM0thX2zA+61eOYgGfDwaRdzxVjZqba+oOghL9RKIQ2I0BwHCShOj52K
         XHcmI05dwovJYpuorcUQ3pf3qJ0C286pEyUtcNVGraTNyPcgYSbi0a3Y/tRRi7dDqbzT
         5Odw==
X-Gm-Message-State: AOAM5316kq1d2yxWl4YA78BYi0Gaena2r0HHUSOay+8FlIK9fLXetPLv
        M2LG1pxwrmNMzxfDkvTX/5jro83zfmKM6T0hXClLFA==
X-Google-Smtp-Source: ABdhPJyQck1jaRQJcCx5q+YusDRz8K0/C0e+rxWpRw84c1RLE7VxNsiWZPX4HBzkINilr+dsfp1MkvVzqRsbOJxWEFs=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr3658179oto.17.1624522171102;
 Thu, 24 Jun 2021 01:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com> <YMyC/Dy7XoxTeIWb@elver.google.com>
 <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com> <YNBqTVFpvpXUbG4z@elver.google.com>
 <01a0161a-44d2-5a32-7b7a-fdb13debfe57@redhat.com> <YNG/8EcdPBfH/Taf@elver.google.com>
 <93e7048a-209f-82f2-8d28-ff8347595695@redhat.com>
In-Reply-To: <93e7048a-209f-82f2-8d28-ff8347595695@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Jun 2021 10:09:19 +0200
Message-ID: <CANpmjNNZ8rQ3W=3hMemrdS_V7fXf4a_mY785eo5XaPNeTngExg@mail.gmail.com>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 11:10, Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
> On 6/22/21 12:48 PM, Marco Elver wrote:
> > On Mon, Jun 21, 2021 at 09:25PM +0200, Daniel Bristot de Oliveira wrote:
> >> On 6/21/21 12:30 PM, Marco Elver wrote:
> >>> On Mon, Jun 21, 2021 at 10:23AM +0200, Daniel Bristot de Oliveira wrote:
> >>> [...]
> >>>>> Yes, unlike code/structural coverage (which is what we have today via
> >>>>> KCOV) functional coverage checks if some interesting states were reached
> >>>>> (e.g. was buffer full/empty, did we observe transition a->b etc.).
> >>>>
> >>>> So you want to observe a given a->b transition, not that B was visited?
> >>>
> >>> An a->b transition would imply that a and b were visited.
> >>
> >> HA! let's try again with a less abstract example...
> >
> > Terminology misunderstanding.
> >
> > I mean "state transition". Writing "a->b transition" led me to infer 'a'
> > and 'b' are states, but from below I infer that you meant an "event
> > trace" (viz. event sequence).  So it seems I was wrong.
> >
> > Let me be clearer: transition A -[a]-> B implies states A and B were
> > visited.
>
> right
>
> Hence, knowing that event 'a' occurred is sufficient, and
> > actually provides a little more information than just "A and B were
> > visited".
>
> iff [a] happens only from A to B...
>
> >
> >>
> >>   |   +------------ on --+----------------+
> >>   v   ^                  +--------v       v
> >> +========+               |        +===========+>--- suspend ---->+===========+
> >> |  OFF   |               +- on --<|     ON    |                  | SUSPENDED |
> >> +========+ <------ shutdown -----<+===========+<----- on -------<+===========+
> >>     ^                                    v                             v
> >>     +--------------- off ----------------+-----------------------------+
> >>
> >> Do you care about:
> >>
> >> 1) states [OFF|ON|SUSPENDED] being visited a # of times; or
> >> 2) the occurrence of the [on|suspend|off] events a # of times; or
> >> 3) the language generated by the "state machine"; like:
> >>
> >>    the occurrence of *"on -> suspend -> on -> off"*
> >>
> >>          which is != of
> >>
> >>    the occurrence of *"on -> on -> suspend -> off"*
> >>
> >>          although the same events and states occurred the same # of times
> >> ?
> >
> > They are all interesting, but unrealistic for a fuzzer to keep track of.
> > We can't realistically keep track of all possible event traces. Nor that
> > some state or event was visited # of times.
>
> We can track this easily via RV, and doing that is already on my todo list. But
> now I got that we do not need all these information for the functional coverage.
>
> > What I did mean is as described above: the simple occurrence of an
> > event, as it implies some previous and next state were visited.
> >
> > The fuzzer then builds up knowledge of which inputs cause some events to
> > occur. Because it knows it has inputs for such events, it will then try
> > to further combine these inputs hoping to reach new coverage. This leads
> > to various distinct event traces using the events it has already
> > observed. All of this is somewhat random of course, because fuzzers are
> > not meant to be model checkers.
> >
> > If someone wants something more complex as you describe, it'd have to
> > explicitly become part of the model (if possible?). The problem of
> > coverage explosion applies, and we may not recommend such usage anyway.
>
> I did not mean to make GCOV/the fuzzer to keep track of these information. I was
> trying to understand what are the best way to provide the information that you
> all need.
>
> >> RV can give you all... but the way to inform this might be different.
> >>
> >>>> I still need to understand what you are aiming to verify, and what is the
> >>>> approach that you would like to use to express the specifications of the systems...
> >>>>
> >>>> Can you give me a simple example?
> >>>
> >>> The older discussion started around a discussion how to get the fuzzer
> >>> into more interesting states in complex concurrent algorithms. But
> >>> otherwise I have no idea ... we were just brainstorming and got to the
> >>> point where it looked like "functional coverage" would improve automated
> >>> test generation in general. And then I found RV which pretty much can
> >>> specify "functional coverage" and almost gets that information to KCOV
> >>> "for free".
> >>
> >> I think we will end up having an almost for free solution, but worth the price.
> >>
> >>>> so, you want to have a different function for every transition so KCOV can
> >>>> observe that?
> >>>
> >>> Not a different function, just distinct "basic blocks". KCOV uses
> >>> compiler instrumentation, and a sequence of non-branching instructions
> >>> denote one point of coverage; at the next branch (conditional or otherwise)
> >>> it then records which branch was taken and therefore we know which code
> >>> paths were covered.
> >>
> >> ah, got it. But can't KCOV be extended with another source of information?
> >
> > Not without changing KCOV. And I think we're weary of something like
> > that due to the potential for coverage explosion. -fsanitize-coverage
> > has various options to capture different types of coverage actually, not
> > purely basic block based coverage. (KCOV already supports
> > KCOV_ENABLE_COMPARISONS, perhaps that could help somehow. It captures
> > arguments of comparisons.)
> >
> >>>>>
> >>>>> From what I can tell this doesn't quite happen today, because
> >>>>> automaton::function is a lookup table as an array.
> >>>>
> >>>> It is a the transition function of the formal automaton definition. Check this:
> >>>>
> >>>> https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf
> >>>>
> >>>> page 9.
> >>>>
> >>>> Could this just
> >>>>> become a generated function with a switch statement? Because then I
> >>>>> think we'd pretty much have all the ingredients we need.
> >>>>
> >>>> a switch statement that would.... call a different function for each transition?
> >>>
> >>> No, just a switch statement that returns the same thing as it does
> >>> today. But KCOV wouldn't see different different coverage with the
> >>> current version because it's all in one basic block because it looks up
> >>> the next state given the current state out of the array. If it was a
> >>> switch statement doing the same thing, the compiler will turn the thing
> >>> into conditional branches and KCOV then knows which code path
> >>> (effectively the transition) was covered.
> >
> > Per Dmitry's comment, yes we need to be careful that the compiler
> > doesn't collapse the switch statement somehow. But this should be
> > achievable with a bunch or 'barrier()' after every 'case ...:'.
>
> Changing the "function" will add some overhead for the runtime monitor use-case.
> For example, for the safety-critical systems that will run with a monitor
> enabled to detect a failure and react to it.
>
> But! I can extend the idea of the reactor to receive the successful state
> transitions or create the "observer" abstraction, to which we can attach a
> generic that will make the switch statements. This function can be
> auto-generated by dot2k as well...
>
> This reactor/observer can be enabed/disabled so... we can add as much annotation
> and barriers as we want.
>
> Thoughts?

That sounds reasonable. Simply having an option (Kconfig would be
ideal) to enable the KCOV-friendly version of the transition function
is good enough for the fuzzer usecase. The kernels built for fuzzing
usually include lots of other debug options anyway, and aren't
production kernels.

Thanks,
-- Marco
