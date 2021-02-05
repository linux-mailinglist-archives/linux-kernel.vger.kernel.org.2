Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729883113BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhBEVnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhBEO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:59:58 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16457C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:37:34 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id u20so3714322qvx.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RZ4pHLDiApBJAX4+SZTYvtkIoH8eBLs6rM4tc6HHOb4=;
        b=hYsydKUNEHn0p2d/mYnQEoYLwRRaK0kyows4etlt0PYfXW7AY21IngjDvFFC8KFn0J
         BfT4imr2GMmTV9TahiRR+3D8/Q2SQFOUoN8n/0yC2+LxO/IeNymqe2EjtuEi70SGdyZu
         lLVVaL3VWAV5eNL3CQMZlZnprr9GKYKQNvNwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RZ4pHLDiApBJAX4+SZTYvtkIoH8eBLs6rM4tc6HHOb4=;
        b=L784swYvHHPeEFvaxOzlfqoco6GEMN10DVpGHL7BEdwSYyutqUOBO53d0Dpkn1cjbm
         i5mAO8zpOggNjtmQDBEgsiCL84DdHePgcuhqX9ynvWhvD2UOw67uV3RJkefkWE/Ucr81
         vKfj/CKFmGNOQkCAjXnk7zaD6vhVOxE3/dXzNVovNG9UvRiwlPKnyb64H7FB1Z3HTm8+
         usrsdVWDXI4MiOoXudiRzdRl23KybFllMsv2ngdvMYkSXH7wqISXhp+GKJOgXpLnGUzU
         mYeMG0V2l9RHif0qcT97dtIqNhykjub1q3NUI2JIVyYtLJmFXCKeiJPjxI5+r60Y1HMi
         pzCA==
X-Gm-Message-State: AOAM533BHyaDkX4jPrCwlpU2yaS61Ovlr6HbkPbJAhp4ApA23DQEoDbf
        oBYTh3f3jS2jyUCUkLIZ+lfKNg==
X-Google-Smtp-Source: ABdhPJz4ssEjMBUzrBMVb/4kU6zSDiAAf9IZPCAAzcJOhbbMp5j5kDpY6RNPP+EaLBgCmLmSXwjAZQ==
X-Received: by 2002:a0c:b59f:: with SMTP id g31mr5057374qve.28.1612543053209;
        Fri, 05 Feb 2021 08:37:33 -0800 (PST)
Received: from localhost ([2620:15c:6:411:7d0b:8b50:779:2056])
        by smtp.gmail.com with ESMTPSA id k14sm8220219qtj.40.2021.02.05.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:37:31 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:37:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
Message-ID: <YB10S/qnerZkH9eb@google.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <YBwKRaNKJ8lD8DgZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwKRaNKJ8lD8DgZ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:52:53PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
> > +static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
> > +				     enum sched_core_cookie_type cookie_type)
> > +{
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +
> > +	if (!p)
> > +		return;
> > +
> > +	rq = task_rq_lock(p, &rf);
> > +
> > +	switch (cookie_type) {
> > +	case sched_core_task_cookie_type:
> > +		p->core_task_cookie = cookie;
> > +		break;
> > +	case sched_core_group_cookie_type:
> > +		p->core_group_cookie = cookie;
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +	}
> > +
> > +	/* Set p->core_cookie, which is the overall cookie */
> > +	__sched_core_update_cookie(p);
> > +
> > +	if (sched_core_enqueued(p)) {
> > +		sched_core_dequeue(rq, p);
> > +		if (!p->core_cookie) {
> > +			task_rq_unlock(rq, p, &rf);
> > +			return;
> > +		}
> > +	}
> > +
> > +	if (sched_core_enabled(rq) &&
> > +	    p->core_cookie && task_on_rq_queued(p))
> > +		sched_core_enqueue(task_rq(p), p);
> > +
> > +	/*
> > +	 * If task is currently running or waking, it may not be compatible
> > +	 * anymore after the cookie change, so enter the scheduler on its CPU
> > +	 * to schedule it away.
> > +	 */
> > +	if (task_running(rq, p) || p->state == TASK_WAKING)
> > +		resched_curr(rq);
> 
> I'm not immediately seeing the need for that WAKING test. Since we're
> holding it's rq->lock, the only place that task can be WAKING is on the
> wake_list. And if it's there, it needs to acquire rq->lock to get
> enqueued, and rq->lock again to get scheduled.
> 
> What am I missing?

Hi Peter,

I did this way following a similar pattern in affine_move_task(). However, I
think you are right. Unlike in the case affine_move_task(), we have
schedule() to do the right thing for us in case of any races with wakeup. So
the TASK_WAKING test is indeed not needed and we can drop tha test. Apologies
for adding the extra test out of paranoia.

thanks,

 - Joel

