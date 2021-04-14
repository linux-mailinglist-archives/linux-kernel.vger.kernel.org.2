Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA535EE30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349376AbhDNHNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhDNHNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:13:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1953C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=An14/uOqbqNoXgdc/38xhaX2pUyQaWxdG5rXPJLeQks=; b=TV5R9U9xdDbt7CRwEoSCyZYiOR
        Y+6nfwVug7s0CbXABCNGsc2/AA8WmS4YI+kgjzL1a90a+GI+CVMYQHfaErbZ/MQyZ+WkaHEQdEnGM
        LZNisTazY0LKtQknZbiC+7esPdaHta40rRZo8xWHCl9MVDjnY/HukwjHtK5Kp0oNNFRYO2OijElgI
        nrU09Wcdk8ZHhO91XMd3JEUN1Hq9uoCABhF4+M7dOSp0HfJSaiO/MYAKl6lDqJR1o3AMXk+zCr4IX
        keJEusjdBCJALm29e3UX/3vsNc6iXEmDYsase2JabqIghSUJliEoqF7tUYtlFVk3YvZ8aU22FPP/U
        6epD1hxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWZhF-006mws-Az; Wed, 14 Apr 2021 07:12:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94431300033;
        Wed, 14 Apr 2021 09:12:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EED4203D395C; Wed, 14 Apr 2021 09:12:20 +0200 (CEST)
Date:   Wed, 14 Apr 2021 09:12:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] sched/fair:Reduce unnecessary check preempt in
 the sched tick
Message-ID: <YHaV1CGkbUgbp2ek@hirez.programming.kicks-ass.net>
References: <20210414022229.5469-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414022229.5469-1-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:22:29AM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> As you are already set the TIF_NEED_RESCHED, there is no need
> to check resched again.

Still no justification; does this actually help anything?

> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/sched/fair.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..1a69b5fffe4a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4360,19 +4360,26 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
>  	unsigned long ideal_runtime, delta_exec;
>  	struct sched_entity *se;
> +	struct rq *rq = rq_of(cfs_rq);
>  	s64 delta;
>  
>  	ideal_runtime = sched_slice(cfs_rq, curr);
>  	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
>  	if (delta_exec > ideal_runtime) {
> -		resched_curr(rq_of(cfs_rq));
> +		if (!test_tsk_need_resched(rq->curr))
> +			resched_curr(rq_of(cfs_rq));
>  		/*
>  		 * The current task ran long enough, ensure it doesn't get
>  		 * re-elected due to buddy favours.
>  		 */
>  		clear_buddies(cfs_rq, curr);
>  		return;
> -	}
> +	/*
> +	 * If here with TIF_NEED_RESCHED already set from the early entity_tick,
> +	 * there is no need to check again.
> +	 */
> +	} else if (test_tsk_need_resched(rq->curr))
> +		return;

This is horrific style. And, afaict, completely unnecessary.
