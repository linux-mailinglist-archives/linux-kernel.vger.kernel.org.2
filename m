Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924B030D082
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBCAv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232464AbhBCAvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:51:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2296B64F6C;
        Wed,  3 Feb 2021 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612313421;
        bh=2oAL83AQgZdUauXSnwoYlspPoPdvBJyWIbDVFHX5qsU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A0tIeYeRMoA140byXMHql45K5kNvUvn0icP2FobnhEP2chqdBo66zwhY3b22cyVpc
         Zfv2ABXjVzpsfw+hmTkcqB/izAEdeATxFNT/thJ4jdNki2NESgUTBfmRdzuOyPQOeO
         zDH2jlzpblgIhUShb7F74bh9bD3wICImio8OUdKiwSMVyuT7qkZLqhqVo6PqRi3TaJ
         EmHUbhRlLVhKRzn8WZq6jBOYVXRHK0N9ibsnmfZ/vcY+N8WEyuUpln2ljTzyn32wJp
         bXnW3ltnLkkGjVCUELNOGkUGCNjHqs4wTY+LdnSfvClLGEvXu1iQVXwCmhR7/OSSRa
         reMnngmVtsi4A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D5D6C3522865; Tue,  2 Feb 2021 16:50:20 -0800 (PST)
Date:   Tue, 2 Feb 2021 16:50:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        ak@linux.intel.com, clm@fb.com
Subject: Re: [PATCH clocksource 4/5] clocksource: Provide a module parameter
 to fuzz per-CPU clock checking
Message-ID: <20210203005020.GI2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210202170437.GA23593@paulmck-ThinkPad-P72>
 <20210202170635.24839-4-paulmck@kernel.org>
 <5badf6e2-4600-4fe9-6b45-d0de94ad718b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5badf6e2-4600-4fe9-6b45-d0de94ad718b@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 11:51:02AM -0800, Randy Dunlap wrote:
> On 2/2/21 9:06 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Code that checks for clock desynchronization must itself be tested, so
> > this commit creates a new clocksource.inject_delay_shift_percpu= kernel
> > boot parameter that adds or subtracts a large value from the check read,
> > using the specified bit of the CPU ID to determine whether to add or
> > to subtract.
> > 
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Mark Rutland <Mark.Rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Reported-by: Chris Mason <clm@fb.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  kernel/time/clocksource.c                       | 10 +++++++++-
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 9965266..f561e94 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -593,6 +593,15 @@
> >  			times the value specified for inject_delay_freq
> >  			of consecutive non-delays.
> >  
> > +	clocksource.inject_delay_shift_percpu= [KNL]
> > +			Shift count to obtain bit from CPU number to
> > +			determine whether to shift the time of the per-CPU
> > +			clock under test ahead or behind.  For example,
> 
> It's a good think that you give an example -- it helps a little bit.
> That sentence above needs to be rewritten...

That is a bit obscure, now that you mention it.

> > +			setting this to the value four will result in
> > +			alternating groups of 16 CPUs shifting ahead and
> > +			the rest of the CPUs shifting behind.  The default
> > +			value of -1 disable this type of error injection.
> 
> 			            disables

Good eyes!

So how about like this?

	clocksource.inject_delay_shift_percpu= [KNL]
			Clocksource delay injection partitions the CPUs
			into two sets, one whose clocks are moved ahead
			and the other whose clocks are moved behind.
			This kernel parameter selects the CPU-number
			bit that determines which of these two sets the
			corresponding CPU is placed into.  For example,
			setting this parameter to the value four will
			result in the first set containing alternating
			groups of 16 CPUs whose clocks are moved ahead,
			while the second set will contain the rest of
			the CPUs, whose clocks are moved behind.

			The default value of -1 disables this type of
			error injection.

							Thanx, Paul

> > +
> >  	clocksource.max_read_retries= [KNL]
> >  			Number of clocksource_watchdog() retries due to
> >  			external delays before the clock will be marked
> 
> 
> -- 
> ~Randy
> 
