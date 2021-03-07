Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27B32FEF8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 06:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCGFOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 00:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhCGFNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 00:13:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CAC264FCC;
        Sun,  7 Mar 2021 05:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615094023;
        bh=PvfTW34g52/n1sHOI4BkuWxJAfwIJMfcdILEKrtP9wM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lMoIc6G/CGlcxO0wIpFcAr4lpnFiINJfiBcCxje3jzoG7yaJqyTXX4sbnF91+mvHy
         OZB5wlAbukOfW4nFcoDzoBBO65SZnC/BgYD+Sg5sGmSFMCIxjZc/BTFoKykox21H5s
         xghiZqlWYIZ1diUSqKJVpcOhoi4hmMw+r/FKU+9SJNYmVKnIrMhhtcuz2Xegau0e/M
         FAcEXfHPNxCrwwFfmzqSvEjH/C0QbtJEP2Er1dNi5Z4+uT0LiQgiNs2ekj+LrOyrzh
         f/rz9YuKYvDnZpfvCSu+Qu+AQDb6J2mq1LSD3/9/Auvd0CQj/kJb6Fn/oSP7J0Ls1C
         jUFgAWHwhQzBg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 262283523946; Sat,  6 Mar 2021 21:13:43 -0800 (PST)
Date:   Sat, 6 Mar 2021 21:13:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] tasklet: Remove tasklet_kill_immediate
Message-ID: <20210307051343.GJ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210306213658.12862-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306213658.12862-1-dave@stgolabs.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 01:36:58PM -0800, Davidlohr Bueso wrote:
> Ever since RCU was converted to softirq, it has no users.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

That was a long time ago...

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/interrupt.h |  1 -
>  kernel/softirq.c          | 32 --------------------------------
>  2 files changed, 33 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 967e25767153..36a2ac6baf9a 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -712,7 +712,6 @@ static inline void tasklet_enable(struct tasklet_struct *t)
>  }
>  
>  extern void tasklet_kill(struct tasklet_struct *t);
> -extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
>  extern void tasklet_init(struct tasklet_struct *t,
>  			 void (*func)(unsigned long), unsigned long data);
>  extern void tasklet_setup(struct tasklet_struct *t,
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9908ec4a9bfe..8b44ab9a2f69 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -658,38 +658,6 @@ static void run_ksoftirqd(unsigned int cpu)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -/*
> - * tasklet_kill_immediate is called to remove a tasklet which can already be
> - * scheduled for execution on @cpu.
> - *
> - * Unlike tasklet_kill, this function removes the tasklet
> - * _immediately_, even if the tasklet is in TASKLET_STATE_SCHED state.
> - *
> - * When this function is called, @cpu must be in the CPU_DEAD state.
> - */
> -void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu)
> -{
> -	struct tasklet_struct **i;
> -
> -	BUG_ON(cpu_online(cpu));
> -	BUG_ON(test_bit(TASKLET_STATE_RUN, &t->state));
> -
> -	if (!test_bit(TASKLET_STATE_SCHED, &t->state))
> -		return;
> -
> -	/* CPU is dead, so no lock needed. */
> -	for (i = &per_cpu(tasklet_vec, cpu).head; *i; i = &(*i)->next) {
> -		if (*i == t) {
> -			*i = t->next;
> -			/* If this was the tail element, move the tail ptr */
> -			if (*i == NULL)
> -				per_cpu(tasklet_vec, cpu).tail = i;
> -			return;
> -		}
> -	}
> -	BUG();
> -}
> -
>  static int takeover_tasklets(unsigned int cpu)
>  {
>  	/* CPU is dead, so no lock needed. */
> -- 
> 2.26.2
> 
