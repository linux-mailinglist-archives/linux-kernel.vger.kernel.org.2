Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6DF3F5388
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhHWW5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:57:40 -0400
Received: from out2.migadu.com ([188.165.223.204]:25495 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhHWW5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:57:39 -0400
Date:   Tue, 24 Aug 2021 06:57:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629759415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2CxI1VfBsnL0p5UbvwsEu/xbia02T68QPuq9M2KuVA=;
        b=tdlEmE8n/LIipOqtWWf11vVdqws5X54oGnb2hg9CITwdu72udesgOHRcwI2B8Dj9jZlySH
        hF2uHX4+uWMoXEVafChNuX9mvgxFZL5oLRPdRjGFz09Jr3+RbqO/pzsmJOrpvcG94Vu5je
        w753EHR0KOgDX3GOiZjS4Qn3tdYdiJo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vineeth Pillai <vineethrp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YSQn6upBfn4PFlo3@geo.homenetwork>
References: <20210818005615.138527-1-joshdon@google.com>
 <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On Mon, Aug 23, 2021 at 04:25:28PM -0400, Vineeth Pillai wrote:
> Hi Peter,
> 
> 
> > > Here, we should have instead updated 'max' when picking for SMT-1. Note
> > > that this code would eventually have righted itself, since the retry
> > > loop would re-pick p2, and update 'max' accordingly. However, this patch
> > > avoids the extra round-trip.
> >
> > Going with the observation Tao made; how about we rewrite the whole lot
> > to not be mind-bending complicated :-)
> >
> > How's this? It seems to build and pass the core-sched selftest thingy
> > (so it must be perfect, right? :-)
> >
> Nice, the code is much simpler now :-). A minor suggestion down..
> 
> > -       for_each_cpu(i, smt_mask) {
> > -               struct rq *rq_i = cpu_rq(i);
> > -
> > +       /*
> > +        * For each thread: do the regular task pick and find the max prio task
> > +        * amongst them.
> > +        *
> > +        * Tie-break prio towards the current CPU
> > +        */
> > +       for_each_cpu_wrap(i, smt_mask, cpu) {
> > +               rq_i = cpu_rq(i);
> >                 rq_i->core_pick = NULL;
> >
> >                 if (i != cpu)
> >                         update_rq_clock(rq_i);
> > +
> > +               for_each_class(class) {
> > +                       p = rq_i->core_temp = class->pick_task(rq_i);
> I think we can use core_pick to store the pick here and core_temp
> might not be required. What do you feel?

You're right.

The @core_temp load the class pick, the @core_pick is the final
pick(class or cookie). Using @core_pick to store class pick first
and then the final pick is right and save the bytes) but just a
little not clarity from my end :-)

> > +                       if (p)
> > +                               break;
> > +               }
> > +
> > +               if (!max || prio_less(max, p, fi_before))
> > +                       max = p;
> 
> 
> Thanks,
> Vineeth



Thanks,
Tao
