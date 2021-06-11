Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E193A3EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFKJKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:10:43 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40723 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhFKJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:10:41 -0400
Received: by mail-wm1-f50.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so8202160wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pQJ3BfPYSqrBaehjMNkJruE7mMOPGuFHp1rTNC+h/3E=;
        b=C8jhBTApNbUvLgfLU7JhGLc+8aMVWpVIqlU6EYHBDfWCwva+jRHD7pkpBmBb5oULvZ
         HqspfL2XkHAs30oy1kWR/EwtadFdbFLh7OyUmPHcsXf/8Mcv6HdV4DhNzj07Cpjvnx1Q
         OeDiJJgoPulflKheGJ+eyAMNMKikQc+2lVB8prN22SSHzXBkT0kiKQOpiyYAaEND4mIc
         0awfLYRbPbLgAGReqaJe45VdT31lnYMb24IDW9nJo+MP/N3IkpyRpEG5FVAOfyimFkIv
         LXAwmGUoLnIqDLfbrVQcpzEcYEbaO9FnND+QrJsF6cWXsg3Ilrxy3x1LXLMfYRKxx6Vs
         OCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pQJ3BfPYSqrBaehjMNkJruE7mMOPGuFHp1rTNC+h/3E=;
        b=bx8fYlpuS0F/l5A/DxUqq3JwzH//mHPAd23fM508xMbMhPlhJvOzuUaddMltBrvRPT
         jvI+juqXtkKTod6zRIQpWRtA5nPYmTqv9XCchn7WADZxol4ceNx01d15mS14GWJZio5d
         QSXaEQBZ4yTxm4oCwNdyw1HSGOkDBnNT7koO4USYvN9JUnqZkC7ox14dr/EwLvtm4pjP
         RH/0SFaCvnYgVz6chC47feIvfyc/xibpEMJd/44dodcyOopPYhE2rOdjrFIuKXr7/kul
         wjRXQtrRCHFetLQprzbYcLVk1nu5uvdfTwOWWz1ckCiGi2KCSdTALTZ60LTakVPskZfj
         az/Q==
X-Gm-Message-State: AOAM533WibR6vBaChJt5YlBHL/2NiacxB0zdCZxuUvZxeGtclXLZ7g/6
        NabPs+pkXaz9IXtjtp780YXguQ==
X-Google-Smtp-Source: ABdhPJw4wXdKjROPygN/+XX6tPWMkmxwAJmcEnyXl73IOMtJCB4OFDES3YLjnPoye2QZAQj2j5cSpw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr2871618wmk.25.1623402463289;
        Fri, 11 Jun 2021 02:07:43 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id l9sm5397611wme.21.2021.06.11.02.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:07:42 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:07:40 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <YMMn3IQOQWVg51Ms@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-3-qperret@google.com>
 <YMJk4TWEAGL3EKUO@hirez.programming.kicks-ass.net>
 <YMMl7YGb2LNzcdtN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMMl7YGb2LNzcdtN@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 Jun 2021 at 08:59:25 (+0000), Quentin Perret wrote:
> On Thursday 10 Jun 2021 at 21:15:45 (+0200), Peter Zijlstra wrote:
> > On Thu, Jun 10, 2021 at 03:13:05PM +0000, Quentin Perret wrote:
> > > SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
> > > the call must not touch scheduling parameters (nice or priority). This
> > > is particularly handy for uclamp when used in conjunction with
> > > SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
> > > impacts uclamp values.
> > > 
> > > However, sched_setattr always checks whether the priorities and nice
> > > values passed in sched_attr are valid first, even if those never get
> > > used down the line. This is useless at best since userspace can
> > > trivially bypass this check to set the uclamp values by specifying low
> > > priorities. However, it is cumbersome to do so as there is no single
> > > expression of this that skips both RT and CFS checks at once. As such,
> > > userspace needs to query the task policy first with e.g. sched_getattr
> > > and then set sched_attr.sched_priority accordingly. This is racy and
> > > slower than a single call.
> > > 
> > > As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
> > > is specified, simply inherit them in this case to match the policy
> > > inheritance of SCHED_FLAG_KEEP_POLICY.
> > > 
> > > Reported-by: Wei Wang <wvw@google.com>
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  kernel/sched/core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 3b213402798e..1d4aedbbcf96 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -6585,6 +6585,10 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
> > >  	rcu_read_unlock();
> > >  
> > >  	if (likely(p)) {
> > > +		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS) {
> > > +			attr.sched_priority = p->rt_priority;
> > > +			attr.sched_nice = task_nice(p);
> > > +		}
> > >  		retval = sched_setattr(p, &attr);
> > >  		put_task_struct(p);
> > >  	}
> > 
> > I don't like this much... afaict the KEEP_PARAMS clause in
> > __setscheduler() also covers the DL params, and you 'forgot' to copy
> > those.
> >
> > Can't we short circuit the validation logic?
> 
> I think we can but I didn't like the look of it, because we end up
> sprinkling checks all over the place. KEEP_PARAMS doesn't imply
> KEEP_POLICY IIUC, and the policy and params checks are all mixed up.
> 
> But maybe that wants fixing too? I guess it could make sense to switch
> policies without touching the params in some cases (e.g switching
> between FIFO and RR, or BATCH and NORMAL), but I'm not sure what that
> would mean for cross-sched_class transitions.

Aha, policy transitions are actually blocked in __setscheduler if
KEEP_PARAMS is set, so KEEP_PARAMS does imply KEEP_POLICY. So skipping
the checks might not be too bad, I'll have a go at it.
