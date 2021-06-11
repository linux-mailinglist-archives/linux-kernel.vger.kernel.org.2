Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075053A43E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFKOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:19:41 -0400
Received: from foss.arm.com ([217.140.110.172]:59658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhFKOTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:19:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBCDF1FB;
        Fri, 11 Jun 2021 07:17:40 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE533F73D;
        Fri, 11 Jun 2021 07:17:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:17:37 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <20210611141737.spzlmuh7ml266c5a@e107158-lin.cambridge.arm.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
 <YMNgPyfiIaIIsjqq@google.com>
 <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
 <YMNp3EigvYjeMVAj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMNp3EigvYjeMVAj@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 13:49, Quentin Perret wrote:
> On Friday 11 Jun 2021 at 14:26:53 (+0100), Qais Yousef wrote:
> > Hi Quentin
> > 
> > On 06/11/21 13:08, Quentin Perret wrote:
> > > Hi Qais,
> > > 
> > > On Friday 11 Jun 2021 at 13:48:20 (+0100), Qais Yousef wrote:
> > > > On 06/10/21 15:13, Quentin Perret wrote:
> > > > > There is currently nothing preventing tasks from changing their per-task
> > > > > clamp values in anyway that they like. The rationale is probably that
> > > > > system administrators are still able to limit those clamps thanks to the
> > > > > cgroup interface. However, this causes pain in a system where both
> > > > > per-task and per-cgroup clamp values are expected to be under the
> > > > > control of core system components (as is the case for Android).
> > > > > 
> > > > > To fix this, let's require CAP_SYS_NICE to increase per-task clamp
> > > > > values. This allows unprivileged tasks to lower their requests, but not
> > > > > increase them, which is consistent with the existing behaviour for nice
> > > > > values.
> > > > 
> > > > Hmmm. I'm not in favour of this.
> > > > 
> > > > So uclamp is a performance and power management mechanism, it has no impact on
> > > > fairness AFAICT, so it being a privileged operation doesn't make sense.
> > > > 
> > > > We had a thought about this in the past and we didn't think there's any harm if
> > > > a task (app) wants to self manage. Yes a task could ask to run at max
> > > > performance and waste power, but anyone can generate a busy loop and waste
> > > > power too.
> > > > 
> > > > Now that doesn't mean your use case is not valid. I agree if there's a system
> > > > wide framework that wants to explicitly manage performance and power of tasks
> > > > via uclamp, then we can end up with 2 layers of controls overriding each
> > > > others.
> > > 
> > > Right, that's the main issue. Also, the reality is that most of time the
> > > 'right' clamps are platform-dependent, so most userspace apps are simply
> > > not equipped to decide what their own clamps should be.
> > 
> > I'd argue this is true for both a framework or an app point of view. It depends
> > on the application and how it would be used.
> > 
> > I can foresee for example and HTTP server wanting to use uclamp to guarantee
> > a QoS target ie: X number of requests per second or a maximum of Y tail
> > latency. The application can try to tune (calibrate) itself without having to
> > have the whole system tuned or pumped on steroid.
> 
> Right, but the problem I see with this approach is that the app only
> understand its own performance, but is unable to decide what is best for
> the overall system health.

How do you define the overall system health here? If the app will cause the
system to heat up massively, it can do this with or without uclamp, no?

The app has better understanding of what tasks it creates and what's important
and what's not; and when certain tasks would need extra boost or not. How would
the system know that without some cooperation from the app anyway?

If you were referring what would happen if two apps are running
simultaneously; in my view the problem is not worse than what would happen
without them using uclamp. They could trip over each others in both cases. You
can actually argue if they both are doing a good job at self regulating you
could end up with a better overall result when using uclamp.

I agree one can do smarter things via a framework. I just don't find it a good
reason to limit the other use cases too.

> 
> Anyway, it sounds like we agree that having _some_ way of limiting this
> would be useful, so we're all good.

Yes. If there's a framework that is smart and want to be the master controller
of managing uclamp requests, then it make sense for it to have a way to ensure
apps can't try to escape what it has imposed. Otherwise it's chaos.

> 
> > Or a framework could manage this on behalf of the application. Both can use
> > uclamp with a feedback loop to calibrate the perf requirement of the tasks to
> > meet a given perf/power criteria.
> > 
> > If you want to do a static management, system framework would make more sense
> > in this case, true.
> > 
> > > 
> > > > Would it make more sense to have a procfs/sysfs flag that is disabled by
> > > > default that allows sys-admin to enforce a privileged uclamp access?
> > > > 
> > > > Something like
> > > > 
> > > > 	/proc/sys/kernel/sched_uclamp_privileged
> > > 
> > > Hmm, dunno, I'm not aware of anything else having a behaviour like that,
> > > so that feels a bit odd.
> > 
> > I think /proc/sys/kernel/perf_event_paranoid falls into this category.
> 
> Aha, so I'm guessing this was introduced as a sysfs knob rather than a
> CAP because it is a non-binary knob, but it's an interesting example.
> 
> > > 
> > > > I think both usage scenarios are valid and giving sys-admins the power to
> > > > enforce a behavior makes more sense for me.
> > > 
> > > Yes, I wouldn't mind something like that in general. I originally wanted
> > > to suggest introducing a dedicated capability for uclamp, but that felt
> > > a bit overkill. Now if others think this should be the way to go I'm
> > > happy to go implement it.
> > 
> > Would be good to hear what others think for sure :)
> 
> Thinking about it a bit more, a more involved option would be to have
> this patch as is, but to also introduce a new RLIMIT_UCLAMP on top of
> it. The semantics could be:
> 
>   - if the clamp requested by the non-privileged task is lower than its
>     existing clamp, then allow;
>   - otherwise, if the requested clamp is less than UCLAMP_RLIMIT, then
>     allow;
>   - otherwise, deny,
> 
> And the same principle would apply to both uclamp.min and uclamp.max,
> and UCLAMP_RLIMIT would default to 0.
> 
> Thoughts?

That could work. But then I'd prefer your patch to go as-is. I don't think
uclamp can do with this extra complexity in using it.

We basically want to specify we want to be paranoid about uclamp CAP or not. In
my view that is simple and can't see why it would be a big deal to have
a procfs entry to define the level of paranoia the system wants to impose. If
it is a big deal though (would love to hear the arguments); requiring apps that
want to self regulate to have CAP_SYS_NICE is better approach. Though I'd still
prefer to keep uclamp ubiquitous and not enforce a specific usage pattern.

Cheers

--
Qais Yousef
