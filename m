Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8642D3BF91B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGHLit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:38:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhGHLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:38:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7F21063;
        Thu,  8 Jul 2021 04:36:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6CD3F5A1;
        Thu,  8 Jul 2021 04:36:04 -0700 (PDT)
Date:   Thu, 8 Jul 2021 12:36:02 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
Message-ID: <20210708113602.sjb4krzvs7xjmtt4@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-4-qperret@google.com>
 <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
 <YN2vj8OeZI7PBdzU@google.com>
 <20210701175248.qxnoo6cu7ts2dpys@e107158-lin.cambridge.arm.com>
 <YN8GaVjWXJp5IL06@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN8GaVjWXJp5IL06@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

Apologies about the delayed response.

After I replied to most of your email I discovered the cause of the confusion,
but left my reply intact. So please read till the end before you reply ;-)

On 07/02/21 12:28, Quentin Perret wrote:
> > There are several thoughts actually. A bit hard to articulate at this time of
> > day, but let me try.
> > 
> > /proc/sys/kernel/sched_util_clamp_min/max are system wide limits. RLIMIT_UCLAMP
> > seems to want to mimic it, so it makes sense for both to behave similarly.
> > Preventing task from requesting a boost (raising UCLAMP_MIN) is different from
> > preventing a task going above performance point (raising UCLAMP_MAX).
> 
> I don't really see why -- as you've already explained tasks can just
> busy loop to inflate their util values. So limiting the min clamp of
> task alone will never be an effective mechanism to limit how much
> capacity a task can ask for.

It's about what the API means and how ultimately the end user should be use and
benefit from it. I don't think we're on the same page here. Let me try to
explain better (hopefully) :)

The system wide controls already split the uclamp min and uclamp max. Each
request delivers a different meaning is what I'm saying. So lumping them under
one control needs at least more explanation of what is the big picture behind
it to warrant contradicting how the system wide limits already behave. And what
this single system knob means from user perspective; outside your specific use
case.

For instance, why this scenario is not allowed?

	RLIMIT_UCLAMP_MIN = 200
	RLIMIT_UCLAMP_MAX = 1024

	This task can boost itself up to 200 then must 'suffer' DVFS/migration
	delays to reach maximum performance point.

Which is basically what you can do with the sysctl_sched_util_clamp_min/max but
they apply globally (and impact the effective uclamp value).

It's a valid way to control resource requests. Uclamp doesn't guarantee any
allocations anyway; it's just a hint that hopefully will work most of the time
and will be limited by thermal issues or oversubscribed system type of
problems.

A more realistic use case would be

	RLIMIT_UCLAMP_MIN = 0
	RLIMIT_UCLAMP_MAX = 512

So a task can't boost itself but allowed to run at half the system performance
point if it becomes busy. Which effectively will prevent short bursty tasks
from achieving high performance points, but allow long running ones to achieve
higher performance points to meet their demand and would be capped at 512.

In all these cases we're assuming a cooperative apps and framework. If there's
a malicious app, then this API could still be useful to block these power
viruses without having to kill them.

The way I see it is that we're introducing RLIMIT API to deal with more than
just on/off switch. I think we need to discuss these potential other use cases
and make sure this API is generic enough to suite them.

The RLIMIT API will become most useful in a world where we have apps that
dynamically manage their performance running in an evnrionment where there's
a 'master' uclamp planner that wants to limit what this app can 'perceive' and
are allowed to achieve in terms of performance/power.

I'd be very happy if this world becomes a reality, I think it's the right way
forward. But for the time being we're just anticipating and guessing. The only
use case we have is on/off. This use case can't dictate the overall theme of
the API though. You can actually view it as a corner case.

> > > Because this is exactly how rlimit already works for nice or rt
> > > priorities. Tasks are always allowed to decrease their 'importance'
> > > (that is, increase their nice values for ex.), but are limited in how
> > > they can increase it.
> > > 
> > > See the __sched_setscheduler() permission checks for nice values and
> > > such.
> > 
> > I thought we already established that uclamp doesn't have security or fairness
> > implications and tasks are free to change it the way they want? This
> > implementation is close to v1 otherwise; we wanted to improve on that?
> 
> Sorry but I'm not sure to understand what you mean here :/
> I thought we agreed that it was _not_ always OK to let tasks drive their
> own clamps values ...

Yeah that's still the case. What I'm saying is that if we set

	RLIMIT_UCLAMP = 512

means the task is allowed to change its uclamp value in the 0-512 range. It
just can't go above. The default value RLIMIT_INIFINITY should preserve the
old behavior as we agreed which is set it anywhere in the range between 0-1024.

Why the rlimit should impose the 'only can be lowered' behavior?

The 'only can be lowered' means:

	p->uclamp[UCLAMP_MIN] = 300

	with RLIMIT_UCLAMP = 512

according to you what should happen:

	p->uclamp[UCLAMP_MIN] can only be changed to 0-300. If the user changes
	it to 200 for instance, then the new range is 0-200. And so on.
	A new value of 400 will return EPERM.

according to what I'm saying:

	p->uclamp[UCLAMP_MIN] can only be changed to 0-512. Only value above
	512 will get -EPERM. So a new value of 400 will be accepted since it
	doesn't break RLIMIT_UCLAMP = 512.

