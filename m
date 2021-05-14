Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0EF38110C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhENTpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhENTpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A93E61446;
        Fri, 14 May 2021 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621021447;
        bh=uT1EHBXnGzLPDuBUJURqmgOWwmzRXhUsEKFWNkyMxCc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rAFY9cq9YeVPkK35tZoimnWS/MriXxe1xMbXNHM3SQY2efmwzXPogruviaS/L506C
         nChybrSmoPFk4eBmnRymn4PezBmmeovtjBZkzcprf8HJAPLV3M/mjWlZ+H+Ldt2Ha1
         YpGvt1PwWwBqgeMFdS5H9TArPpQn2ngn2fb+OQyPp69ammYf6oORO4Q2E2k2G3wTRY
         pQYT7Hhme0SVGuyqfkRMLAUcXh512EBoFS5TT5lqjduJClgdDLKtjdOvjChGzXZTP1
         heGtN/kA5aTmtpVxIx7+3dhQd2kLv5QsB51DLT4czlcr5ioVKSOhjcJLZtAhOn+Q3m
         r8UY2IgeYCIJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 333C55C02A5; Fri, 14 May 2021 12:44:07 -0700 (PDT)
Date:   Fri, 14 May 2021 12:44:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
Subject: Re: [PATCH] ipc/sem.c: use READ_ONCE()/WRITE_ONCE() for
 use_global_lock
Message-ID: <20210514194407.GN975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210514175319.12195-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514175319.12195-1-manfred@colorfullife.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:53:19PM +0200, Manfred Spraul wrote:
> The patch solves two weaknesses in ipc/sem.c:
> 
> 1) The initial read of use_global_lock in sem_lock() is an
> intentional race. KCSAN detects these accesses and prints
> a warning.
> 
> 2) The code assumes that plain C read/writes are not
> mangled by the CPU or the compiler.
> 
> To solve both issues, use READ_ONCE()/WRITE_ONCE().
> Plain C reads are used in code that owns sma->sem_perm.lock.
> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

One follow-up question: If I am reading the code correctly, there is
a call to complexmode_enter() from sysvipc_sem_proc_show() that does
not hold the global lock.  Does this mean that the first check of
->use_global_lock in complexmode_enter() should be marked?

							Thanx, Paul

> ---
>  ipc/sem.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index bf534c74293e..a0ad3a3edde2 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -217,6 +217,8 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
>   * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
>   * is inside a spin_lock() and after a write from 0 to non-zero a
>   * spin_lock()+spin_unlock() is done.
> + * To prevent the compiler/cpu temporarily writing 0 to use_global_lock,
> + * READ_ONCE()/WRITE_ONCE() is used.
>   *
>   * 2) queue.status: (SEM_BARRIER_2)
>   * Initialization is done while holding sem_lock(), so no further barrier is
> @@ -342,10 +344,10 @@ static void complexmode_enter(struct sem_array *sma)
>  		 * Nothing to do, just reset the
>  		 * counter until we return to simple mode.
>  		 */
> -		sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
> +		WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
>  		return;
>  	}
> -	sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
> +	WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
>  
>  	for (i = 0; i < sma->sem_nsems; i++) {
>  		sem = &sma->sems[i];
> @@ -371,7 +373,8 @@ static void complexmode_tryleave(struct sem_array *sma)
>  		/* See SEM_BARRIER_1 for purpose/pairing */
>  		smp_store_release(&sma->use_global_lock, 0);
>  	} else {
> -		sma->use_global_lock--;
> +		WRITE_ONCE(sma->use_global_lock,
> +				sma->use_global_lock-1);
>  	}
>  }
>  
> @@ -412,7 +415,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
>  	 * Initial check for use_global_lock. Just an optimization,
>  	 * no locking, no memory barrier.
>  	 */
> -	if (!sma->use_global_lock) {
> +	if (!READ_ONCE(sma->use_global_lock)) {
>  		/*
>  		 * It appears that no complex operation is around.
>  		 * Acquire the per-semaphore lock.
> -- 
> 2.31.1
> 
