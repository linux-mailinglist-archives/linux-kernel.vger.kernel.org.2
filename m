Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09EF44DCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhKKVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhKKVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:16:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5AB6610CB;
        Thu, 11 Nov 2021 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636665195;
        bh=EAuYRToH0I27lEdpxD8gDtcn9THFnIboW1rGQZGtOms=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NhhuYWXmIBgGI8CkK4/ZsxdrgZIDV9Dj15AUuhpLA0ZB3TNhkLUVirz0ZeQsCjDT7
         bZ0MjSdDHPcctcUn2Hv17h1pTkeHt+YxUgQZLcWSqWC2+hDfMDx5GZvfL5pLCi1xNJ
         DpvExHeKHCjusoMX/CC5/5PstIlAfiCom72VNn4hy/Ttj5VnIHnPRSvbg7LheG4ksJ
         vG8212zSKtZz3zc9uYwbtcd/zNYKZVDQcGKM5cx6UguiEAr0/t8veB7k9DJ5QPnnAt
         r9/7KH6MxZtSmaDcpmetYyRXPKst+mSu6AiDJA8jKRGXoCWHMiVbA0Q11WAJ6Do83Q
         d/xJVZ6pgtIbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 853C65C06AF; Thu, 11 Nov 2021 13:13:15 -0800 (PST)
Date:   Thu, 11 Nov 2021 13:13:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <20211111211315.GQ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111195904.618253-2-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 04:59:04PM -0300, Wander Lairson Costa wrote:
> If we have a reasonable large dataset to flush in the printk ring
> buffer in the presence of a slow console device (like a serial port
> with a low baud rate configured), the RCU stall detector may report
> warnings.
> 
> This patch suppresses RCU stall warnings while flushing the ring buffer
> to the console.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

From an RCU perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/printk/printk.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index cbc35d586afb..42b622454314 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2588,6 +2588,20 @@ static inline int can_use_console(void)
>  	return cpu_online(raw_smp_processor_id()) || have_callable_console();
>  }
>  
> +extern int rcu_cpu_stall_suppress;
> +
> +static void rcu_console_stall_suppress(void)
> +{
> +	if (!rcu_cpu_stall_suppress)
> +		rcu_cpu_stall_suppress = 4;
> +}
> +
> +static void rcu_console_stall_unsuppress(void)
> +{
> +	if (rcu_cpu_stall_suppress == 4)
> +		rcu_cpu_stall_suppress = 0;
> +}
> +
>  /**
>   * console_unlock - unlock the console system
>   *
> @@ -2634,6 +2648,9 @@ void console_unlock(void)
>  	 * and cleared after the "again" goto label.
>  	 */
>  	do_cond_resched = console_may_schedule;
> +
> +	rcu_console_stall_suppress();
> +
>  again:
>  	console_may_schedule = 0;
>  
> @@ -2645,6 +2662,7 @@ void console_unlock(void)
>  	if (!can_use_console()) {
>  		console_locked = 0;
>  		up_console_sem();
> +		rcu_console_stall_unsuppress();
>  		return;
>  	}
>  
> @@ -2716,8 +2734,10 @@ void console_unlock(void)
>  
>  		handover = console_lock_spinning_disable_and_check();
>  		printk_safe_exit_irqrestore(flags);
> -		if (handover)
> +		if (handover) {
> +			rcu_console_stall_unsuppress();
>  			return;
> +		}
>  
>  		if (do_cond_resched)
>  			cond_resched();
> @@ -2738,6 +2758,8 @@ void console_unlock(void)
>  	retry = prb_read_valid(prb, next_seq, NULL);
>  	if (retry && console_trylock())
>  		goto again;
> +
> +	rcu_console_stall_unsuppress();
>  }
>  EXPORT_SYMBOL(console_unlock);
>  
> -- 
> 2.27.0
> 
