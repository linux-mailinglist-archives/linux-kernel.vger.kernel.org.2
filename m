Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7519835E7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbhDMUuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:50:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348385AbhDMUtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:49:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618346951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=LMJfQ64xQK5PmMvGbUFqr8WBkiPMOxrFg/EOkPfyD9g=;
        b=Q+uPYMEQv4F6jfWckp8WGdvgNaS5NIoCYcV/K3O0swMERDMCSBMKdof7mX8X59EKiWq3xE
        rby2YBXLx3aV7LLjxzrwc4EQLFXOfUtc1EflWpZ6bEi5DcvgzdURzUCfQNTRtuxtNMbuwc
        IMZOEm6PcJgnK5HRlWPlUZArARVWT96yAY+IspB7Pbok/Dl7UN1jbf3Sqd82vj2AfS2uuM
        ZsXq5Y/va12+kdqXc1gP2Vx715F7NEFON9NAyZvl8zSVZf/G37l8pkKfxXQCAweBiZwFbV
        4chB/+pUN7OGe93lQ7Xcc9VV6GXsIQvVnRxQlDWso0FvbWjVo3wpALHhBgRGKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618346951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=LMJfQ64xQK5PmMvGbUFqr8WBkiPMOxrFg/EOkPfyD9g=;
        b=mKnWVWNOq0/BMDcFKtKqOQUB03HPXSBYquic8HUequf52gOTr9++/jRaHLRWY7C4t5dtzo
        LwKWlkCoKNNBiGAw==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210412231809.GI4510@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 13 Apr 2021 22:49:11 +0200
Message-ID: <87r1jdykoo.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Mon, Apr 12 2021 at 16:18, Paul E. McKenney wrote:
> On Mon, Apr 12, 2021 at 10:37:10PM +0200, Thomas Gleixner wrote:
>> On Mon, Apr 12 2021 at 12:57, Paul E. McKenney wrote:
>> > On Mon, Apr 12, 2021 at 08:54:03PM +0200, Thomas Gleixner wrote:
>> >> > I will send a new series out later today, Pacific Time.
>> >> 
>> >> Can you do me a favour and send it standalone and not as yet another
>> >> reply to this existing thread maze. A trivial lore link to the previous
>> >> version gives enough context.
>> >
>> > Will do!
>> >
>> > Of course, it turns out that lockdep also doesn't like waited-on
>> > smp_call_function_single() invocations from timer handlers,
>> > so I am currently looking at other options for dealing with that
>> > potential use-after-free.  I am starting to like the looks of "only set
>> > CLOCK_SOURCE_VERIFY_PERCPU on statically allocated clocksource structures
>> > and let KASAN enforce this restriction", but I have not quite given up
>> > on making it more general.
>> 
>> The simplest point is in the thread under the clocksource_mutex which
>> prevents anything from vanishing under your feet.
>
> And lockdep is -much- happier with the setup shown below, so thank
> you again!

But it is too simple now :) ...

> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index f047c6cb056c..34dc38b6b923 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -519,6 +515,13 @@ static int __clocksource_watchdog_kthread(void)
>  	unsigned long flags;
>  	int select = 0;
>  
> +	/* Do any required per-CPU skew verification. */
> +	list_for_each_entry(cs, &watchdog_list, wd_list) {
> +		if ((cs->flags & (CLOCK_SOURCE_UNSTABLE | CLOCK_SOURCE_VERIFY_PERCPU)) ==
> +		    (CLOCK_SOURCE_UNSTABLE | CLOCK_SOURCE_VERIFY_PERCPU))
> +			clocksource_verify_percpu(cs);
> +	}

because that list is _NOT_ protected by the clocksource_mutex as you
noticed yourself already.

But you don't have to walk that list at all because the only interesting
thing is the currently active clocksource, which is about to be changed
in case the watchdog marked it unstable and cannot be changed by any
other code concurrently because clocksource_mutex is held.

So all you need is:

	if (curr_clocksource &&
	    curr_clocksource->flags & CLOCK_SOURCE_UNSTABLE &&
	    curr_clocksource->flags & CLOCK_SOURCE_VERIFY_PERCPU)
		clocksource_verify_percpu_wreckage(curr_clocksource);

Hmm?

Thanks,

        tglx
        

