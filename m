Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F231F919
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhBSMKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhBSMJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:09:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 172CA64EB8;
        Fri, 19 Feb 2021 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613736554;
        bh=S8+swo0kxO+4YEuYc6YnXlZjZV+VM73UWiHZsFpDoJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNPk+39YlVWWcTpd4pyvv55Vce77wpm1V94AvbhOct8VEqRaju1iNfkJRLt5OeV3d
         nkN+MQUY4G7tdf/dOYYw2Vf+SB8Nb/QPfxw2/8N24d5rQfGjO+B03/WtcGA0lm6QRu
         fcg+UFarshoJlMOtXy9HB+TDwBQWOheub0QAg7Dp02BhIDuTdmQmBcFkuqjCuyvGjY
         beV4dWD8l4tRIYRTmLWtdEYwDAOLK1+zgSmEwpZy5F2gRwpX6apkkH8b3GsWEdhrKO
         Rf26wH/aFf0FtlLoomA6sKx56DlgxVcsPQsiAs9iAhPXUcRM/+p4abGLXNmnh/Pseb
         cliCJ8AxUAonQ==
Date:   Fri, 19 Feb 2021 13:09:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the issue that the tick_nohz_get_sleep_length()
 function could return a negative value
Message-ID: <20210219120911.GA51281@lothringen>
References: <YTBPR01MB3262A1EAA009500DF6DD2132C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTBPR01MB3262A1EAA009500DF6DD2132C4A20@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:49:38PM +0000, Zhou Ti (x2019cwm) wrote:
> Fix the issue that the tick_nohz_get_sleep_length() function could return a 
> negative value.
> 
> The variable "dev->next_event" has a small possibility to be smaller than 
> the variable "now" during running, which would result in a negative value 
> of "*delta_next". The variable "next_event" also has a small posibility to 
> be smaller than the variable "now". Both case could lead to a negative 
> return of function tick_nohz_get_sleep_length().
> 
> Signed-off-by: Ti Zhou <x2019cwm@stfx.ca>
> ---
> --- tip/kernel/time/tick-sched.c.orig	2021-01-20 05:34:25.151325912 -0400
> +++ tip/kernel/time/tick-sched.c	2021-01-20 19:44:28.238538380 -0400
> @@ -1142,6 +1142,9 @@ ktime_t tick_nohz_get_sleep_length(ktime
>  
>  	*delta_next = ktime_sub(dev->next_event, now);
>  
> +	if (unlikely(*delta_next < 0))
> +		*delta_next = 0;
> +
>  	if (!can_stop_idle_tick(cpu, ts))
>  		return *delta_next;
>  
> @@ -1156,6 +1159,9 @@ ktime_t tick_nohz_get_sleep_length(ktime
>  	next_event = min_t(u64, next_event,
>  			   hrtimer_next_event_without(&ts->sched_timer));
>  
> +	if (unlikely(next_event < now))
> +		next_event = now;
> +
>  	return ktime_sub(next_event, now);
>  }
>  

I have reworked the changelog that way and queued. I'll post a
series including it after the merge window.

Thanks!

---
From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Date: Wed, 20 Jan 2021 23:49:38 +0000
Subject: [PATCH] tick/nohz: Prevent tick_nohz_get_sleep_length() from
 returning negative value

If the hardware clock happens to fire its interrupts late, two possible
issues can happen while calling tick_nohz_get_sleep_length(). Either:

1) The next clockevent device event is due past the last idle entry time.

or:

2) The last timekeeping update happened before the last idle entry time
   and the next timer callback expires past the last idle entry time.

Make sure that both cases are handled to avoid returning a negative
duration to the cpuidle governors.

Signed-off-by: Ti Zhou <x2019cwm@stfx.ca>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e10a4af88737..22b6a46818cf 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1142,6 +1142,9 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 
 	*delta_next = ktime_sub(dev->next_event, now);
 
+	if (unlikely(*delta_next < 0))
+		*delta_next = 0;
+
 	if (!can_stop_idle_tick(cpu, ts))
 		return *delta_next;
 
@@ -1156,6 +1159,9 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	next_event = min_t(u64, next_event,
 			   hrtimer_next_event_without(&ts->sched_timer));
 
+	if (unlikely(next_event < now))
+		next_event = now;
+
 	return ktime_sub(next_event, now);
 }
 
-- 
2.25.1

