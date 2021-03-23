Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C9346252
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhCWPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:06:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhCWPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:06:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616511997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lQK6JktulkWDnzcvyc4bc1DKWBb5c2ynr8MH9lTEz8=;
        b=tYLmcD35TszZ9Luks4SX3VGOMJs1kicMnDON0HuP4Tbc4H4gv/1FIh2wqVQ59+U8Ud2Pts
        CMVGpHKH0zhOIvUK93QyEcbZnKW6REJ3u3x2ACsfCMhLT14k8spcx8hxtRDj8gKc3qsiMl
        fUhls5lHQ0ye7qHMOliDKAHRjj5m9Ak=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEC42AE37;
        Tue, 23 Mar 2021 15:06:37 +0000 (UTC)
Date:   Tue, 23 Mar 2021 16:06:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrey Ignatov <rdna@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH V2] workqueue: watchdog: update wq_watchdog_touched
 for unbound lockup checking
Message-ID: <YFoD/a/SPWe9mocr@alley>
References: <YFh4kWFZTw4wSOq3@alley>
 <AHoA7gBvDieBN0w9ILASHaqg.3.1616503055590.Hmail.wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AHoA7gBvDieBN0w9ILASHaqg.3.1616503055590.Hmail.wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-23 20:37:35, 王擎 wrote:
> 
> >On Fri 2021-03-19 16:00:36, Wang Qing wrote:
> >> When touch_softlockup_watchdog() is called, only wq_watchdog_touched_cpu 
> >> updated, while the unbound worker_pool running on its core uses 
> >> wq_watchdog_touched to determine whether locked up. This may be mischecked.
> >
> >By other words, unbound workqueues are not aware of the more common
> >touch_softlockup_watchdog() because it updates only
> >wq_watchdog_touched_cpu for the affected CPU. As a result,
> >the workqueue watchdog might report lockup in unbound workqueue
> >even though it is blocked by a known slow code.
> 
> Yes, this is the problem I'm talking about.

I thought more about it. This patch prevents a false positive.
Could it bring an opposite problem and hide real problems?

I mean that an unbound workqueue might get blocked on CPU A
because of a real softlockup. But we might not notice it because
CPU B is touched. Well, there are other ways how to detect
this situation, e.g. the softlockup watchdog.


> >> My suggestion is to update both when touch_softlockup_watchdog() is called, 
> >> use wq_watchdog_touched_cpu to check bound, and use wq_watchdog_touched 
> >> to check unbound worker_pool.
> >> 
> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> ---
> >>  kernel/watchdog.c  |  5 +++--
> >>  kernel/workqueue.c | 17 ++++++-----------
> >>  2 files changed, 9 insertions(+), 13 deletions(-)
> >> 
> >> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> >> index 7110906..107bc38
> >> --- a/kernel/watchdog.c
> >> +++ b/kernel/watchdog.c
> >> @@ -278,9 +278,10 @@ void touch_all_softlockup_watchdogs(void)
> >>  	 * update as well, the only side effect might be a cycle delay for
> >>  	 * the softlockup check.
> >>  	 */
> >> -	for_each_cpu(cpu, &watchdog_allowed_mask)
> >> +	for_each_cpu(cpu, &watchdog_allowed_mask) {
> >>  		per_cpu(watchdog_touch_ts, cpu) = SOFTLOCKUP_RESET;
> >> -	wq_watchdog_touch(-1);
> >> +		wq_watchdog_touch(cpu);
> >
> >Note that wq_watchdog_touch(cpu) newly always updates
> >wq_watchdog_touched. This cycle will set the same jiffies
> >value cpu-times to the same variable.
> >
> Although there is a bit of redundancy here, but the most concise way of 
> implementation, and it is certain that it will not affect performance.
> 
> >> +	}
> >>  }
> >>  
> >>  void touch_softlockup_watchdog_sync(void)
> >> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> >> index 0d150da..be08295
> >> --- a/kernel/workqueue.c
> >> +++ b/kernel/workqueue.c
> >> @@ -5826,8 +5821,8 @@ notrace void wq_watchdog_touch(int cpu)
> >>  {
> >>  	if (cpu >= 0)
> >>  		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
> >> -	else
> >> -		wq_watchdog_touched = jiffies;
> >> +
> >> +	wq_watchdog_touched = jiffies;
> >>  }
> >>  
> >>  static void wq_watchdog_set_thresh(unsigned long thresh)
> >
> >This last hunk is enough to fix the problem. wq_watchdog_touched will
> >get updated also from cpu-specific touch_softlockup_watchdog().
> 
> Not enough in fact, because wq_watchdog_touched was updated in wq_watchdog_touch(), 
> so wq_watchdog_touched can no longer be used to judge the bound pool, we must update 
> every wq_watchdog_touched_cpu in touch_all_softlockup_watchdogs() for bound judgment.

I see. Your patch makes sense.

I would just improve the commit message. It should better explain
why all the twists are needed. I would write something like:

<proposal>
Subject: workqueue/watchdog: Make unbound workqueues aware of
touch_softlockup_watchdog()

There are two workqueue-specific watchdog timestamps:

    + @wq_watchdog_touched_cpu (per-CPU) updated by
      touch_softlockup_watchdog()

    + @wq_watchdog_touched (global) updated by
      touch_all_softlockup_watchdogs()

watchdog_timer_fn() checks only the global @wq_watchdog_touched for
unbound workqueues. As a result, unbound workqueues are not aware
of touch_softlockup_watchdog(). The watchdog might report a stall
even when the unbound workqueues are blocked by a known slow code.

Solution:

touch_softlockup_watchdog() must touch also the global
@wq_watchdog_touched timestamp.

The global timestamp can not longer be used for bound workqueues
because it is updated on all CPUs. Instead, bound workqueues
have to check only @wq_watchdog_touched_cpu and these timestamp
has to be updated for all CPUs in touch_all_softlockup_watchdogs().

Beware:

The change might cause the opposite problem. An unbound workqueue
might get blocked on CPU A because of a real softlockup. The workqueue
watchdog would miss it when the timestamp got touched on CPU B.

It is acceptable because softlockups are detected by softlockup
watchdog. The workqueue watchdog is there to detect stalls where
a work never finishes, for example, because of dependencies of works
queued into the same workqueue.
</proposal>

How does that sound?

Best Regards,
Petr