As of mainline code today, a task can choose any value in the range 1024 for
its own. I don't agree to impose a new behavior to impose lowering the value
only. I don't think this behavior fits the uclamp story as I tried to explain
before. Apps are free to manage their uclamp values. I appreciate a framework
could set a limit of what they can request, but they should still be free to
pick any value within this limit.

> 
> > I think RLIMIT_UCLAMP should set an upper bound, and that's it.
> 
> Well that is the core of our disagreement, but I think we should be
> consitent with the existing mechanisms.

RLIMIT only imposes not going above a value, no? Does it say the attribute must
be 'lowered' only if RLIMIT is set? I don't see a correlation.

> 
> Today any unprivileged task can increase its nice value, and there is
> nothing root can do to prevent that, irrespective of rlimit.

Can or can't? Unpriviliged users can only lower nice values even without
RLIMIT, no? That could be what I'm missing although when I read the code it
clearly will always fail when the requested nice value is not >= the current
task nice value. The rlimit check is 'don't care' if that's not true.

	if (attr->sched_nice < task_nice(p) && ...

> 
> If root uses rlimit to prevent an unprivileged task from lowering its
> nice value below, say, 0 (in the [-20, 19] range), then if that task
> already has nice -15, it will be allowed to increase it to e.g. nice
> -10, even if that exceeds the rlimit:
> 
> https://elixir.bootlin.com/linux/v5.13/source/kernel/sched/core.c#L6127
> 
> Tasks are always allowed to decrease their own 'importance' for nice and
> RT priorities, and I don't see why we should do anything different for
> uclamp.

Ah, I think the inverted meaning of 'increase' for nice might be catching us
here. Yes for nice unprivileged can decrease their importance (which means
increase their nice value).

Hopefully I explained my thoughts about uclamp better above. I think for uclamp
we just need to impose it doesn't exceed the RLIMIT. It can be increased or
decreased within the RLIMIT range.

And I think I get your point now about 'exceeding' the RLIMIT. You're talking
about the corner case I mentioned before of

	p->uclamp[UCLAMP_MAX] = 1024

but then

	RLIMIT_UCALMP = 512

what you're saying is that it's okay for a task to decrease it to 800 here
although that will exceed the RLIMIT, right?

Okay. I'm not sure how this corner case should be handled. But I hear your it
could be the consistent behavior to adopt here if that' what nice and priority
allow to happen already.

> 
> Rlimit only comes into play when a task tries to increase its importance.
> So that's what the above check tries to implement.

Hmm the way I read the code is that we unconditionally prevent a task from
increasing its importance. And that what I was objecting to (beside the
question of the corner case above).

/me revisits the code again

Okay I indeed misread the code. Sorry about that. I think we're aligned now ;-)

It indeed allows moving in the [0:RLIMIT_UCLAMP] range except to handle the
corner case above.

> 
> > 
> > > 
> > > > It just shouldn't be outside the specified limit, no?
> > > > 
> > > > And I think there's a bug in this logic. If UCLAMP_MIN was 1024 then the
> > > > RLIMIT_UCLAMP was lowered to 512, the user will be able to change UCLAMP_MIN to
> > > > 700 for example because of the
> > > > 
> > > > 	return value <= p->uclamp_req[clamp_id].value || ...
> > > 
> > > Right, but again this is very much intentional and consistent with the
> > > existing behaviour for RLIMIT_NICE and friends. I think we should stick
> > > with that for the new uclamp limit unless there is a good reason to
> > > change it.
> > 
> > Like above. I don't see the two limits are the same. Uclamp is managing
> > a different resource that doesn't behave like nice IMO. Apps are free to
> > lower/raise their uclamp value as long as they don't exceed the limit set by
> > RLIMIT_UCLAMP.
> 
> And like above, I don't see why uclamp should not behave like the
> existing scheduler-related rlimits :)

Hopefully we're on the same page now. I was seeing this condition to always
impose lowering for some reason and that's what created the confusion.

> 
> > > > I think we should just prevent the requested value to be above the limit. But
> > > > the user can lower and increase it within that range. ie: for RLIMIT_UCLAMP
> > > > = 512, any request in the [0:512] range is fine.
> > > > 
> > > > Also if we set RLIMIT_UCLAMP = 0, then the user will still be able to change
> > > > the uclamp value to 0, which is not what we want. We need a special value for
> > > > *all requests are invalid*.
> > > 
> > > And on this one again this is all for consistency :)
> > 
> > But this will break your use case. If android framework decided to boost a task
> > to 300, then the task itself decides to set its boost to 0, it'll override that
> > setting, no? Isn't against what you want?
> 
> No, I don't think we have a problem with that. The problem we have is
> that today the framework has essentially no control what-so-ever over
> per-task clamp values. With the rlimit stuff we can at least limit the
> range that tasks are allowed to ask for.
> 
> > We could make 0 actually behave as *all requests are invalid*.
> 
> I don't have a fundamental problem with that. Feels a little odd to have
> a special value in the range, but that could probably be useful, so why
> not ...

If setting it to 0 will not break your use case, then we can look at not
imposing that. Although if the API will not allow to prevent the user from
modifying the uclamp values at all, something will be missing in the API IMO.

Let me think if there are other alternatives to consider. A limit of 0 could be
interpreted as no requests allowed. It makes sense logically to me. But maybe
we can do better, hmmm

Thanks!

--
Qais Yousef
