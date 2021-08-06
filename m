Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4D83E225C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbhHFEPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 00:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhHFEPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 00:15:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DD9860EBC;
        Fri,  6 Aug 2021 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628223303;
        bh=iOjc/0/HUU3pEtEtet4Pzyq7t3h6ygOVDXTBFLZaatg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hvzWNnPqmGH4WsnZwgRgRIkOvZyglo8QxliWthkiCx+bdBcFZDgMFPebLtOGOdcUn
         sh6hZbTT8E2TaLPqByA9yx2KTleUDf7pBdsamhqMU+Cgq/Pc5FvFXy2nvEbjEuoiDE
         msWOxH1A6b9Cv/sbhMB/P11HW6E8Ve1DKaczfXdk1yzaZC7u8z6GijYQuqPqcUR6b5
         +ULCULAC6vCuXeJFQQjk0DMrGStaksRv8yfzXV8CM66qxEpOWKGL8anFVaPtg3CvUU
         SAFGpEPCk9XfYAXbCHy2+bcALpeQ1XDXRrbRWDDOfPYtV3MLK47iB5JMSOgK97/Ti/
         6yZlRRYao97Jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2239A5C1722; Thu,  5 Aug 2021 21:15:03 -0700 (PDT)
Date:   Thu, 5 Aug 2021 21:15:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [clocksource]  8901ecc231:  stress-ng.lockbus.ops_per_sec -9.5%
 regression
Message-ID: <20210806041503.GO4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
 <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805021646.GA11629@gao-cwp>
 <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805053938.GA12593@gao-cwp>
 <20210805153727.GG4397@paulmck-ThinkPad-P17-Gen-1>
 <20210806020958.GA18104@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806020958.GA18104@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:10:00AM +0800, Chao Gao wrote:
> On Thu, Aug 05, 2021 at 08:37:27AM -0700, Paul E. McKenney wrote:
> >On Thu, Aug 05, 2021 at 01:39:40PM +0800, Chao Gao wrote:
> >> [snip]
> >> >> This patch works well; no false-positive (marking TSC unstable) in a
> >> >> 10hr stress test.
> >> >
> >> >Very good, thank you!  May I add your Tested-by?
> >> 
> >> sure.
> >> Tested-by: Chao Gao <chao.gao@intel.com>
> >
> >Very good, thank you!  I will apply this on the next rebase.
> >
> >> >I expect that I will need to modify the patch a bit more to check for
> >> >a system where it is -never- able to get a good fine-grained read from
> >> >the clock.
> >> 
> >> Agreed.
> >> 
> >> >And it might be that your test run ended up in that state.
> >> 
> >> Not that case judging from kernel logs. Coarse-grained check happened 6475
> >> times in 43k seconds (by grep "coarse-grained skew check" in kernel logs).
> >> So, still many checks were fine-grained.
> >
> >Whew!  ;-)
> >
> >So about once per 13 clocksource watchdog checks.
> >
> >To Andi's point, do you have enough information in your console log to
> >work out the longest run of course-grained clocksource checks?
> 
> Yes. 5 consecutive course-grained clocksource checks. Note that
> considering the reinitialization after course-grained check, in my
> calculation, two course-grained checks are considered consecutive if
> they happens in 1s(+/- 0.3s).

Very good, thank you!

So it seems eminently reasonable to have the clocksource watchdog complain
bitterly for more than (say) 100 consecutive course-grained checks.

I am thinking in terms of a separate patch for this purpose.

Thoughts?

							Thanx, Paul
