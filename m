Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349023E1826
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbhHEPho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242000AbhHEPhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D6A160E78;
        Thu,  5 Aug 2021 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628177847;
        bh=KJFGnAesTb/YE5RvbTnTHSc1LxNKuUkzXiyHn6mZRFA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gsNqgUPG9mDnGruEjlLobzw0dmjBqaDui9bCFV1mRJ2JldTKHUIMRUgOBKjZVU77m
         F+PrkYW0EPUa0OYfnskR/SobY3vnm1x2L6QNuS9RoC4Kydg6kZUlDxia6f20YjO8Ri
         YG1IFmzJJSX0HxSrFri+rk9DxJwSjMzAiI9kY0Kwd4kcxzYJ3Nmh1wHu+qvzgadO3w
         RVRhrKs/3TdC3dLe2j8sfM50nZATU3Z4aoZcdqd/YYz3OijkbBcv+mKOR9xsHcMev7
         Qt4e0ZjrkMn3lerUTKaRhfWgHQMgF84ovnymlzRH9QZOp8+LS2rsPznx00StJv2i7Y
         lHjozz1FU7GzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 679E35C098A; Thu,  5 Aug 2021 08:37:27 -0700 (PDT)
Date:   Thu, 5 Aug 2021 08:37:27 -0700
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
Message-ID: <20210805153727.GG4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
 <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805021646.GA11629@gao-cwp>
 <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805053938.GA12593@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805053938.GA12593@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 01:39:40PM +0800, Chao Gao wrote:
> [snip]
> >> This patch works well; no false-positive (marking TSC unstable) in a
> >> 10hr stress test.
> >
> >Very good, thank you!  May I add your Tested-by?
> 
> sure.
> Tested-by: Chao Gao <chao.gao@intel.com>

Very good, thank you!  I will apply this on the next rebase.

> >I expect that I will need to modify the patch a bit more to check for
> >a system where it is -never- able to get a good fine-grained read from
> >the clock.
> 
> Agreed.
> 
> >And it might be that your test run ended up in that state.
> 
> Not that case judging from kernel logs. Coarse-grained check happened 6475
> times in 43k seconds (by grep "coarse-grained skew check" in kernel logs).
> So, still many checks were fine-grained.

Whew!  ;-)

So about once per 13 clocksource watchdog checks.

To Andi's point, do you have enough information in your console log to
work out the longest run of course-grained clocksource checks?

> >My current thought is that if more than (say) 100 consecutive attempts
> >to read the clocksource get hit with excessive delays, it is time to at
> >least do a WARN_ON(), and maybe also time to disable the clocksource
> >due to skew.  The reason is that if reading the clocksource -always-
> >sees excessive delays, perhaps the clock driver or hardware is to blame.
> >
> >Thoughts?
> 
> It makes sense to me.

Sounds good!

							Thanx, Paul
