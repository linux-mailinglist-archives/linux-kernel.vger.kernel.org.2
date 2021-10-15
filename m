Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB142FB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbhJOSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbhJOSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:34:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A852C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y0ub/mtiPvZHRhEzxfdTOlvvKd5olSjIoP+bVmfXcn4=; b=YQMBKlS28ovVdMMFeYkGbRL0sV
        4WLOlEB2W/C4vkf36BaC01+p3nxiVO6wCx28gc1EX0ms7nk5ODgHcwJl9/4jQbgmuRyFYbpvxyGCX
        Z2jqNrEVrn88TeWwdLNkwJP444eiXUqOVMdceuZQdgjmrae7CYYW03MoWroSGG3WJfhzfBKUtKc0E
        78/vZrkdDwNPEpcIXMEw5lbT70E43bFGcHUFMoSFEvZXStUbOOmk2H2Gj0Sp0AG0pTX7HTPM6YcH/
        5gD2dsMDDUdWaQyWj9XvpeAXWw3jZHRbi+wi+0rE0p0CmeX9UzJC28HZyPJH4dLg5PXVC0CoPds/S
        FzD1aj3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbRxm-009CcK-T0; Fri, 15 Oct 2021 18:30:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5C469857C7; Fri, 15 Oct 2021 20:29:50 +0200 (CEST)
Date:   Fri, 15 Oct 2021 20:29:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Wait before decaying
 max_newidle_lb_cost
Message-ID: <20211015182950.GM174703@worktop.programming.kicks-ass.net>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
 <20211015124654.18093-4-vincent.guittot@linaro.org>
 <20211015174045.GI174703@worktop.programming.kicks-ass.net>
 <CAKfTPtD4RgqR4um3faHeR5AC2Uw5+cbH6vee4wq-5Qox9bqwQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD4RgqR4um3faHeR5AC2Uw5+cbH6vee4wq-5Qox9bqwQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 08:02:01PM +0200, Vincent Guittot wrote:
> On Fri, 15 Oct 2021 at 19:41, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Oct 15, 2021 at 02:46:53PM +0200, Vincent Guittot wrote:
> > > Decay max_newidle_lb_cost only when it has not been updated for a while
> > > and ensure to not decay a recently changed value.
> >
> > I was more thinking something long these lines; ofcourse, no idea how
> > well it actually behaves.
> >
> > Index: linux-2.6/include/linux/sched/topology.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/sched/topology.h
> > +++ linux-2.6/include/linux/sched/topology.h
> > @@ -98,7 +98,6 @@ struct sched_domain {
> >
> >         /* idle_balance() stats */
> >         u64 max_newidle_lb_cost;
> > -       unsigned long next_decay_max_lb_cost;
> >
> >         u64 avg_scan_cost;              /* select_idle_sibling */
> >
> > Index: linux-2.6/kernel/sched/fair.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/sched/fair.c
> > +++ linux-2.6/kernel/sched/fair.c
> > @@ -10241,6 +10241,17 @@ void update_max_interval(void)
> >  }
> >
> >  /*
> > + * Asymmetric IIR filter, 1/4th down, 3/4th up.
> > + */
> > +static void update_newidle_cost(u64 *cost, u64 new)
> > +{
> > +       s64 diff = new - *cost;
> > +       if (diff > 0)
> > +               diff *= 3;
> > +       *cost += diff / 4;
> > +}
> 
> I tried to use something similar which was based on update_avg() but
> there were some performance regressions:
> some regressions were linked to not jumping to the new max directly. I
> assume some level were started whereas it would take too much time
> and some regressions happened  if the decay was too quick

Hmm, fair enough..

There's always something like:

       s64 diff = new - *cost;
       if (diff < 0)
               diff = 3*diff/256;
       *cost += diff;

Which jumps up instantly and decays rather slower. The advantage of
something like that, as I see it, is all those lines it deletes, but if
it doesn't actually work, it doesn't work.

A well. Thanks for trying.
