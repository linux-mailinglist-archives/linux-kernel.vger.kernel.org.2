Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA08835C703
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhDLNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:08:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbhDLNIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:08:37 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618232897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZP2snCTh+JHrz4jVYis2HFOEGARSIstoiJmLjCAKk4=;
        b=QKW4hQRupWaQcTUowFPpkIw22sdWiWlTC9gJAGEbG7PhCj/E03hPRY9WfCN7hHkvG76dJA
        FyFbHs7S6QXuskXiSvUs+5JAGXP7Wr4P63+B40d5hh14jdYh1SaupLwAzAv3n9Y/bKV1oI
        xkfQY9qG9E9QxMpb9x780uInsRzsYDMQQD979tatAjLEXvUWfM/BapCSa2nfIdfsJ6bH+9
        M8LY3vrCyuLYCEeANi5mBsvgVDLasbYCOVwGsHHNQ/Y2N+bkSM4r5DVowIxLa7Mlw50qgF
        rTv4WZWmk4dJXNqGERbJALKB54mnW2gIq3rWKudTBMZtWOoIP2ctWKWsT3gcJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618232897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZP2snCTh+JHrz4jVYis2HFOEGARSIstoiJmLjCAKk4=;
        b=jfbSSM8iJg/SKUfpsnt/j4wSzVJBCyKZ+kiRekypQN8QxUb27l+RWHY03+I11Kx8BfNWUr
        NxKZbsuwMCu+OxDw==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-3-paulmck@kernel.org> <87blam4iqe.ffs@nanos.tec.linutronix.de> <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1> <878s5p2jqv.ffs@nanos.tec.linutronix.de> <20210411164612.GZ4510@paulmck-ThinkPad-P17-Gen-1> <20210412042157.GA1889369@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 12 Apr 2021 15:08:16 +0200
Message-ID: <87k0p71whr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11 2021 at 21:21, Paul E. McKenney wrote:
> On Sun, Apr 11, 2021 at 09:46:12AM -0700, Paul E. McKenney wrote:
>> So I need to is inline clocksource_verify_percpu_wq()
>> into clocksource_verify_percpu() and then move the call to
>> clocksource_verify_percpu() to __clocksource_watchdog_kthread(), right
>> before the existing call to list_del_init().  Will do!
>
> Except that this triggers the WARN_ON_ONCE() in smp_call_function_single()
> due to interrupts being disabled across that list_del_init().
>
> Possibilities include:
>
> 1.	Figure out why interrupts must be disabled only sometimes while
> 	holding watchdog_lock, in the hope that they need not be across
> 	the entire critical section for __clocksource_watchdog_kthread().
> 	As in:
>
> 		local_irq_restore(flags);
> 		clocksource_verify_percpu(cs);
> 		local_irq_save(flags);
>
> 	Trying this first with lockdep enabled.  Might be spectacular.

Yes, it's a possible deadlock against the watchdog timer firing ...

The reason for irqsave is again historical AFAICT and nobody bothered to
clean it up. spin_lock_bh() should be sufficient to serialize against
the watchdog timer, though I haven't looked at all possible scenarios.

> 2.	Invoke clocksource_verify_percpu() from its original
> 	location in clocksource_watchdog(), just before the call to
> 	__clocksource_unstable().  This relies on the fact that
> 	clocksource_watchdog() acquires watchdog_lock without
> 	disabling interrupts.

That should be fine, but this might cause the softirq to 'run' for a
very long time which is not pretty either.

Aside of that, do we really need to check _all_ online CPUs? What you
are trying to figure out is whether the wreckage is CPU local or global,
right?

Wouldn't a shirt-sleeve approach of just querying _one_ CPU be good
enough? Either the other CPU has the same wreckage, then it's global or
it hasn't which points to a per CPU local issue.

Sure it does not catch the case where a subset (>1) of all CPUs is
affected, but I'm not seing how that really buys us anything.

Thanks,

        tglx
