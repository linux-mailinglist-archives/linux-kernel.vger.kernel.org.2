Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC11244CE19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhKKAHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234339AbhKKAHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:07:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93A2D61105;
        Thu, 11 Nov 2021 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636589054;
        bh=VbwJff2ix6rHkK73bDpQue47690xvnlowivXigHSQBA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Bhzk8Hg02W5B9ULNm5HJ6mYlw8DjPWN6oyCTYq9wbO9d8WwpCpUwgDvLGpZuJmQ/m
         F6aR6IKpNFU4i3+bfJTKHP6m5uLBe8uGgk16jzVZb+BJq9GozPTffwERUNpCuw0GOM
         Oxy6MCxQ38Zuk9xj/KDtxz9XDW29zo5fYhrtJ6nzuewd2l4JdJCyjV3R834Hg9oZsy
         FfOeeSPJ6G1stCwH4vkY18MgMy15Vv6VpkkGl4Fn7sKFfcLplNuksybm5LQjpwKVzr
         IN6CYE4CoMTc43WEQFWU71pTUDEBV+Kx/rNqJmwomOHhaXtk8MsCuZfNg/mrvjBWap
         VW7NTglKQYHUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 61A605C0A70; Wed, 10 Nov 2021 16:04:14 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:04:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211111000414.GH641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211110221732.272986-1-longman@redhat.com>
 <20211110223250.GG641268@paulmck-ThinkPad-P17-Gen-1>
 <1f43bfad-434f-88d5-b794-4cf1116e9924@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f43bfad-434f-88d5-b794-4cf1116e9924@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 06:25:14PM -0500, Waiman Long wrote:
> 
> On 11/10/21 17:32, Paul E. McKenney wrote:
> > On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
> > > It was found that when an x86 system was being stressed by running
> > > various different benchmark suites, the clocksource watchdog might
> > > occasionally mark TSC as unstable and fall back to hpet which will
> > > have a signficant impact on system performance.
> > > 
> > > The current watchdog clocksource skew threshold of 50us is found to be
> > > insufficient. So it is changed back to 100us before commit 2e27e793e280
> > > ("clocksource: Reduce clocksource-skew threshold") in patch 1. Patch 2
> > > adds a Kconfig option to allow kernel builder to control the actual
> > > threshold to be used.
> > > 
> > > Waiman Long (2):
> > >    clocksource: Avoid accidental unstable marking of clocksources
> > >    clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
> > The ability to control the fine-grained threshold seems useful, but is
> > the TSC still marked unstable when this commit from -rcu is applied?
> > It has passed significant testing on other workloads.
> > 
> > 2a43fb0479aa ("clocksource: Forgive repeated long-latency watchdog clocksource reads")
> > 
> > If the patch below takes care of your situation, my thought is to
> > also take your second patch, which would allow people to set the
> > cutoff more loosely or more tightly, as their situation dictates.
> > 
> > Thoughts?
> 
> That is commit 14dbb29eda51 ("clocksource: Forgive repeated long-latency
> watchdog clocksource reads") in your linux-rcu git tree. From reading the
> patch, I believe it should be able to address the hpet fallback problem that
> Red Hat had encountered. Your patch said it was an out-of-tree patch. Are
> you planning to mainline it?

Yes, I expect to submit it into the next merge window (not the current
v5.16 merge window, but v5.17).  However, if your situation is urgent, and
if it works for you, I could submit it as a fix for an earlier regression.

> Patch 1 of this series contains some testing data that caused hpet fallback
> in our testing runs. In summary, a clock skew of 100us is found to be enough
> to avoid the problem with benchmark runs. However, we have some cases where
> TSC was marked unstable at bootup time with a skew of 200us or more which, I
> believe, was caused by the thermal stress that the system was experiencing
> after running stressful benchmarks for hours.

This sort of thing does show some value for allowing the threshold to
be adjusted.  I hope that it does not prove necessary to dynamically
adjust the threshold based on CPU clock frequency, but you never know.

> At the end, we have to revert your clocksource patches before shipping RHEL9
> beta last week.

Which has the disadvantage of leaving the initial clock-skew issues,
but I do understand that introducing one problem even while fixing
another one still counts as a regression.

							Thanx, Paul
