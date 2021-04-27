Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9236BDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhD0DrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhD0DrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:47:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B925661104;
        Tue, 27 Apr 2021 03:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619495200;
        bh=RTQhbHh3ORjUxwWm+ZJsLGqrlFy+8ohbRZ2BknnL+IY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mYV9FrClxsn3fy/e2FIhX53SWq5h45qxaahaUBlViJhnpGDQjN9SunXJrAWRJAWRi
         D7clajKGsxEuveKc3br/tSznc/rIinUB7Zz1eYPmlEHE89K0XzbsALDtgzOvBx/iP6
         /DnguOzrbrozpea/k6/TTXdBncfxKpR21nY9bcSHeOBy2OFaFMDfA1lmwlvH5wc4WM
         nmlFZqEOTPoKYG7ZOmmbVhDTjbFLQyXOfG+0tmR0BYnow5RoLdtep+PCAEnNfn0CYx
         VqdfouEiz1t4ULaXsdGLIyVjLMQEWDvhOV3GZjik5wdDCWdpbo/+nIXdr3BqL73s4F
         TPZmgyqw7F/Rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7798B5C08D8; Mon, 26 Apr 2021 20:46:40 -0700 (PDT)
Date:   Mon, 26 Apr 2021 20:46:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        zhengjun.xing@intel.com,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v10 clocksource 6/7] clocksource: Forgive tsc_early
 pre-calibration drift
Message-ID: <20210427034640.GF975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-6-paulmck@kernel.org>
 <20210426150127.GB23119@shbuild999.sh.intel.com>
 <20210426152529.GX975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426153605.GB89018@shbuild999.sh.intel.com>
 <20210426182652.GE975577@paulmck-ThinkPad-P17-Gen-1>
 <20210427011355.GC89018@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427011355.GC89018@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:13:55AM +0800, Feng Tang wrote:
> On Mon, Apr 26, 2021 at 11:26:52AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 26, 2021 at 11:36:05PM +0800, Feng Tang wrote:
> > > On Mon, Apr 26, 2021 at 08:25:29AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Apr 26, 2021 at 11:01:27PM +0800, Feng Tang wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On Sun, Apr 25, 2021 at 03:47:07PM -0700, Paul E. McKenney wrote:
> > > > > > Because the x86 tsc_early clocksource is given a quick and semi-accurate
> > > > > > calibration (by design!), it might have drift rates well in excess of
> > > > > > the 0.1% limit that is in the process of being adopted.
> > > > > > 
> > > > > > Therefore, add a max_drift field to the clocksource structure that, when
> > > > > > non-zero, specifies the maximum allowable drift rate in nanoseconds over
> > > > > > a half-second period.  The tsc_early clocksource initializes this to five
> > > > > > miliseconds, which corresponds to the 1% drift rate limit suggested by
> > > > > > Xing Zhengjun.  This max_drift field is intended only for early boot,
> > > > > > so clocksource_watchdog() splats if it encounters a non-zero value in
> > > > > > this field more than 60 seconds after boot, inspired by a suggestion by
> > > > > > Thomas Gleixner.
> > > > > > 
> > > > > > This was tested by setting the clocksource_tsc ->max_drift field to 1,
> > > > > > which, as expected, resulted in a clock-skew event.
> > > > > 
> > > > > We've run the same last for this v10, and those 'unstable' thing [1] can
> > > > > not be reproduced!
> > > > 
> > > > Good to hear!  ;-)
> > > > 
> > > > > We've reported one case that tsc can be wrongly judged as 'unstable'
> > > > > by 'refined-jiffies' watchdog [1], while reducing the threshold could
> > > > > make it easier to be triggered.
> > > > > 
> > > > > It could be reproduced on the a plaform with a 115200 serial console,
> > > > > and hpet been disabled (several x86 platforms has this), add 
> > > > > 'initcall_debug' cmdline parameter to get more debug message, we can
> > > > > see:
> > > > > 
> > > > > [    1.134197] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> > > > > [    1.134214] clocksource:                       'refined-jiffies' wd_nesc: 500000000 wd_now: ffff8b35 wd_last: ffff8b03 mask: ffffffff
> > > > > [    1.134217] clocksource:                       'tsc-early' cs_nsec: 507537855 cs_now: 4e63c9d09 cs_last: 4bebd81f5 mask: ffffffffffffffff
> > > > > [    1.134220] clocksource:                       No current clocksource.
> > > > > [    1.134222] tsc: Marking TSC unstable due to clocksource watchdog
> > > > 
> > > > Just to make sure I understand: "could be reproduced" as in this is the
> > > > result from v9, and v10 avoids this, correct?
> > > 
> > > Sorry I didn't make it clear. This is a rarely happened case, and can
> > > be reproduced with upstream kerenl, which has 62.5 ms threshold. 6/7 &
> > > 7/7 patch of reducing the threshold can make it easier to be triggered.
> > 
> > Ah, OK, so this could be considered to be a benefit of this series, then.
> > 
> > Does this happen only for tsc-early, or for tsc as well?
> > 
> > Has it already been triggered on v10 of this series?  (I understand that
> > it certainly should be easier to trigger, just curious whether this has
> > already happened.)
> 
> Yes, it has. The upper log is from v10 (actually it's the 'dev' branch
> of your linux-rcu git, which I didn't find obvious difference) on a
> client platform 
> 
>  [    1.134214] clocksource:    'refined-jiffies' wd_nesc: 500000000 wd_now: ffff8b35 wd_last: ffff8b03 mask: ffffffff
>  [    1.134217] clocksource:    'tsc-early' cs_nsec: 507537855 cs_now: 4e63c9d09 cs_last: 4bebd81f5 mask: ffffffffffffffff
> 
> The deviation is 7537855 ns (7.5 ms). And as said before, it needs many
> pre-conditions to be triggered.
> 
> Also I found the debug patch is useful, which prints out the direct
> nanoseconds info when 'unstable' is detected.

Looks good to me!

If you give me a Signed-off-by, I would be happy to queue it.

							Thanx, Paul

> kernel/time/clocksource.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index a374cf7b6336..5370f0c84981 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -443,10 +443,10 @@ static void clocksource_watchdog(struct timer_list *unused)
>  		if (abs(cs_nsec - wd_nsec) > md) {
>  			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
>  				smp_processor_id(), cs->name);
> -			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
> -				watchdog->name, wdnow, wdlast, watchdog->mask);
> -			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
> -				cs->name, csnow, cslast, cs->mask);
> +			pr_warn("                      '%s' wd_nesc: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
> +				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
> +			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
> +				cs->name, cs_nsec, csnow, cslast, cs->mask);
>  			if (curr_clocksource == cs)
>  				pr_warn("                      '%s' is current clocksource.\n", cs->name);
>  			else if (curr_clocksource)
> -- 
> 2.27.0
> 
> Thanks,
> Feng
> 
> 
> 
> > 
> > 							Thanx, Paul
