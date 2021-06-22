Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB73AFC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhFVFTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhFVFTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:19:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:17:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y4so795737qvs.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqSlROQ23wCczEkXMjh41SAPP0yfuUJ4MkjfzIZVHcQ=;
        b=DHtz42yZpgmdLbMd92XHtq+hHJWEzka3weV4WL/ZINlOTJWKuB85UzG1d6IPNbWrIu
         khF1C9Vwqty4zOdmPQglfMs+vqmuaDvNUQFIH68cb4u9scD9der1+oT6cgG9RCjuNeGz
         GEza3qmUDCGnsJhLwAxMTlBFVdIe3r3DbHpcsMrPFGzR0B7XvqdMBVFq27Huj5brENnU
         3NGNexIO69QeOGWRsI0ngkHE94QIhuvJpI20yk3fJXoNST5Z29ZT2Splo61t7YeT+5Fg
         c0cvt9j+QkJKkSSE5WXkazEjJKMlgZVCvKbw2wGHgsPRZNE+9iWfPs+4MydZLgGBe66K
         V7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqSlROQ23wCczEkXMjh41SAPP0yfuUJ4MkjfzIZVHcQ=;
        b=aW1OGvFTTHhV7GS34ckBOgm5z6XDQxT+LM3UoLl4wQaSzReNHtreH1A9+VVcpGNdwS
         NXMQ2MpPZT+llT2VVABIw5tQlqxaQzJvCAMGDiJxs04+XvTmn6aoSZeRzwNTbBcwchR9
         G6khjzz0C+GfFqcMbzsdHPw3OM5UfBp1t15paWdkYNhnANyS3R2r7qn4n/YU7bFkmu+R
         bJBMyaWvW1UuVkFxgMUMLuKMkf1w8nsDuxkMBxa0SQLcFnxrpMp21DDu6D99rQrdbjT1
         bDCeNMG9+AUGi5b3TLykTL9NZemIsJGz1i84GvEQYshMZcnFqI2KqXJoh89W/v/Rkq3B
         BASw==
X-Gm-Message-State: AOAM530Wmo4SZYqce2bmi6hsm7OyDaCWzdUrAUn4Q0rsP21qdt/bZo3C
        uNME/3L2hExEr86E4873enHFE8meppygEF6FpKo7NA==
X-Google-Smtp-Source: ABdhPJyLOFCrj1heZWTeFfiDE/T4JfdHbDeT/K+DoClfwTdWOqLgXLKGI9RzwGugicgkTZTyqXNtdgrSJyQWm7MtwFI=
X-Received: by 2002:a05:6214:80c:: with SMTP id df12mr23565588qvb.18.1624339044833;
 Mon, 21 Jun 2021 22:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1> <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com> <YMyC/Dy7XoxTeIWb@elver.google.com>
 <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com> <YNBqTVFpvpXUbG4z@elver.google.com>
In-Reply-To: <YNBqTVFpvpXUbG4z@elver.google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Jun 2021 07:17:13 +0200
Message-ID: <CACT4Y+ZJvcYpiCUO6ioaz3ieQKU=X8NBCQLsFpQqEGosJfW9zw@mail.gmail.com>
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

On Mon, Jun 21, 2021 at 12:30 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, Jun 21, 2021 at 10:23AM +0200, Daniel Bristot de Oliveira wrote:
> [...]
> > > Yes, unlike code/structural coverage (which is what we have today via
> > > KCOV) functional coverage checks if some interesting states were reached
> > > (e.g. was buffer full/empty, did we observe transition a->b etc.).
> >
> > So you want to observe a given a->b transition, not that B was visited?
>
> An a->b transition would imply that a and b were visited.
>
> > I still need to understand what you are aiming to verify, and what is the
> > approach that you would like to use to express the specifications of the systems...
> >
> > Can you give me a simple example?
>
> The older discussion started around a discussion how to get the fuzzer
> into more interesting states in complex concurrent algorithms. But
> otherwise I have no idea ... we were just brainstorming and got to the
> point where it looked like "functional coverage" would improve automated
> test generation in general. And then I found RV which pretty much can
> specify "functional coverage" and almost gets that information to KCOV
> "for free".
>
> > so, you want to have a different function for every transition so KCOV can
> > observe that?
>
> Not a different function, just distinct "basic blocks". KCOV uses
> compiler instrumentation, and a sequence of non-branching instructions
> denote one point of coverage; at the next branch (conditional or otherwise)
> it then records which branch was taken and therefore we know which code
> paths were covered.
>
> > >
> > > From what I can tell this doesn't quite happen today, because
> > > automaton::function is a lookup table as an array.
> >
> > It is a the transition function of the formal automaton definition. Check this:
> >
> > https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf
> >
> > page 9.
> >
> > Could this just
> > > become a generated function with a switch statement? Because then I
> > > think we'd pretty much have all the ingredients we need.
> >
> > a switch statement that would.... call a different function for each transition?
>
> No, just a switch statement that returns the same thing as it does
> today. But KCOV wouldn't see different different coverage with the
> current version because it's all in one basic block because it looks up
> the next state given the current state out of the array. If it was a
> switch statement doing the same thing, the compiler will turn the thing
> into conditional branches and KCOV then knows which code path
> (effectively the transition) was covered.

If we do this, we need to watch out for compiler optimizations. In
both clang and gcc KCOV pass runs in the middle of the middle-end
after some optimizations. It's possible that some trivial branches are
merged back into unconditional code already (e.g. table/conditional
moves).


> > > Then:
> > >
> > > 1. Create RV models for states of interests not covered by normal code
> > >    coverage of code under test.
> > >
> > > 2. Enable KCOV for everything.
> > >
> > > 3. KCOV's coverage of the RV model will tell us if we reached the
> > >    desired "functional coverage" (and can be used by e.g. syzbot to
> > >    generate better tests without any additional changes because it
> > >    already talks to KCOV).
> > >
> > > Thoughts?
> > >
> > > Thanks,
> > > -- Marco
