Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD233F1F67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhHSRvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhHSRvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:51:14 -0700 (PDT)
Date:   Thu, 19 Aug 2021 19:51:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629395471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7JzR54d3NgMo4wVBkkuQgRsz+JyqC/wVuqOR0Pabdk=;
        b=hGOrxapBmW4wxBbP7Whl3aG/Ps8rkOIt6PolKgQEwyetUyzH0n+GLiq2ejDTIbk05BxL6e
        BzC87Q67UrTRXQ+rI4k2ttIo9HuLnyk7jH3t2vmlJ2UXJ8884RwSRuUPwDjLlNy0doCpf1
        Lfcji72fXk6U3TuzD50NeE97TvZEA56CxJBx4zK8wseViqLxJxj1pGsfwZf7PLx46KBgV1
        murZre1zu757v+JBrtqCelMnStwUyhq0jwKTv8dj88f0l4OTS051688HBHy0gKRwBi/Ofe
        ux4KZBjj3ddPxw++eoXBeI8bXnkvlWSk7LGu0XJtF5AUuPBfREu0Ug0amvMORA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629395471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7JzR54d3NgMo4wVBkkuQgRsz+JyqC/wVuqOR0Pabdk=;
        b=/ok1fVyn4sUWuEN3lj/VCCa6KRhCbuXvXDfxqy21bkoQLUJFs4pfQykvYp0AXWCq0aVT03
        feIH+Exektd3V/CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V5 41/72] locking/ww_mutex: Gather mutex_waiter
 initialization
Message-ID: <20210819175110.w7lxq5w3gdj5vhwf@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210815211304.281927514@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-15 23:28:39 [+0200], Thomas Gleixner wrote:
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -30,6 +30,7 @@ void debug_mutex_lock_common(struct mute
>  	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
>  	waiter->magic = waiter;
>  	INIT_LIST_HEAD(&waiter->list);
> +	waiter->ww_ctx = MUTEX_POISON_WW_CTX;
>  }
>  
>  void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -980,17 +980,15 @@ static __always_inline int __sched
>  	}
>  
>  	debug_mutex_lock_common(lock, &waiter);
> +	waiter.task = current;
> +	if (ww_ctx)
> +		waiter.ww_ctx = ww_ctx;
>  
>  	lock_contended(&lock->dep_map, ip);
>  
>  	if (!use_ww_ctx) {
>  		/* add waiting tasks to the end of the waitqueue (FIFO): */
>  		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
> -
> -
> -#ifdef CONFIG_DEBUG_MUTEXES
> -		waiter.ww_ctx = MUTEX_POISON_WW_CTX;
> -#endif

The crash, Guenter Roeck reported, is because now waiter.ww_ctx is
always initialized to poisen.
Previously in the ww-mutex case without a context it was set to NULL
in the next hunk.
Keeping the ww_ctx assigment in the next hunk seems to work.

>  	} else {
>  		/*
>  		 * Add in stamp order, waking up waiters that must kill
> @@ -999,12 +997,8 @@ static __always_inline int __sched
>  		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
>  		if (ret)
>  			goto err_early_kill;
> -
> -		waiter.ww_ctx = ww_ctx;
>  	}
>  
> -	waiter.task = current;
> -
>  	set_current_state(state);
>  	for (;;) {
>  		/*

Sebastian
