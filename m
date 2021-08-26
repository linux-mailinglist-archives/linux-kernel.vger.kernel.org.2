Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEC3F90CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbhHZWx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:53:56 -0400
Received: from out0.migadu.com ([94.23.1.103]:44384 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhHZWxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:53:55 -0400
Date:   Fri, 27 Aug 2021 06:53:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630018384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erq1XqrY8ZVsMbLH+bOTHYcfIujF9uYA/N4nT8HFyFo=;
        b=Lh57LYjeZZhENIdAMjgBYwRj/m21dqYay8a3yO6Wu3VikEz+eTpTlpOXFNbptmkbvkNkxz
        okyZOOihNDt85VzogX3T+1lYXmYgipQ/R1T0wVNQ5oxu1uDsoqqmjeCTeW9nuMH9nv9i6C
        yXoFveRQKl0INhbz0tc/ffp9z+vVEAY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH] sched: Fix get_push_task() vs migrate_disable()
Message-ID: <YSgbfyLdkEApqsoI@geo.homenetwork>
References: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
 <YSfAWkWvd+4MJcvu@geo.homenetwork>
 <87k0k82dzq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0k82dzq.ffs@tglx>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Aug 26, 2021 at 09:38:17PM +0200, Thomas Gleixner wrote:
> Tao,
> 
> On Fri, Aug 27 2021 at 00:24, Tao Zhou wrote:
> > On Thu, Aug 26, 2021 at 03:37:38PM +0200, Sebastian Andrzej Siewior wrote:
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index e205b63d6db07..32a4945730a9b 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -2259,6 +2259,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
> >>  	if (p->nr_cpus_allowed == 1)
> >>  		return NULL;
> >>  
> >> +	if (p->migration_disabled)
> >> +		return NULL;
> >
> > Not much I can restore here..
> >
> > Is is_migration_disabled(p) be more correct to check migration
> > disable.
> 
> Kinda, but it's not an issue here because get_push_task() is only available when
> CONFIG_SMP=y which makes p->migration_disabled available as well.
> 
> > And get_push_task() being called in pull_rt_task() has checked migration
> > disable first and then call get_push_task(). That means this check in
> > get_push_task() in patch is a second repeatly check.
> 
> No. The checks are for two different tasks...

Aha, yes. I lost here. Thanks for your reply.

> Thanks,
> 
>         tglx



Thanks,
Tao
