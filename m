Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B473A955B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhFPIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhFPIxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:53:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2QiwPS2Na/XljEgPdwhB2GK45kJilQMUypk9M8yGWKc=; b=J923zfGLO3xvSRTXfMYXwWem2o
        J9U6aDWNCBY5wzx0utXnninp2o6BpfwQzNn5rxdGWwP9fUZMmzbH/Q1esTFabnfmMXhsgP31WLZXA
        p5Rsd/X62ULqIPNnpaqHuaw8VWF/SDOO4aNcWqunCkm3/J0LYKKKgJvLBcZgkO1Q509qM80R8vgMR
        pXgUKCoCVKH0UevEPXonP47rUiV/ogofZ+GzQTp/4dc8TyidbEuN8Cx/HORraPk8jsDkE9lkO5Mxw
        Cq/673aJX5Vde6+Iy5pnZsIYwBhsctP0bOolN/0VJgR/H8jq6McbVRC/qMniZSNsTtGPY6uL3fd2e
        gojqLUFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltRGV-008H6n-VE; Wed, 16 Jun 2021 08:51:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A35A2300252;
        Wed, 16 Jun 2021 10:51:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8558E20C169E2; Wed, 16 Jun 2021 10:51:21 +0200 (CEST)
Date:   Wed, 16 Jun 2021 10:51:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/6] posix-cpu-timers: Don't start process wide cputime
 counter if timer is disabled
Message-ID: <YMm7iafJ1mberGIg@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113159.26177-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:55PM +0200, Frederic Weisbecker wrote:
> If timer_settime() is called with a 0 expiration on a timer that is
> already disabled, the process wide cputime counter will be started
> and won't ever get a chance to be stopped by stop_process_timer() since
> no timer is actually armed to be processed.
> 
> This process wide counter might bring some performance hit due to the
> concurrent atomic additions at the thread group scope.
> 
> The following snippet is enough to trigger the issue.
> 
> 	void trigger_process_counter(void)
> 	{
> 		timer_t id;
> 		struct itimerspec val = { };
> 
> 		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> 		timer_settime(id, TIMER_ABSTIME, &val, NULL);
> 		timer_delete(id);
> 	}
> 
> So make sure we don't needlessly start it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  kernel/time/posix-cpu-timers.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index aa52fc85dbcb..132fd56fb1cd 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -632,10 +632,15 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  	 * times (in arm_timer).  With an absolute time, we must
>  	 * check if it's already passed.  In short, we need a sample.
>  	 */
> -	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> +	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
>  		val = cpu_clock_sample(clkid, p);
> -	else
> -		val = cpu_clock_sample_group(clkid, p, true);
> +	} else {
> +		/*
> +		 * Sample group but only start the process wide cputime counter
> +		 * if the timer is to be enabled.
> +		 */
> +		val = cpu_clock_sample_group(clkid, p, !!new_expires);
> +	}

The cpu_timer_enqueue() is in arm_timer() and the condition for calling
that is:

  'new_expires != 0 && val < new_expires'

Which is not the same as the one you add.

I'm thinking the fundamental problem here is the disconnect between
cpu_timer_enqueue() and pct->timers_active ?
