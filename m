Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2E364C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbhDSUyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:54:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbhDSUwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:52:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618865535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOx5M9WLwzNo3UD/FTwq9JMDYtQHwmdN0Q+VOaVwgng=;
        b=irmRaBaCSZ1kfZio2qzHjWuMPX/TxEBqu169gGk39Fi2AI1Z7OAwy72C6lpg8VZ7NZy5QK
        feYBTeOTuEp1BZHiOW9eogUPZS3k6y6S5kYmsEZ64VPujuFY8zriGc0v2xHtYOhDJ5qqNh
        kmtOFSuNJtRpHUnE8AVSUf99fzrt5o6jVmjhiC2LfeYBh26oOVnTeKKXP25UnZKgcwVqlO
        30tY/anAOHSyHz4oV7H9lp5QqgXSWAYfuYW0pSFUGZLHRWmXBK/Gkeoq1LDrOAn7yTiroW
        t070Vym6sc3MnIVPJcaMNXmLRCV48zFgLS1MZd0Y35rxRmtBBeXojm3M7D+BiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618865535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOx5M9WLwzNo3UD/FTwq9JMDYtQHwmdN0Q+VOaVwgng=;
        b=FVrL823Huyj4PvJLr9Hog25HUH51+TPrOEuVApY1ByIUE0XWfHlqEc8kTMKq/E5fdG/Aap
        6L6LE6bs0XFF4sAA==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v6] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <20210419193902.GB57245@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet> <87o8en4k9a.ffs@nanos.tec.linutronix.de> <20210409165146.GA40118@fuller.cnet> <87lf9q4lue.ffs@nanos.tec.linutronix.de> <20210413170431.GA16190@fuller.cnet> <20210415153935.GA69750@fuller.cnet> <87im4nv0fh.ffs@nanos.tec.linutronix.de> <20210415204017.GA111847@fuller.cnet> <20210416160023.GA6187@fuller.cnet> <20210419193902.GB57245@fuller.cnet>
Date:   Mon, 19 Apr 2021 22:52:14 +0200
Message-ID: <87lf9eq9oh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2021 at 16:39, Marcelo Tosatti wrote:
>  
> +static void clock_was_set_force_reprogram_work(struct work_struct *work)
> +{
> +	clock_was_set(true);
> +}
> +
> +static DECLARE_WORK(hrtimer_force_reprogram_work, clock_was_set_force_reprogram_work);
> +
> +
>  static void clock_was_set_work(struct work_struct *work)
>  {
> -	clock_was_set();
> +	clock_was_set(false);
>  }
>  
>  static DECLARE_WORK(hrtimer_work, clock_was_set_work);
> @@ -769,9 +777,12 @@ static DECLARE_WORK(hrtimer_work, clock_was_set_work);
>   * Called from timekeeping and resume code to reprogram the hrtimer
>   * interrupt device on all cpus.
>   */
> -void clock_was_set_delayed(void)
> +void clock_was_set_delayed(bool force_reprogram)
>  {
> -	schedule_work(&hrtimer_work);
> +	if (force_reprogram)
> +		schedule_work(&hrtimer_force_reprogram_work);
> +	else
> +		schedule_work(&hrtimer_work);
>  }
>  
>  #else
> @@ -871,6 +882,18 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
>  	tick_program_event(expires, 1);
>  }
>  
> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
> +			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
> +			 (1U << HRTIMER_BASE_TAI) |		\
> +			 (1U << HRTIMER_BASE_TAI_SOFT) |	\
> +			 (1U << HRTIMER_BASE_BOOTTIME) |	\
> +			 (1U << HRTIMER_BASE_BOOTTIME_SOFT))
> +
> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> +{
> +	return (cpu_base->active_bases & CLOCK_SET_BASES) != 0;
> +}
> +
>  /*
>   * Clock realtime was set
>   *
> @@ -882,11 +905,42 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
>   * resolution timer interrupts. On UP we just disable interrupts and
>   * call the high resolution interrupt code.
>   */
> -void clock_was_set(void)
> +void clock_was_set(bool force_reprogram)
>  {
>  #ifdef CONFIG_HIGH_RES_TIMERS
> -	/* Retrigger the CPU local events everywhere */
> -	on_each_cpu(retrigger_next_event, NULL, 1);
> +	cpumask_var_t mask;
> +	int cpu;
> +
> +	if (force_reprogram == true) {
> +		on_each_cpu(retrigger_next_event, NULL, 1);
> +		goto set_timerfd;
> +	}
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> +		on_each_cpu(retrigger_next_event, NULL, 1);
> +		goto set_timerfd;
> +	}

This is really horrible and the proper thing to do is to seperate the
s2idle/resume related functionality which allows to do some other
cleanups as well.

I already started to look at that over the weekend, but got stuck due to
a couple of correctness issues I found with the whole clock_was_set()
mechanism while looking. That stuff needs to be fixed first.

Back to the above. For the s2idle resume path there is no reason for an
IPI at all. It's just that way because it has been bolted on the
existing machinery.

So today it does:

   tick_unfreeze() {
     if (first_cpu_to_unfreeze()) {
        timekeeping_resume();
          tick_resume();
            tick_resume_local();
          clock_was_set_delayed();
     } else {
        tick_resume_local();
     }
   }

Then after everything is unfrozen including workqueues the delayed
clock_was_set() runs and does the IPI dance. That's just silly.

We can be smarter than that:

   tick_unfreeze() {
     if (first_cpu_to_unfreeze())
        timekeeping_resume();
          tick_resume();
            tick_resume_local();
              hrtimer_resume_local();
     } else {
        tick_resume_local();
          hrtimer_resume_local();
     }
   }

See? No IPI required at all and no magic force argument and as a bonus
we get also understandable code.

Splitting this properly allows to be smarter about the affected clocks
because most of the clock_was_set() events only care about
CLOCK_REALTIME and CLOCK_TAI and just the sleep time injection affects
CLOCK_BOOTTIME as well.

There are a few other things which can be done to avoid even more IPIs,
but let me address the correctness issues of clock_was_set() first.

Thanks,

        tglx
