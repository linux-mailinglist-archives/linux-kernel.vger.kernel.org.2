Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6552935B0C7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 01:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhDJX1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 19:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234874AbhDJX1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 19:27:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B360A6105A;
        Sat, 10 Apr 2021 23:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618097204;
        bh=lGO3IAAwtRwpC/tDhdwk61KHVYg0udt9ra021bdGs2M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WnCvlvXm6Y+Smp5u1r0CHmWSF5lcrUgz51OfPtWVxX5dUx8o6b9Nt0AklU5EJVJaw
         65tDog/Zd2kCN0znSKoebYNn1k9wbHIgM081WLmC4yMQN2kf8tsbrnN4jDQxNJvSjI
         U7VR4+gPELXwQMb/L2i0YodfkRwki5TbnYh1mPvjHDYjKVRvytOk7RHdUUOoyCdvJr
         WTbHihtzuNQoBkaNj6QQ5VjGsi7jnVwxRtIEk8n9Ffafj2bPmp/zN/wCZyNx9DwxeM
         8wdeSfQmeXwXWDvm2HUEBuyTyxE0TwGh7uFJ+Rr2GPMd6hfjWQ0IvZj1l7Zgc/9Mu/
         Wp+zkqsaxjI6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7DD0E5C0C5F; Sat, 10 Apr 2021 16:26:44 -0700 (PDT)
Date:   Sat, 10 Apr 2021 16:26:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource] Do not mark clocks unstable due to delays
 for v5.13
Message-ID: <20210410232644.GT4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402202929.GA22273@paulmck-ThinkPad-P72>
 <20210402203137.22479-1-paulmck@kernel.org>
 <87pmzc498v.ffs@nanos.tec.linutronix.de>
 <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <87im4u4lft.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im4u4lft.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 10:01:58AM +0200, Thomas Gleixner wrote:
> On Fri, Apr 02 2021 at 15:48, Paul E. McKenney wrote:
> > Hello!
> >
> > If there is a sufficient delay between reading the watchdog clock and the
> > clock under test, the clock under test will be marked unstable through no
> > fault of its own.  This series checks for this, doing limited retries
> > to get a good set of clock reads.  If the clock is marked unstable
> > and is marked as being per-CPU, cross-CPU synchronization is checked.
> > This series also provides delay injection, which may be enabled via
> > kernel boot parameters to test the checking for delays.
> >
> > Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
> > vCPU preemption.
> 
> I buy the vCPU preemption part and TBH guests should not have that
> watchdog thing active at all for exactly this reason.

Agreed, one approch is to enable the the clocksource watchdog only in
the hypervisor, and have some action on the guests triggered when the
host detects clock skew.

This works quite well, at least until something breaks in a way that
messes up clock reads from the guest but not from the host.  And I
am sure that any number of hardware guys will tell me that this just
isn't possible, but if failing hardware operated according to their
expectations, that hardware wouldn't be considered to be failing.
Or it wouldn't be hardware, firmware, or clock-driver bringup, as the
case may be.

> SMI, NMI injecting 62.5ms delay? If that happens then the performance of
> the clocksource is the least of your worries.

I was kind of hoping that you would tell me why the skew must be all the
way up to 62.5ms before the clock is disabled.  The watchdog currently
is quite happy with more than 10% skew between clocks.

100HZ clocks or some such?

							Thanx, Paul
