Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AEE3A6984
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhFNPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:05:37 -0400
Received: from foss.arm.com ([217.140.110.172]:38132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhFNPFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:05:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB0361FB;
        Mon, 14 Jun 2021 08:03:31 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CC263F70D;
        Mon, 14 Jun 2021 08:03:30 -0700 (PDT)
Date:   Mon, 14 Jun 2021 16:03:27 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <20210614150327.3humrvztv3fxurvk@e107158-lin.cambridge.arm.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
 <YMNgPyfiIaIIsjqq@google.com>
 <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
 <YMNp3EigvYjeMVAj@google.com>
 <20210611141737.spzlmuh7ml266c5a@e107158-lin.cambridge.arm.com>
 <YMN2ljLMUikvCBXk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMN2ljLMUikvCBXk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 14:43, Quentin Perret wrote:
> On Friday 11 Jun 2021 at 15:17:37 (+0100), Qais Yousef wrote:
> > On 06/11/21 13:49, Quentin Perret wrote:
> > > Thinking about it a bit more, a more involved option would be to have
> > > this patch as is, but to also introduce a new RLIMIT_UCLAMP on top of
> > > it. The semantics could be:
> > > 
> > >   - if the clamp requested by the non-privileged task is lower than its
> > >     existing clamp, then allow;
> > >   - otherwise, if the requested clamp is less than UCLAMP_RLIMIT, then
> > >     allow;
> > >   - otherwise, deny,
> > > 
> > > And the same principle would apply to both uclamp.min and uclamp.max,
> > > and UCLAMP_RLIMIT would default to 0.
> > > 
> > > Thoughts?
> > 
> > That could work. But then I'd prefer your patch to go as-is. I don't think
> > uclamp can do with this extra complexity in using it.
> 
> Sorry I'm not sure what you mean here?

Hmm. I understood this as a new flag to sched_setattr() syscall first, but now
I get it. You want to use getrlimit()/setrlimit()/prlimit() API to impose
a restriction. My comment was in regard to this being a sys call extension,
which it isn't. So please ignore it.

> 
> > We basically want to specify we want to be paranoid about uclamp CAP or not. In
> > my view that is simple and can't see why it would be a big deal to have
> > a procfs entry to define the level of paranoia the system wants to impose. If
> > it is a big deal though (would love to hear the arguments);
> 
> Not saying it's a big deal, but I think there are a few arguments in
> favor of using rlimit instead of a sysfs knob. It allows for a much
> finer grain configuration  -- constraints can be set per-task as well as
> system wide if needed, and it is the standard way of limiting resources
> that tasks can ask for.

Is it system wide or per user?

> 
> > requiring apps that
> > want to self regulate to have CAP_SYS_NICE is better approach.
> 
> Rlimit wouldn't require that though, which is also nice as CAP_SYS_NICE
> grants you a lot more power than just clamps ...

Now I better understand your suggestion. It seems a viable option I agree.
I need to digest it more still though. The devil is in the details :)

Shouldn't the default be RLIM_INIFINITY? ie: no limit?

We will need to add two limit, RLIMIT_UCLAMP_MIN/MAX, right?

We have the following hierarchy now:

	1. System Wide (/proc/sys/kerenl/sched_util_clamp_min/max)
	2. Cgroup
	3. Per-Task

In that order of priority where 1 limits/overrides 2 and 3. And
2 limits/overrides 3.

Where do you see the RLIMIT fit in this hierarchy? It should be between 2 and
3, right? Cgroup settings should still win even if the user/processes were
limited?

If the framework decided a user can't request any boost at all (can't increase
its uclamp_min above 0). IIUC then setting the hard limit of RLIMIT_UCLAMP_MIN
to 0 would achieve that, right?

Since the framework and the task itself would go through the same
sched_setattr() call, how would the framework circumvent this limit? IIUC it
has to raise the RLIMIT_UCLAMP_MIN first then perform sched_setattr() to
request the boost value, right? Would this overhead be acceptable? It looks
considerable to me.

Also, Will prlimit() allow you to go outside what was set for the user via
setrlimit()? Reading the man pages it seems to override, so that should be
fine.

For 1 (System Wide) limits, sched_setattr() requests are accepted, but the
effective uclamp is *capped by* the system wide limit.

Were you thinking RLIMIT_UCLAMP* will behave similarly? If they do, we have
consistent behavior with how the current system wide limits work; but this will
break your use case because tasks can change the requested uclamp value for
a task, albeit the effective value will be limited.

	RLIMIT_UCLAMP_MIN=512
	p->uclamp[UCLAMP_min] = 800	// this request is allowed but
					// Effective UCLAMP_MIN = 512

If not, then

	RLIMIT_UCLAMP_MIN=no limit
	p->uclamp[UCLAMP_min] = 800	// task changed its uclamp_min to 800
	RLIMIT_UCLAMP_MIN=512		// limit was lowered for task/user

what will happen to p->uclamp[UCLAMP_MIN] in this case? Will it be lowered to
match the new limit? And this will be inconsistent with the current system wide
limits we already have.

Sorry too many questions. I was mainly thinking loudly. I need to spend more
time to dig into the details of how RLIMITs are imposed to understand how this
could be a good fit. I already see some friction points that needs more
thinking.

Thanks

--
Qais Yousef
