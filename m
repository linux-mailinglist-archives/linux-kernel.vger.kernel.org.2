Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96054381486
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 02:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhEOA0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 20:26:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40194 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEOA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 20:26:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621038296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7J20CIY6n338R3EMfMgJGDDEv/DbiWFGwByEAM8L1M=;
        b=g7jxwZOiV6cd9mZtmR35bEc69sWpnHtEqWUPSkDollmplIm8F7W9hSbLHO5KYl34B8L1yY
        Y4VG5ie1jIOzRx/6Nc/pOk3UxsRrgmfAibAQpEwztALO4Yw6UOrfcGkkWRhVarO7qFiYZD
        OSK1P+5fOzVme63RxouKm1zhN8hXC0c+krES7YeZp5Ex3fmLkVowcCKJHKtjPtVcQoDHvA
        CxCgi5vy1OQLulH+oHM2uvtk2XkEEifaFG3q3zjZ+55lgQm00ClsPMM2YaYdypfgJZ6+uZ
        gKXA8u8K4610ng6nKoRLi2iaGlPHE6at9sqMGD986ju1932+HaNf7hLhHK8ZmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621038296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7J20CIY6n338R3EMfMgJGDDEv/DbiWFGwByEAM8L1M=;
        b=sACx/pxL0BGJAcxcoHgCA0ia/bMLbN904sCl104LR/mNxMGqUaZR12dtr4foo3OCHRcQeW
        2bObbo68y/j4JpDQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 7/8] hrtimer: Avoid unnecessary SMP function calls in clock_was_set()
In-Reply-To: <YJ8Hp0gTGwugxxFM@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de> <20210427083724.732437214@linutronix.de> <YJ0+6vfkC+LTPkkw@hirez.programming.kicks-ass.net> <87bl9d407i.ffs@nanos.tec.linutronix.de> <YJ8Hp0gTGwugxxFM@hirez.programming.kicks-ass.net>
Date:   Sat, 15 May 2021 02:24:55 +0200
Message-ID: <87v97k2694.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15 2021 at 01:28, Peter Zijlstra wrote:

> On Fri, May 14, 2021 at 08:52:33PM +0200, Thomas Gleixner wrote:
>> On Thu, May 13 2021 at 16:59, Peter Zijlstra wrote:
>> > On Tue, Apr 27, 2021 at 10:25:44AM +0200, Thomas Gleixner wrote:
>> >> -	/* Retrigger the CPU local events everywhere */
>> >> -	on_each_cpu(retrigger_next_event, NULL, 1);
>> >> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
>> >> +		on_each_cpu(retrigger_next_event, NULL, 1);
>> >
>> > This will violate NOHZ_FULL;
>> 
>> Only if that allocation fails.
>
> Right, which should be near to never I suppose.
>
>> Aside of that any CPU which has an affected timer will get notified even
>> on NOHZ_FULL.
>
> Right; but if it's properly NOHZ_FULL -- the kind that wanted a signal
> on any entry into the kernel -- when it won't have timers and this IPI
> will trigger the signal and kill the program.

That's true today. clock_was_set() IPI's unconditionally. The whole
point of this exercise is to avoid that if there are no armed timers on
the affected clocks.

>> >> +	preempt_disable();
>> >> +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
>> >
>> > The sane option is:
>> >
>> > 	smp_call_function_many_cond(cpu_online_mask, retrigger_next_event,
>> > 				    NULL, SCF_WAIT, update_needs_ipi);
>> >
>> > Which does all of the above, but better.
>> 
>> With the difference that the for_each_cpu() loop runs with preemption
>> disabled, while with this approach preemption is only disabled accross
>> the function call.
>
> Yeah, I'd forgotten that... I might put looking at that on the todo list
> somewhere :/

That's this append only thingy, right?

Thanks,

        tglx
