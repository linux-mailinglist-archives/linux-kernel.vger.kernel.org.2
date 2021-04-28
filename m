Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A933C36D5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhD1Kgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhD1Kge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:36:34 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D97C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:35:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 82so73259528yby.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ch8iPLVnjB26GYW/E4Kp88UBIdNVnDfQkN+teceVlmQ=;
        b=anF9LsF+XidzgO65yYDfmPZrk1xPeZig73tPiUHWzo7iTkQXWG0f42aiiG8QKO4i4X
         //SG/+iOl7RnS8Xg0I5OsxFeGZCsEFb6j5CRoKmWL+GVpaDKtNa+E9POooEHc/8CiEBZ
         ufg1IaqHm6XgVdYKsRH2PXZJY7nAO6dME8jkFPpAaicd/B0gXkB92PIiJJRxzcV7IcMA
         vSVPUrsorR5/IfpbiMuG61UKKao0da2aH60s0SlR3H6exO6X3DUzmZgvLCzQ3XayU81q
         zPjPXanYr1RHN5y+5FkD8zJc6jU9izvZHwp01bE0ogAVScGiLwvu5mLKALFFgDnXh5bs
         EeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ch8iPLVnjB26GYW/E4Kp88UBIdNVnDfQkN+teceVlmQ=;
        b=RF7+daFccolw46O7dP4TkHEWfCpF3OMMBHinpBy4YL3bGPkaZbqG8rFXa0V4tTv8CM
         0RiCM6epoPaMSN3yuLPIwONmC4cLzf/Go8ibuh152IgC3AJXBB8kM6MvkfluWbfdO7e7
         WlUkRJ0fs2zgnR7g4BJmUZ9GURji7KfSqfnGSSXXlPYdcG9ee/9lylEiSxasEW2vUpq2
         988CZ2ZlM32cF04KpGZukKE7ioiyZW30BdZibG9CYYfwngOYzpG1VUWUK2Vey5HU64rJ
         zJhyI78CIYPdeBBUWqadjjZQl1jjBI5GMvOJihjK+hVUlCJ8wdzpxx11XVbHB7144Zux
         NWYw==
X-Gm-Message-State: AOAM531PswOekwz9Gi3Ecds4PZCQvxJaBYhdxnWR5d5nXaek8Rkdl7BD
        a7KO995lSxfOWN/Plf3kw5kBDwrLh+YBxi7sssg=
X-Google-Smtp-Source: ABdhPJyW6RIYCv/WoCi5UJI7Rzp7sPEW3VtQCDoyp6VvpO/AB2xb1AV6U2zlNvPIM4jJLDVEFvU3Nna2BlZDXB2qNHM=
X-Received: by 2002:a5b:602:: with SMTP id d2mr3502182ybq.199.1619606147709;
 Wed, 28 Apr 2021 03:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CABk29NvaH687GfOm_b5_hJF6HBQ6fu+1hzc0GFNEMv5mj3DrUw@mail.gmail.com> <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
In-Reply-To: <YIknPXxwZvq0qmId@hirez.programming.kicks-ass.net>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 28 Apr 2021 18:35:36 +0800
Message-ID: <CAERHkrttLutB1yUHS=i_syQZjqWmttm8PfQeH4WkcCLQvaR64A@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Hiatt <dhiatt@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 5:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 27, 2021 at 04:30:02PM -0700, Josh Don wrote:
>
> > Also, did you mean to have a preempt_enable_no_resched() rather than
> > prempt_enable() in raw_spin_rq_trylock?
>
> No, trylock really needs to be preempt_enable(), because it can have
> failed, at which point it will not have incremented the preemption count
> and our decrement can hit 0, at which point we really should reschedule.
>
> > I went over the rq_lockp stuff again after Don's reported lockup. Most
> > uses are safe due to already holding an rq lock. However,
> > double_rq_unlock() is prone to race:
> >
> > double_rq_unlock(rq1, rq2):
> > /* Initial state: core sched enabled, and rq1 and rq2 are smt
> > siblings. So, double_rq_lock(rq1, rq2) only took a single rq lock */
> > raw_spin_rq_unlock(rq1);
> > /* now not holding any rq lock */
> > /* sched core disabled. Now __rq_lockp(rq1) != __rq_lockp(rq2), so we
> > falsely unlock rq2 */
> > if (__rq_lockp(rq1) != __rq_lockp(rq2))
> >         raw_spin_rq_unlock(rq2);
> > else
> >         __release(rq2->lock);
> >
> > Instead we can cache __rq_lockp(rq1) and __rq_lockp(rq2) before
> > releasing the lock, in order to prevent this. FWIW I think it is
> > likely that Don is seeing a different issue.
>
> Ah, indeed so.. rq_lockp() could do with an assertion, not sure how to
> sanely do that. Anyway, double_rq_unlock() is simple enough to fix, we
> can simply flip the unlock()s.
>
> ( I'm suffering a cold and am really quite slow atm )
>
> How's this then?
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f732642e3e09..3a534c0c1c46 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -290,6 +290,10 @@ static void sched_core_assert_empty(void)
>  static void __sched_core_enable(void)
>  {
>         static_branch_enable(&__sched_core_enabled);
> +       /*
> +        * Ensure raw_spin_rq_*lock*() have completed before flipping.
> +        */
> +       synchronize_sched();

synchronize_sched() seems no longer exist...

Thanks,
-Aubrey
