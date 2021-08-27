Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5422E3F9DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhH0RX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245583AbhH0RXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:23:35 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCBC06129F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:22:46 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x5so7732700ill.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQF1u9twazTHw5bGzpfVJ61gjAfk0YOMr503PJzhxkA=;
        b=J5eWZarMLNhwjrVFQ2daH2Qe/cvX7HukjY3WROfeHrxvi6U5C8oRmvPRKnFAnJQCtb
         zzX3s2/DbR0f/lZ37Pz+h//qUCA/W3VtqMlYglE8RgUtvu9BuP2+8+5VLEMKSS/URzse
         rhEAi+t0USNcxZ+i6jFa0YP+JJa/fZcRWssgiOvpPihIToeC8AhPX3/7aBhxWfmCeOjB
         6GHwyHPM26gkxZQkYEo1v7lqx9svomtnfTn7i0JlXFCX2MbonOGfN5LID8ycZUrdmzTC
         PkGGNsZ1oELu+XsPFxQVnTHFTMc/54kqf9/h3F85kRhzs4OlYjnuQZXbm57V0XaN36AQ
         LuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQF1u9twazTHw5bGzpfVJ61gjAfk0YOMr503PJzhxkA=;
        b=SifJ1ciKJK0GGQ6uQrC+VHijIV5OA9oTjntdEHeBpoVE/RH+5frWjlegAp7FOSPrMX
         yBuKN/AtTI2LrtCNn5zFcc43Ax6ymibtVWNh0GtYcc3CdUKulv4KV0aCRbBiWPDzt4EB
         Gxq5MRYx0t2y/wi0x8twD7R8Vsce4d0R+Zw5JBesjhbSuJCSMtPD+UgrTCDVhQ++D7Le
         iVY5nALTQDoLhKqt4gkXZxptBBYr/FpKBTYAII5q6IYlVKr9S+Z4pf+LitoxW2mZk0em
         VepV/XeqAS9nR8/1nc6DzSeUDr/h9OKZNVsruyhY7i6QM5WtOlBpzbwdJzSNOzHBFb0h
         +OZQ==
X-Gm-Message-State: AOAM533dMRRf3o28PuW/DykXqI96PQqaeF/UMu3gPbpAhNS9OLxctR+C
        qgcF2Xn4xlp9LGwuO5U6Tvw=
X-Google-Smtp-Source: ABdhPJxj7scKBPfADEVZuIE6Jer7RjrckrcxvS6NKL4dphhM177roh4Tsba/N7/jg9h9yGfOHGATMA==
X-Received: by 2002:a92:8707:: with SMTP id m7mr7414471ild.177.1630084965748;
        Fri, 27 Aug 2021 10:22:45 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r8sm3579292iov.39.2021.08.27.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:22:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 579A627C005B;
        Fri, 27 Aug 2021 13:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 27 Aug 2021 13:22:44 -0400
X-ME-Sender: <xms:Yh8pYc8EiDm0Zo8Bjgcd63FSK-4XiPos0HosFlEthLeLGHRyaGIviQ>
    <xme:Yh8pYUsiBux9byqYTkfkzqpz2rUKNUIXfuE76L36I4Y4U1fNHx89JPebYRM3uQt-d
    RSc5OARtW62s2IfYw>
X-ME-Received: <xmr:Yh8pYSBU8J8yU2hO6mq0BTUOymdjEX79FFcINTFPi41l8p3mvpnMgeFq4tE1DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddufedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfeg
    vdegjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Yh8pYcf9S5dOD1FVpZhpLPL9CK-kDU3ua0GBAOTzlf9J0jn-EJ678w>
    <xmx:Yh8pYROcE3P6M4wlq0PAw9PNU9t34hqEjTK_avOuI76RvVSovT4HXQ>
    <xmx:Yh8pYWki_XlEDwkFou8XWLqR8kUrXgIUiZRf4Rs7mnLI5FPRlLyf6g>
    <xmx:Yx8pYWmhtCm_ZRrDAovT7rlPoij4CiDtfklx2qs7-pjkIhoSFZyVB5n6LJA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Aug 2021 13:22:42 -0400 (EDT)
Date:   Sat, 28 Aug 2021 01:21:46 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V5 32/72] locking/rtmutex: Provide the spin/rwlock core
 lock function
Message-ID: <YSkfKoXIYhsLT2Ef@boqun-archlinux>
References: <20210815203225.710392609@linutronix.de>
 <20210815211303.770228446@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815211303.770228446@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 11:28:25PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> A simplified version of the rtmutex slowlock function which neither handles
> signals nor timeouts and is careful about preserving the state of the
> blocked task across the lock operation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/locking/rtmutex.c        |   60 ++++++++++++++++++++++++++++++++++++++++
>  kernel/locking/rtmutex_common.h |    2 -
>  2 files changed, 61 insertions(+), 1 deletion(-)
> ---
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1416,3 +1416,63 @@ static __always_inline int __rt_mutex_lo
>  	return rt_mutex_slowlock(lock, state);
>  }
>  #endif /* RT_MUTEX_BUILD_MUTEX */
> +
> +#ifdef RT_MUTEX_BUILD_SPINLOCKS
> +/*
> + * Functions required for spin/rw_lock substitution on RT kernels
> + */
> +
> +/**
> + * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
> + * @lock:	The underlying rt mutex
> + */
> +static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
> +{
> +	struct rt_mutex_waiter waiter;
> +
> +	lockdep_assert_held(&lock->wait_lock);
> +
> +	if (try_to_take_rt_mutex(lock, current, NULL))
> +		return;
> +
> +	rt_mutex_init_rtlock_waiter(&waiter);
> +
> +	/* Save current state and set state to TASK_RTLOCK_WAIT */
> +	current_save_and_set_rtlock_wait_state();
> +
> +	task_blocks_on_rt_mutex(lock, &waiter, current, RT_MUTEX_MIN_CHAINWALK);
> +
> +	for (;;) {
> +		/* Try to acquire the lock again. */
> +		if (try_to_take_rt_mutex(lock, current, &waiter))
> +			break;
> +
> +		raw_spin_unlock_irq(&lock->wait_lock);
> +
> +		schedule_rtlock();
> +
> +		raw_spin_lock_irq(&lock->wait_lock);
> +		set_current_state(TASK_RTLOCK_WAIT);
> +	}
> +
> +	/* Restore the task state */
> +	current_restore_rtlock_saved_state();
> +
> +	/*
> +	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We
> +	 * might have to fix that up:
> +	 */
> +	fixup_rt_mutex_waiters(lock);
> +	debug_rt_mutex_free_waiter(&waiter);
> +}
> +
> +static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +	rtlock_slowlock_locked(lock);
> +	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);

Just out of curiosity, could we use raw_spin_{un,}lock_irq() here
instead of *_irq{save,restore}()? Because rtlock_slowlock() might sleep,
and we cannot call it with irq-off.

Regards,
Boqun

> +}
> +
> +#endif /* RT_MUTEX_BUILD_SPINLOCKS */
> --- a/kernel/locking/rtmutex_common.h
> +++ b/kernel/locking/rtmutex_common.h
> @@ -181,7 +181,7 @@ static inline void rt_mutex_init_waiter(
>  	waiter->task = NULL;
>  }
>  
> -static inline void rtlock_init_rtmutex_waiter(struct rt_mutex_waiter *waiter)
> +static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
>  {
>  	rt_mutex_init_waiter(waiter);
>  	waiter->wake_state = TASK_RTLOCK_WAIT;
> 
