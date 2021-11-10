Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED57B44C8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhKJTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbhKJTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636572638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dbk5lIdW/7j1Q904c6fUOsJn47kZhm6n04f91Zt5JhU=;
        b=JRapwdvbaa5o02t4GvulT7fEsMvRLC3gdvN7/4SxIXbQMEhHYYuX/ovu+dSo1LyL4p4zkb
        nzrQ16ObMQhUCVdJdiNwtFLcvTnTcHkL4oZYTynOhxb614aHvltQEut9UrJEWPS97mm1nA
        J819N6Gx5c4hVe8hS4Pf6UfxwVzyI5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-vy3nRb_KNKevTBrQ-BUyEw-1; Wed, 10 Nov 2021 14:30:35 -0500
X-MC-Unique: vy3nRb_KNKevTBrQ-BUyEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA1E015735;
        Wed, 10 Nov 2021 19:30:33 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CD8819D9D;
        Wed, 10 Nov 2021 19:30:33 +0000 (UTC)
Date:   Wed, 10 Nov 2021 14:30:31 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched/cputime: Fix getrusage(RUSAGE_THREAD) with
 nohz_full
Message-ID: <YYwd17co5iwSnDzK@lorien.usersys.redhat.com>
References: <20211026141055.57358-1-frederic@kernel.org>
 <20211026141055.57358-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026141055.57358-3-frederic@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 26, 2021 at 04:10:55PM +0200 Frederic Weisbecker wrote:
> getrusage(RUSAGE_THREAD) with nohz_full may return shorter utime/stime
> than the actual time.
> 
> task_cputime_adjusted() snapshots utime and stime and then adjust their
> sum to match the scheduler maintained cputime.sum_exec_runtime.
> Unfortunately in nohz_full, sum_exec_runtime is only updated once per
> second in the worst case, causing a discrepancy against utime and stime
> that can be updated anytime by the reader using vtime.
> 
> To fix this situation, perform an update of cputime.sum_exec_runtime
> when the cputime snapshot reports the task as actually running while
> the tick is disabled. The related overhead is then contained within the
> relevant situations.
> 
> Reported-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
> ---
>  include/linux/sched/cputime.h |  5 +++--
>  kernel/sched/cputime.c        | 12 +++++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
> index 6c9f19a33865..ce3c58286062 100644
> --- a/include/linux/sched/cputime.h
> +++ b/include/linux/sched/cputime.h
> @@ -18,15 +18,16 @@
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
>  
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
> -extern void task_cputime(struct task_struct *t,
> +extern bool task_cputime(struct task_struct *t,
>  			 u64 *utime, u64 *stime);
>  extern u64 task_gtime(struct task_struct *t);
>  #else
> -static inline void task_cputime(struct task_struct *t,
> +static inline bool task_cputime(struct task_struct *t,
>  				u64 *utime, u64 *stime)
>  {
>  	*utime = t->utime;
>  	*stime = t->stime;
> +	return false;
>  }
>  
>  static inline u64 task_gtime(struct task_struct *t)
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 872e481d5098..9392aea1804e 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -615,7 +615,8 @@ void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
>  		.sum_exec_runtime = p->se.sum_exec_runtime,
>  	};
>  
> -	task_cputime(p, &cputime.utime, &cputime.stime);
> +	if (task_cputime(p, &cputime.utime, &cputime.stime))
> +		cputime.sum_exec_runtime = task_sched_runtime(p);
>  	cputime_adjust(&cputime, &p->prev_cputime, ut, st);
>  }
>  EXPORT_SYMBOL_GPL(task_cputime_adjusted);
> @@ -828,19 +829,21 @@ u64 task_gtime(struct task_struct *t)
>   * add up the pending nohz execution time since the last
>   * cputime snapshot.
>   */
> -void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
> +bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>  {
>  	struct vtime *vtime = &t->vtime;
>  	unsigned int seq;
>  	u64 delta;
> +	int ret;
>  
>  	if (!vtime_accounting_enabled()) {
>  		*utime = t->utime;
>  		*stime = t->stime;
> -		return;
> +		return false;
>  	}
>  
>  	do {
> +		ret = false;
>  		seq = read_seqcount_begin(&vtime->seqcount);
>  
>  		*utime = t->utime;
> @@ -850,6 +853,7 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>  		if (vtime->state < VTIME_SYS)
>  			continue;
>  
> +		ret = true;
>  		delta = vtime_delta(vtime);
>  
>  		/*
> @@ -861,6 +865,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>  		else
>  			*utime += vtime->utime + delta;
>  	} while (read_seqcount_retry(&vtime->seqcount, seq));
> +
> +	return ret;
>  }
>  
>  static int vtime_state_fetch(struct vtime *vtime, int cpu)
> -- 
> 2.25.1
> 


Could someone please pick this (or, rather, these) up?

Acked-by: Phil Auld <pauld@redhat.com>

Thanks!


Phil

-- 

