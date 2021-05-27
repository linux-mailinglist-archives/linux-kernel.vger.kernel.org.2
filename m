Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9088C3937BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 23:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhE0VG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 17:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233788AbhE0VG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 17:06:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E8A4613E3;
        Thu, 27 May 2021 21:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622149524;
        bh=usTkYUDMMgRLdDdQrjUeWJsC5bIfE442l+uBD1FDr1g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VLIMbVJsyqy5YGjl8qDmNMxdr1ATAL1r6WsSQmjjcVj+dBMkew+wV94lTdL2HxB4v
         QSvry6tjjJjeDJ3vw3kujsAC83M60yt9G45NGzyPk8RQZeJi00ZOHRSEmsoi/sM4LI
         Zs59P7WujpyFz379uIrEnPbnnPlTbjDQOIz5G8q30R9yhpyRQcrJtkt+ioCu9VpHU1
         ED2genEOurwDsXL9gglF9yK4GJkF3meMx/lp6LXhGwNLlWO1B2FpWQrM167zVOBYEw
         8qETaypfuU1OtOd1ZntWEXSXJcC3pqL/vg8xU03EPXz/LCOGibJjhNcf3l+fRae5+7
         Y0gevS/QT/fbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3C9C45C032C; Thu, 27 May 2021 14:05:24 -0700 (PDT)
Date:   Thu, 27 May 2021 14:05:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [clocksource] 8901ecc231: stress-ng.lockbus.ops_per_sec -9.5%
 regression
Message-ID: <20210527210524.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <138f81df-08e1-f96e-1915-c58b44f96a41@linux.intel.com>
 <20210527191923.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <YK/zHMPSZSKrmXC6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK/zHMPSZSKrmXC6@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:29:32PM +0100, Matthew Wilcox wrote:
> On Thu, May 27, 2021 at 12:19:23PM -0700, Paul E. McKenney wrote:
> > On Thu, May 27, 2021 at 12:01:23PM -0700, Andi Kleen wrote:
> > > 
> > > >      Nevertheless, it is quite possible that real-world use will result in
> > > >      some situation requiring that high-stress workloads run on hardware
> > > >      not designed to accommodate them, and also requiring that the kernel
> > > >      refrain from marking clocksources unstable.
> > > >      Therefore, provide an out-of-tree patch that reacts to this situation
> > > 
> > > out-of-tree means it will not be submitted?
> > > 
> > > I think it would make sense upstream, but perhaps guarded with some option.
> > 
> > The reason I do not intend to immediately upstream this patch is that
> > it increases the probability that a real clocksource read-latency issue
> > will be ignored, for example, during hardware bringup.  Furthermore,
> > the only known need from it comes from hardware that is, in the words
> > of the stress-ng man page, "poorly designed".  And the timing of this
> > email thread leads me to believe that such hardware is not easy to obtain.
> 
> I think you're placing a little too much weight on the documentation
> here.  It seems that a continuous stream of locked operations executed
> in userspace on a single CPU can cause this problem to occur.  If that's
> true all the way out to one guest in a hypervisor can cause problems
> for the hypervisor itself, I think cloud providers everywhere are
> going to want this patch?

Only those cloud provides making heavy use of the aforementioned "poorly
designed" hardware, correct?

							Thanx, Paul

> > My thought is therefore to keep this patch out of tree for now.
> > If it becomes clear that long-latency clocksource reads really are
> > a significant issue in their own right (as opposed to merely being a
> > symptom of a hardware or firmware bug), then this patch is available to
> > immediately respond to that issue.
> > 
> > And there would then be strong evidence in favor of me biting the bullet,
> > adding the complexity and the additional option (with your Suggested-by),
> > and getting that upstream and into -stable.
> > 
> > Seem reasonable?
> > 
> > 							Thanx, Paul
> > 
