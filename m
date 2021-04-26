Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0736B31A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhDZMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhDZMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:33:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52045C061763
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 05:33:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619440381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tstdcx/ZfhFpFfki9DQLaQFX4+9YKggD9tcQ4CyOZi4=;
        b=lY7l/lzfL81Mv9zdV21JmneH55OZPQ4HddlsyGmQyowBco9t7PBEVhMi4hYC1orj3oDmMe
        fN7V7tjEF1a7AGqckwkL9UlsPEQN2onTRqIqUoylTRu4oFYsAgOKXWH7aZGfluQzgYXIDC
        RXJQ4ujxftf9TZi8AwbtcW3ofwp2ZuKGJPk+nJy3l079vYLi0SP6NqAIgrdTk3NSo8Nate
        N2iI2fIU6yMgdvgsQuAmYIZPaOF0/2UbWAtkPRt8dOFWKEbuFisXr7+EKcWfsdmM035xCM
        uKKHN7Swr8RYnyLow6jcL8a6XajNpr7T/ZZy8ad3PsiDqPfcsHdEWTj0y7KCLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619440381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tstdcx/ZfhFpFfki9DQLaQFX4+9YKggD9tcQ4CyOZi4=;
        b=J5hVqx9+pyRCXchYGLWtIgBCvH50phRedQ231JFjKsxeGImQqDwRbz0IVqSR4WflnrTTBH
        Y3+oe39tL2O9DnCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Avoid double reprogramming in __hrtimer_start_range_ns()
In-Reply-To: <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com> <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com> <87eef5qbrx.ffs@nanos.tec.linutronix.de> <87v989topu.ffs@nanos.tec.linutronix.de> <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net>
Date:   Mon, 26 Apr 2021 14:33:00 +0200
Message-ID: <87sg3dtedf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26 2021 at 11:40, Peter Zijlstra wrote:
> On Mon, Apr 26, 2021 at 10:49:33AM +0200, Thomas Gleixner wrote:
>> If __hrtimer_start_range_ns() is invoked with an already armed hrtimer then
>> the timer has to be canceled first and then added back. If the timer is the
>> first expiring timer then on removal the clockevent device is reprogrammed
>> to the next expiring timer to avoid that the pending expiry fires needlessly.
>>  		/*
>>  		 * Remove the timer and force reprogramming when high
>> @@ -1048,8 +1049,16 @@ remove_hrtimer(struct hrtimer *timer, st
>>  		debug_deactivate(timer);
>>  		reprogram = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
>>  
>> +		/*
>> +		 * If the timer is not restarted then reprogramming is
>> +		 * required if the timer is local. If it is local and about
>> +		 * to be restarted, avoid programming it twice (on removal
>> +		 * and a moment later when it's requeued).
>> +		 */
>>  		if (!restart)
>>  			state = HRTIMER_STATE_INACTIVE;
>> +		else
>> +			reprogram &= !keep_local;
>
> 			reprogram = reprogram && !keep_local;
>
> perhaps?

Maybe

>>  
>>  		__remove_hrtimer(timer, base, state, reprogram);
>>  		return 1;
>> @@ -1103,9 +1112,31 @@ static int __hrtimer_start_range_ns(stru
>>  				    struct hrtimer_clock_base *base)
>>  {
>>  	struct hrtimer_clock_base *new_base;
>> +	bool force_local, first;
>>  
>> -	/* Remove an active timer from the queue: */
>> -	remove_hrtimer(timer, base, true);
>> +	/*
>> +	 * If the timer is on the local cpu base and is the first expiring
>> +	 * timer then this might end up reprogramming the hardware twice
>> +	 * (on removal and on enqueue). To avoid that by prevent the
>> +	 * reprogram on removal, keep the timer local to the current CPU
>> +	 * and enforce reprogramming after it is queued no matter whether
>> +	 * it is the new first expiring timer again or not.
>> +	 */
>> +	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
>> +	force_local &= base->cpu_base->next_timer == timer;
>
> Using bitwise ops on a bool is cute and all, but isn't that more
> readable when written like:
>
> 	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases) &&
> 		      base->cpu_base->next_timer == timer;
>

Which results in an extra conditional branch.

>> +	/*
>> +	 * Timer was forced to stay on the current CPU to avoid
>> +	 * reprogramming on removal and enqueue. Force reprogram the
>> +	 * hardware by evaluating the new first expiring timer.
>> +	 */
>> +	hrtimer_force_reprogram(new_base->cpu_base, 1);
>> +	return 0;
>>  }
>
> There is an unfortunate amount of duplication between
> hrtimer_force_reprogram() and hrtimer_reprogram(). The obvious cleanups
> don't work however :/ Still, does that in_hrtirq optimization make sense
> to have in force_reprogram ?

Yes, no, do not know. Let me have a look.

Thanks,

        tglx
