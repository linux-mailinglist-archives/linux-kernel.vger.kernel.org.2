Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790713B9179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhGAMIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:08:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281ACC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:05:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r3so4355303wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgbewMvI6BnTlboIBSfq2MvWqho668pYPAmBfwyRL7o=;
        b=JteDJfxM4lf6OPGS2m2LVG7DA/Wuak3Wyt+9C0LYn+7kGQaaMGlg8v/yLgfIpvIB/Y
         CFmd99JUXdztY5b9iNFi3lMl8pxSYe79cS8B9fl/g7TB8hNvU5cFZbAvT26a+J+LpoTm
         xup9mxA0OdeOmYFuBQbSlnCaHSQenw0X/tSCQIk+85aGDkAUNxf+laQRbyT4kVH1DOh7
         wsY0pdQ5ycMkGJscxSJRM3LYsHGND/Lsm2YXNNieRP5OtpeavRyqLi1YKX/DFzfoc/Su
         IoIaYEnhWTi01O+0DMtoFfpHjnVDpH6TKVP99KzmIub7mNUF4hhbgWQhf7bvf0SlC8iC
         ne8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgbewMvI6BnTlboIBSfq2MvWqho668pYPAmBfwyRL7o=;
        b=TMPwul0prnLJWVNxxNXzQ+QsAfLjpEmUXbBEWtk5xOVrx2JW2ZrRU+mMABVyX5RlPk
         yixQ7cLCgXG0i25Z1deGVOcgJHc9pj0J8HHPU7FgP7uLExmoxahDBsY6gVoSTIZGEHEy
         uC5SR8AxZSS3nL2T1RKByyi1K2lwha/czbIJ+ewVbjq0bo1ty7xR0+K7ex91pI9wasv0
         MweFj7rOZBbo7hnANgnaTk0pIYo3K9OVNxWpBFvzCBpClMG3Z0AwqtXmbE4c6JjSTkpp
         lh3B0VYVWXVAgmMvRaBkTRx1xsfqBcs4NkXS/enHlDCZ2dVFB8FiRqAWZF+U70JJbg/A
         Ihyg==
X-Gm-Message-State: AOAM530To2p4tvH8uj1UDhM4Cyf+Kjk8kQosdNDR512BQ57HbWISq3yS
        +Tk48Rv+sUbJ0BN+lAjoyvd8sA==
X-Google-Smtp-Source: ABdhPJxTFqCeqdnbUJrvdX0pLCUNUw1q7ykm6r4W05YwODNfZ68YJvRmk+aZ0yKTPL8bUQoZSuKe3g==
X-Received: by 2002:a05:600c:254:: with SMTP id 20mr36964wmj.174.1625141139199;
        Thu, 01 Jul 2021 05:05:39 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id o11sm9260208wmc.2.2021.07.01.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:05:38 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:05:35 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
