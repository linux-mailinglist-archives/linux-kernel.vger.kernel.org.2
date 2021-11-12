Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C813444E9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhKLPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:24:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB38AC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nw4fVxmHOhOzV4laJzGiSMwLTRJzCYywBkU/nufUygg=; b=o0yV9hz3EA5uK6RtR9i14hSjXp
        4K75+d4X9sMxAEl67mhlCT3z+CkLttOnPJNGyHftorbhxrLtCLITB6HtIYVP3Okpq8y98jjoGzOJ8
        gmL0sQ0yok0O3cQ3bRsUBLuQF4BypEb4PXWdrCe9L4JhE0LMyXvdh+rryWtXrDk+oSAEba/vCsnyQ
        QvKCUPQf47ee+jPoRikbZnNuYYg7egkIa/gu5FHEHZpDvJ42Bm23jf/6KDkBVggiyIZkVYGSwjXXB
        52KTTz1Ql5KkCHe4eMCqvCBj0xHSMPBOwU+1vCv5b9c5jNtTZyd3X3B4DZ8+9Yn9GMBXO5Xtq5Vft
        Nfh4g6HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlYMw-003cdw-LO; Fri, 12 Nov 2021 15:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62C2930001B;
        Fri, 12 Nov 2021 16:21:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25EF22080FBBA; Fri, 12 Nov 2021 16:21:34 +0100 (CET)
Date:   Fri, 12 Nov 2021 16:21:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Subject: Re: [PATCH 2/2] sched: sched: Fix rq->next_balance time updated to
 earlier than current time
Message-ID: <YY6GfilrilzTmhZx@hirez.programming.kicks-ass.net>
References: <20211112100458.7958-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112100458.7958-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:04:58AM +0100, Vincent Guittot wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> In traces on newidle_balance(), this_rq->next_balance
> time goes backward and earlier than current time jiffies, e.g.
> 
> 11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
> 11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> 13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
> 13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> 14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
> 14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c

No explanation of what these numbers mean, or where they're taken from.

> It doesn't make sense to have a next_balance in the past.
> Fix newidle_balance() and update_next_balance() so the next
> balance time is at least jiffies+1.

The changelog is deficient in that it doesn't explain how the times end
up in the past, therefore we cannot evaluate if the provided solution is
sufficient etc..

> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a162b0ec8963..1050037578a9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10138,7 +10138,10 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
>  
>  	/* used by idle balance, so cpu_busy = 0 */
>  	interval = get_sd_balance_interval(sd, 0);
> -	next = sd->last_balance + interval;
> +	if (time_after(jiffies+1, sd->last_balance + interval))
> +		next = jiffies+1;
> +	else
> +		next = sd->last_balance + interval;
>  
>  	if (time_after(*next_balance, next))
>  		*next_balance = next;
> @@ -10974,6 +10977,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  out:
>  	/* Move the next balance forward */
> +	if (time_after(jiffies+1, this_rq->next_balance))
> +		this_rq->next_balance = jiffies+1;

jiffies roll over here..

Also, what's the point of the update_next_balance() addition in the face
of this one? AFAICT this hunk completely renders the other hunk useless.

>  	if (time_after(this_rq->next_balance, next_balance))
>  		this_rq->next_balance = next_balance;

and you've violated your own premise :-)

Now, this pattern is repeated throughout, if it's a problem here, why
isn't it a problem in say rebalance_domains() ?

Can we please unify the code across sites instead of growing different
hacks in different places?

