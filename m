Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C6456DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhKSKib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:38:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhKSKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:38:20 -0500
Date:   Fri, 19 Nov 2021 11:35:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637318118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crDPWL6wWPxKzBCG/NfncOcztrIm4En5cL+/A9vukp8=;
        b=xCMIubKqm6gQwDlO7SQ4cbdte7FEJL7nHPlMM8UCPskzOSM8ThQ2p2CM/4MXV9y/6Jm25I
        DznQIQUzKWtK5TxI1QFD5PzIKrz80UUZhxMJTuYT7uWoLDyhIndE46YyRKfLguItCKShSP
        2QoaPtTVcZk6JI/uqXHhkpzHNuY9AYS7uOUWLmbIaiAgNNd3fXTS+HFcrQU+8KszNkivM8
        ChqgdRcjRgRodLBax0ULBYDxz7QgsSLiCqr1EADOsmSxTpHT9nbgG+8qEa1lMtf5P4jhQD
        1geqqoW+DuDabRJHfWd/UE6S7+8I8IdeN1KSSkc/V/LW2aQc4AiY39qLEO6D7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637318118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=crDPWL6wWPxKzBCG/NfncOcztrIm4En5cL+/A9vukp8=;
        b=lCBCAxONZzHFtUyRjsRsQcCjpHt31wz12lM2Gu5heUQU/rUP9s/Vy9XgGCgtboorCU18SF
        +S4a4muJxnE3IeAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 7/9] locking/rwlocks: introduce write_lock_nested
Message-ID: <20211119103516.24uhxrkdcy4vq25k@linutronix.de>
References: <20211115185909.3949505-1-minchan@kernel.org>
 <20211115185909.3949505-8-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115185909.3949505-8-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-15 10:59:07 [-0800], Minchan Kim wrote:
> diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
> index 49c1f3842ed5..efd6da62c893 100644
> --- a/include/linux/rwlock_rt.h
> +++ b/include/linux/rwlock_rt.h
> @@ -28,6 +28,7 @@ extern void rt_read_lock(rwlock_t *rwlock);
>  extern int rt_read_trylock(rwlock_t *rwlock);
>  extern void rt_read_unlock(rwlock_t *rwlock);
>  extern void rt_write_lock(rwlock_t *rwlock);
> +extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
>  extern int rt_write_trylock(rwlock_t *rwlock);
>  extern void rt_write_unlock(rwlock_t *rwlock);
>
> @@ -83,6 +84,11 @@ static __always_inline void write_lock(rwlock_t *rwlock)
>  	rt_write_lock(rwlock);
>  }
>  
> +static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
> +{
> +	rt_write_lock_nested(rwlock, subclass);
> +}
> +

These two hunks as-is don't work. You need a CONFIG_DEBUG_LOCK_ALLOC block and
in the !CONFIG_DEBUG_LOCK_ALLOC case you need

#define rt_write_lock_nested(lock, subclass)     rt_write_lock(((void)(subclass), (lock)))

>  static __always_inline void write_lock_bh(rwlock_t *rwlock)
>  {
>  	local_bh_disable();
> diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
> index b2e553f9255b..b82d346f1e00 100644
> --- a/kernel/locking/spinlock_rt.c
> +++ b/kernel/locking/spinlock_rt.c
> @@ -239,6 +239,18 @@ void __sched rt_write_lock(rwlock_t *rwlock)
>  }
>  EXPORT_SYMBOL(rt_write_lock);
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
> +{
> +	___might_sleep(__FILE__, __LINE__, 0);

This _must_ be rtlock_might_resched() like it is done in rt_write_lock()
above.

> +	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
> +	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
> +	rcu_read_lock();
> +	migrate_disable();
> +}
> +EXPORT_SYMBOL(rt_write_lock_nested);
> +#endif
> +
>  void __sched rt_read_unlock(rwlock_t *rwlock)
>  {
>  	rwlock_release(&rwlock->dep_map, _RET_IP_);

Sebastian
