Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE63AE7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFUKy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFUKy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:54:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:52:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b3so8845223wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y6E3taWCrMQ235EVkwLa7JKaYgpJSgZTJH4olJpTWf8=;
        b=S7rbnTyZCHnZE96rFDraqErmxv3PFtRs/ba2GV0KDt+85Yiica/gqoaPLthXeOKyDh
         Lqk0B++ZsOVMzE8KpwyUw9y1LtlzstqG1Md7cmFPN0oirSF9BPMaMxZSU/wPGzsnaa0h
         1aL8Bner54xRI/MSD92zCN4cOe1w2LAyytDxwOJvjj4e6IMlEFwnG0Jf9dZZ827J5UqF
         /2RAJeOWcU/JfuMUD0Fed2Nj08p9a65IDj3xMWS8AG0VDaj3vbEbn6v8h96HZYMsWOg+
         sixmnowFxDkhpnXKquD393lsJsveI97SHFmJS6q1VNacS5VNB0275bIqUe6+j6RZn4d/
         /NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y6E3taWCrMQ235EVkwLa7JKaYgpJSgZTJH4olJpTWf8=;
        b=G++MBG4YNb5SV7anfN+nvE9rJxcnURiuNhi4YN/3cJ4Pl+ZaNbUrJ9aCr8JZrXWeRh
         wfSdHk5eAMIiExc1ndgelfw4/93wmhDN1DQ5yGgJgZHJLA6h8TdRcn1rbvgGaXYpjDdI
         92CwYrRIkaOdRrWqTlHIWItDbEjXHRL9NhPDJE3NZdmcGrqd4BQFisimQxQOXQTAexvc
         ko+qhIbTVIk11MJPicfpQCuxyQkuFJXWqbE+3tC9I/8lwB2wVi3nqeCCmS42aZAKPrDM
         Co2cS6m0jcPpJ7s7B1Fql+NhjU4Y655t35Jrbd7k8uKo1GUwwxnH1RBFbrgrjOmhJZUw
         WrBw==
X-Gm-Message-State: AOAM532qMnUADjyn1cy2jNI+3cLXbQrST4auIdOKTu4r4EimjjlLn5bH
        r++8yrCOmxQBv2WeCDngY2jgMw==
X-Google-Smtp-Source: ABdhPJzg6xB/sbsIloi4ceOISDIvcAGIUl3N4s2vHsVtLn/9kfOvkmYfQ+U2oXG5t3Og9S6zm5mHvA==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr27921022wrr.335.1624272752160;
        Mon, 21 Jun 2021 03:52:32 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id t17sm15943308wmi.47.2021.06.21.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:52:31 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:52:28 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 3/3] sched: Make uclamp changes depend on CAP_SYS_NICE
Message-ID: <YNBvbEv2UTzSHBP5@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-4-qperret@google.com>
 <20210611124820.ksydlg4ncw2xowd3@e107158-lin.cambridge.arm.com>
 <YMNgPyfiIaIIsjqq@google.com>
 <20210611132653.o5iljqtmr2hcvtsl@e107158-lin.cambridge.arm.com>
 <YMNp3EigvYjeMVAj@google.com>
 <20210611141737.spzlmuh7ml266c5a@e107158-lin.cambridge.arm.com>
 <YMN2ljLMUikvCBXk@google.com>
 <20210614150327.3humrvztv3fxurvk@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614150327.3humrvztv3fxurvk@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

Apologies for the delayed reply, I was away last week.

On Monday 14 Jun 2021 at 16:03:27 (+0100), Qais Yousef wrote:
> On 06/11/21 14:43, Quentin Perret wrote:
> > On Friday 11 Jun 2021 at 15:17:37 (+0100), Qais Yousef wrote:
> > > On 06/11/21 13:49, Quentin Perret wrote:
> > > > Thinking about it a bit more, a more involved option would be to have
> > > > this patch as is, but to also introduce a new RLIMIT_UCLAMP on top of
> > > > it. The semantics could be:
> > > > 
> > > >   - if the clamp requested by the non-privileged task is lower than its
> > > >     existing clamp, then allow;
> > > >   - otherwise, if the requested clamp is less than UCLAMP_RLIMIT, then
> > > >     allow;
> > > >   - otherwise, deny,
> > > > 
> > > > And the same principle would apply to both uclamp.min and uclamp.max,
> > > > and UCLAMP_RLIMIT would default to 0.
> > > > 
> > > > Thoughts?
> > > 
> > > That could work. But then I'd prefer your patch to go as-is. I don't think
> > > uclamp can do with this extra complexity in using it.
> > 
> > Sorry I'm not sure what you mean here?
> 
> Hmm. I understood this as a new flag to sched_setattr() syscall first, but now
> I get it. You want to use getrlimit()/setrlimit()/prlimit() API to impose
> a restriction. My comment was in regard to this being a sys call extension,
> which it isn't. So please ignore it.
> 
> > 
> > > We basically want to specify we want to be paranoid about uclamp CAP or not. In
> > > my view that is simple and can't see why it would be a big deal to have
> > > a procfs entry to define the level of paranoia the system wants to impose. If
> > > it is a big deal though (would love to hear the arguments);
> > 
> > Not saying it's a big deal, but I think there are a few arguments in
> > favor of using rlimit instead of a sysfs knob. It allows for a much
> > finer grain configuration  -- constraints can be set per-task as well as
> > system wide if needed, and it is the standard way of limiting resources
> > that tasks can ask for.
> 
> Is it system wide or per user?

