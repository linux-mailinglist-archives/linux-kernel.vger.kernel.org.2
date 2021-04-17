Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9265E362FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhDQM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 08:28:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35054 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 08:28:50 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618662503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0abE3J5vsoXiEgTyesb4PssHvHXbBvKJFFhaFzAtlkg=;
        b=YWa4DWKSzwHANiXj8IOp7ATpYHy9CzLBvMW3M5kbkCe9mdUzm4XssLiUYd4Nseg45YPlG2
        +kqtvrSoF7tnf16dUWHk4gZqBqUkrhglzAqnan+rhuMTlewRApMk3po6derfvCbrcp/0qX
        0mNZBqtdehc7hBMpDmQigRAmwiZDmPXIcmkgITTvppiJlYejKm3WipXo49Bigbab68f869
        wR6WZhru3JslHnHa2V8L2Kqf01dMGMq6IsFZHzHmERmKKYkVlASKfevynmXJYEaqxee5YY
        sJBMkeVAjtKYeOq+uGhcnm1rJttreutVp6d1nTfhBhQLSPkkLufbssY81vQQDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618662503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0abE3J5vsoXiEgTyesb4PssHvHXbBvKJFFhaFzAtlkg=;
        b=3v8p3dWRhzejX1WCKGYYEX19kktknh93Ucr6zxO+wAwCnJjFhSvabZ80Ux2frc0IHgBy04
        osAJ+T91kDE/UtAA==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210414043602.2812981-3-paulmck@kernel.org>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1> <20210414043602.2812981-3-paulmck@kernel.org>
Date:   Sat, 17 Apr 2021 14:28:22 +0200
Message-ID: <87v98lrt7d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13 2021 at 21:36, Paul E. McKenney wrote:
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 1fc0962c89c0..97eeaf164296 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -169,7 +169,7 @@ struct clocksource kvm_clock = {
>  	.read	= kvm_clock_get_cycles,
>  	.rating	= 400,
>  	.mask	= CLOCKSOURCE_MASK(64),
> -	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VERIFY_PERCPU,

kvm_clock is not marked with CLOCK_SOURCE_MUST_VERIFY, so what's the
point of adding this here? It's not subject to be monitored by the
watchdog muck.

> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index f70dffc2771f..56289170753c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1151,7 +1151,8 @@ static struct clocksource clocksource_tsc = {
>  	.mask			= CLOCKSOURCE_MASK(64),
>  	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
>  				  CLOCK_SOURCE_VALID_FOR_HRES |
> -				  CLOCK_SOURCE_MUST_VERIFY,
> +				  CLOCK_SOURCE_MUST_VERIFY |
> +				  CLOCK_SOURCE_VERIFY_PERCPU,

While this one is part of the horror show.

> +static u64 csnow_mid;
> +static cpumask_t cpus_ahead;
> +static cpumask_t cpus_behind;
> +
> +static void clocksource_verify_one_cpu(void *csin)
> +{
> +	struct clocksource *cs = (struct clocksource *)csin;
> +
> +	csnow_mid = cs->read(cs);
> +}
> +
> +static void clocksource_verify_percpu(struct clocksource *cs)
> +{
> +	int64_t cs_nsec, cs_nsec_max, cs_nsec_min;
> +	u64 csnow_begin, csnow_end;
> +	bool firsttime = 1;
> +	int testcpu;
> +	s64 delta;
> +	int cpu;

        int testcpu, cpu; :)

