Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076544EB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhKLQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:39:02 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA4C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:36:10 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t83so7254391qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1KTTZSFpv5Mx7Y3WJbOlusBXYkGHh9qpD6INjny64qY=;
        b=gtAruu5K25dKTwTtlOLrRXW03nfMdBP/fraAGMGLUOAq37M1okA3jRzq5kP4P/7AP0
         9oYK2LEuvkHlibUEMyCuWjUB6JUhniWweOUhsT0jB9Ta5e3BIFhNubJBn6VWlEfGyS8g
         PWSLn8QXE/rcxgID31lZ1Lt2BJNrlC0DRDUlrkl9khCzvuH2F3YGgk/Q+cGtCQhKJlGa
         I5JNWUCrDA2GZs00fNnVkjW4ucEg1wWRYKmAaDQJXWCg84cA176vGGXoZV90+0M0JUQc
         WHzN9XlPq76Bm5eph3fslsJVXMDTeCIMVsWs93lxPCCGvsRfB8IZxjeRex++IoDswHkn
         NEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KTTZSFpv5Mx7Y3WJbOlusBXYkGHh9qpD6INjny64qY=;
        b=kCnbpJh2PEbR2d3KHBmcNdqHSrLFk+RtspXG5pk0UJOn49Vh2r8KI6QC0FTncwy9sY
         t84/cVKZtFOUZE784nbgEhvN+CoowH5WBoa+VTuKVBkP8zHjQ1ps/TO07YHquYFiiGsw
         ULcZx6F/YkICigUBQplC4fDbfKtHI3FbIRZOrVj5oT/4wksWediHcb08IAiS6nqk+jtp
         bkl+jFc0lF//4e1IWx5e9X4MW7eqm7IDYLL0ycop1RdpsIdwbCkNBK32keQ6625R5owQ
         eJTE1g2oytsw+l1hIH5IJh2uWJrwH0jGhux2Z9ZI2ASGBFXvINNzh+NdkLFswplL1Bca
         fp8A==
X-Gm-Message-State: AOAM530sqWbdicldMXxdB0y0EVS9jNGtl3GbD8m9nKxzrAFcXLnu5d9Y
        sgNHKkilIvOQEw/vf0UpDgPRTw==
X-Google-Smtp-Source: ABdhPJwuxg/92hDyW9wy/IXQfi5JAN3/ZbDgxSD1/0rZMEoEbQlseL3MZdNfLTBUs2bK0XZK4+Kdcw==
X-Received: by 2002:a05:620a:450a:: with SMTP id t10mr13871770qkp.412.1636734970152;
        Fri, 12 Nov 2021 08:36:10 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id o17sm2959085qtv.30.2021.11.12.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:36:09 -0800 (PST)
Date:   Fri, 12 Nov 2021 11:36:08 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
Message-ID: <YY6X+HPS8A4sLEiO@cmpxchg.org>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 03:56:36PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> > CC peterz as well for rt and timekeeping magic
> > 
> > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > 
> > > In an EAS enabled system, there are two scenarios discordant to current design,
> > > 
> > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > RT task usually preempts CFS task in little core.
> > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > ignore the preempted time by RT, DL and Irqs.
> 
> It ignores preemption full-stop. I don't see why RT/IRQ should be
> special cased here.
> 
> > > With these two constraints, the percpu nonidle time would be mainly consumed by
> > > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > > via the proportion of cfs_rq's utilization on the whole rq.
> 
> 
> > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > +{
> > > +	struct rq *rq = task_rq(current);
> > > +	unsigned long growth_fixed = (unsigned long)growth;
> > > +
> > > +	if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > +		return growth_fixed;
> > > +
> > > +	if (current->in_memstall)
> > > +		growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > +					- rq->avg_irq.util_avg + 1) * growth, 1024);
> > > +
> > > +	return growth_fixed;
> > > +}
> > > +
> > >  static void init_triggers(struct psi_group *group, u64 now)
> > >  {
> > >  	struct psi_trigger *t;
> > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > >  	}
> > >  
> > >  	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > +		delta = psi_memtime_fixup(delta);
> > 
> > Ok, so we want to deduct IRQ and RT preemption time from the memstall
> > period of an active reclaimer, since it's technically not stalled on
> > memory during this time but on CPU.
> > 
> > However, we do NOT want to deduct IRQ and RT time from memstalls that
> > are sleeping on refaults swapins, since they are not affected by what
> > is going on on the CPU.
> 
> I think that focus on RT/IRQ is mis-guided here, and the implementation
> is horrendous.
> 
> So the fundamental question seems to be; and I think Johannes is the one
> to answer that: What time-base do these metrics want to use?
> 
> Do some of these states want to account in task-time instead of
> wall-time perhaps? I can't quite remember, but vague memories are
> telling me most of the PSI accounting was about blocked tasks, not
> running tasks, which makes all this rather more complicated.
> 
> Randomly scaling time as proposed seems almost certainly wrong. What
> would that make the stats mean?

It *could* be argued that IRQs and RT preemptions are CPU stalls.

I'm less convinced we should subtract preemptions from memory stalls.

Yes, when you're reclaiming and you get preempted for whatever reason,
you're technically stalled on CPU in this moment. However, reclaim
itself consumes CPU and walltime, and it could be what is causing
those preemptions to begin with! For example, reclaim could eat up 90%
of your scheduling timeslice and then cause a preemption when the
thread is back in userspace and trying to be productive. By consuming
time, it also drags out the overall timeline for userspace to finish
its work, and a longer timeline will have more disruptions from
independent events like IRQs and RT thread wakeups.

So if you *were* to discount CPU contention from memory stalls, it
would also mean that you'd have to count *memory stalls* when
userspace experiences CPU contention caused by preceding reclaims. I
don't think it makes sense to try to go down that road...

They're dependent resources. Just like faster CPUs and faster IO
devices mean less memory pressure for the same amount of reclaim and
paging activity, it seems logical that contention of those underlying
resources will result in longer memory stalls and higher pressure.
