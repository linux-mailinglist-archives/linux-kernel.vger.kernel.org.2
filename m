Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6481838C968
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhEUOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236887AbhEUOpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC2C3610A8;
        Fri, 21 May 2021 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621608227;
        bh=6bQ7KdTLoxbGFwugW8N1T6l3fRz6GxN5ATVum7FMqmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AStz2MvbxCP8H/fJhVPa6+Mw38O/iRHjAdZk9I96XIAcrPFrQwqVNSwgG/Q91QThD
         znS37xhZ5YMMCQSX6K6l7JfCySEdZwef0QAfUX/aBM/PyOHtDrV3jVc/FtJEnrok3U
         rsH4Bx3btfQjqyrrGC3HnGAamv1GE3CNvRCM6A1ydxamVjNFUFlbzEyHGy/634I1xZ
         bruH6jiz/7tPrgPYhV16SfErqcoPsgfTYbtj+t/BJ3uEDTouUz6TqP+C+PIAblGXdG
         PS4Fw4l/HcSae6+GWXlw+gq/JrdXY96yHOcJEyEzFYS1bOJRyL7B4JMmaerDUHtKiX
         iMxInP3+9/J0g==
Date:   Fri, 21 May 2021 15:43:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH 3/5] tick/broadcast: Prefer per-cpu oneshot wakeup timers
 to broadcast
Message-ID: <20210521144342.GA12124@willie-the-truck>
References: <20210520184705.10845-1-will@kernel.org>
 <20210520184705.10845-4-will@kernel.org>
 <a269c869-b966-75d5-5fe1-6ed6921c1b83@nextfour.com>
 <20210521112503.GA11850@willie-the-truck>
 <87tumw9oy4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tumw9oy4.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:49:39PM +0200, Thomas Gleixner wrote:
> On Fri, May 21 2021 at 12:25, Will Deacon wrote:
> > On Fri, May 21, 2021 at 05:25:41AM +0300, Mika Penttilä wrote:
> >> On 20.5.2021 21.47, Will Deacon wrote:
> >> >   /*
> >> >    * Conditionally install/replace broadcast device
> >> >    */
> >> > -void tick_install_broadcast_device(struct clock_event_device *dev)
> >> > +void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
> >> >   {
> >> >   	struct clock_event_device *cur = tick_broadcast_device.evtdev;
> >> > +	if (tick_set_oneshot_wakeup_device(dev, cpu))
> >> > +		return;
> >> > +
> >> >   	if (!tick_check_broadcast_device(cur, dev))
> >> >   		return;
> >> 
> >> Does this disable hpet registering as a global broadcast device on x86 ? I
> >> think it starts with cpumask = cpu0 so it qualifies for a percpu wakeup
> >> timer.
> >
> > Well spotted, I think you're probably right. I'll try to reproduce on my
> > laptop to confirm, but I hadn't noticed the tricks played with the cpumask
> > on x86.
> >
> > I'll probably need to rework things so that we install the broadcast timer
> > first, but prefer global devices.
> 
> HPET has cpumask(0) but does not have CLOCK_EVT_FEAT_PERCPU set. The
> feature flag is a clear indicator for per cpu.

Thanks, that makes the logic much neater because that feature already causes
the device to be rejected as the broadcast so there's no need to worry about
considering a device for both broadcast and a local wakeup.

I'll post a v2 on Monday once I've tested it on my laptop (which is throwing
ext4 errors at the moment...)

Will
