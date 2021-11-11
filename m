Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B24E44D034
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 04:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKKDKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 22:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhKKDKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:10:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAD076112F;
        Thu, 11 Nov 2021 03:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636600041;
        bh=mQhFTBGbLJvZk4aneeZo3nYuPTxKnHK3hBctQD8Jk6g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=McX/LLlYGAF2yEEWQWXOj4zmrb7YDqm6jazqMbmfXCFidJ9Mr4DDA+jTdsiJNjK49
         5u2X5SuXqVwXB6PPEpEuzfuWxafnQxC8+rzvfexqEgYyKhk3SQg+kett3awkYZcYve
         TvA6qfm6OOkIRfqpfJJ/H0/U9TI4WPHhoxcR1wUKB3k5VSqf3io1fBHPEgVm7JY0NN
         sycW+/r7ijK7RsxN/uTfWWP+9bFxOwbtkvzqHghT5jA0Y5vhRdMDk7L0yn8OxQdQ1k
         xPuM33uUabae3O92FwF6Mf6ZiUVxu9NxcmRL9z67hcN0bGvjTmNSX8HRg21Bi3rXox
         qmvWCrx18oC5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A30F95C0A70; Wed, 10 Nov 2021 19:07:21 -0800 (PST)
Date:   Wed, 10 Nov 2021 19:07:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211111030721.GJ641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211110221732.272986-1-longman@redhat.com>
 <20211111012301.GA15663@shbuild999.sh.intel.com>
 <551c33a1-25d0-a840-f26b-238bee51d4ec@redhat.com>
 <20211111015331.GA15724@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111015331.GA15724@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 09:53:31AM +0800, Feng Tang wrote:
> On Wed, Nov 10, 2021 at 08:30:10PM -0500, Waiman Long wrote:
> > 
> > On 11/10/21 20:23, Feng Tang wrote:
> > > Hi Waiman, Paul,
> > > 
> > > On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
> > > > It was found that when an x86 system was being stressed by running
> > > > various different benchmark suites, the clocksource watchdog might
> > > > occasionally mark TSC as unstable and fall back to hpet which will
> > > > have a signficant impact on system performance.
> > > We've seen similar cases while running 'netperf' and 'lockbus/ioport'
> > > cases of 'stress-ng' tool.
> > > 
> > > In those scenarios, the clocksource used by kernel is tsc, while
> > > hpet is used as watchdog. And when the "screwing" happens, we found
> > > mostly it's the hpet's 'fault', that when system is under extreme
> > > pressure, the read of hpet could take a long time, and even 2
> > > consecutive read of hpet will have a big gap (up to 1ms+) in between.
> > > So the screw we saw is actually caused by hpet instead of tsc, as
> > > tsc read is a lightweight cpu operation
> > > 
> > > I tried the following patch to detect the screw of watchdog itself,
> > > and avoid wrongly judging the tsc to be unstable. It does help in
> > > our tests, please help to review.
> > > 
> > > And one futher idea is to also adding 2 consecutive read of current
> > > clocksource, and compare its gap with watchdog's, and skip the check
> > > if the watchdog's is bigger.
> > 
> > That is what I found too. And I also did a 2nd watchdog read to compare the
> > consecutive delay versus half the threshold and skip the test if it exceeds
> > it. My patch is actually similar in concept to what your patch does.
>  
> Aha, yes, I missed that.
> 
> I just got to office, and saw the disucssion around 0/2 patch and replied,
> without going through the patches, sorry about that.
> 
> 0day reported some cases about stress-ng testing, and we are still testing
> differenct cases we've seen.

Whichever way it happens, I agree that an extra read to correctly
attribute the latency could be very effective!  Good on you both!

							Thanx, Paul
