Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE536C86C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhD0PNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235466AbhD0PNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619536350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbCLDunCrFDW+UNrnx2AkD+SvvLwF4qVXw/73zjizkc=;
        b=ivqAP/6relT0enaTrTxy2dxhFtDAm9sZzK/XrDoCK7t26y4ta7TVid6YzXFVWot6FgW+9s
        0ot7HxI99rMgpGPDTWp9SjoRC5Pta2lbH037oJs7slbJwyn0cTC+SnI/nEG1TmvcXPmTK9
        ZojqIfj2Mt2OCmQm106sqR7FnX66V4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-PFUsQWzEOtWdtSSqfEywUQ-1; Tue, 27 Apr 2021 11:12:27 -0400
X-MC-Unique: PFUsQWzEOtWdtSSqfEywUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA9BA80DDF8;
        Tue, 27 Apr 2021 15:12:25 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5F605C260;
        Tue, 27 Apr 2021 15:12:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id B490D416D899; Tue, 27 Apr 2021 12:11:25 -0300 (-03)
Date:   Tue, 27 Apr 2021 12:11:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 8/8] hrtimer: Avoid more SMP function calls in
 clock_was_set()
Message-ID: <20210427151125.GA171315@fuller.cnet>
References: <20210427082537.611978720@linutronix.de>
 <20210427083724.840364566@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427083724.840364566@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 10:25:45AM +0200, Thomas Gleixner wrote:
> There are more indicators whether the SMP function calls on clock_was_set()
> can be avoided:
> 
>     - When the remote CPU is currently handling hrtimer_interrupt(). In
>       that case the remote CPU will update offsets and reevaluate the timer
>       bases before reprogramming anyway, so nothing to do.
> 
> By unconditionally updating the offsets the following checks are possible:
> 
>     - When the offset update already happened on the remote CPU then the
>       remote update attempt will yield the same seqeuence number and no
>       IPI is required.
> 
>     - After updating it can be checked whether the first expiring timer in
>       the affected clock bases moves before the first expiring (softirq)
>       timer of the CPU. If that's not the case then sending the IPI is not
>       required.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/hrtimer.c |   66 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 9 deletions(-)
> 
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -880,6 +880,60 @@ static void hrtimer_reprogram(struct hrt
>  	tick_program_event(expires, 1);
>  }
>  
> +static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
> +			     unsigned int active)
> +{
> +	struct hrtimer_clock_base *base;
> +	unsigned int seq;
> +	ktime_t expires;
> +
> +	/*
> +	 * If the remote CPU is currently handling an hrtimer interrupt, it
> +	 * will update and reevaluate the first expiring timer of all clock
> +	 * bases before reprogramming. Nothing to do here.
> +	 */
> +	if (cpu_base->in_hrtirq)
> +		return false;

Thomas,

The base offsets are updated at 

Cscope tag: hrtimer_update_base
   #   line  filename / context / line
   1    736  kernel/time/hrtimer.c <<retrigger_next_event>>	(IPI handler)
             hrtimer_update_base(base);
   2   1617  kernel/time/hrtimer.c <<hrtimer_run_softirq>>	(softirq handler)
             now = hrtimer_update_base(cpu_base);
   3   1645  kernel/time/hrtimer.c <<hrtimer_interrupt>>	(hrtimer_interrupt entry)
             entry_time = now = hrtimer_update_base(cpu_base);
   4   1695  kernel/time/hrtimer.c <<hrtimer_interrupt>>	(after tick_program_event failure)
             now = hrtimer_update_base(cpu_base);
   5   1768  kernel/time/hrtimer.c <<hrtimer_run_queues>>	(sched_tick)
             now = hrtimer_update_base(cpu_base);

Consider


hrtimer_interrupt
in_hrtirq = 1
__run_hrtimer
raw_spin_unlock_irqrestore(&cpu_base->lock, flags)
								settimeofday
								clock_was_set
								lock cpu_base->lock
								update_needs_ipi returns false
continue to process hrtimers with stale base->offset

No?

