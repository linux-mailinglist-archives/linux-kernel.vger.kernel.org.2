Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7338C65B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEUMUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhEUMT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:19:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4CCB61132;
        Fri, 21 May 2021 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621599515;
        bh=KcngFT+HqIF4LaiGZA/Ukas74tflbqcyPQFr4P9o3DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTsE2E1FlxuGoEIdZFQfK6nFZ09pMXsK1+lDqeC+YKjS3QxSVu8zHOhjQwy5XALKm
         uYhvv3QRoriXJrMbbEOj6XcNYVSjA7qk5bc2dyCvCxMgm6BqV1/anpdctYb0I+ErPS
         buW0pfdo6MLWKDG+zt1lFUy1OFxgGMk1LV/BvhfxemJ7geDXhPv9fdKi45JH3NMvJ+
         0v6xUIoevnrpMJPMyFn5LPYKizUGGyhmZCjFAMb8/3K0KgpdXDPf74EHgXzLjQtwis
         o4xb7v4PCcVMcmRD+HBwwO2EDGBPCpXalFQTrNllwz/GiL7JAt8VcXH7eXjrbkCJtd
         3qFc1BkCIEFXA==
Date:   Fri, 21 May 2021 13:18:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH 3/5] tick/broadcast: Prefer per-cpu oneshot wakeup timers
 to broadcast
Message-ID: <20210521121830.GA11937@willie-the-truck>
References: <20210520184705.10845-1-will@kernel.org>
 <20210520184705.10845-4-will@kernel.org>
 <a269c869-b966-75d5-5fe1-6ed6921c1b83@nextfour.com>
 <20210521112503.GA11850@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521112503.GA11850@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 12:25:03PM +0100, Will Deacon wrote:
> On Fri, May 21, 2021 at 05:25:41AM +0300, Mika Penttilä wrote:
> > On 20.5.2021 21.47, Will Deacon wrote:
> > >   /*
> > >    * Conditionally install/replace broadcast device
> > >    */
> > > -void tick_install_broadcast_device(struct clock_event_device *dev)
> > > +void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
> > >   {
> > >   	struct clock_event_device *cur = tick_broadcast_device.evtdev;
> > > +	if (tick_set_oneshot_wakeup_device(dev, cpu))
> > > +		return;
> > > +
> > >   	if (!tick_check_broadcast_device(cur, dev))
> > >   		return;
> > 
> > Does this disable hpet registering as a global broadcast device on x86 ? I
> > think it starts with cpumask = cpu0 so it qualifies for a percpu wakeup
> > timer.
> 
> Well spotted, I think you're probably right. I'll try to reproduce on my
> laptop to confirm, but I hadn't noticed the tricks played with the cpumask
> on x86.
> 
> I'll probably need to rework things so that we install the broadcast timer
> first, but prefer global devices.

... and in doing that, I noticed my module refcounting is off as well so
I'll definitely be spinning a v2.

Will
