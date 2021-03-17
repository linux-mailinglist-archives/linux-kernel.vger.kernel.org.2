Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A307933E278
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhCQACO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCQAB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2581464F38;
        Wed, 17 Mar 2021 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615939318;
        bh=6jN7ZF2FOHtclliC68HU01PlBZ8L+9xblvhPgm1xFyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBpBGOkz8ULooiEJ7TfR6214zuBRm7H9kd5M0WrgBx76xfCyCBvgxu+Ml4XEO5CZJ
         EjpW4LNSl4avXXtkjiLQyN6DcvcAVpHIwIW7M/vOpKXrVpmSPl7TiUEZ51AYE2UbKv
         ZjVd2LqBCEIKOKX/q9NjXOjdPCtN/oOy4yi9gZtJqLnS+/U/pT+RjpQ/dLiCqDOK6N
         SU1w7ZT6p0HTU6LLth3jWGWK8IaVh7UfrZ1rT/Obz8FlFblCiV8Ii0BJyVjeDgXyw0
         lbUnsy2wn4DrtufqMu4GzW1f0LvZuyDdrAPTbmcW6rDQHIWYanc+o6RffqGX+LOOoe
         xR5t4FL33/dMw==
Date:   Wed, 17 Mar 2021 09:01:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] kernel:kprobe: Fix typo issue
Message-Id: <20210317090154.70aaf7e8c21eda290fc13d4e@kernel.org>
In-Reply-To: <20210316125751.11023-1-caoxiaofeng@yulong.com>
References: <20210316125751.11023-1-caoxiaofeng@yulong.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaofeng,

On Tue, 16 Mar 2021 20:57:51 +0800
Xiaofeng Cao <cxfcosmos@gmail.com> wrote:

> change 'immmediately' to 'immediately'
> change 'quiesence' to 'quiescence'
> change 'unneed' to 'unneeded'
> change 'sinec' to 'since
> change 'sefe' to 'safe''
> change 'And' to 'At the'
> change 'buy' to 'but'

Thanks for the fix!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>



> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---
>  kernel/kprobes.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd7a6..ae3a22d2099b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -506,7 +506,7 @@ static void do_optimize_kprobes(void)
>  	/*
>  	 * The optimization/unoptimization refers online_cpus via
>  	 * stop_machine() and cpu-hotplug modifies online_cpus.
> -	 * And same time, text_mutex will be held in cpu-hotplug and here.
> +	 * At the same time, text_mutex will be held in cpu-hotplug and here.
>  	 * This combination can cause a deadlock (cpu-hotplug try to lock
>  	 * text_mutex but stop_machine can not be done because online_cpus
>  	 * has been changed)
> @@ -592,12 +592,12 @@ static void kprobe_optimizer(struct work_struct *work)
>  
>  	/*
>  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> -	 * kprobes before waiting for quiesence period.
> +	 * kprobes before waiting for quiescence period.
>  	 */
>  	do_unoptimize_kprobes();
>  
>  	/*
> -	 * Step 2: Wait for quiesence period to ensure all potentially
> +	 * Step 2: Wait for quiescence period to ensure all potentially
>  	 * preempted tasks to have normally scheduled. Because optprobe
>  	 * may modify multiple instructions, there is a chance that Nth
>  	 * instruction is preempted. In that case, such tasks can return
> @@ -607,10 +607,10 @@ static void kprobe_optimizer(struct work_struct *work)
>  	 */
>  	synchronize_rcu_tasks();
>  
> -	/* Step 3: Optimize kprobes after quiesence period */
> +	/* Step 3: Optimize kprobes after quiescence period */
>  	do_optimize_kprobes();
>  
> -	/* Step 4: Free cleaned kprobes after quiesence period */
> +	/* Step 4: Free cleaned kprobes after quiescence period */
>  	do_free_cleaned_kprobes();
>  
>  	mutex_unlock(&text_mutex);
> @@ -631,7 +631,7 @@ void wait_for_kprobe_optimizer(void)
>  	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
>  		mutex_unlock(&kprobe_mutex);
>  
> -		/* this will also make optimizing_work execute immmediately */
> +		/* this will also make optimizing_work execute immediately */
>  		flush_delayed_work(&optimizing_work);
>  		/* @optimizing_work might not have been queued yet, relax */
>  		cpu_relax();
> @@ -1057,7 +1057,7 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  
>  err_ftrace:
>  	/*
> -	 * At this point, sinec ops is not registered, we should be sefe from
> +	 * At this point, since ops is not registered, we should be safe from
>  	 * registering empty filter.
>  	 */
>  	ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
> @@ -1712,7 +1712,7 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
>  			/*
>  			 * If kprobes_all_disarmed is set, orig_p
>  			 * should have already been disarmed, so
> -			 * skip unneed disarming process.
> +			 * skip unneeded disarming process.
>  			 */
>  			if (!kprobes_all_disarmed) {
>  				ret = disarm_kprobe(orig_p, true);
> @@ -2424,7 +2424,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  			     within_module_core((unsigned long)p->addr, mod))) {
>  				/*
>  				 * The vaddr this probe is installed will soon
> -				 * be vfreed buy not synced to disk. Hence,
> +				 * be vfreed but not synced to disk. Hence,
>  				 * disarming the breakpoint isn't needed.
>  				 *
>  				 * Note, this will also move any optimized probes
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
