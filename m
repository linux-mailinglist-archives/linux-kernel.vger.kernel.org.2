Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0403A3E75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFKJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:02:28 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:47031 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFKJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:02:26 -0400
Received: by mail-wr1-f42.google.com with SMTP id a11so5188403wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eqAgH3+mYANtIZP0iDeonA1LwsqiapZHD1o9sAccub0=;
        b=CSbUD/qdqEy/bCWxz6KpYOVvv0StWKew/iZU184g8GVR/FnUEuYmgdlydfcQA2GwFG
         XcEPaHfMSz/GXArSlPQa35UcP4l2VNrdzMs//ow+Ho7K1ZtgIG/1BlpjtVGZAvz+uIcN
         C8IV9iCJQJfgr98J/dDMsnK/CmQa/NOSpStkX6Xj0jHANOKmDOn4lIatSmCYO1+2Rulq
         1C9NuzUahVqzyq98M94bDTRigWaTXoaRNpyQ9IVikpOD1WNV05wVVTbk9hlg7izKBI69
         NwhdLzx95yYH+JlIAKH0BtBghMF6aFVw9bShkZTKZKfLPU0JdGWCAl1Tgubrd0ZO5Siv
         SKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqAgH3+mYANtIZP0iDeonA1LwsqiapZHD1o9sAccub0=;
        b=P8EIZxk5eXLK6q3l3oJvqKhOHCzgsBa6HF9r6V7hs11A6HI0yo07qCk4QXl6xXZgF/
         jCXAz/+e6cZjFEa4L9RtPPfxSSTPArmGqFt6hMO5ZOOn8QDnlr/7dIUvi1Q6CGWprmx2
         Vi3/rX9IVNtdTFyFN7Z/M6PFDkJDV1s7nWs6VwlxXMqIkzi/XQNGEZ8F/b47LhU7VBCK
         CeKk8XUsv1qy4NeRtcYbwn2gZ0UHb6XJAp5ZT43AoTaoZ8YdG6brCIBMPY5Bw/0RYyTf
         lju6EjuGtGUeeM0v2o3R2GvAO7jdLZF5ZG7gpeUjXpqUd7EWCgCk2lmA+0FCxHsOsNuE
         cafw==
X-Gm-Message-State: AOAM531M6r5/s+jSyn0u4L53PW0M4Xp8kqATEFaJWQm8yeMcff5xpyaq
        IbLoeu4O++PTwZ99Q9WN56sZxCXs7Qy2MA==
X-Google-Smtp-Source: ABdhPJytxbsqS3WrPhWTtjV9U8QeIU17/B3Ph2rxu1ts4LGdGrPEvaho6hFVI7vXumSCAWO2G+w78Q==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr2786894wrv.163.1623401968490;
        Fri, 11 Jun 2021 01:59:28 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m23sm5429806wmc.29.2021.06.11.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:59:27 -0700 (PDT)
Date:   Fri, 11 Jun 2021 08:59:25 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <YMMl7YGb2LNzcdtN@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-3-qperret@google.com>
 <YMJk4TWEAGL3EKUO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMJk4TWEAGL3EKUO@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Jun 2021 at 21:15:45 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 10, 2021 at 03:13:05PM +0000, Quentin Perret wrote:
> > SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
> > the call must not touch scheduling parameters (nice or priority). This
> > is particularly handy for uclamp when used in conjunction with
> > SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
> > impacts uclamp values.
> > 
> > However, sched_setattr always checks whether the priorities and nice
> > values passed in sched_attr are valid first, even if those never get
> > used down the line. This is useless at best since userspace can
> > trivially bypass this check to set the uclamp values by specifying low
> > priorities. However, it is cumbersome to do so as there is no single
> > expression of this that skips both RT and CFS checks at once. As such,
> > userspace needs to query the task policy first with e.g. sched_getattr
> > and then set sched_attr.sched_priority accordingly. This is racy and
> > slower than a single call.
> > 
> > As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
> > is specified, simply inherit them in this case to match the policy
> > inheritance of SCHED_FLAG_KEEP_POLICY.
> > 
> > Reported-by: Wei Wang <wvw@google.com>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  kernel/sched/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3b213402798e..1d4aedbbcf96 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6585,6 +6585,10 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
> >  	rcu_read_unlock();
> >  
> >  	if (likely(p)) {
> > +		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS) {
> > +			attr.sched_priority = p->rt_priority;
> > +			attr.sched_nice = task_nice(p);
> > +		}
> >  		retval = sched_setattr(p, &attr);
> >  		put_task_struct(p);
> >  	}
> 
> I don't like this much... afaict the KEEP_PARAMS clause in
> __setscheduler() also covers the DL params, and you 'forgot' to copy
> those.
>
> Can't we short circuit the validation logic?

I think we can but I didn't like the look of it, because we end up
sprinkling checks all over the place. KEEP_PARAMS doesn't imply
KEEP_POLICY IIUC, and the policy and params checks are all mixed up.

But maybe that wants fixing too? I guess it could make sense to switch
policies without touching the params in some cases (e.g switching
between FIFO and RR, or BATCH and NORMAL), but I'm not sure what that
would mean for cross-sched_class transitions.
