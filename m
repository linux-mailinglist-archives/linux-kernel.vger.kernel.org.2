Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1ED369ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbhDWTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:15:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDWTP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:15:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619205289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRRccMIE3B0r4h6fyeNGlYwZXtoJwsJnMvcwiPXdThg=;
        b=lJOMtXM1WsvXnCU8Gn9mDDN/CbosOsN/69wT8tU5Xl4Wzet8NGUgKLzFk5LfHUgNacWIhm
        sL1Cy1HxhyPdJk9f1hQXT+aHeRozCrcmLuRGThwZg/XE79beq6Wj1kqW/i/rzLv8WHN3v3
        FCuJKLKJxC4gkYHEbJwQqjNierIKHUsdEW0iFysbgU75LB91ZA6W4/LM0HkAroDCpe9CRP
        5JzzQPWnOgc8j0wYqNuPy+jAKJj4MtJqO3dAyoOS7jQhHN15gZKEXnjD83MPh9KRmUC5wF
        fpqHBNCPZd+BmE+8G6h4bBZONjZIPAjrDWlnjLMiR7aIGHGKt8wpoVg4A2y+hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619205289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRRccMIE3B0r4h6fyeNGlYwZXtoJwsJnMvcwiPXdThg=;
        b=2CxWF3lgZNEqxPhjv6pK5IQ0EBFXNAFXU9eKGiv6+xCtOEf4FNM4UzW+HeKiheE/ppE8RV
        +6uLV48T4y3Ot6AQ==
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec -14.4% regression
In-Reply-To: <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
References: <20210420064934.GE31773@xsang-OptiPlex-9020> <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1> <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1> <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com> <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1> <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com> <20210422074126.GA85095@shbuild999.sh.intel.com> <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
Date:   Fri, 23 Apr 2021 21:14:49 +0200
Message-ID: <87tunwvmmu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22 2021 at 07:24, Paul E. McKenney wrote:
> On Thu, Apr 22, 2021 at 03:41:26PM +0800, Feng Tang wrote:
> So what are our options?
>
> 1.	Clear CLOCK_SOURCE_MUST_VERIFY from tsc-early.
>
> 2.	#1, but add tsc-early into the watchdog list and set
> 	CLOCK_SOURCE_MUST_VERIFY once it is better calibrated.
>
> 3.	Add a field to struct clocksource that, if non-zero, gives
> 	the maximum drift in nanoseconds per half second (AKA
> 	WATCHDOG_INTERVAL).  If zero, the WATCHDOG_MAX_SKEW value
> 	is used.  Set this to (say) 150,000ns for tsc-early.
>
> 4.	As noted earlier, increase WATCHDOG_MAX_SKEW to 150 microseconds,
> 	which again is not a good approach given the real-world needs
> 	of real-world applications.
>
> 5.	Your ideas here.

#3 or add a flag to the clocksource which says 'frequency is guesswork' and
increase the threshold based on that.

If that flag is still set max_drift is != 0 after 20 seconds yell.

Thanks,

        tglx


