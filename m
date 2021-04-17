Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2047A363005
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhDQMry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:47:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhDQMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:47:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618663639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqBR/fku0Axww/pBD/ch8Tbclrbt2bUFLFKkPOrAh0I=;
        b=cYXD6FJIICuo7btR3VOTUHgLjLD5HU0vPvDHw2pODLWDR5YU7EY4GuSEllvMsO6Ys9Vynh
        dbKqddo+mZOYXc/FNIQ90o9ShJeqqLKRK8svW/DzoON2U65xFqBIlvgaeUMC/CFZylbXYi
        iBppXe1Hq8Cj1hIAYyN7IKrSkDnnl6Vl2dEtj8tRcGKnfQmGnTsmM9lYO1ktHrqzqMF7N3
        AHd07eo/mFUi1G0UAodsR4YQwvBsb7aRvri9FuoPMpnZnqUQeEvDOP74AXI64ONI1hAdXi
        QVMJ0E+f0gBvsShPmRadN7lzWoVicdTvQS5r9PSJhKipURoBUtKZkrBDf+XskA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618663639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqBR/fku0Axww/pBD/ch8Tbclrbt2bUFLFKkPOrAh0I=;
        b=BQVEzOHrQXsmxCKqNfBimZOlGglWizsnabl4TVWwpKTQexviCuL1aGHiLAvtzM8HDQ2Jnj
        nXtp61R0xMHEnODQ==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210414043602.2812981-3-paulmck@kernel.org>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1> <20210414043602.2812981-3-paulmck@kernel.org>
Date:   Sat, 17 Apr 2021 14:47:18 +0200
Message-ID: <87sg3prsbt.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13 2021 at 21:36, Paul E. McKenney wrote:

Bah, hit send too quick.

> +	cpumask_clear(&cpus_ahead);
> +	cpumask_clear(&cpus_behind);
> +	preempt_disable();

Daft. 

> +	testcpu = smp_processor_id();
> +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n", cs->name, testcpu);
> +	for_each_online_cpu(cpu) {
> +		if (cpu == testcpu)
> +			continue;
> +		csnow_begin = cs->read(cs);
> +		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
> +		csnow_end = cs->read(cs);

As this must run with interrupts enabled, that's a pretty rough
approximation like measuring wind speed with a wet thumb.

Wouldn't it be smarter to let the remote CPU do the watchdog dance and
take that result? i.e. split out more of the watchdog code so that you
can get the nanoseconds delta on that remote CPU to the watchdog.

> +		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
> +		if (delta < 0)
> +			cpumask_set_cpu(cpu, &cpus_behind);
> +		delta = (csnow_end - csnow_mid) & cs->mask;
> +		if (delta < 0)
> +			cpumask_set_cpu(cpu, &cpus_ahead);
> +		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
> +		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);

> +		if (firsttime || cs_nsec > cs_nsec_max)
> +			cs_nsec_max = cs_nsec;
> +		if (firsttime || cs_nsec < cs_nsec_min)
> +			cs_nsec_min = cs_nsec;
> +		firsttime = 0;

  int64_t cs_nsec_max = 0, cs_nsec_min = LLONG_MAX;

and then the firsttime muck is not needed at all.

Thanks,

        tglx

