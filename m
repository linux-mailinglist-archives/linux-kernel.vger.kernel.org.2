Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBDB3484AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhCXWfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhCXWep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:34:45 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:34:45 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id j15so5837719vkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjhN2o4D3D5cmTUfZsR0LyLCAl4RHtBYpnuqfRgNGNU=;
        b=M1eCd+1dFlwux5POF+d5odHsJUJpYb7tAp9dKy3MFjj158OFkg+1g6gV3XvSXePAcx
         cuPALrN0wgKFGtXtv9sJk2cQjNApqNoFFObwIeqZfq5AhtjWpzUs12Rlwo8wvs0T1nt+
         6Uu6qJ6aVDSsQFcCVSzxhKewS5BxEAPiOhI4Ge0pFVCAurb/i7HVKSadO7lCCjHTPnwb
         ewE4o3eNJW0qEJnHlBmFtgpSXl7h8eKgEnwWKrBYHdV8292Eo9b3KrrD4xLQs28HWIO3
         wlKg1KljYG89tAwEFiU9xb0B35i7ndhGPmAu3vlyZk7SsqZniRTDWZoioNRCcY5gpo2k
         cA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjhN2o4D3D5cmTUfZsR0LyLCAl4RHtBYpnuqfRgNGNU=;
        b=MifDPH25kft4I0X3uvk4zWH39GgowQDaT0lrhAl/YvdkXdYwoKisjkskdWVHu6CByI
         Wc0Gj8JHf2O4t2HYCqBoTxbqpuxKClzcHzVnqFHDhpeMhogFn0gKY+Y1iiUmGN5lZV2D
         RPFhKno1wKw8l26xscVwNZt/ZREPczdtKX2+XwASevkbM7EPYzrRVhSFuzokRfMGRbiq
         JhV9DzMwmzgD7lulKrs2+kaObEjE3jge+96KHQIKu03voM/Qj9Qk4Prg5JlIyEb3bEFR
         egvFzLrOD8pYNtbxSks67CO3XF3azbWk9ylTmhcZcYVoBwGFhNmnZu9XisijlLHBYwDO
         JYDw==
X-Gm-Message-State: AOAM531R5EACjzoKydzld1UdQWevsmVD3MaOdhFFKVWWnZsSnP2QJCrQ
        MUERGfnpVhNf7gjpfa0NigPZ1hRzpxWR9cjIbuhzog==
X-Google-Smtp-Source: ABdhPJxtVNjDkxx+rYD1RI/rUlhEqsZYiPUR51+xS2O55HwLgyytdxjrV/bmuectGGmX7flesTKXsQf1K7qgssi2So0=
X-Received: by 2002:a1f:2d09:: with SMTP id t9mr3589700vkt.3.1616625284423;
 Wed, 24 Mar 2021 15:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210322170711.1855115-1-arnd@kernel.org> <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net> <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home> <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk> <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk> <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
 <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk>
In-Reply-To: <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Mar 2021 15:34:33 -0700
Message-ID: <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
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

On Wed, Mar 24, 2021 at 2:51 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 24/03/2021 18.33, Peter Zijlstra wrote:
> > On Wed, Mar 24, 2021 at 05:45:52PM +0100, Rasmus Villemoes wrote:
> >> Sorry, I think I misread the code. The static calls are indeed
> >> initialized with a function with the right prototype. Try adding
> >> "preempt=full" on the command line so that we exercise these lines
> >>
> >>                static_call_update(cond_resched,
> >> (typeof(&__cond_resched)) __static_call_return0);
> >>                 static_call_update(might_resched,
> >> (typeof(&__cond_resched)) __static_call_return0);
> >>
> >> I would expect that to blow up, since we end up calling a long (*)(void)
> >> function using a function pointer of type int (*)(void).
> >
> > Note that on x86 there won't actually be any calling of function
> > pointers. See what arch/x86/kernel/static_call.c does :-)
>
> I know, but so far x86 is the only one with HAVE_STATIC_CALL, so for
> arm64 which is where CFI seems to be targeted initially, static_calls
> are function pointers. And unless CFI ignores the return type, I'd
> really expect the above to fail.

I think you're correct, this would trip CFI without HAVE_STATIC_CALL.
However, arm64 also doesn't support PREEMPT_DYNAMIC at the moment, so
this isn't currently a problem there.

Sami
