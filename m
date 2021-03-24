Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0573473F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhCXIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:51:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:48220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233774AbhCXIux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:50:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616575852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSPKvcu/uoRdcxBP8xOUaNwYGRRAJE5gTDcwquMW0MU=;
        b=THAL6mYZO0zKISp2nfWK1agQ/uxktBcdJZtCWV2ORyNGCzYSZQbWkA+NvS2lprbMTj8zm3
        H6uVe5QtfkaIb6vP0FMSOkL53YORF3OnkVagxwZ6FLwmffFXOjBDwXmq18qXYdPu/u8ikT
        sGD68JdBboqDZBQJ/S2SGAhOcOwET2A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F210AC6E;
        Wed, 24 Mar 2021 08:50:52 +0000 (UTC)
Date:   Wed, 24 Mar 2021 09:50:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH V2] workqueue: watchdog: update
 wq_watchdog_touched for unbound lockup checking
Message-ID: <YFr9a5tws6PhAjye@alley>
References: <YFoD/a/SPWe9mocr@alley>
 <ADYALADXDuGCRBjCE77aRKpD.3.1616552206707.Hmail.wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADYALADXDuGCRBjCE77aRKpD.3.1616552206707.Hmail.wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-24 10:16:46, 王擎 wrote:
> 
> >On Tue 2021-03-23 20:37:35, 王擎 wrote:
> >> 
> >> >On Fri 2021-03-19 16:00:36, Wang Qing wrote:
> >> >> When touch_softlockup_watchdog() is called, only wq_watchdog_touched_cpu 
> >> >> updated, while the unbound worker_pool running on its core uses 
> >> >> wq_watchdog_touched to determine whether locked up. This may be mischecked.
> >> >
> >> >By other words, unbound workqueues are not aware of the more common
> >> >touch_softlockup_watchdog() because it updates only
> >> >wq_watchdog_touched_cpu for the affected CPU. As a result,
> >> >the workqueue watchdog might report lockup in unbound workqueue
> >> >even though it is blocked by a known slow code.
> >> 
> >> Yes, this is the problem I'm talking about.
> >
> >I thought more about it. This patch prevents a false positive.
> >Could it bring an opposite problem and hide real problems?
> >
> >I mean that an unbound workqueue might get blocked on CPU A
> >because of a real softlockup. But we might not notice it because
> >CPU B is touched. Well, there are other ways how to detect
> >this situation, e.g. the softlockup watchdog.
> >
> >
> >> >> My suggestion is to update both when touch_softlockup_watchdog() is called, 
> >> >> use wq_watchdog_touched_cpu to check bound, and use wq_watchdog_touched 
> >> >> to check unbound worker_pool.
> >> >> 
> >> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> >> ---
> >> >>  kernel/watchdog.c  |  5 +++--
> >> >>  kernel/workqueue.c | 17 ++++++-----------
> >> >>  2 files changed, 9 insertions(+), 13 deletions(-)
> >> >> 
> >> >> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> >> >> index 7110906..107bc38
> >> >> --- a/kernel/watchdog.c
> >> >> +++ b/kernel/watchdog.c
> >> >> @@ -278,9 +278,10 @@ void touch_all_softlockup_watchdogs(void)
> >> >>  	 * update as well, the only side effect might be a cycle delay for
> >> >>  	 * the softlockup check.
> >> >>  	 */
> >> >> -	for_each_cpu(cpu, &watchdog_allowed_mask)
> >> >> +	for_each_cpu(cpu, &watchdog_allowed_mask) {
> >> >>  		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
> >> >> -	wq_watchdog_touch(-1);
> >> >> +		wq_watchdog_touch(cpu);
> >> >
> >> >Note that wq_watchdog_touch(cpu) newly always updates
> >> >wq_watchdog_touched. This cycle will set the same jiffies
> >> >value cpu-times to the same variable.
> >> >
> >> Although there is a bit of redundancy here, but the most concise way of 
> >> implementation, and it is certain that it will not affect performance.
> >> 
> Another way to implement is wq_watchdog_touch() remain unchanged, but need 
> to modify touch_softlockup_watchdog() and touch_all_softlockup_watchdogs():
> notrace void touch_softlockup_watchdog(void)
> {
> 	touch_softlockup_watchdog_sched();
> 	wq_watchdog_touch(raw_smp_processor_id());
> +     wq_watchdog_touch(-1);
> }
> void touch_all_softlockup_watchdogs(void)
>  * update as well, the only side effect might be a cycle delay for
>  * the softlockup check.
> */
>  -	for_each_cpu(cpu, &watchdog_allowed_mask)
> +	for_each_cpu(cpu, &watchdog_allowed_mask) {
>   		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
>  +		wq_watchdog_touch(cpu);
>  +	}
>  	wq_watchdog_touch(-1);
>   }
> So wq_watchdog_touched will not get updated many times,  
> which do you think is better, Petr?

I actually prefer the original patch. It makes wq_watchdog_touch()
easy to use. The complexity is hidden in wq-specific code.

The alternative way updates each timestamp only once but the use
is more complicated. IMHO, it is more error prone.

Best Regards,
Petr
