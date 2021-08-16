Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC03E3EDD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhHPSyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhHPSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:54:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26370C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgT5CvitXfMITfK+y02y/I/quiStM8gDXffTjUkOrGY=; b=dAhUZEvpT61E1YQLsHl6siDLD0
        AfR0pwdNCO6ZKTRAwKv9e6eOCweqHEAvl2OJYSbBiMiEMB6IRSUVc8R0cAgzocDDJQzqX2VkEBK/f
        FnXz928012gYHCz716YjDlHxRjnc66eNGA87Ty8NWq8O7+AI+u1ebWvAwiA93inmFQwDAqmIxy2zo
        YM1CXgCdh6DX++bIW4+p6T4uZDBq1SMGTIGHG35corEErlxuImHxCAOhCU+TzPbhLTSHIfyDggbuI
        eNEnYUCMcZqAaam/6H4BZtbhp1ql4u7Lxo10vt9Faig+tDTfAtUlpdgZ6X7IsgRGPEGFo6Iihlh0k
        Cw1BnSSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFhiy-001hen-Ft; Mon, 16 Aug 2021 18:52:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91A1A30009A;
        Mon, 16 Aug 2021 20:52:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EE7729DAE38C; Mon, 16 Aug 2021 20:52:39 +0200 (CEST)
Date:   Mon, 16 Aug 2021 20:52:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Subject: Re: [PATCH] sched/core: An optimization of pick_next_task() not sure
Message-ID: <YRqz93crZIS1Mvmy@hirez.programming.kicks-ass.net>
References: <20210816154401.23919-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816154401.23919-1-tao.zhou@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:44:01PM +0800, Tao Zhou wrote:
> When find a new candidate max, wipe the stale and start over.
> Goto again: and use the new max to loop to pick the the task.
> 
> Here first want to get the max of the core and use this new
> max to loop once to pick the task on each thread.
> 
> Not sure this is an optimization and just stop here a little
> and move on..
> 

Did you find this retry was an issue on your workload? Or was this from
reading the source?

> ---
>  kernel/sched/core.c | 52 +++++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 20ffcc044134..bddcd328df96 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5403,7 +5403,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	const struct sched_class *class;
>  	const struct cpumask *smt_mask;
>  	bool fi_before = false;
> -	int i, j, cpu, occ = 0;
> +	int i, cpu, occ = 0;
>  	bool need_sync;
>  
>  	if (!sched_core_enabled(rq))
> @@ -5508,11 +5508,27 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	 * order.
>  	 */
>  	for_each_class(class) {
> -again:
> +		struct rq *rq_i;
> +		struct task_struct *p;
> +
>  		for_each_cpu_wrap(i, smt_mask, cpu) {
> -			struct rq *rq_i = cpu_rq(i);
> -			struct task_struct *p;
> +			rq_i = cpu_rq(i);
> +			p = pick_task(rq_i, class, max, fi_before);
> +			/*
> +			 * If this new candidate is of higher priority than the
> +			 * previous; and they're incompatible; pick_task makes
> +			 * sure that p's priority is more than max if it doesn't
> +			 * match max's cookie. Update max.
> +			 *
> +			 * NOTE: this is a linear max-filter and is thus bounded
> +			 * in execution time.
> +			 */
> +			if (!max || !cookie_match(max, p))
> +				max = p;
> +		}
>  
> +		for_each_cpu_wrap(i, smt_mask, cpu) {
> +			rq_i = cpu_rq(i);
>  			if (rq_i->core_pick)
>  				continue;
>  

This now calls pick_task() twice for each CPU, which seems unfortunate;
perhaps add q->core_temp storage to cache that result. Also, since the
first iteration is now explicitly about the max filter, perhaps we
shouuld move that part of pick_task() into the loop and simplify things
further?