Right, so calling this 'system-wide' is probably an abuse, but IIRC
rlimits are per-process, and are inherited accross fork/exec. So the
usual trick to have a default value is to set the rlimits on the init
task accordingly. Android for instance already does that for a few
things, and I would guess that systemd and friends have equivalents
(though admittedly I should check that).

> > 
> > > requiring apps that
> > > want to self regulate to have CAP_SYS_NICE is better approach.
> > 
> > Rlimit wouldn't require that though, which is also nice as CAP_SYS_NICE
> > grants you a lot more power than just clamps ...
> 
> Now I better understand your suggestion. It seems a viable option I agree.
> I need to digest it more still though. The devil is in the details :)
> 
> Shouldn't the default be RLIM_INIFINITY? ie: no limit?

I guess so yes.

> We will need to add two limit, RLIMIT_UCLAMP_MIN/MAX, right?

Not sure, but I was originally envisioning to have only one that applies
to both min and max. In which would we need separate ones?

> We have the following hierarchy now:
> 
> 	1. System Wide (/proc/sys/kerenl/sched_util_clamp_min/max)
> 	2. Cgroup
> 	3. Per-Task
> 
> In that order of priority where 1 limits/overrides 2 and 3. And
> 2 limits/overrides 3.
> 
> Where do you see the RLIMIT fit in this hierarchy? It should be between 2 and
> 3, right? Cgroup settings should still win even if the user/processes were
> limited?

Yes, the rlimit stuff would just apply the syscall interface.

> If the framework decided a user can't request any boost at all (can't increase
> its uclamp_min above 0). IIUC then setting the hard limit of RLIMIT_UCLAMP_MIN
> to 0 would achieve that, right?

Exactly.

> Since the framework and the task itself would go through the same
> sched_setattr() call, how would the framework circumvent this limit? IIUC it
> has to raise the RLIMIT_UCLAMP_MIN first then perform sched_setattr() to
> request the boost value, right? Would this overhead be acceptable? It looks
> considerable to me.

The framework needs to have CAP_SYS_NICE to change another process'
clamps, and generally rlimit checks don't apply to CAP_SYS_NICE-capable
processes -- see __sched_setscheduler(). So I think we should be fine.
IOW, rlimits are just constraining what unprivileged tasks are allowed
to request for themselves IIUC.

> Also, Will prlimit() allow you to go outside what was set for the user via
> setrlimit()? Reading the man pages it seems to override, so that should be
> fine.

IIRC rlimit are per-process properties, not per-user, so I think we
should be fine here as well?

> For 1 (System Wide) limits, sched_setattr() requests are accepted, but the
> effective uclamp is *capped by* the system wide limit.
> 
> Were you thinking RLIMIT_UCLAMP* will behave similarly?

Nope, I was actually thinking of having the syscall return -EPERM in
this case, as we already do for nice values or RT priorities.

> If they do, we have
> consistent behavior with how the current system wide limits work; but this will
> break your use case because tasks can change the requested uclamp value for
> a task, albeit the effective value will be limited.
> 
> 	RLIMIT_UCLAMP_MIN=512
> 	p->uclamp[UCLAMP_min] = 800	// this request is allowed but
> 					// Effective UCLAMP_MIN = 512
> 
> If not, then
> 
> 	RLIMIT_UCLAMP_MIN=no limit
> 	p->uclamp[UCLAMP_min] = 800	// task changed its uclamp_min to 800
> 	RLIMIT_UCLAMP_MIN=512		// limit was lowered for task/user
> 
> what will happen to p->uclamp[UCLAMP_MIN] in this case? Will it be lowered to
> match the new limit? And this will be inconsistent with the current system wide
> limits we already have.

As per the above, if the syscall returns -EPERM we can leave the
integration with system-wide defaults and such untouched I think.

> Sorry too many questions. I was mainly thinking loudly. I need to spend more
> time to dig into the details of how RLIMITs are imposed to understand how this
> could be a good fit. I already see some friction points that needs more
> thinking.

No need to apologize, this would be a new userspace-visible interface,
so you're right that we need to think it through.

Thanks for the feedback,
Quentin
