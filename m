Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9303B95B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhGARzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:55:24 -0400
Received: from foss.arm.com ([217.140.110.172]:58842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhGARzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:55:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61EB76D;
        Thu,  1 Jul 2021 10:52:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF7CA3F5A1;
        Thu,  1 Jul 2021 10:52:50 -0700 (PDT)
Date:   Thu, 1 Jul 2021 18:52:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
Message-ID: <20210701175248.qxnoo6cu7ts2dpys@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-4-qperret@google.com>
 <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
 <YN2vj8OeZI7PBdzU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN2vj8OeZI7PBdzU@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 12:05, Quentin Perret wrote:
> Hi Qais,
> 
> On Thursday 01 Jul 2021 at 11:50:14 (+0100), Qais Yousef wrote:
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index 9cbd915025ad..91a78cf1fe79 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -586,6 +586,7 @@ static const struct limit_names lnames[RLIM_NLIMITS] = {
> > >  	[RLIMIT_NICE] = {"Max nice priority", NULL},
> > >  	[RLIMIT_RTPRIO] = {"Max realtime priority", NULL},
> > >  	[RLIMIT_RTTIME] = {"Max realtime timeout", "us"},
> > > +	[RLIMIT_UCLAMP] = {"Max utilization clamp", NULL},
> > 
> > I think a single RLIMIT_UCLAMP is fine for pure permission control. But if we
> > have to do something with the currently requested values we'd need to split it
> > IMO.
> 
> I don't see why we'd need to TBH. Increasing the uclamp min of task will
> request a higher capacity for the task, and increasing the uclamp min
> will _allow_ the task to ask for a higher capacity. So at the end of the
> day, what we want to limit is how much can a task request, no matter
> how it does it. It's all the same thing in my mind, but if you have a
> clear idea of what could go wrong, then I'm happy to think again :)

There are several thoughts actually. A bit hard to articulate at this time of
day, but let me try.

/proc/sys/kernel/sched_util_clamp_min/max are system wide limits. RLIMIT_UCLAMP
seems to want to mimic it, so it makes sense for both to behave similarly.
Preventing task from requesting a boost (raising UCLAMP_MIN) is different from
preventing a task going above performance point (raising UCLAMP_MAX). One
could want to control one without impacting the other.

Also I'm not sure about the relationship between RLIMIT_UCLAMP on the effective
uclamp value. It seems off to me that by default p->uclamp_req[UCLAMP_MAX]
= 1024, but setting RLIMIT_UCLAMP to 512 will keep all tasks uncapped by
default (ie: exceeding the limit).

> 
> > >  };
> > >  
> > >  /* Display limits for a process */
> > > diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
> > > index 8874f681b056..53483b7cd4d7 100644
> > > --- a/include/asm-generic/resource.h
> > > +++ b/include/asm-generic/resource.h
> > > @@ -26,6 +26,7 @@
> > >  	[RLIMIT_NICE]		= { 0, 0 },				\
> > >  	[RLIMIT_RTPRIO]		= { 0, 0 },				\
> > >  	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> > > +	[RLIMIT_UCLAMP]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> > >  }
> > >  
> > >  #endif
> > > diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
> > > index f12db7a0da64..4d0fe4d564bf 100644
> > > --- a/include/uapi/asm-generic/resource.h
> > > +++ b/include/uapi/asm-generic/resource.h
> > > @@ -46,7 +46,8 @@
> > >  					   0-39 for nice level 19 .. -20 */
> > >  #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
> > >  #define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
> > > -#define RLIM_NLIMITS		16
> > > +#define RLIMIT_UCLAMP		16	/* maximum utilization clamp */
> > > +#define RLIM_NLIMITS		17
> > >  
> > >  /*
> > >   * SuS says limits have to be unsigned.
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index ad055fb9ed2d..b094da4c5fea 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1430,6 +1430,11 @@ static int uclamp_validate(struct task_struct *p,
> > >  	if (util_min != -1 && util_max != -1 && util_min > util_max)
> > >  		return -EINVAL;
> > >  
> > > +	return 0;
> > > +}
> > > +
> > > +static void uclamp_enable(void)
> > > +{
> > >  	/*
> > >  	 * We have valid uclamp attributes; make sure uclamp is enabled.
> > >  	 *
> > > @@ -1438,8 +1443,20 @@ static int uclamp_validate(struct task_struct *p,
> > >  	 * scheduler locks.
> > >  	 */
> > >  	static_branch_enable(&sched_uclamp_used);
> > > +}
> > >  
> > > -	return 0;
> > > +static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
> > > +{
> > > +	unsigned long uc_rlimit = task_rlimit(p, RLIMIT_UCLAMP);
> > > +
> > > +	if (value == -1) {
> > > +		if (rt_task(p) && clamp_id == UCLAMP_MIN)
> > > +			value = sysctl_sched_uclamp_util_min_rt_default;
> > > +		else
> > > +			value = uclamp_none(clamp_id);
> > > +	}
> > > +
> > > +	return value <= p->uclamp_req[clamp_id].value || value <= uc_rlimit;
> > 
> > Hmm why do we still need to prevent the task from changing the uclamp value
> > upward?
> 
> Because this is exactly how rlimit already works for nice or rt
> priorities. Tasks are always allowed to decrease their 'importance'
> (that is, increase their nice values for ex.), but are limited in how
> they can increase it.
> 
> See the __sched_setscheduler() permission checks for nice values and
> such.

I thought we already established that uclamp doesn't have security or fairness
implications and tasks are free to change it the way they want? This
implementation is close to v1 otherwise; we wanted to improve on that?

I think RLIMIT_UCLAMP should set an upper bound, and that's it.

> 
> > It just shouldn't be outside the specified limit, no?
> > 
> > And I think there's a bug in this logic. If UCLAMP_MIN was 1024 then the
> > RLIMIT_UCLAMP was lowered to 512, the user will be able to change UCLAMP_MIN to
> > 700 for example because of the
> > 
> > 	return value <= p->uclamp_req[clamp_id].value || ...
> 
> Right, but again this is very much intentional and consistent with the
> existing behaviour for RLIMIT_NICE and friends. I think we should stick
> with that for the new uclamp limit unless there is a good reason to
> change it.

Like above. I don't see the two limits are the same. Uclamp is managing
a different resource that doesn't behave like nice IMO. Apps are free to
lower/raise their uclamp value as long as they don't exceed the limit set by
RLIMIT_UCLAMP.

> 
> > I think we should just prevent the requested value to be above the limit. But
> > the user can lower and increase it within that range. ie: for RLIMIT_UCLAMP
> > = 512, any request in the [0:512] range is fine.
> > 
> > Also if we set RLIMIT_UCLAMP = 0, then the user will still be able to change
> > the uclamp value to 0, which is not what we want. We need a special value for
> > *all requests are invalid*.
> 
> And on this one again this is all for consistency :)

But this will break your use case. If android framework decided to boost a task
to 300, then the task itself decides to set its boost to 0, it'll override that
setting, no? Isn't against what you want?

We could make 0 actually behave as *all requests are invalid*.

> 
> > I'm not against this, but my instinct tells me that the simple sysctl knob to
> > define the paranoia/priviliged level for uclamp is a lot simpler and more
> > straightforward control.
> 
> It is indeed simpler, but either way we're committing to a new
> userspace-visible. I feel that the rlimit stuff is going to be a lot
> more future-proof, because it allows for much finer grain configurations
> and as such is likely to cover more use-cases in the long run.

Yeah as I said I'm not against it in principle. What is tripping me off is
mainly the relationship between RLIMIT_UCLAMP and the effective uclamp value.
But maybe I'm overthinking it.

Thanks

--
Qais Yousef
