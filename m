Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EB44CF48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhKKB4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:56:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:35719 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhKKB4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:56:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230291758"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="230291758"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:53:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="670079226"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2021 17:53:31 -0800
Date:   Thu, 11 Nov 2021 09:53:31 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211111015331.GA15724@shbuild999.sh.intel.com>
References: <20211110221732.272986-1-longman@redhat.com>
 <20211111012301.GA15663@shbuild999.sh.intel.com>
 <551c33a1-25d0-a840-f26b-238bee51d4ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551c33a1-25d0-a840-f26b-238bee51d4ec@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 08:30:10PM -0500, Waiman Long wrote:
> 
> On 11/10/21 20:23, Feng Tang wrote:
> > Hi Waiman, Paul,
> > 
> > On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
> > > It was found that when an x86 system was being stressed by running
> > > various different benchmark suites, the clocksource watchdog might
> > > occasionally mark TSC as unstable and fall back to hpet which will
> > > have a signficant impact on system performance.
> > We've seen similar cases while running 'netperf' and 'lockbus/ioport'
> > cases of 'stress-ng' tool.
> > 
> > In those scenarios, the clocksource used by kernel is tsc, while
> > hpet is used as watchdog. And when the "screwing" happens, we found
> > mostly it's the hpet's 'fault', that when system is under extreme
> > pressure, the read of hpet could take a long time, and even 2
> > consecutive read of hpet will have a big gap (up to 1ms+) in between.
> > So the screw we saw is actually caused by hpet instead of tsc, as
> > tsc read is a lightweight cpu operation
> > 
> > I tried the following patch to detect the screw of watchdog itself,
> > and avoid wrongly judging the tsc to be unstable. It does help in
> > our tests, please help to review.
> > 
> > And one futher idea is to also adding 2 consecutive read of current
> > clocksource, and compare its gap with watchdog's, and skip the check
> > if the watchdog's is bigger.
> 
> That is what I found too. And I also did a 2nd watchdog read to compare the
> consecutive delay versus half the threshold and skip the test if it exceeds
> it. My patch is actually similar in concept to what your patch does.
 
Aha, yes, I missed that.

I just got to office, and saw the disucssion around 0/2 patch and replied,
without going through the patches, sorry about that.

0day reported some cases about stress-ng testing, and we are still testing
differenct cases we've seen.

Thanks,
Feng

> Cheers,
> Longman
