Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD9F3F4A34
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhHWMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhHWMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:01:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF0EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SvYyxaR7pbaroKoYkxxVyJBV0ySbQ+OIJjyRsFmYxFo=; b=g3CjWbwjcvDmlrsJarkQJZWQCh
        Rady3qn1tVuaeZKNowXoQhfdxvMBc950JONW9X7tU6X+9KdEj/bZeNJQvFTy9UMi+YCaQ9FKLDOHH
        Hz/7e/X3MlPYVEvytw7g0RikKrvGQflHS4RbRkXRrS3hKOJNnlQBQpTUH8n5bQg7UvmK+8Owx/0o0
        APGJd9nJ+kHMv+e22d6Gdb28i+CTkPWsCtUx/ZcUaMYhoHLCBlsGWvaFWHjO7+aiyQbqf4/0AgsFF
        lRlEu6OP8HajueuuKTL8d4VCdE75XAaBnhFfON7c3Z6B8ieNiOuJYLgiuvlSFDUVa53A0TfLGoqhd
        DLcYqsKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI8bs-009hP4-5N; Mon, 23 Aug 2021 11:59:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F0BB300332;
        Mon, 23 Aug 2021 13:59:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68D2020A5C3C3; Mon, 23 Aug 2021 13:59:23 +0200 (CEST)
Date:   Mon, 23 Aug 2021 13:59:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Add NOHZ balancer flag for
 nohz.next_balance updates
Message-ID: <YSONmyWL14mqV6zA@hirez.programming.kicks-ass.net>
References: <20210823111700.2842997-1-valentin.schneider@arm.com>
 <20210823111700.2842997-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823111700.2842997-2-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 12:16:59PM +0100, Valentin Schneider wrote:

> Gate NOHZ blocked load
> update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
> kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
> expected.

> @@ -10572,7 +10572,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  	 * setting the flag, we are sure to not clear the state and not
>  	 * check the load of an idle cpu.
>  	 */
> -	WRITE_ONCE(nohz.has_blocked, 0);
> +	if (flags & NOHZ_STATS_KICK)
> +		WRITE_ONCE(nohz.has_blocked, 0);
>  
>  	/*
>  	 * Ensures that if we miss the CPU, we must see the has_blocked
> @@ -10594,13 +10595,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  		 * balancing owner will pick it up.
>  		 */
>  		if (need_resched()) {
> -			has_blocked_load = true;
> +			if (flags & NOHZ_STATS_KICK)
> +				has_blocked_load = true;
>  			goto abort;
>  		}
>  
>  		rq = cpu_rq(balance_cpu);
>  
> -		has_blocked_load |= update_nohz_stats(rq);
> +		if (flags & NOHZ_STATS_KICK)
> +			has_blocked_load |= update_nohz_stats(rq);
>  
>  		/*
>  		 * If time for next balance is due,
> @@ -10631,8 +10634,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  	if (likely(update_next_balance))
>  		nohz.next_balance = next_balance;
>  
> -	WRITE_ONCE(nohz.next_blocked,
> -		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> +	if (flags & NOHZ_STATS_KICK)
> +		WRITE_ONCE(nohz.next_blocked,
> +			   now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>  
>  abort:
>  	/* There is still blocked load, enable periodic update */

I'm a bit puzzled by this; that function has:

  SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);

Which:

 - isn't updated
 - implies STATS must be set when BALANCE

the latter gives rise to my confusion; why add that gate on STATS? It
just doesn't make sense to do a BALANCE and not update STATS.
