Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6147D454F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhKQV2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231834AbhKQV2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:28:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBE3661929;
        Wed, 17 Nov 2021 21:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637184347;
        bh=loXNOhaK0WJi0LoAdfM3Ag6FcSV9eSUMpqtv0lzNEOM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GKKg+R8Yg1Cg2RUeUnb1R2nH2pcO6rwAp3Qd7QpcBLpF4bw6bCfceI2BDQCTev8SA
         +NxLK/kdF/hEfzjUsqIe8H8L3MIDvhNOkT7DrE141GF8eTVKpQqeXQXR17LcmqD5JU
         JM33lp8a8dq9PX9P1FTYklkrghfWuWzpYKRK3X+qLaPhU6FVhJVyEVzqsViRIyWcgL
         o7zAvAnQvsetAETKMSpN9RVtawhCmX6jIsvwsWsfyMAxKSSVKM4wuQcE9zSO8SG3XN
         PrTiHOtQUfA3Z2PVm7OeL8Q8U9nELQU75Cix36v1Bb9A4sW7uqlip9jMOyqUYSJRzE
         svdEl6I/VcqpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9945F5C06BA; Wed, 17 Nov 2021 13:25:47 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:25:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 0/4] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211117212547.GO641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211116234426.837799-1-longman@redhat.com>
 <20211117165426.GG641268@paulmck-ThinkPad-P17-Gen-1>
 <7cb5ab62-21ea-f649-2009-38b8c1ff283a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb5ab62-21ea-f649-2009-38b8c1ff283a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 01:51:51PM -0500, Waiman Long wrote:
> On 11/17/21 11:54, Paul E. McKenney wrote:
> > On Tue, Nov 16, 2021 at 06:44:22PM -0500, Waiman Long wrote:
> > A few questions:
> > 
> > 1.	Once you have all the patches in place, is the increase in
> > 	WATCHDOG_MAX_SKEW from 50us to 100us necessary?
> 
> I think so. Using Feng's reproducer, I was able to cause a hpet-hpet delay
> of more than 90us on a 1-socket system. With a default 50us
> WATCHDOG_MAX_SKEW, the chance of a warning showing up will be much higher.
> Trying to minimize the chance that a warning may appear is my primary reason
> to increase WATCHDOG_MAX_SKEW.

Should we downgrade the "had to retry read" complain to pr_info(),
and make the only real warning be the case where a large number of
consecutive read attempts fail?  I believe that Heiner Kallweit was
looking for something like this.

> > 2.	The reason for having cs->uncertainty_margin set to
> > 	2*WATCHDOG_MAX_SKEW was to allow for worst-case skew from both
> > 	the previous and the current reading.  Are you sure that
> > 	dropping back to WATCHDOG_MAX_SKEW avoids false positives?
> 
> I can remove the hunk of changing cs->uncertainty_margin. It is critical for
> this patch.

Assuming "not critical", good!

> > 3.	In patch 3/4, shouldn't clock_skew_skip be a field in the
> > 	clocksource structure rather than a global?  If a system had
> > 	multiple clocks being checked, wouldn't having this as a field
> > 	make things more predictable?  Or am I missing something subtle
> > 	here?
> 
> Yes, you are right. I should have put it into clocksource structure. I will
> make the change in v3.

Sounds good!  Looking forward to v3!

> > 4.	These are intended to replace this commit in -rcu, correct?
> > 
> > 	9d5739316f36 ("clocksource: Forgive repeated long-latency watchdog clocksource reads")
> > 
> > 	But not this commit, correct?
> > 
> > 	5444fb39fd49 ("torture: Test splatting for delay-ridden clocksources")
>
> Yes, that is my intention.

Very good, thank you!

> > And would you like me to queue these, or would you rather send them
> > separately?  (Either way works for me, just please let me know.)
> 
> I don't have a preference either way. If you are willing to queue these, it
> will be great too.

Happy to do so!

							Thanx, Paul
