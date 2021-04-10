Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0263035ABF3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDJIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:41:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhDJIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:41:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618044081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlNa3MqXzj9whM41XX+hatb3qm4j/svULVtdbTVRTrg=;
        b=EkCb/+eFWsgf1OzTYEQGOBFKfsO9bFnhyzQ4u2MRAlhaDe7mipyHi1lupXZwilIJ4NTaGW
        9skFetFKiulmgsO10izLH7pFHqY9mBzaKNP4KYoBlUFcAW4pwK1+uk7soVwVgoKcSZJwYQ
        Jnqh5eaEQaJUaKfgN6ZLUlKNUv2VZS1qlwBHGHGDV5cp1vShoE9ul8s9KlDB8Wx54fQRsx
        S2af0fPifnorc3g20+PaEhYoqJIwnkpFwiIbNXyvchmRvNmW8Ptp/Nr5UQMDqaXjEW3ysX
        hqN3h2stvE/pLG4Fb90A2hQCMPfe+lIIV6F1/Rza+oPiOYAzWlkvFK7sqOjfhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618044081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlNa3MqXzj9whM41XX+hatb3qm4j/svULVtdbTVRTrg=;
        b=GkK+URQDnOl0+opA203ssk4uk3XZwj6/TFBpS3eIENn3A84DGbf/KogCPIieVg9FmFD2er
        4hNX/Vrn2ZSJ6wCA==
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 clocksource 2/5] clocksource: Retry clock read if long delays detected
In-Reply-To: <20210402224906.3912-2-paulmck@kernel.org>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-2-paulmck@kernel.org>
Date:   Sat, 10 Apr 2021 10:41:21 +0200
Message-ID: <87eefi4jm6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02 2021 at 15:49, paulmck wrote:
> This commit therefore re-reads the watchdog clock on either side of

'This commit' is not any better than 'This patch' and this sentence
makes no sense. I might be missing something, but how exactly does "the
commit" re-read the watchdog clock?

 git grep 'This patch' Documentation/process/

> the read from the clock under test.  If the watchdog clock shows an
> +retry:
>  		local_irq_disable();
> -		csnow = cs->read(cs);
> -		clocksource_watchdog_inject_delay();
>  		wdnow = watchdog->read(watchdog);
> +		clocksource_watchdog_inject_delay();
> +		csnow = cs->read(cs);
> +		wdagain = watchdog->read(watchdog);
>  		local_irq_enable();
> +		delta = clocksource_delta(wdagain, wdnow, watchdog->mask);
> +		wdagain_nsec = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);

That variable naming is confusing as hell. This is about the delta and
not about the second readout of the watchdog.

> +		if (wdagain_nsec < 0 || wdagain_nsec > WATCHDOG_MAX_SKEW) {

How exactly is this going negative especially with clocksources which
have a limited bitwidth? See clocksource_delta().

> +			wderr_nsec = wdagain_nsec;
> +			if (nretries++ < max_read_retries)
> +				goto retry;
> +		}
> +		if (nretries)
> +			pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d\n",
> +				smp_processor_id(), watchdog->name, wderr_nsec, nretries);

Lacks curly braces around the pr_warn() simply because it's not a single
line. Breaks my parser :)

But if this ever happens to exceed max_read_retries, then what's the
point of continuing at all? The data is known to be crap already.

>  		/* Clocksource initialized ? */
>  		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||

Thanks,

        tglx
