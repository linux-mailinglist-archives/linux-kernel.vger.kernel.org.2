Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA5362911
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbhDPULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhDPULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:11:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7938C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:10:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618603851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g0nAMUNCNuNCD3V5EVWgrPp6Sfifdgyl94Z2svMBqG0=;
        b=o+xpaAtuvb+Phx9S0ri0eceQASqvpettY4H0po/4ZKBwyvNCo0Xh5Xb7i4LERkBU3KfEd6
        Z9ePB/ozVfPhJ3UC52sYH18vhBUcgPiMbcZSlkYoIy+rCAjOihVO3NZZ664iI7Bm6HMd6q
        TrwGXLmg3wmEQzn/Efgv1nCIQXYAohVN0i+vqL7RVZuMtbIRKBE93YoVEeVk4BJmY2eOgq
        bhNusnvWXxYXfDZk+LEBdobP+J6cXmMQMDx93cRi/FKwd0F/iH44OXA1m5553YymSfF9k8
        7to+ApUEq0zpvgBhJ4VPAp0M55xmJqYnVgwfa9VOa33euA3zz+H8AAS/lvLzRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618603851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g0nAMUNCNuNCD3V5EVWgrPp6Sfifdgyl94Z2svMBqG0=;
        b=NCiIqrMpMGlCvbPwGxzKaMGw+XSwqcVSMlrP+A0mDaxAowpILWQ/BfYMAu0FApPCloEeCX
        jn9zMmYYP9SdshBA==
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 1/5] clocksource: Provide module parameters to inject delays in watchdog
In-Reply-To: <20210414043602.2812981-1-paulmck@kernel.org>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1> <20210414043602.2812981-1-paulmck@kernel.org>
Date:   Fri, 16 Apr 2021 22:10:51 +0200
Message-ID: <878s5iuh10.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13 2021 at 21:35, Paul E. McKenney wrote:
>  
> +static int inject_delay_freq;
> +module_param(inject_delay_freq, int, 0644);
> +static int inject_delay_run = 1;
> +module_param(inject_delay_run, int, 0644);

int? Can't we just make them 'unsigned int'? Negative values are not
that useful.

> +static int max_read_retries = 3;
> +module_param(max_read_retries, int, 0644);

max_read_retries is unused here. Should be in the patch which actually
uses it.

> +static void clocksource_watchdog_inject_delay(void)
> +{
> +	int i;
> +	static int injectfail = -1;
> +
> +	if (inject_delay_freq <= 0 || inject_delay_run <= 0)
> +		return;
> +	if (injectfail < 0 || injectfail > INT_MAX / 2)
> +		injectfail = inject_delay_run;
> +	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {

Operator precedence based cleverness is really easy to parse - NOT!

> +		pr_warn("%s(): Injecting delay.\n", __func__);
> +		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC; i++)
> +			udelay(1000);
> +		pr_warn("%s(): Done injecting delay.\n", __func__);
> +	}
> +
> +	WARN_ON_ONCE(injectfail < 0);
> +}

Brain melt stage reached by now.

        static unsigned int invocations, injections;

        if (!inject_delay_period || !inject_delay_repeat)
        	return;

        if (!(invocations % inject_delay_period)) {
        	mdelay(2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC);
                if (++injections < inject_delay_repeat)
                	return;
                injections = 0;
        }

        invocations++;
}

Hmm?

Thanks,

        tglx
