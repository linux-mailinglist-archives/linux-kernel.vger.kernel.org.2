Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11353B01BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFVKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:50:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:48:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso1937815wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NxykBNeGwcOrdeucRq1YtpuFobyHaujkbqCNSvgnwdM=;
        b=c+3wpe4A54I5t4Nc2biBSXGsizInzNWKcElNHWqWTlol1ly4bEmcpyoCKTJTPFf8n0
         LdmX4JsE4L9s4NbXzqnrjWSqnZrEMiw8spea2TwnNbtXubw48KzjlzNqgfUv0MqPpCdH
         e0VER1P6BHPAc1AoCCCT7n2YUb4immo6z/1vAfvzUDu3tOAKDgGP30BPU2eMLLC2fekO
         YjgcGtS9mlnqIMgKipHMmWvBUeKTVjuXWZ1Pud3mI9QB09YnnFx5+chnxze9GC3o5LOh
         AzbfwA7TmKQ+Ltk9TXxT+x8o5K9GYLWIt7LkgBXA+95ZpTi8pLDDYgXHrIJSZgy4W2+4
         REuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NxykBNeGwcOrdeucRq1YtpuFobyHaujkbqCNSvgnwdM=;
        b=ovPpv3KgElrfzb24kof9fe4OYlJ8NiCkPie3WfHmdPD2bY0hT7l/c4nsHHAkZSvw9h
         qYjTF6d30O7g3JZQLrzRK6mEJQPDnfn9vcZwxfSjBZlckD3TgamtPp2A/W0Egr5r77K5
         XzzstzSEoHo56Mo5EIaFv8Us5HoomC4JMbiP5CidBiW7QS1MsPx1BZfuMflnEPgGlKPe
         UArf5tZWtkBD6AX2NmW+bOBuvhRFr0miXxkd35p7hDz+YOxwXoJgtuh7/3qpHUT5W+YI
         O5OTTKyKOlUfzUY0hYotHh25rioWmEdIxzZjo7bac8qY+Ab4Mb+u3iw4LL+5AmyFbG+Y
         O9SA==
X-Gm-Message-State: AOAM533R8Zl/0t2j0aZxDTmztbE5AEI2RmoxyHw7UN9DQ/oH68mykubG
        rMwaTn5TsgqvwdEFqEGxxeIMyQ==
X-Google-Smtp-Source: ABdhPJyanQ6ElMJQ3i43DmrusRTW8tuhjMzRs6+X3ni2iQ+nVW/9hlczoK/YdnIhl6oOmVcCLRQ+rg==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr3704670wmm.185.1624358902396;
        Tue, 22 Jun 2021 03:48:22 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:cd02:f0e6:eb27:e1e5])
        by smtp.gmail.com with ESMTPSA id o26sm1913119wms.27.2021.06.22.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:48:21 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:48:16 +0200
From:   Marco Elver <elver@google.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
Message-ID: <YNG/8EcdPBfH/Taf@elver.google.com>
References: <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
 <YMyC/Dy7XoxTeIWb@elver.google.com>
 <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com>
 <YNBqTVFpvpXUbG4z@elver.google.com>
 <01a0161a-44d2-5a32-7b7a-fdb13debfe57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a0161a-44d2-5a32-7b7a-fdb13debfe57@redhat.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 09:25PM +0200, Daniel Bristot de Oliveira wrote:
> On 6/21/21 12:30 PM, Marco Elver wrote:
> > On Mon, Jun 21, 2021 at 10:23AM +0200, Daniel Bristot de Oliveira wrote:
> > [...]
> >>> Yes, unlike code/structural coverage (which is what we have today via
> >>> KCOV) functional coverage checks if some interesting states were reached
> >>> (e.g. was buffer full/empty, did we observe transition a->b etc.).
> >>
> >> So you want to observe a given a->b transition, not that B was visited?
> > 
> > An a->b transition would imply that a and b were visited.
> 
> HA! let's try again with a less abstract example...

Terminology misunderstanding.

I mean "state transition". Writing "a->b transition" led me to infer 'a'
and 'b' are states, but from below I infer that you meant an "event
trace" (viz. event sequence).  So it seems I was wrong.

Let me be clearer: transition A -[a]-> B implies states A and B were
visited. Hence, knowing that event 'a' occurred is sufficient, and
actually provides a little more information than just "A and B were
visited".

