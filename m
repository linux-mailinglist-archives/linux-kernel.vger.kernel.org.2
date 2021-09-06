Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61106401EB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhIFQw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:52:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbhIFQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:52:56 -0400
Date:   Mon, 6 Sep 2021 18:51:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630947110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dM6ZSxX+kqnXOlRxcZetuOZenpkaZFK+WdaWLO/jTjc=;
        b=cLrkL2oCbyMh3dFWYBOJZfHGLZQ4s6bizS6StIRX9HYFjByiABp3s+EGpWmHU7AMyOovwD
        KfQBlGVb3A3FLvgP3EwtUH9W4VEhHXIuByi8AQEKaki4S1q0sa5scET1cuaFl1MxXkgM7H
        cteLfpPHAmuFbYUhlct2Y8G4ASvVlwLYDUHLpO3NfJR0CLPNkgJDbJB5pRb0XqgOUa+RZO
        PUcKRzpk/q3FtNEEsE9g1OreEnmy83g0BJiGb56IvQEdwIGgXt5kmcUGyESsSSuzWGxG8T
        LU3N8ZYnaAR+OIS3NDmDRijncQB9Jk5/EOloiEzsvtc07Z7bFqlw4jWbV1inJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630947110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dM6ZSxX+kqnXOlRxcZetuOZenpkaZFK+WdaWLO/jTjc=;
        b=lvCTpbODJzaioPBX7fth65pZCas1S3RIGhZp3IoXhE7zMA4OdYcOkdqXY9ukCjpkdrWUxL
        jqvOOPrx8lhZlUCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: Fix ww_mutex deadlock check
Message-ID: <20210906165149.4b6ghzxnoqfm6ram@linutronix.de>
References: <20210831082152.GC9846@kili>
 <YS81R45p7mYbhmrT@hirez.programming.kicks-ass.net>
 <YS9La56fHMiCCo75@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS9La56fHMiCCo75@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 11:44:11 [+0200], Peter Zijlstra wrote:
> Subject: locking/rtmutex: Fix ww_mutex deadlock check
> 
> Dan reported that rt_mutex_adjust_prio_chain() can be called with
> .orig_waiter == NULL however commit a055fcc132d4 ("locking/rtmutex:
> Return success on deadlock for ww_mutex waiters") unconditionally
> dereferences it.
> 
> Since both call-sites that have .orig_waiter == NULL don't care for the
> return value, simply disable the deadlock squash by adding the NULL
> check.
> 
> Notably, both callers use the deadlock condition as a termination
> condition for the iteration; once detected, we're sure (de)boosting is
> done. Arguably [3] would be a more natural termination point, but I'm
> not sure adding a third deadlock detection state would improve the code.
> 
> Fixes: a055fcc132d4 ("locking/rtmutex: Return success on deadlock for ww_mutex waiters")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It sounds reasonable and I don't see any fallout in the testsuite so

  Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
>  kernel/locking/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 8eabdc79602b..6bb116c559b4 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -753,7 +753,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
>  		 * other configuration and we fail to report; also, see
>  		 * lockdep.
>  		 */
> -		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter && orig_waiter->ww_ctx)
>  			ret = 0;
>  
>  		raw_spin_unlock(&lock->wait_lock);

Sebastian
