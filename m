Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C436B8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhDZS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233842AbhDZS1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B10661164;
        Mon, 26 Apr 2021 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619461613;
        bh=L9UA7FVEIduqR9ypDh7kLwmWnB+xYgumIc8eA/tIxEw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CXWczh6voQNTJqoWnOeaLH8xQNl6J0BsKLZNmGyDGzKrbaEstetXzyw/iFG2qgtCn
         3MHAL16V0KjIYURwdLVgQuge8K8gpjCwcvZiolIQKFWujXdJouidHiFfF3cZ4thf1i
         htYJlO2GuefdRfZoPGMNeuwbMMTkSJHCtXWDGLBNyEMtaL296zhZn5wAFtlz9Bi/rq
         yWdoI0h+u0QeRqRnDepw5h8mJlMfXJpg0ULNtxJCFwMzF7UrrMcLObozjcFWk8MQOB
         RO+k5MbAX3yfkIIaSLIu8hK3WamHD/CF2S/tWmTNYZwvCLZ3XwL9p5z80Rix53SZdG
         SvlXyXSrVt+Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2A015C06D0; Mon, 26 Apr 2021 11:26:52 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:26:52 -0700
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
Message-ID: <20210426182652.GE975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-6-paulmck@kernel.org>
 <20210426150127.GB23119@shbuild999.sh.intel.com>
 <20210426152529.GX975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426153605.GB89018@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426153605.GB89018@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:36:05PM +0800, Feng Tang wrote:
> On Mon, Apr 26, 2021 at 08:25:29AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 26, 2021 at 11:01:27PM +0800, Feng Tang wrote:
> > > Hi Paul,
> > > 
> > > On Sun, Apr 25, 2021 at 03:47:07PM -0700, Paul E. McKenney wrote:
> > > > Because the x86 tsc_early clocksource is given a quick and semi-accurate
> > > > calibration (by design!), it might have drift rates well in excess of
> > > > the 0.1% limit that is in the process of being adopted.
> > > > 
> > > > Therefore, add a max_drift field to the clocksource structure that, when
> > > > non-zero, specifies the maximum allowable drift rate in nanoseconds over
> > > > a half-second period.  The tsc_early clocksource initializes this to five
> > > > miliseconds, which corresponds to the 1% drift rate limit suggested by
> > > > Xing Zhengjun.  This max_drift field is intended only for early boot,
> > > > so clocksource_watchdog() splats if it encounters a non-zero value in
> > > > this field more than 60 seconds after boot, inspired by a suggestion by
> > > > Thomas Gleixner.
> > > > 
> > > > This was tested by setting the clocksource_tsc ->max_drift field to 1,
> > > > which, as expected, resulted in a clock-skew event.
> > > 
> > > We've run the same last for this v10, and those 'unstable' thing [1] can
> > > not be reproduced!
> > 
> > Good to hear!  ;-)
> > 
> > > We've reported one case that tsc can be wrongly judged as 'unstable'
> > > by 'refined-jiffies' watchdog [1], while reducing the threshold could
> > > make it easier to be triggered.
> > > 
> > > It could be reproduced on the a plaform with a 115200 serial console,
> > > and hpet been disabled (several x86 platforms has this), add 
> > > 'initcall_debug' cmdline parameter to get more debug message, we can
> > > see:
> > > 
> > > [    1.134197] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> > > [    1.134214] clocksource:                       'refined-jiffies' wd_nesc: 500000000 wd_now: ffff8b35 wd_last: ffff8b03 mask: ffffffff
> > > [    1.134217] clocksource:                       'tsc-early' cs_nsec: 507537855 cs_now: 4e63c9d09 cs_last: 4bebd81f5 mask: ffffffffffffffff
> > > [    1.134220] clocksource:                       No current clocksource.
> > > [    1.134222] tsc: Marking TSC unstable due to clocksource watchdog
> > 
> > Just to make sure I understand: "could be reproduced" as in this is the
> > result from v9, and v10 avoids this, correct?
> 
> Sorry I didn't make it clear. This is a rarely happened case, and can
> be reproduced with upstream kerenl, which has 62.5 ms threshold. 6/7 &
> 7/7 patch of reducing the threshold can make it easier to be triggered.

Ah, OK, so this could be considered to be a benefit of this series, then.

Does this happen only for tsc-early, or for tsc as well?

Has it already been triggered on v10 of this series?  (I understand that
it certainly should be easier to trigger, just curious whether this has
already happened.)

							Thanx, Paul