> 
>   |   +------------ on --+----------------+
>   v   ^                  +--------v       v
> +========+               |        +===========+>--- suspend ---->+===========+
> |  OFF   |               +- on --<|     ON    |                  | SUSPENDED |
> +========+ <------ shutdown -----<+===========+<----- on -------<+===========+
>     ^                                    v                             v
>     +--------------- off ----------------+-----------------------------+
> 
> Do you care about:
> 
> 1) states [OFF|ON|SUSPENDED] being visited a # of times; or
> 2) the occurrence of the [on|suspend|off] events a # of times; or
> 3) the language generated by the "state machine"; like:
> 
>    the occurrence of *"on -> suspend -> on -> off"*
> 
>          which is != of
> 
>    the occurrence of *"on -> on -> suspend -> off"*
> 
>          although the same events and states occurred the same # of times
> ?

They are all interesting, but unrealistic for a fuzzer to keep track of.
We can't realistically keep track of all possible event traces. Nor that
some state or event was visited # of times.

What I did mean is as described above: the simple occurrence of an
event, as it implies some previous and next state were visited.

The fuzzer then builds up knowledge of which inputs cause some events to
occur. Because it knows it has inputs for such events, it will then try
to further combine these inputs hoping to reach new coverage. This leads
to various distinct event traces using the events it has already
observed. All of this is somewhat random of course, because fuzzers are
not meant to be model checkers.

If someone wants something more complex as you describe, it'd have to
explicitly become part of the model (if possible?). The problem of
coverage explosion applies, and we may not recommend such usage anyway.

> RV can give you all... but the way to inform this might be different.
> 
> >> I still need to understand what you are aiming to verify, and what is the
> >> approach that you would like to use to express the specifications of the systems...
> >>
> >> Can you give me a simple example?
> > 
> > The older discussion started around a discussion how to get the fuzzer
> > into more interesting states in complex concurrent algorithms. But
> > otherwise I have no idea ... we were just brainstorming and got to the
> > point where it looked like "functional coverage" would improve automated
> > test generation in general. And then I found RV which pretty much can
> > specify "functional coverage" and almost gets that information to KCOV
> > "for free".
> 
> I think we will end up having an almost for free solution, but worth the price.
> 
> >> so, you want to have a different function for every transition so KCOV can
> >> observe that?
> > 
> > Not a different function, just distinct "basic blocks". KCOV uses
> > compiler instrumentation, and a sequence of non-branching instructions
> > denote one point of coverage; at the next branch (conditional or otherwise)
> > it then records which branch was taken and therefore we know which code
> > paths were covered.
> 
> ah, got it. But can't KCOV be extended with another source of information?
 
Not without changing KCOV. And I think we're weary of something like
that due to the potential for coverage explosion. -fsanitize-coverage
has various options to capture different types of coverage actually, not
purely basic block based coverage. (KCOV already supports
KCOV_ENABLE_COMPARISONS, perhaps that could help somehow. It captures
arguments of comparisons.)

> >>>
> >>> From what I can tell this doesn't quite happen today, because
> >>> automaton::function is a lookup table as an array.
> >>
> >> It is a the transition function of the formal automaton definition. Check this:
> >>
> >> https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf
> >>
> >> page 9.
> >>
> >> Could this just
> >>> become a generated function with a switch statement? Because then I
> >>> think we'd pretty much have all the ingredients we need.
> >>
> >> a switch statement that would.... call a different function for each transition?
> > 
> > No, just a switch statement that returns the same thing as it does
> > today. But KCOV wouldn't see different different coverage with the
> > current version because it's all in one basic block because it looks up
> > the next state given the current state out of the array. If it was a
> > switch statement doing the same thing, the compiler will turn the thing
> > into conditional branches and KCOV then knows which code path
> > (effectively the transition) was covered.
 
Per Dmitry's comment, yes we need to be careful that the compiler
doesn't collapse the switch statement somehow. But this should be
achievable with a bunch or 'barrier()' after every 'case ...:'.

> [ the answer for this points will depend on your answer from my first question
> on this email so... I will reply it later ].
> 
> -- Daniel
> 
> >>> Then:
> >>>
> >>> 1. Create RV models for states of interests not covered by normal code
> >>>    coverage of code under test.
> >>>
> >>> 2. Enable KCOV for everything.
> >>>
> >>> 3. KCOV's coverage of the RV model will tell us if we reached the
> >>>    desired "functional coverage" (and can be used by e.g. syzbot to
> >>>    generate better tests without any additional changes because it
> >>>    already talks to KCOV).
> >>>
> >>> Thoughts?
> >>>
> >>> Thanks,
> >>> -- Marco
