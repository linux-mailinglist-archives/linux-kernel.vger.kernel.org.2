Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4D348570
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbhCXXki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239088AbhCXXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:40:16 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72399C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:40:16 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id l13so12258133vst.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bJAjeyDFlt/tHcqm2V+mpuLFNShRzmhelkEjPgwJuE=;
        b=qujWlKC4H2oZVAg4b6TJ2CFk2tcCk9b6A2IUG5kIh+yDqyfykrQzJfk1T0PKhLpaM/
         v68ggUMgXjaAO0JHqLMDPOmpJaQ0QCT+u5Tq6b9ohAQX/T+At7NT2aBcET+w/dqhb2Ls
         aPGnFnnuGEW7kDAaS8fUx8udKeg/aCFZBjHBQPRbCRvosk/b//t5LCFQmstv/EytvX9R
         /qEtuqFOHSrvWKDycJuXEJmgv7BUnHegI/EdwUYv9f74ETflgYWdfTU//uH9MdSVaYzH
         0e5iFQsmdIBNvFtOMMy2WG2GEH0re+Z+/w6mrkx0H0jiiraT/mn4wrhnCXoEO3rokdo4
         bqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bJAjeyDFlt/tHcqm2V+mpuLFNShRzmhelkEjPgwJuE=;
        b=RLFZfSk1xbMx1rhWyjZ0Wobgk5a5IoSSdamypOcvOBqKXYlzZ+iVfue073JYTIzTSR
         sqGdLN4PLKbpnFfWndY8E3qCcG9tETtA07Ao/40REXVftzlgd1BBjTsTTJE8S0HZdaf4
         bUtAXMakysCqUpPsW4f08Fq6YG8RHC2a9SR6MRhVpBjro5ZFhzNs95NhZW+mTDFTgjDK
         OWDeG0+Nm+rAPlboplU3XEAe2ZIilHIsJVwPhWW5jwJwoS2wb0rBhAZMf1eIiVXr/npi
         6g062/lBrFoAqUaroP7Q2QQ9B6J0ZhHdbePfRX1vhM8HfiyBYkUw1i55wBqJgRkGZChK
         PCXg==
X-Gm-Message-State: AOAM531qk6C1LwR67I8kE7vXiM+8ke0CGJF1pmxLTraG2gRuPu6KWLjO
        67RsrQ6L1JJ1o09+eYuKv0Uzv43u2QtO5mkmQvJhZg==
X-Google-Smtp-Source: ABdhPJwwvjlrS5JgWX9y7GLpJW1PRUnkNfWShSxlvOXV3AfPx7Woth+SDPVwGDZpcoT6h/bAuU7e+qV6WZ5pbh9hXTM=
X-Received: by 2002:a67:db98:: with SMTP id f24mr3724512vsk.13.1616629215330;
 Wed, 24 Mar 2021 16:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210322170711.1855115-1-arnd@kernel.org> <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net> <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home> <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk> <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk> <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
 <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk> <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
 <2b38d13f-9f90-b94b-7de4-c924696e6a9f@rasmusvillemoes.dk>
In-Reply-To: <2b38d13f-9f90-b94b-7de4-c924696e6a9f@rasmusvillemoes.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Mar 2021 16:40:04 -0700
Message-ID: <CABCJKudx9bkvkOsAVi7Wzgr3AVFGwa64Kre1d59v0tTr6GOgcA@mail.gmail.com>
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 3:53 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 24/03/2021 23.34, Sami Tolvanen wrote:
> > On Wed, Mar 24, 2021 at 2:51 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On 24/03/2021 18.33, Peter Zijlstra wrote:
> >>> On Wed, Mar 24, 2021 at 05:45:52PM +0100, Rasmus Villemoes wrote:
> >>>> Sorry, I think I misread the code. The static calls are indeed
> >>>> initialized with a function with the right prototype. Try adding
> >>>> "preempt=full" on the command line so that we exercise these lines
> >>>>
> >>>>                static_call_update(cond_resched,
> >>>> (typeof(&__cond_resched)) __static_call_return0);
> >>>>                 static_call_update(might_resched,
> >>>> (typeof(&__cond_resched)) __static_call_return0);
> >>>>
> >>>> I would expect that to blow up, since we end up calling a long (*)(void)
> >>>> function using a function pointer of type int (*)(void).
> >>>
> >>> Note that on x86 there won't actually be any calling of function
> >>> pointers. See what arch/x86/kernel/static_call.c does :-)
> >>
> >> I know, but so far x86 is the only one with HAVE_STATIC_CALL, so for
> >> arm64 which is where CFI seems to be targeted initially, static_calls
> >> are function pointers. And unless CFI ignores the return type, I'd
> >> really expect the above to fail.
> >
> > I think you're correct, this would trip CFI without HAVE_STATIC_CALL.
> > However, arm64 also doesn't support PREEMPT_DYNAMIC at the moment, so
> > this isn't currently a problem there.
>
> Well, there's PREEMPT_DYNAMIC and HAVE_PREEMPT_DYNAMIC. The former
> doesn't depend on the latter (and the latter does depend on
> HAVE_STATIC_CALL, so effectively not for anything but x86). You should
> be able to select both PREEMPT_DYNAMIC and CFI_CLANG, and test if
> booting with preempt=full does give the fireworks one expects.

Actually, it looks like I can't select PREEMPT_DYNAMIC, and tweaking
Kconfig to force enable it on arm64 results in a build error
("implicit declaration of function 'static_call_mod'").

Sami
