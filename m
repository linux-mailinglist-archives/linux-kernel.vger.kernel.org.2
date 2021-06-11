Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67D3A3EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhFKJWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhFKJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:22:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60C8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EswCt/Z76atEagNm6Jm4YHwcVOamUfUCApeR1/tGBR8=; b=hhu/UUOXb5j/CbCXszQLcFUk6/
        qqF+dD6bXT9oZ7NvMyZyRn1OIM+vX4eZCVQeDDcIAUFEg6IN2I//fQY/x9YFKiZVyDSNBWYuNHxoc
        FbnXMmots3TuqMYJ7TNzDN9cnOIrOB/xX88p3hsZGAA4pGoo2DQD1JnSHQKh4edUTFyW6Jl2+6fZg
        GkH34vRNN4HGHyA+QwtP43eFPWgiqRLwTkjl2pkrDANu4znV3sD/qo5p143daIRx1kPfjucNkBvZH
        NyYIAeHap6/qmvzL0V3X9RYDKBAXeU0aSIBJlHTIGFvdLUoku2V65mMywmtrKG8v4A9BwWz+y5gll
        h+qdQdqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrdLA-005ptM-BT; Fri, 11 Jun 2021 09:20:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFF2030008D;
        Fri, 11 Jun 2021 11:20:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90C5821AB0AC0; Fri, 11 Jun 2021 11:20:42 +0200 (CEST)
Date:   Fri, 11 Jun 2021 11:20:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <YMMq6jtiwZUuKR3F@hirez.programming.kicks-ass.net>
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

On Fri, Jun 11, 2021 at 08:59:25AM +0000, Quentin Perret wrote:
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
> But maybe that wants fixing too? 

If you can make that code nicer, I'm all for it, it's a bit of a mess.

But failing that, I suppose the alternative is extracting something like
get_params from sched_getattr() and sharing that bit of code to do what
you do above.

> I guess it could make sense to switch
> policies without touching the params in some cases (e.g switching
> between FIFO and RR, or BATCH and NORMAL), but I'm not sure what that
> would mean for cross-sched_class transitions.

You're right, cross-class needs both.
