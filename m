Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B708F362B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhDPWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234662AbhDPWjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9FA46137D;
        Fri, 16 Apr 2021 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618612728;
        bh=fLShCm6HfuN+aWirA8byWk1J3cvvfDXcNCJir5OTQNw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BFCcLVE/r/1B67KiATn/UaC9F3n9ulTT00juDdRaMBWTJiZU1MLvNizP7B7x/Ykx+
         3JgdGYyef/bPaSEBVr6un3/eAFZhxtUTx1FqfEOj2lWnQwQUEPbV5BetspS5Ciz7YX
         AHbLMoEcxI7fJr+Sqm9bXP8CDAMh8Ia2AOnwPGZP5hwJCuMX+DoBQooUGtiJABoNIz
         b9rfXzfzbBug8IRC3D3ZhqBiuuNSC4WhiwFqSOtN1uBJTM5CBHJf2QaoFWTmZErd64
         4GcR4AX33ourRk/klSiFh+728jYDArpHXMi9pdePgum4t2V4sE5Q/9ZBX9Ttjr5W3O
         da/2rHBDjAMFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE0515C0253; Fri, 16 Apr 2021 15:38:48 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:38:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 1/5] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210416223848.GL4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
 <20210414043602.2812981-1-paulmck@kernel.org>
 <878s5iuh10.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s5iuh10.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:10:51PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 21:35, Paul E. McKenney wrote:
> >  
> > +static int inject_delay_freq;
> > +module_param(inject_delay_freq, int, 0644);
> > +static int inject_delay_run = 1;
> > +module_param(inject_delay_run, int, 0644);
> 
> int? Can't we just make them 'unsigned int'? Negative values are not
> that useful.
> 
> > +static int max_read_retries = 3;
> > +module_param(max_read_retries, int, 0644);
> 
> max_read_retries is unused here. Should be in the patch which actually
> uses it.

Good point, I will make all three unsigned int and move max_read_retries
to 2/5 ("clocksource: Retry clock read if long delays detected").

> > +static void clocksource_watchdog_inject_delay(void)
> > +{
> > +	int i;
> > +	static int injectfail = -1;
> > +
> > +	if (inject_delay_freq <= 0 || inject_delay_run <= 0)
> > +		return;
> > +	if (injectfail < 0 || injectfail > INT_MAX / 2)
> > +		injectfail = inject_delay_run;
> > +	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {
> 
> Operator precedence based cleverness is really easy to parse - NOT!
> 
> > +		pr_warn("%s(): Injecting delay.\n", __func__);
> > +		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC; i++)
> > +			udelay(1000);
> > +		pr_warn("%s(): Done injecting delay.\n", __func__);
> > +	}
> > +
> > +	WARN_ON_ONCE(injectfail < 0);
> > +}
> 
> Brain melt stage reached by now.
> 
>         static unsigned int invocations, injections;
> 
>         if (!inject_delay_period || !inject_delay_repeat)
>         	return;
> 
>         if (!(invocations % inject_delay_period)) {
>         	mdelay(2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC);
>                 if (++injections < inject_delay_repeat)
>                 	return;
>                 injections = 0;
>         }
> 
>         invocations++;
> }
> 
> Hmm?

That is quite a bit nicer than the interacting parameters that I
had.  I will rework along these lines.

							Thanx, Paul
