Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4636DEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbhD1Sc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232390AbhD1Sc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:32:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76E5361418;
        Wed, 28 Apr 2021 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619634702;
        bh=0Wm21LceUjTljj/ENED+DzPxqQXXE08eG6FFpKDL4aI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NJDTAfJLcQm4ytPxoDzdA4wNnmdDPw0hrGI8cD3LFBbdwTtnR/MEbLyK+0g1CCsEF
         SFFykNziKVSvScfSVnejE2l/ZKkQDGw22K6CVtug3DXoV6BWqeZPNq1ZmYMOhpTW+G
         Hp/AXK/3zoWEtH3oQ23WfrRaViB6YGxaKuXN6Ff6tPxlN1tiUah9pJNk5nIA6R4DwR
         khtTrbfG9/U0igm/JWvpPDDXxOqhHdKeofHcZMY7gjlC8GF78A2y26rHJFliOa7OCB
         oBkzF+KhJ/QuPGO+5ttpbBsZeUxGCm409ny6qd9ku8GR94klbntgU1EOVwSkxkSnwx
         OWIMw+kHC9csw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EFBDD5C00FE; Wed, 28 Apr 2021 11:31:41 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:31:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org, zhengjun.xing@intel.com
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210428183141.GS975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210427175027.GA945820@paulmck-ThinkPad-P17-Gen-1>
 <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <20210428014819.GA965980@paulmck-ThinkPad-P17-Gen-1>
 <87czuen2au.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czuen2au.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:14:49PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 27 2021 at 18:48, Paul E. McKenney wrote:
> > On Tue, Apr 27, 2021 at 11:09:49PM +0200, Thomas Gleixner wrote:
> >> Paul,
> >> 
> >> On Tue, Apr 27 2021 at 10:50, Paul E. McKenney wrote:
> >> > On Tue, Apr 27, 2021 at 06:37:46AM -0700, Paul E. McKenney wrote:
> >> >> I suppose that I give it (say) 120 seconds instead of the current 60,
> >> >> which might be the right thing to do, but it does feel like papering
> >> >> over a very real initramfs problem.  Alternatively, I could provide a
> >> >> boot parameter allowing those with slow systems to adjust as needed.
> >> >
> >> > OK, it turns out that there are systems for which boot times in excess
> >> > of one minute are expected behavior.  They are a bit rare, though.
> >> > So what I will do is keep the 60-second default, add a boot parameter,
> >> > and also add a comment by the warning pointing out the boot parameter.
> >> 
> >> Oh, no. This starts to become yet another duct tape horror show.
> >> 
> >> I'm not at all against a more robust and resilent watchdog mechanism,
> >> but having a dozen knobs to tune and heuristics which are doomed to fail
> >> is not a solution at all.
> >
> > One problem is that I did the .max_drift patch backwards.  I tightened
> > the skew requirements on all clocks except those specially marked, and
> > I should have done the reverse.  With that change, all of the clocks
> > except for clocksource_tsc would work (or as the case might be, fail to
> > work) in exactly the same way that they do today, but still rejecting
> > false-positive skew events due to NMIs, SMIs, vCPU preemption, and so on.
> >
> > Then patch v10 7/7 can go away completely, and patch 6/7 becomes much
> > smaller (and gets renamed), for example, as shown below.
> >
> > Does that help?
> 
> No. Because the problem is on both ends. We have TSC early which has
> inaccurate frequency and we have watchdogs which are inaccurate,
> i.e. refined jiffies.
> 
> So the threshold has to take both into account.

Got it, and will fix.

							Thanx, Paul
