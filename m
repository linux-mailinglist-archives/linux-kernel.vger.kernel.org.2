Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39AC38FF81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEYKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEYKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:49:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBECDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=acqkdVK8gb0pT106nPB+w/Kmxa8zfXAfs26vpTyFlNg=; b=pQSq+GOLZogVi8DK6fJ/jEAfna
        4JgNQgQ186aESOs6yJOocnoinrM8yeTNVwpVP/xBuKXtWdKlgXdZ3Neawb04ZKRwiTMzRZyIbzR9R
        SwX5KmSOdSeQKRbri1pk+muW7PZwh1UCyG8aeEIkgLq7HhJSzYWlDmd1GTpf4zPchXy4j/+BKdV84
        FSHkkfekwlz7KeOpo1JcsiO3yMSI6y8fWSF5iMhSMTxwBlQs5p8PanThJbteLDfXJYMmUYByHqsU7
        Kud8c8UuScfQoDibnGWmObkgYj3/n/I3mk7gK/tOoJDUuwO6LCp32kL7/BzWZKdaGjy7JtAK25BOD
        PB+7CunA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llUaJ-0002HQ-Fb; Tue, 25 May 2021 10:46:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 454003001E4;
        Tue, 25 May 2021 12:46:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 212332029A1A5; Tue, 25 May 2021 12:46:52 +0200 (CEST)
Date:   Tue, 25 May 2021 12:46:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, baruah@wustl.edu,
        anderson@cs.unc.edu
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YKzVnH/OTFvIP0dP@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
 <YKe89Uda+uJdx4X0@hirez.programming.kicks-ass.net>
 <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:42:03PM +0800, changhuaixin wrote:
> > On May 21, 2021, at 10:00 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Thu, May 20, 2021 at 08:34:17PM +0800, Huaixin Chang wrote:
> >> The CFS bandwidth controller limits CPU requests of a task group to
> >> quota during each period. However, parallel workloads might be bursty
> >> so that they get throttled even when their average utilization is under
> >> quota. And they are latency sensitive at the same time so that
> >> throttling them is undesired.
> >> 
> >> Scaling up period and quota allows greater burst capacity. But it might
> >> cause longer stuck till next refill. Introduce "burst" to allow
> >> accumulating unused quota from previous periods, and to be assigned when
> >> a task group requests more CPU than quota during a specific period.
> >> 
> >> Introducing burst buffer might also cause interference to other groups.
> >> Thus limit the maximum accumulated buffer by "burst", and limit
> >> the maximum allowed burst by quota, too.
> > 
> > Overall, *much* better than before.
> > 
> > However I would like a little bit better discussion of how exactly
> > people are supposed to reason about this. That will also help with the
> > question from Odin on how people are supposed to set/compute this burst
> > value.
> > 
> > So traditional (UP-EDF) bandwidth control is something like:
> > 
> >  (U = \Sum u_i) <= 1
> > 
> > This guaranteeds both that every deadline is met and that the system is
> > stable. After all, if U were > 1, then for every second of walltime,
> > we'd have to run more than a second of program time, and obviously miss
> > our deadline, but the next deadline will be further out still, there is
> > never time to catch up, unbounded fail.
> > 
> > This work observes that a workload doesn't always executes the full
> > quota; this enables one to describe u_i as a statistical distribution.
> > 
> > For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
> > (the traditional WCET). This effectively allows u to be smaller,
> > increasing the efficiency (we can pack more tasks in the system), but at
> > the cost of missing deadlines when all the odds line up. However, it
> > does maintain stability, since every overrun must be paired with an
> > underrun as long as our x is above the average.
> > 
> > That is, suppose we have 2 tasks, both specify a p(95) value, then we
> > have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
> > everything is good. At the same time we have a p(5)p(5) = 0.25% chance
> > both tasks will exceed their quota at the same time (guaranteed deadline
> > fail). Somewhere in between there's a threshold where one exceeds and
> > the other doesn't underrun enough to compensate; this depends on the
> > specific CDFs.
> > 
> > At the same time, we can say that the worst case deadline miss, will be
> > \Sum e_i; that is, there is a bounded tardiness (under the assumption
> > that x+e is indeed WCET).

Having second thoughts about this exact claim; lightning can strike
twice, and if we exceed bounds again before having recovered from the
last time we might exceed the bound mentioned. I _think_ the property
holds, but the bound might need work.

> > And I think you can compute more fun properties.
> > 
> > Now, CFS bandwidth control is not EDF, and the above doesn't fully
> > translate, but much does I think.
> > 
> > We borrow time now against our future underrun, at the cost of increased
> > interference against the other system users. All nicely bounded etc..
> > 
> 
> I shall improve the commit log then.

Thanks!

> We did some compute on the probability that deadline is missed, and the expected
> boundary. These values are calculated with different number of control groups and
> variable CPU utilization when runtime is under exponential distribution, poisson
> distribution or pareto distribution.
> 
> The more control groups there are, the more likely deadline is made and the smaller average
> WCET to expect. Because many equal control groups means small chance of U > 1.
> 
> And the more under utilized the whole system is, the more likely deadline is made and the smaller
> average WCET to expect.
> 
> More details are posted in
> https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/.

Indeed you did; I'm a bit sad it's so hard to find papers that cover
this. When one Googles for 'Probabilistic WCET' there's a fair number of
papers about using Extreme Value Theory to estimate the traditional WCET
given measurement based input. Many from the excellent WCET track at
ECRTS.

The thing is, the last time I attended that conference (which appears to
be almost 4 years ago :/), I'm sure I spoke to people about exactly the
thing explored here. Albeit, at the time we discussed this as a
SCHED_DEADLINE task model extension.

Let me Cc a bunch of people that might know more..,
