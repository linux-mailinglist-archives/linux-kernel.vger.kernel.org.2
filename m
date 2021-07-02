Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6313BA060
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGBMbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhGBMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:31:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:28:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a13so12224021wrf.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9Oz+3VD7WQkXYoOF+pG+QNu3ULaTSePBk6kwSo1Geg=;
        b=Gmtv7s2cRzCykwqfI9ZWEue4uhvm0cQcr01okCVT/mDis5TJVrnlwndnkPoL6gggzc
         OKVLxTqQVgXIcBXiR5j+qWx6pqmWmWspmjnm6PUkVceOiXxOUk+z12/44d+p6GulxY5O
         daQgwiGzi2JOjAaNrR1fgjs83hsj3gqg3W7cNyiEY1esK447wVzOUt38UC6wW4vWhWxG
         0QNXO/XyCVIgHcLpjqtW58Yu4qKpTF+1oOUuQigjy15amsiou0A45zOj4lDK4IQ4XgIo
         hJ/GZMIC2Hr9IaKcfeq+1WWhHZ276MGhhb2mjTpx9ZMOqozULsd67eQA+WkPJMRg5aX7
         Z4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c9Oz+3VD7WQkXYoOF+pG+QNu3ULaTSePBk6kwSo1Geg=;
        b=g91x/f2NJWy/Y/33/vrpQt11CEZnrmgp8fMcqnkbvBu8Qzo5is4xpUUKzm8KMpV5iV
         nL4bz04wgY9GLRI6yiSUcdV+fN6p+DrWQoHy6TmomEiEymScSQBdNUbeoRmxQoApdHXY
         OdiDDqmeQ+8Y7Q+O4STzoI0IxISnBejYfq/JuFHqbfE6qesCpXZ/34yGnWF5vmoWQ7Tz
         /8u9vySjD6BqGv4JYSgsFhBfp4mW6wmYwqgZwYiTgtGYrmIgvPByiojy5ZLFySnMavv9
         WlOl9KLlITZkZb5aVzKUxBx+lI8Vi7EQ4C7/BFZtFSNOTkFezqxwB/smCFYs+bLTWMgL
         hB8A==
X-Gm-Message-State: AOAM532nX3mjZNWeHRBIUimXPh6ToEVStyhiA1xmHMNYFstQ3Rnjl+ES
        xC2/EFFFsbyJgbAufNw0YkNSYw==
X-Google-Smtp-Source: ABdhPJy0MyKjrvVDPGy/SV+WnDbwpVe95RgTL/nJBDnmdLa/7k398bY7oBIp+AEYZ2149ypf9gP7YQ==
X-Received: by 2002:a5d:4642:: with SMTP id j2mr5769856wrs.348.1625228908290;
        Fri, 02 Jul 2021 05:28:28 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id s14sm3063669wru.33.2021.07.02.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:28:27 -0700 (PDT)
Date:   Fri, 2 Jul 2021 12:28:25 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
Message-ID: <YN8GaVjWXJp5IL06@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-4-qperret@google.com>
 <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
 <YN2vj8OeZI7PBdzU@google.com>
 <20210701175248.qxnoo6cu7ts2dpys@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701175248.qxnoo6cu7ts2dpys@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 Jul 2021 at 18:52:48 (+0100), Qais Yousef wrote:
