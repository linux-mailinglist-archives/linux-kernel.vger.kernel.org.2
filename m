Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC43B086F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhFVPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhFVPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:17:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97391C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:14:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624374889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJvKRUgSUVYCKtRDH1sRj2EVoY8sZULdAwwnAripmVU=;
        b=hlN/U0aLk/5SQN2y14HYA3ialA81bhVqdsRMSjNhuHrYfS9y3O9o9nc7A0caEj2AAmiqkZ
        g6S6J+K65NGqtHiAVjywIr5RKAnnGNdHGRkrkzu0jniSfNRvPOLMe42/ifelMyY5XrGOyb
        4bz+Ata3gfUVkx6bUFuYIEWv2GHogNrTpCD3yX6S94kSCmuZieomFXm8ZFnM253NYOzXtd
        ggCoyqSpVs4j/d96tXR2JWWF4Vl4QL329Q4yLbuILpGaJUA+WsQWBONdmFlFf6OsQez17S
        YMhhpxeWbqRvgVanZb1VKUBPCZ0dOwt+LySpRYx7QAxgvI6jJkif8K42DXQIRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624374889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJvKRUgSUVYCKtRDH1sRj2EVoY8sZULdAwwnAripmVU=;
        b=gUiM4RgzJVaWczWAkgu0M1YiQfGqp31YDVcwfcsVDMWb4ltTkIQOQlZduBfO5nJvyVM9R2
        eCILO0lToQ1j2qCw==
To:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Ani Sinha <ani@anisinha.ca>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v3] Add kernel logs when sched clock unstable and NO_HZ_FULL is not possible
In-Reply-To: <20210620101312.1757363-1-ani@anisinha.ca>
References: <20210620101312.1757363-1-ani@anisinha.ca>
Date:   Tue, 22 Jun 2021 17:14:48 +0200
Message-ID: <87r1gudj87.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20 2021 at 15:43, Ani Sinha wrote:

> Commit 4f49b90abb4aca ("sched-clock: Migrate to use new tick
> dependency mask model") had also removed the kernel warning
> message informing the user that it was not possible to turn
> on NO_HZ_FULL. Adding back that log message here. It is
> unhelpful when the kernel turns off NO_HZ_FULL silently
> without informing anyone.
> Also added a kernel log when sched clock is marked as unstable.

Don't do two things at once. See Documentation/process/....

Also your subject line want's a proper prefix.

> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index c2b2859ddd82..9f9fe658f8a5 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -192,8 +192,11 @@ void clear_sched_clock_stable(void)
>  
>  	smp_mb(); /* matches sched_clock_init_late() */
>  
> -	if (static_key_count(&sched_clock_running.key) == 2)
> +	if (static_key_count(&sched_clock_running.key) == 2) {
> +		WARN_ONCE(sched_clock_stable(),
> +			  "sched clock is now marked unstable.");

What's the WARN for here? That backtrace is largely uninteresting.

> -	if (can_stop_full_tick(cpu, ts))
> +	if (can_stop_full_tick(cpu, ts)) {
>  		tick_nohz_stop_sched_tick(ts, cpu);
> -	else if (ts->tick_stopped)
> -		tick_nohz_restart_sched_tick(ts, ktime_get());
> +	} else {
> +		/*
> +		 * Don't allow the user to think they can get
> +		 * full NO_HZ with this machine.
> +		 */
> +		WARN_ONCE(tick_nohz_full_running,
> +			  "NO_HZ_FULL will not work for the current system.");

can_stop_full_tick() returning false can be transient and then the user
still has no idea _why_ this is printed.

Also assume the user/admin starts perf and knows he's going to disturb
NOHZ full, then _why_ would he be interested in that warning.

And again the backtrace is useless. The call path is known.

Thanks,

        tglx
