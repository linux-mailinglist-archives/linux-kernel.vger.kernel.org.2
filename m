Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33643B873
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJZRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhJZRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:43:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63231C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:40:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d20so5087764qvm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YRXI+6zdsKcLVpeQk0qCIlDOvQkB/1oPiySxlZMri08=;
        b=RWyIE4Fa617L7PVk0tEYvRLNtFXMBHRsMl0OSNmb8PzmXtCg89ULCtfe+hMRotirNG
         AqQW3LjEFv2Gje2pnvKhfwfz1JnufRpP+M90GUCHnKttmY3bJcR8VEabbTjh7L9IXzyq
         OBoih6AUbv5WU3Dk07pNt+AlamxCTlv6rIYLFca4ZjS90iHHgsa84HJdFfJ3pv/KHgrG
         LFsy+rf54xaHxNjyuFOuW/94/d4Gk4gjfpRnzLm60APmGccy+QJO0Y+DGE0/8+85q73u
         vzrxVMD59rL13CAh74by995mCrkfrMTcQJ0hy9KZgJP+aOUlR/aKifCa+YL3OBXYtfIc
         VWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YRXI+6zdsKcLVpeQk0qCIlDOvQkB/1oPiySxlZMri08=;
        b=DQzkjn9taCoT25HPBLLb3aIdE7ecUqwCMO/iyfJnpi0vfSSs/2h1VfUJHKRGzM8P8u
         yzFt4GtW62/uzDqPer4Juv0TK/HK4HHYQrEwN8YwTIE6/fhO3baVqcQ4ekFFRhVWzoDi
         CBMKXgXlE8YoUi+XuzyZqp3ShDiSEW08L0F2ZdRoI+Ja4MGQQJ6Zdou1GdFwuDtFVdut
         3MQEPgHYDV9oqkxDG2tZOK+zQAvrwQF00XeFoRulFLOQ1PddJ3mYjq3L/tycnZ5HDCuz
         ulpyfs6/DwQlTFCceHm96tkC17igKqbn5Ai5SNOVQCqMfZb6PGrkMBL6DujK3xFWwB3S
         QR/Q==
X-Gm-Message-State: AOAM532NO2hOVAsb0o+G2J2xHfITkEv72OHcAeWed/mnm3o8P1CCLtsj
        2xMJAV6+weTl8P4/vlNkwQ==
X-Google-Smtp-Source: ABdhPJyJMpzScr5IJYxxeUHHZCP5TfzpVhDgqyNsN1Qe+9yZZAshbUQdQGbHctpxd+agEfMpvhg8Xw==
X-Received: by 2002:a05:6214:2aae:: with SMTP id js14mr10025021qvb.27.1635270039544;
        Tue, 26 Oct 2021 10:40:39 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k8sm10699104qkk.37.2021.10.26.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:40:39 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:40:37 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched/cputime: Fix getrusage(RUSAGE_THREAD) with
 nohz_full
Message-ID: <YXg9lZv6u+zvRco5@gabell>
References: <20211026141055.57358-1-frederic@kernel.org>
 <20211026141055.57358-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026141055.57358-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 04:10:55PM +0200, Frederic Weisbecker wrote:
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

Thank you for this patch. getrusage(RUSAGE_THREAD) with nohz_full works well!
Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks,
Masa

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
