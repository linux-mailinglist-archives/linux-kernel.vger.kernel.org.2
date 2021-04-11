Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7535B635
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhDKQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 12:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235338AbhDKQug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 12:50:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C762460FE5;
        Sun, 11 Apr 2021 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618159819;
        bh=1Ci5YxD42EKGi80rC43qOW2PFb5jDJWWyWqsYef//xQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oUt/lg+CyZ0KttvB8DND1zcIEeZQhMAk4e4YFMYngwX6AcivHpT+kQRmX5ze16dIb
         4C+kpWzPdsbz3lAOICpuJq0EjHFGryrrBM/8lzWDE+H+YdLvQ+Svi4Lmj3YhrXt/Tu
         pfE7XKS0d5eahfpgMnGdRWEomrBuG067Gj55lJRSNiEujphAX/5iBvMJFdDvRfUvbM
         OqyS3CX4L7HXSSsqvg2FeIi4rx3/ncvJdvoVQv0PG+AorE5nMO0/aKIi93aQCpuPnE
         eSaJ9bANGIm0WQPTze+y2A+xTcXWBwAMB4Wsag2Hib9mO9fUEBvAlQdanTiVcjCal8
         iLpn3wiXQKalw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9AF685C0A23; Sun, 11 Apr 2021 09:50:19 -0700 (PDT)
Date:   Sun, 11 Apr 2021 09:50:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource] Do not mark clocks unstable due to delays
 for v5.13
Message-ID: <20210411165019.GA4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402202929.GA22273@paulmck-ThinkPad-P72>
 <20210402203137.22479-1-paulmck@kernel.org>
 <87pmzc498v.ffs@nanos.tec.linutronix.de>
 <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <87im4u4lft.ffs@nanos.tec.linutronix.de>
 <20210410232644.GT4510@paulmck-ThinkPad-P17-Gen-1>
 <875z0t2ilk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z0t2ilk.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 12:58:31PM +0200, Thomas Gleixner wrote:
> On Sat, Apr 10 2021 at 16:26, Paul E. McKenney wrote:
> > On Sat, Apr 10, 2021 at 10:01:58AM +0200, Thomas Gleixner wrote:
> >> On Fri, Apr 02 2021 at 15:48, Paul E. McKenney wrote:
> >> I buy the vCPU preemption part and TBH guests should not have that
> >> watchdog thing active at all for exactly this reason.
> >
> > Agreed, one approch is to enable the the clocksource watchdog only in
> > the hypervisor, and have some action on the guests triggered when the
> > host detects clock skew.
> >
> > This works quite well, at least until something breaks in a way that
> > messes up clock reads from the guest but not from the host.  And I
> > am sure that any number of hardware guys will tell me that this just
> > isn't possible, but if failing hardware operated according to their
> > expectations, that hardware wouldn't be considered to be failing.
> > Or it wouldn't be hardware, firmware, or clock-driver bringup, as the
> > case may be.
> 
> Don't tell me. The fact that this code exists at all is a horror on it's
> own.

Let's just say that really I did consider the option of just disabling
the watchdog for guest OSes, but it will likely be at least a few years
before per-CPU hardware clocks regain my trust.  :-/

> >> SMI, NMI injecting 62.5ms delay? If that happens then the performance of
> >> the clocksource is the least of your worries.
> >
> > I was kind of hoping that you would tell me why the skew must be all the
> > way up to 62.5ms before the clock is disabled.  The watchdog currently
> > is quite happy with more than 10% skew between clocks.
> >
> > 100HZ clocks or some such?
> 
> Histerical raisins. When the clocksource watchdog was introduced it
> replaced a x86 specific validation which was jiffies based. I have faint
> memories that we wanted to have at least jiffies based checks preserved
> in absence of other hardware, which had other problems and we gave up on
> it. But obviously nobody thought about revisiting the threshold.
> 
> Yes, it's way too big. The slowest watchdog frequency on x86 is ~3.5 Mhz
> (ACPI PMtimer). Don't know about the reference frequency on MIPS which
> is the only other user of this.

Whew!  I will try reducing the permitted skew.  My (perhaps naive) guess
is that with the delay rejection, there is no reason that it cannot
be decreased at least to 500us.  If that goes well, I will send along
another patch.

							Thanx, Paul
