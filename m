Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D243A95CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhFPJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhFPJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:18:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7LgyNhMeySjLgdtjGJWLbYeWqHj0anBeJjBkkv2F6pE=; b=mnp/CLLIE/CrGvHg8pqIaYBavF
        WVqiuhpup/iu0fMnxfsmxxzEJYj2wsUZYc3AuynDcVd+E4E9MmuhJaDyYbpQGJI713Fvmqn4wym8j
        NCZAomLoji9kUrrZIsYjtsarzH8bIA4PdM8uSdKabxzqd1LvTVAufFYcfzW8np6qoyKg26X2NXuZG
        WszqOILfCKSdfoRfkmKlpwW22hMX/faUZDEsy/f9UnKuQo8qO/i+3ZciwthWBRWVT6CMzpggvkjm0
        kPNcAttQnd9AbkrvEdAfQcpAYLsvF8VI47bnvCkgpbxQISwkplH6JgjZeIPw01jJL9/HMd9frC8Hi
        RgLx6pyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltReP-008HLY-MV; Wed, 16 Jun 2021 09:16:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13932300269;
        Wed, 16 Jun 2021 11:16:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01C3020277F84; Wed, 16 Jun 2021 11:16:03 +0200 (CEST)
Date:   Wed, 16 Jun 2021 11:16:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/6] posix-cpu-timers: Force next_expiration recalc after
 timer deletion
Message-ID: <YMnBUybUcUP3Ll/P@hirez.programming.kicks-ass.net>
References: <20210604113159.26177-1-frederic@kernel.org>
 <20210604113159.26177-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604113159.26177-4-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 01:31:56PM +0200, Frederic Weisbecker wrote:
> A timer deletion only dequeues the timer but it doesn't shutdown
> the related costly process wide cputimer counter and the tick dependency.
> 
> The following code snippet keeps this overhead around for one week after
> the timer deletion:
> 
> 	void trigger_process_counter(void)
> 	{
> 		timer_t id;
> 		struct itimerspec val = { };
> 
> 		val.it_value.tv_sec = 604800;
> 		timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> 		timer_settime(id, 0, &val, NULL);
> 		timer_delete(id);
> 	}
> 
> Make sure the next target's tick recalculates the nearest expiration and
> clears the process wide counter and tick dependency if necessary.

> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 132fd56fb1cd..bb1f862c785e 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -405,6 +405,33 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
>  	return 0;
>  }
>  
> +/*
> + * Dequeue the timer and reset the base if it was its earliest expiration.
> + * It makes sure the next tick recalculates the base next expiration so we
> + * don't keep the costly process wide cputime counter around for a random
> + * amount of time, along with the tick dependency.
> + */
> +static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
> +{
> +	struct cpu_timer *ctmr = &timer->it.cpu;
> +	struct posix_cputimer_base *base;
> +	int clkidx;
> +
> +	if (!cpu_timer_dequeue(ctmr))
> +		return;
> +
> +	clkidx = CPUCLOCK_WHICH(timer->it_clock);
> +
> +	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> +		base = p->posix_cputimers.bases + clkidx;
> +	else
> +		base = p->signal->posix_cputimers.bases + clkidx;
> +
> +	if (cpu_timer_getexpires(ctmr) == base->nextevt)
> +		base->nextevt = 0;
> +}

OK, so check_process_timers() unconditionally recomputes ->nextevt in
collect_posix_cputimers() provided ->timers_active. It also clears
->timers_active if it finds none are left. This recompute is before all
actual consumers of ->nextevt, with one exception.

This will loose the update of ->nextevt in arm_timer(), if one were to
happen between this and check_process_timers(), but afaict that has no
ill effect. Still that might warrant a comment somewhere.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
