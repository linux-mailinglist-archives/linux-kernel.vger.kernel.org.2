Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAA41C3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbhI2L4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbhI2L4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:56:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82544C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AXcOMRD/oN+qiHrpXzSGG6mQTQ8QYHKWZxpXmmnTiyU=; b=Cu4ooHnsYEhN91FUMt4dY+EhSo
        54iEtJCscLxGIgyi/zNVQjQ6Lksxvwv6lPLx7fMy/PoiNnYLKVixE9BUEfYeETMam6Dcs1NFl6cm4
        sYw6Jj8Rl5y8JIvrPieP8C3aNQJcmpQ8bNr7US0HPG3HwVyf0tsfiwyaDfWdGPEYQs+mqnaPs9e7L
        VnQsFmvVHOCx8dhE1aP0yIuwUippnRvoHzdmpnFJkYsNKKCDYvFjyBYIX95jZQhKaI7KLfalji4BS
        x8ZW05TI4ZooL8YI94QebpsUC7ukNf2D155X54PowLBDSLedgP9+sZXLAZtbNBiCgiCA+dA6LkxPP
        pXDFLM4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVYAE-006hgK-9e; Wed, 29 Sep 2021 11:54:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95D4E300056;
        Wed, 29 Sep 2021 13:54:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CA2B20177EAF; Wed, 29 Sep 2021 13:54:17 +0200 (CEST)
Date:   Wed, 29 Sep 2021 13:54:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [patch 4/5] sched: Delay task stack freeing on RT
Message-ID: <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net>
References: <20210928122339.502270600@linutronix.de>
 <20210928122411.593486363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928122411.593486363@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:24:30PM +0200, Thomas Gleixner wrote:

> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -172,6 +172,11 @@ static void delayed_put_task_struct(stru
>  	kprobe_flush_task(tsk);
>  	perf_event_delayed_put(tsk);
>  	trace_sched_process_free(tsk);
> +
> +	/* RT enabled kernels delay freeing the VMAP'ed task stack */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		put_task_stack(tsk);
> +
>  	put_task_struct(tsk);
>  }

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4846,8 +4846,12 @@ static struct rq *finish_task_switch(str
>  		if (prev->sched_class->task_dead)
>  			prev->sched_class->task_dead(prev);
>  
> -		/* Task is done with its stack. */
> -		put_task_stack(prev);
> +		/*
> +		 * Release VMAP'ed task stack immediate for reuse. On RT
> +		 * enabled kernels this is delayed for latency reasons.
> +		 */
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +			put_task_stack(prev);
>  
>  		put_task_struct_rcu_user(prev);
>  	}


Having this logic split across two files seems unfortunate and prone to
'accidents'. Is there a real down-side to unconditionally doing it in
delayed_put_task_struct() ?

/me goes out for lunch... meanwhile tglx points at: 68f24b08ee89.

Bah.. Andy?
