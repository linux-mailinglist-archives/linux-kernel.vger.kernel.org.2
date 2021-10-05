Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B96423257
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhJEUvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:51:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11517C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XZXpNwpz9osZrELs12g+PXZw7auEOq+ZDobp4Wv9Mys=; b=JtKLKX9tFSOY3oQEzAohka/d9y
        sBh03UWeq2jRDBNTXDVXX1YNss1U8TQVXrMIv7QWIt7LuNNUBx8bqRp5C6CdniHFIuuRLtCHPGii5
        iinB3wMls/xPr6d7MtqYBRtn7G2zA0UBOs84EYkPMvZ1GUzNGJ2f56ugM9J9hNqRJAKlkjeAlcKMF
        Cta6pPQqreBeM8CZwENzE9l3Da6ZD9wTTAKSFdEDFATPSRIxF+pXp2lWsRPKx54VFvFr7fG3z2jbV
        fgihB4vM7RjmzEbrzx5H3mEZS2CrcDmGrAamyts+psqYUs96fWCnh8sMVgeUM7X2pF5bXivxwohZa
        CeN+Iigw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXrNR-0087gz-2C; Tue, 05 Oct 2021 20:49:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1324D981AAA; Tue,  5 Oct 2021 22:49:28 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:49:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] sched/fair: Skip update_blocked_averages if we are
 defering load balance
Message-ID: <20211005204927.GE174703@worktop.programming.kicks-ass.net>
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
 <20211004171451.24090-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004171451.24090-3-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:14:51PM +0200, Vincent Guittot wrote:
> In newidle_balance(), the scheduler skips load balance to the new idle cpu
> when the 1st sd of this_rq is:
> 
>    this_rq->avg_idle < sd->max_newidle_lb_cost
> 
> Doing a costly call to update_blocked_averages() will not be useful and
> simply adds overhead when this condition is true.
> 
> Check the condition early in newidle_balance() to skip
> update_blocked_averages() when possible.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1f78b2e3b71c..1294b78503d9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10841,17 +10841,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	 */
>  	rq_unpin_lock(this_rq, rf);
>  
> +	rcu_read_lock();
> +	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> +
>  	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -	    !READ_ONCE(this_rq->rd->overload)) {
> +		!READ_ONCE(this_rq->rd->overload) ||
> +		(sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {

set cino=(0:0, please.

Also, people have, in the past, tried to get rid of the first clause
here, perhaps this can replace it instead of augment it?

>  
> -		rcu_read_lock();
> -		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  		if (sd)
>  			update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
>  
>  		goto out;
>  	}
> +	rcu_read_unlock();

There's another rcu_read_lock section right below this, at the very
least we can merge them.

Also, IIRC we're running all this with premption disabled, and since
rcu-sched got folded into rcu, all that rcu_read_*lock() stuff isn't
strictly required anymore.

(we're full circle there, back in the day RCU implied RCU-sched and the
scheduler relied on preempt-disable for lots of this stuff, then Paul
split them, and I spend a fair amount of time adding all this
rcu_read_*lock() crud, and now he's merge them again, and it can go
again).

Except of course, I think we need to make rcu_dereference_check happy
first :/
