Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996D944E8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhKLOcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhKLOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:32:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE371C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yjn5TF7htvmwDrVuz3mRtuCJAhpYpSdxeHobzEE41A=; b=UmU7h+ft+Z8IuG6ElCKOdGLd5B
        Wp/4lAirSwbYYmd/3prgwy+XOsHREf9WbPil0JEScF5ITpNnQHAKL305IWXLW+wDhMZnMxoLbtdCm
        3oFLU5ynIiF33mLFu5zBEsuIwkIPAAvfezi68o9kAHWkVWxTFxRMotN8UO0Tv4PZSB5zhDax12yig
        YzBLl1zWsac+bXCvRNUh/kFIBhRYzb0JLzBt051zmiDaVw6LTpCxezKoKijwipczAjSxqAuPRRNAB
        NM8BveSI5s2z3XdV0bY66IYgsHeBjD7gM3lEMHQ/uEhGOFGKCQWEZhWdOiy6PtKYumNGhZ5/IGTCA
        RSKnVIJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlXYT-003afL-IU; Fri, 12 Nov 2021 14:29:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71FF6300366;
        Fri, 12 Nov 2021 15:29:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39E852C6E8EFB; Fri, 12 Nov 2021 15:29:24 +0100 (CET)
Date:   Fri, 12 Nov 2021 15:29:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Subject: Re: [PATCH 1/2] sched/fair: skip newidle update stats
Message-ID: <YY56RBQR912S6ScC@hirez.programming.kicks-ass.net>
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112095857.7016-2-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 10:58:56AM +0100, Vincent Guittot wrote:
> In case we skip the newly idle LB entirely or we abort it because we are
> going to exceed the avg_idle, we have to make sure to not start an update
> of the blocked load when entering idle
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 13950beb01a2..a162b0ec8963 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10861,7 +10861,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	int this_cpu = this_rq->cpu;
>  	u64 t0, t1, curr_cost = 0;
>  	struct sched_domain *sd;
> -	int pulled_task = 0;
> +	int pulled_task = 0, early_stop = 0;
>  
>  	update_misfit_status(NULL, this_rq);
>  
> @@ -10898,8 +10898,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>  
> -		if (sd)
> +		if (sd) {
>  			update_next_balance(sd, &next_balance);
> +
> +			/*
> +			 * We skip new idle LB because there is not enough
> +			 * time before next wake up. Make sure that we will
> +			 * not kick NOHZ_NEWILB_KICK
> +			 */
> +			early_stop = 1;
> +		}
>  		rcu_read_unlock();
>  
>  		goto out;
> @@ -10918,8 +10926,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  		update_next_balance(sd, &next_balance);
>  
> -		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
> +		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> +			early_stop = 1;
>  			break;
> +		}
>  
>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
>  
> @@ -10969,7 +10979,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	if (pulled_task)
>  		this_rq->idle_stamp = 0;
> -	else
> +	else if (!early_stop)
>  		nohz_newidle_balance(this_rq);
>  
>  	rq_repin_lock(this_rq, rf);

Urgh code flow is a mess... Let me see if I can fix some of that.

Anyway, does nohz_newidle_balance() want to loose it's ->avg_idle test
with this on?
