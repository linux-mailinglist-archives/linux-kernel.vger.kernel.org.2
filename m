Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068F937B4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhELDjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhELDjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:39:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B69661432;
        Wed, 12 May 2021 03:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620790687;
        bh=oT0X2JNCx1DviEyHFEyiFx4MvQ/+8rEsXU09/zK0VR0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EEzDzWRp7tu0larBn9hLExOedDdhvg7q2aDpnMvTgmq0MGBpi1YXLpRrXKVAroOZn
         tp9ehTbLN65H7HI1JiOb3nYjBHhLP0lAU2IJELbAOM9ESXZyDG7CRUDDpfzcxE+laE
         YuzPoWc/UJ5SHo9ScFImrJJKjFVSvRTO2t5P/1QKZnnyyrJKlQuDx1BfB/ROb1Ko+E
         weU7IlBs4LqCgLi1rESM3RgtMEkj7YatIRiiarwQJh90DbljJMnQprr7CjboNBAwGi
         CbMCwqKASoqS91j/3PNr/u0dtR2H4urqnDRwxIiF6MitpE5MnSxSXbte+MCunGI/cl
         1D2b5Qm6jKIZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1B2E85C0134; Tue, 11 May 2021 20:38:07 -0700 (PDT)
Date:   Tue, 11 May 2021 20:38:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com, zhengjun.xing@intel.com
Subject: Re: [PATCH v14 clocksource 6/6] clocksource: Print deviation in
 nanoseconds for unstable case
Message-ID: <20210512033807.GS975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
 <20210511233455.2897068-6-paulmck@kernel.org>
 <20210512022136.GC78351@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512022136.GC78351@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 10:21:36AM +0800, Feng Tang wrote:
> On Tue, May 11, 2021 at 04:34:55PM -0700, Paul E. McKenney wrote:
> > From: Feng Tang <feng.tang@intel.com>
> > 
> > Currently when an unstable clocksource is detected, the raw counters
> > of that clocksource and watchdog will be printed, which can only be
> > understood after some math calculation.  So print the existing delta in
> > nanoseconds to make it easier for humans to check the results.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/time/clocksource.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index bbe1bcf44ffa..9c45b98e60e2 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -406,10 +406,10 @@ static void clocksource_watchdog(struct timer_list *unused)
> >  		if (abs(cs_nsec - wd_nsec) > md) {
> >  			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
> >  				smp_processor_id(), cs->name);
> > -			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
> > -				watchdog->name, wdnow, wdlast, watchdog->mask);
> > -			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
> > -				cs->name, csnow, cslast, cs->mask);
> > +			pr_warn("                      '%s' wd_nesc: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
> 
> There is a typo in the message, 'wd_nesc' should be 'wd_nsec' , 
> sorry for that.

No problem!  I already have you covered with bfa55d346b23 ("squash!
clocksource: Print deviation in nanoseconds for unstable case").

I will merge it on the next rebase.

							Thanx, Paul

> Thanks,
> Feng
> 
> 
> > +				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
> > +			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
> > +				cs->name, cs_nsec, csnow, cslast, cs->mask);
> >  			if (curr_clocksource == cs)
> >  				pr_warn("                      '%s' is current clocksource.\n", cs->name);
> >  			else if (curr_clocksource)
> > -- 
> > 2.31.1.189.g2e36527f23
