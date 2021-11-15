Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8F450645
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhKOOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhKOOKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:10:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE9C06044F;
        Mon, 15 Nov 2021 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636985229;
        bh=0Yc+9W2EMNKjs4GeEBcxZKlK1b20s82QAE2faGsmGvk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZPfqygKLGDNWpmFI5d30Ag2Y+2Qk5/y1qL9yfUkgjx9I7WQXmqfCSw3M9l5OL2ZjO
         dol6+bid8aPEE8BWe4qvLvU138E6zM62dwpi/VKhTPQSKizZZFn4IUeTiae8/W4nYL
         M4+b2IDVy6vrt3QDX8T4ONQxR54cqkxYuEY8XLklgmftrm8riScALhFoaACVAftoil
         77x92sAezxC1Krxcr9tXUtID2Ra+WP0ZWW3/8b99HtG4LBf8Gv1mNLmy7Hlg/9V8/n
         r7ViyHXhbIhNTNUGlES/+7plVGkbFZGSdiRe/TLyK0sUv8RdEJr2/ry1lmUnR+d3ev
         3jfeBmxsZA4ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 99AD25C065D; Mon, 15 Nov 2021 06:07:09 -0800 (PST)
Date:   Mon, 15 Nov 2021 06:07:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] clocksource: Avoid accidental unstable marking of
 clocksources
Message-ID: <20211115140709.GG641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211110221732.272986-1-longman@redhat.com>
 <20211110221732.272986-2-longman@redhat.com>
 <20211111045703.GA15896@shbuild999.sh.intel.com>
 <20211111144311.GK641268@paulmck-ThinkPad-P17-Gen-1>
 <20211112054417.GA29845@shbuild999.sh.intel.com>
 <889b16c6-b6cc-63d7-a6de-8cec42c7d78c@redhat.com>
 <20211114155407.GB641268@paulmck-ThinkPad-P17-Gen-1>
 <20211115020851.GB29845@shbuild999.sh.intel.com>
 <e2d300c4-cc0d-47c4-3e7d-8a1cc3546719@redhat.com>
 <20211115075915.GA34844@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115075915.GA34844@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:59:15PM +0800, Feng Tang wrote:
> On Sun, Nov 14, 2021 at 10:24:56PM -0500, Waiman Long wrote:
> > 
> > On 11/14/21 21:08, Feng Tang wrote:
> > > Or did you have something else in mind?
> > > > > > I'm not sure the detail in  Waiman's cases, and in our cases (stress-ng)
> > > > > > the delay between watchdog's (HPET here) read were not linear, that
> > > > > > from debug data, sometimes the 3-2 difference could be bigger or much
> > > > > > bigger than the 2-1 difference.
> > > > > > 
> > > > > > The reason could be the gap between 2 reads depends hugely on the system
> > > > > > pressure at that time that 3 HPET read happens. On our test box (a
> > > > > > 2-Socket Cascade Lake AP server), the 2-1 and 3-2 difference are stably
> > > > > > about 2.5 us,  while under the stress it could be bumped to from 6 us
> > > > > > to 2800 us.
> > > > > > 
> > > > > > So I think checking the 3-2 difference plus increasing the max retries
> > > > > > to 10 may be a simple way, if the watchdog read is found to be
> > > > > > abnormally long, we skip this round of check.
> > > > > On one of the test system, I had measured that normal delay
> > > > > (hpet->tsc->hpet) was normally a bit over 2us. It was a bit more than 4us at
> > > > > bootup time. However, the same system under stress could have a delay of
> > > > > over 200us at bootup time. When I measured the consecutive hpet delay, it
> > > > > was about 180us. So hpet read did dominate the total clocksource read delay.
> > > > Thank you both for the data!
> > > > 
> > > > > I would not suggest increasing the max retries as it may still fail in most
> > > > > cases because the system stress will likely not be going away within a short
> > > > > time. So we are likely just wasting cpu times. I believe we should just skip
> > > > > it if it is the watchdog read that is causing most of the delay.
> > > > If anything, adding that extra read would cause me to -reduce- the number
> > > > of retries to avoid increasing the per-watchdog overhead.
> > > I understand Waiman's concern here, and in our test patch, the 2
> > > consecutive watchdog read delay check is done inside this retrying
> > > loop accompanying the 'cs' read, and once an abnormal delay is found,
> > > the watchdog check is skipped without waiting for the max-retries to
> > > complete.
> > > 
> > > Our test data shows the consecutive delay is not always big even when
> > > the system is much stressed, that's why I suggest to increase the
> > > retries.
> > 
> > If we need a large number of retries to avoid triggering the unstable TSC
> > message, we should consider increase the threshod instead. Right?
> > 
> > That is why my patch 2 makes the max skew value a configurable option so
> > that we can tune it if necessary.
> 
> I'm fine with it, though the ideal case I expected is with carefully
> picked values for max_retries/screw_threshhold, we could save the users
> from configuring these. But given the complexity of all HWs out there,
> it's not an easy goal.

That is my goal as well, but I expect that more experience, testing,
and patches will be required to reach that goal.

> And I still suggest to put the consecutive watchdog read check inside
> the retry loop, so that it could bail out early when detecting the
> abnormal delay.

If the HPET read shows abnormal delay, agreed.  But if the abnormal
delay is only in the clocksource under test (TSC in this case), then
a re-read seems to me to make sense.

> Another thing is we may need to set the 'watchdog_reset_pending', as
> under the stress, there could be consecutive many times of "skipping"
> watchdog check, and the saved value of 'cs' and 'watchdog' should be
> reset.

My thought was to count a read failure only if the HPET read did not
have excessive delays.  This means that a cache-buster workload could 
indefinitely delay a clock-skew check, which was one reason that I
was thinking in terms of using the actual measured delays to set the
clock-skew check criterion.

Either way, something like Waiman's patch checking the HPET delay looks
to me to be valuable.

Thoughts?

							Thanx, Paul
