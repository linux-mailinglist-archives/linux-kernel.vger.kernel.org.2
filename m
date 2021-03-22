Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917E7343EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCVK7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhCVK7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:59:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616410769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kUcTG570Ejb0vlSCIhpNee/ymS/YFRgIItlrgLhmTTc=;
        b=nqWYfkKha1BDbttOcuVWzkS93MKew6jX1FUuiR9AKatni2gSvmSZD5LhQ2lNHVBdIz/FxX
        HsP/dCOr1+K/f5he+9VFBKSUlyv562h0HlKdXBesitIvQ7hHoOENJOCbxXYYGxd3YeprI6
        8gDZ4rqHspCeSYKn3GkTO0ZXfCHyOuM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E401AD4A;
        Mon, 22 Mar 2021 10:59:29 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:59:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] workqueue: watchdog: update wq_watchdog_touched for
 unbound lockup checking
Message-ID: <YFh4kWFZTw4wSOq3@alley>
References: <1616140838-24222-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616140838-24222-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-19 16:00:36, Wang Qing wrote:
> When touch_softlockup_watchdog() is called, only wq_watchdog_touched_cpu 
> updated, while the unbound worker_pool running on its core uses 
> wq_watchdog_touched to determine whether locked up. This may be mischecked.

By other words, unbound workqueues are not aware of the more common
touch_softlockup_watchdog() because it updates only
wq_watchdog_touched_cpu for the affected CPU. As a result,
the workqueue watchdog might report lockup in unbound workqueue
even though it is blocked by a known slow code.

> My suggestion is to update both when touch_softlockup_watchdog() is called, 
> use wq_watchdog_touched_cpu to check bound, and use wq_watchdog_touched 
> to check unbound worker_pool.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  kernel/watchdog.c  |  5 +++--
>  kernel/workqueue.c | 17 ++++++-----------
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 7110906..107bc38
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -278,9 +278,10 @@ void touch_all_softlockup_watchdogs(void)
>  	 * update as well, the only side effect might be a cycle delay for
>  	 * the softlockup check.
>  	 */
> -	for_each_cpu(cpu, &watchdog_allowed_mask)
> +	for_each_cpu(cpu, &watchdog_allowed_mask) {
>  		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
> -	wq_watchdog_touch(-1);
> +		wq_watchdog_touch(cpu);

Note that wq_watchdog_touch(cpu) newly always updates
wq_watchdog_touched. This cycle will set the same jiffies
value cpu-times to the same variable.

> +	}
>  }
>  
>  void touch_softlockup_watchdog_sync(void)
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0d150da..be08295
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5787,22 +5787,17 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
>  			continue;
>  
>  		/* get the latest of pool and touched timestamps */
> +		if (pool->cpu >= 0)
> +			touched = READ_ONCE(per_cpu(wq_watchdog_touched_cpu, pool->cpu));
> +		else
> +			touched = READ_ONCE(wq_watchdog_touched);
>  		pool_ts = READ_ONCE(pool->watchdog_ts);
> -		touched = READ_ONCE(wq_watchdog_touched);
>  
>  		if (time_after(pool_ts, touched))
>  			ts = pool_ts;
>  		else
>  			ts = touched;
>  
> -		if (pool->cpu >= 0) {
> -			unsigned long cpu_touched =
> -				READ_ONCE(per_cpu(wq_watchdog_touched_cpu,
> -						  pool->cpu));
> -			if (time_after(cpu_touched, ts))
> -				ts = cpu_touched;
> -		}
> -
>  		/* did we stall? */
>  		if (time_after(jiffies, ts + thresh)) {
>  			lockup_detected = true;
> @@ -5826,8 +5821,8 @@ notrace void wq_watchdog_touch(int cpu)
>  {
>  	if (cpu >= 0)
>  		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
> -	else
> -		wq_watchdog_touched = jiffies;
> +
> +	wq_watchdog_touched = jiffies;
>  }
>  
>  static void wq_watchdog_set_thresh(unsigned long thresh)

This last hunk is enough to fix the problem. wq_watchdog_touched will
get updated also from cpu-specific touch_softlockup_watchdog().

The original patch simplified the logic of wq_watchdog_timer_fn().
But it added un-necessary assignments into
touch_all_softlockup_watchdogs(void).

I do not have strong opinion what solution is better. I slightly
prefer to keep only this last hunk.

Best Regards,
Petr
