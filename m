Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA10C338B93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhCLLgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbhCLLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:35:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:35:45 -0800 (PST)
Date:   Fri, 12 Mar 2021 12:35:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615548941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xX8P03TtZH6T55/VsCQ3I0wyuiyg/KtGk1p9na+SNbk=;
        b=NYW+VO82yU9feDyxopQCxlsQEHNmXhDD00v654OZiabfMmJ5Hygu8U+S8IY2+VoKz6WhtG
        g5NBYK0fgQqHkcxSkXkbBg4Lddb35t5kAECDPF5jZ9T0Rmrp4UorZ8kjPsPchJa+FoIfGM
        nTcP1s7ArBlkgypSeI+O61yiEp1NunvbuaLMUkEMtW2Lh+IdtaKCK6GLQI91DZpdHNoet2
        smZphlBJmjXKJ0pSkQEN83P7/z+sozLqW3mlscbpUYojBD4XlY+QI2RMD35xMwGZ5RtWA5
        oSE7vhJFMN7zJw9H0UFvXPaYlddE3TsMuVonZqJSDhngmkatdvZbJZEZ8NuTOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615548941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xX8P03TtZH6T55/VsCQ3I0wyuiyg/KtGk1p9na+SNbk=;
        b=CQBPDuSb1N40OO5Vz6zLx0+IxkEq4F4W7U3ClmPG67XUdFatyWsIxPvofHW1MtrTv/w6Cy
        UjHbillW6Z7YtaAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch V2 3/3] signal: Allow tasks to cache one sigqueue struct
Message-ID: <20210312113540.7byffvc46cgj75ah@linutronix.de>
References: <20210311132036.228542540@linutronix.de>
 <20210311141704.424120350@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210311141704.424120350@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-11 14:20:39 [+0100], Thomas Gleixner wrote:
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -433,7 +433,11 @@ static struct sigqueue *
>  	rcu_read_unlock();
>  
>  	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
> -		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
> +		/* Preallocation does not hold sighand::siglock */
> +		if (sigqueue_flags || !t->sigqueue_cache)
> +			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
> +		else
> +			q = xchg(&t->sigqueue_cache, NULL);

Could it happen that two tasks saw t->sigqueue_cache != NULL, the first
one got the pointer via xchg() and the second got NULL via xchg()?

>  	} else {
>  		print_dropped_signal(sig);
>  	}
> @@ -472,12 +481,19 @@ void flush_sigqueue(struct sigpending *q
>  }
>  
>  /*
> - * Called from __exit_signal. Flush tsk->pending and clear tsk->sighand.
> + * Called from __exit_signal. Flush tsk->pending, clear tsk->sighand and
> + * free tsk->sigqueue_cache.
>   */
>  void exit_task_sighand(struct task_struct *tsk)
>  {
> +	struct sigqueue *q;
> +
>  	flush_sigqueue(&tsk->pending);
>  	tsk->sighand = NULL;
> +
> +	q = xchg(&tsk->sigqueue_cache, NULL);
> +	if (q)
> +		kmem_cache_free(sigqueue_cachep, q);

Do we need this xchg() here? Only the task itself adds something here
and the task is on its way out so it should not add an entry to the
cache.

>  }
>  
>  /*

Sebastian
