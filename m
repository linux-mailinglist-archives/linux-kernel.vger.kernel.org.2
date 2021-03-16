Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC733DAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhCPR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhCPR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:29:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5FFC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+mXXWIQo5xdD9dB4aceExITJJ/ACvjPp1heUG7+TVPA=; b=iZOYvaXsbHJGnrlV4e19BR52x4
        F9UpFzlSExPYA2U6lQXea1n/+OWgvyArSi4YzHmvwM5TceZDvy2bkZVs8xTecu5qfW/0bUU0+rLaD
        UWwSxgMAV4zW/S3eOeRjyAbPgHs8Qkade4++4U/YaBIZ+EY0d18nsv2CM+vSmEbP9pU2CiZtHhmHi
        /ikaxo0kfHcRPXRQRUKLKohD3HGVnVQmsi6TKDwxMAbJAs6yL8BAcYGiXMveE18Vq7270e78UBAgP
        JgW8vZrHqh42UFqJriDBDSUscJJKd16uN3xTtvjPN2AR1sxuMvdE8cbgitlSzPD7gg9DsPpiKFEKX
        rtDlIkgg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMDVT-001UfE-Uz; Tue, 16 Mar 2021 17:29:24 +0000
Subject: Re: [PATCH] kernel:kprobe: Fix typo issue
To:     Xiaofeng Cao <cxfcosmos@gmail.com>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
References: <20210316125751.11023-1-caoxiaofeng@yulong.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <570250b7-0f3c-09db-7a62-167146f33fef@infradead.org>
Date:   Tue, 16 Mar 2021 10:29:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316125751.11023-1-caoxiaofeng@yulong.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 5:57 AM, Xiaofeng Cao wrote:
> change 'immmediately' to 'immediately'
> change 'quiesence' to 'quiescence'
> change 'unneed' to 'unneeded'
> change 'sinec' to 'since
> change 'sefe' to 'safe''
> change 'And' to 'At the'
> change 'buy' to 'but'
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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
> 


-- 
~Randy

