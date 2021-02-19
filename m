Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02C631F970
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBSMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhBSMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:33:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B373664E54;
        Fri, 19 Feb 2021 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613737992;
        bh=pZIQqFujw5R6jSZxYrLEFYhYSZcD29FIGY6b7nQuEy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=To+UdOopDsJaN/V46ujKSg9JZNVwaZIMT8PuYqagR+6ZwP2+gETbiIcijlnq5brTk
         LDhpLGZP01yzUiv0KrDbABnDTDTfOlL//EIBDJK/eVxOk1zgPEUnTtdRYyiMrSuCmr
         0xguMliizKlpr66WKuoGtHe7KcxsfGlR6KE9MGU6TQdmiJjbSWxvTBdG1vHdBq0iWA
         wNDc5I1JglhFVVyKOV3bEmvJWAKNTSSFPVHU5EM2YFUhloDfNHbSLjfoCRsZ1J10K0
         fRTyN7E/ovOKUoG5zh0BExytT9ZXtEeDPHBxleESYlyRNPSGvb9qckG65Fk25JArjX
         1NiUgvKjJ+0SQ==
Date:   Fri, 19 Feb 2021 13:33:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] tick/nohz: Make the idle_exittime update correctly
Message-ID: <20210219123309.GC51281@lothringen>
References: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e194669-c074-069c-4fda-ad5bc313a611@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 05:41:52PM +0800, Yunfeng Ye wrote:
> The idle_exittime field of tick_sched is used to record the time when
> the idle state was left. but currently the idle_exittime is updated in
> the function tick_nohz_restart_sched_tick(), which is not always in idle
> state when nohz_full is configured.
> 
>   tick_irq_exit
>     tick_nohz_irq_exit
>       tick_nohz_full_update_tick
>         tick_nohz_restart_sched_tick
>           ts->idle_exittime = now;
> 
> So move to tick_nohz_stop_idle() to make the idle_exittime update
> correctly.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  kernel/time/tick-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 749ec2a583de..be2e5d772d50 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -591,6 +591,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
>  {
>  	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
>  	ts->idle_active = 0;
> +	ts->idle_exittime = now;
> 
>  	sched_clock_idle_wakeup_event();
>  }
> @@ -901,7 +902,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
>  	 * Cancel the scheduled timer and restore the tick
>  	 */
>  	ts->tick_stopped  = 0;
> -	ts->idle_exittime = now;
> 
>  	tick_nohz_restart(ts, now);
>  }

Hi,

I've edited and queued on top of latest changes, see below. I'll post it after
the merge window.

---
From: Yunfeng Ye <yeyunfeng@huawei.com>
Date: Wed, 10 Feb 2021 00:08:54 +0100
Subject: [PATCH] tick/nohz: Update idle_exittime on actual idle exit

The idle_exittime field of tick_sched is used to record the time when
the idle state was left. but currently the idle_exittime is updated in
the function tick_nohz_restart_sched_tick(), which is not always in idle
state when nohz_full is configured:

  tick_irq_exit
    tick_nohz_irq_exit
      tick_nohz_full_update_tick
        tick_nohz_restart_sched_tick
          ts->idle_exittime = now;

It's thus overwritten by mistake on nohz_full tick restart. Move the
update to the appropriate idle exit path instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 79796286a4ba..2907c762a8fe 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -918,8 +918,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	 * Cancel the scheduled timer and restore the tick
 	 */
 	ts->tick_stopped  = 0;
-	ts->idle_exittime = now;
-
 	tick_nohz_restart(ts, now);
 }
 
@@ -1231,6 +1229,7 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 	else
 		tick_nohz_restart_sched_tick(ts, now);
 
+	ts->idle_exittime = now;
 	tick_nohz_account_idle_ticks(ts);
 }
 
-- 
2.25.1