Message-ID: <YN2vj8OeZI7PBdzU@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-4-qperret@google.com>
 <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Thursday 01 Jul 2021 at 11:50:14 (+0100), Qais Yousef wrote:
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 9cbd915025ad..91a78cf1fe79 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -586,6 +586,7 @@ static const struct limit_names lnames[RLIM_NLIMITS] = {
> >  	[RLIMIT_NICE] = {"Max nice priority", NULL},
> >  	[RLIMIT_RTPRIO] = {"Max realtime priority", NULL},
> >  	[RLIMIT_RTTIME] = {"Max realtime timeout", "us"},
> > +	[RLIMIT_UCLAMP] = {"Max utilization clamp", NULL},
> 
> I think a single RLIMIT_UCLAMP is fine for pure permission control. But if we
> have to do something with the currently requested values we'd need to split it
> IMO.

I don't see why we'd need to TBH. Increasing the uclamp min of task will
request a higher capacity for the task, and increasing the uclamp min
will _allow_ the task to ask for a higher capacity. So at the end of the
day, what we want to limit is how much can a task request, no matter
how it does it. It's all the same thing in my mind, but if you have a
clear idea of what could go wrong, then I'm happy to think again :)

> >  };
> >  
> >  /* Display limits for a process */
> > diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
> > index 8874f681b056..53483b7cd4d7 100644
> > --- a/include/asm-generic/resource.h
> > +++ b/include/asm-generic/resource.h
> > @@ -26,6 +26,7 @@
> >  	[RLIMIT_NICE]		= { 0, 0 },				\
> >  	[RLIMIT_RTPRIO]		= { 0, 0 },				\
> >  	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> > +	[RLIMIT_UCLAMP]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> >  }
> >  
> >  #endif
> > diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
> > index f12db7a0da64..4d0fe4d564bf 100644
> > --- a/include/uapi/asm-generic/resource.h
> > +++ b/include/uapi/asm-generic/resource.h
> > @@ -46,7 +46,8 @@
> >  					   0-39 for nice level 19 .. -20 */
> >  #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
> >  #define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
> > -#define RLIM_NLIMITS		16
> > +#define RLIMIT_UCLAMP		16	/* maximum utilization clamp */
> > +#define RLIM_NLIMITS		17
> >  
> >  /*
> >   * SuS says limits have to be unsigned.
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ad055fb9ed2d..b094da4c5fea 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1430,6 +1430,11 @@ static int uclamp_validate(struct task_struct *p,
> >  	if (util_min != -1 && util_max != -1 && util_min > util_max)
> >  		return -EINVAL;
> >  
> > +	return 0;
> > +}
> > +
> > +static void uclamp_enable(void)
> > +{
> >  	/*
> >  	 * We have valid uclamp attributes; make sure uclamp is enabled.
> >  	 *
> > @@ -1438,8 +1443,20 @@ static int uclamp_validate(struct task_struct *p,
> >  	 * scheduler locks.
> >  	 */
> >  	static_branch_enable(&sched_uclamp_used);
> > +}
> >  
> > -	return 0;
> > +static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
> > +{
> > +	unsigned long uc_rlimit = task_rlimit(p, RLIMIT_UCLAMP);
> > +
> > +	if (value == -1) {
> > +		if (rt_task(p) && clamp_id == UCLAMP_MIN)
> > +			value = sysctl_sched_uclamp_util_min_rt_default;
> > +		else
> > +			value = uclamp_none(clamp_id);
> > +	}
> > +
> > +	return value <= p->uclamp_req[clamp_id].value || value <= uc_rlimit;
> 
> Hmm why do we still need to prevent the task from changing the uclamp value
> upward?

Because this is exactly how rlimit already works for nice or rt
priorities. Tasks are always allowed to decrease their 'importance'
(that is, increase their nice values for ex.), but are limited in how
they can increase it.

See the __sched_setscheduler() permission checks for nice values and
such.

> It just shouldn't be outside the specified limit, no?
> 
> And I think there's a bug in this logic. If UCLAMP_MIN was 1024 then the
> RLIMIT_UCLAMP was lowered to 512, the user will be able to change UCLAMP_MIN to
> 700 for example because of the
> 
> 	return value <= p->uclamp_req[clamp_id].value || ...

Right, but again this is very much intentional and consistent with the
existing behaviour for RLIMIT_NICE and friends. I think we should stick
with that for the new uclamp limit unless there is a good reason to
change it.

> I think we should just prevent the requested value to be above the limit. But
> the user can lower and increase it within that range. ie: for RLIMIT_UCLAMP
> = 512, any request in the [0:512] range is fine.
> 
> Also if we set RLIMIT_UCLAMP = 0, then the user will still be able to change
> the uclamp value to 0, which is not what we want. We need a special value for
> *all requests are invalid*.

And on this one again this is all for consistency :)

> I'm not against this, but my instinct tells me that the simple sysctl knob to
> define the paranoia/priviliged level for uclamp is a lot simpler and more
> straightforward control.

It is indeed simpler, but either way we're committing to a new
userspace-visible. I feel that the rlimit stuff is going to be a lot
more future-proof, because it allows for much finer grain configurations
and as such is likely to cover more use-cases in the long run.

Thanks,
Quentin