> On 07/01/21 12:05, Quentin Perret wrote:
> > Hi Qais,
> > 
> > On Thursday 01 Jul 2021 at 11:50:14 (+0100), Qais Yousef wrote:
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index 9cbd915025ad..91a78cf1fe79 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -586,6 +586,7 @@ static const struct limit_names lnames[RLIM_NLIMITS] = {
> > > >  	[RLIMIT_NICE] = {"Max nice priority", NULL},
> > > >  	[RLIMIT_RTPRIO] = {"Max realtime priority", NULL},
> > > >  	[RLIMIT_RTTIME] = {"Max realtime timeout", "us"},
> > > > +	[RLIMIT_UCLAMP] = {"Max utilization clamp", NULL},
> > > 
> > > I think a single RLIMIT_UCLAMP is fine for pure permission control. But if we
> > > have to do something with the currently requested values we'd need to split it
> > > IMO.
> > 
> > I don't see why we'd need to TBH. Increasing the uclamp min of task will
> > request a higher capacity for the task, and increasing the uclamp min
> > will _allow_ the task to ask for a higher capacity. So at the end of the
> > day, what we want to limit is how much can a task request, no matter
> > how it does it. It's all the same thing in my mind, but if you have a
> > clear idea of what could go wrong, then I'm happy to think again :)
> 
> There are several thoughts actually. A bit hard to articulate at this time of
> day, but let me try.
> 
> /proc/sys/kernel/sched_util_clamp_min/max are system wide limits. RLIMIT_UCLAMP
> seems to want to mimic it, so it makes sense for both to behave similarly.
> Preventing task from requesting a boost (raising UCLAMP_MIN) is different from
> preventing a task going above performance point (raising UCLAMP_MAX).

I don't really see why -- as you've already explained tasks can just
busy loop to inflate their util values. So limiting the min clamp of
task alone will never be an effective mechanism to limit how much
capacity a task can ask for.

> One could want to control one without impacting the other.
> 
> Also I'm not sure about the relationship between RLIMIT_UCLAMP on the effective
> uclamp value. It seems off to me that by default p->uclamp_req[UCLAMP_MAX]
> = 1024, but setting RLIMIT_UCLAMP to 512 will keep all tasks uncapped by
> default (ie: exceeding the limit).
> 
> > 
> > > >  };
> > > >  
> > > >  /* Display limits for a process */
> > > > diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
> > > > index 8874f681b056..53483b7cd4d7 100644
> > > > --- a/include/asm-generic/resource.h
> > > > +++ b/include/asm-generic/resource.h
> > > > @@ -26,6 +26,7 @@
> > > >  	[RLIMIT_NICE]		= { 0, 0 },				\
> > > >  	[RLIMIT_RTPRIO]		= { 0, 0 },				\
> > > >  	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> > > > +	[RLIMIT_UCLAMP]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> > > >  }
> > > >  
> > > >  #endif
> > > > diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
> > > > index f12db7a0da64..4d0fe4d564bf 100644
> > > > --- a/include/uapi/asm-generic/resource.h
> > > > +++ b/include/uapi/asm-generic/resource.h
> > > > @@ -46,7 +46,8 @@
> > > >  					   0-39 for nice level 19 .. -20 */
> > > >  #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
> > > >  #define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
> > > > -#define RLIM_NLIMITS		16
> > > > +#define RLIMIT_UCLAMP		16	/* maximum utilization clamp */
> > > > +#define RLIM_NLIMITS		17
> > > >  
> > > >  /*
> > > >   * SuS says limits have to be unsigned.
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index ad055fb9ed2d..b094da4c5fea 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -1430,6 +1430,11 @@ static int uclamp_validate(struct task_struct *p,
> > > >  	if (util_min != -1 && util_max != -1 && util_min > util_max)
> > > >  		return -EINVAL;
> > > >  
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void uclamp_enable(void)
> > > > +{
> > > >  	/*
> > > >  	 * We have valid uclamp attributes; make sure uclamp is enabled.
> > > >  	 *
> > > > @@ -1438,8 +1443,20 @@ static int uclamp_validate(struct task_struct *p,
> > > >  	 * scheduler locks.
> > > >  	 */
> > > >  	static_branch_enable(&sched_uclamp_used);
> > > > +}
> > > >  
> > > > -	return 0;
> > > > +static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
> > > > +{
> > > > +	unsigned long uc_rlimit = task_rlimit(p, RLIMIT_UCLAMP);
> > > > +
> > > > +	if (value == -1) {
> > > > +		if (rt_task(p) && clamp_id == UCLAMP_MIN)
> > > > +			value = sysctl_sched_uclamp_util_min_rt_default;
> > > > +		else
> > > > +			value = uclamp_none(clamp_id);
> > > > +	}
> > > > +
> > > > +	return value <= p->uclamp_req[clamp_id].value || value <= uc_rlimit;
> > > 
> > > Hmm why do we still need to prevent the task from changing the uclamp value
> > > upward?
> > 
> > Because this is exactly how rlimit already works for nice or rt
> > priorities. Tasks are always allowed to decrease their 'importance'
> > (that is, increase their nice values for ex.), but are limited in how
> > they can increase it.
> > 
> > See the __sched_setscheduler() permission checks for nice values and
> > such.
> 
> I thought we already established that uclamp doesn't have security or fairness
> implications and tasks are free to change it the way they want? This
> implementation is close to v1 otherwise; we wanted to improve on that?

Sorry but I'm not sure to understand what you mean here :/
I thought we agreed that it was _not_ always OK to let tasks drive their
own clamps values ...

> I think RLIMIT_UCLAMP should set an upper bound, and that's it.

Well that is the core of our disagreement, but I think we should be
consitent with the existing mechanisms.

Today any unprivileged task can increase its nice value, and there is
nothing root can do to prevent that, irrespective of rlimit.

If root uses rlimit to prevent an unprivileged task from lowering its
nice value below, say, 0 (in the [-20, 19] range), then if that task
already has nice -15, it will be allowed to increase it to e.g. nice
-10, even if that exceeds the rlimit:

https://elixir.bootlin.com/linux/v5.13/source/kernel/sched/core.c#L6127

Tasks are always allowed to decrease their own 'importance' for nice and
RT priorities, and I don't see why we should do anything different for
uclamp.

Rlimit only comes into play when a task tries to increase its importance.
So that's what the above check tries to implement.

> 
> > 
> > > It just shouldn't be outside the specified limit, no?
> > > 
> > > And I think there's a bug in this logic. If UCLAMP_MIN was 1024 then the
> > > RLIMIT_UCLAMP was lowered to 512, the user will be able to change UCLAMP_MIN to
> > > 700 for example because of the
> > > 
> > > 	return value <= p->uclamp_req[clamp_id].value || ...
> > 
> > Right, but again this is very much intentional and consistent with the
> > existing behaviour for RLIMIT_NICE and friends. I think we should stick
> > with that for the new uclamp limit unless there is a good reason to
> > change it.
> 
> Like above. I don't see the two limits are the same. Uclamp is managing
> a different resource that doesn't behave like nice IMO. Apps are free to
> lower/raise their uclamp value as long as they don't exceed the limit set by
> RLIMIT_UCLAMP.

And like above, I don't see why uclamp should not behave like the
existing scheduler-related rlimits :)

> > > I think we should just prevent the requested value to be above the limit. But
> > > the user can lower and increase it within that range. ie: for RLIMIT_UCLAMP
> > > = 512, any request in the [0:512] range is fine.
> > > 
> > > Also if we set RLIMIT_UCLAMP = 0, then the user will still be able to change
> > > the uclamp value to 0, which is not what we want. We need a special value for
> > > *all requests are invalid*.
> > 
> > And on this one again this is all for consistency :)
> 
> But this will break your use case. If android framework decided to boost a task
> to 300, then the task itself decides to set its boost to 0, it'll override that
> setting, no? Isn't against what you want?

No, I don't think we have a problem with that. The problem we have is
that today the framework has essentially no control what-so-ever over
per-task clamp values. With the rlimit stuff we can at least limit the
range that tasks are allowed to ask for.

> We could make 0 actually behave as *all requests are invalid*.

I don't have a fundamental problem with that. Feels a little odd to have
a special value in the range, but that could probably be useful, so why
not ...

Thanks!
Quentin
