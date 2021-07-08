Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115863BF924
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGHLko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhGHLkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A70861436;
        Thu,  8 Jul 2021 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625744281;
        bh=XCxvllQ/KD+p9FxitaUkqrANLpqAIhFcRBSM/MmUgQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNgQlrQSej9qvj5IpDGyJO8hLbhjXbUbgpHpwZuGskaUzjJxXBFKweAz+o0jJhYRz
         xySP/0gEhtrFch2B1hHjYhZvmTlWDZcACJK5tMxIF2GcrAREyLucYMimIHoH2vqsXS
         dYbP06HMpzwnp7rwRnqmAwy2NiqRo0U9HDMfj5hhEAhjO7KWZiRQS1zKgNgRcDv1Up
         s27x4h2QvUsq8y7grfyBcvXt6ywwN10xr3XnOD+2ycliNlidcy8cjolGnH+uuj5hG1
         CB6uNb81PDi842af4bcWcIzQvp4X4t7VpqiDrbBqq08kOGbi2mfWTs+FwpXfQ/ZctO
         2mFlTubY6K7WA==
Date:   Thu, 8 Jul 2021 13:37:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] preempt: Allow CONFIG_DEBUG_PREEMPT for
 CONFIG_PREEMPT_VOLUNTARY
Message-ID: <20210708113759.GB130061@lothringen>
References: <20210707192306.2297497-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707192306.2297497-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 08:23:06PM +0100, Valentin Schneider wrote:
> While recently staring at some preempt_count dumpster fire for a
> CONFIG_PREEMPT_VOLUNTARY kernel, I wished I could turn on
> CONFIG_DEBUG_PREEMPT on top of CONFIG_DEBUG_ATOMIC_SLEEP to see *where*
> preemption had been disabled. It didn't take much to get that, and although
> it didn't help my particular case, I think it can still be useful.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c | 3 +--
>  lib/Kconfig.debug   | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c22cd026440..5673b85fa22d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5109,8 +5109,7 @@ static inline void sched_tick_start(int cpu) { }
>  static inline void sched_tick_stop(int cpu) { }
>  #endif
>  
> -#if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
> -				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
> +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
>  /*
>   * If the value passed in is equal to the current preempt count
>   * then we just disabled preemption. Start timing the latency.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 678c13967580..7fdd45eee343 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1204,7 +1204,7 @@ config DEBUG_TIMEKEEPING
>  
>  config DEBUG_PREEMPT
>  	bool "Debug preemptible kernel"
> -	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
> +	depends on DEBUG_KERNEL && PREEMPT_COUNT && TRACE_IRQFLAGS_SUPPORT

IIRC it used to be that way before. That was the reason for the split
of CONFIG_PREEMPT_COUNT from CONFIG_PREEMPT in the first place. Not
sure what happened. But anyway, your patch looks welcome.

Thanks.

>  	default y
>  	help
>  	  If you say Y here then the kernel will use a debug variant of the
> -- 
> 2.25.1
> 
