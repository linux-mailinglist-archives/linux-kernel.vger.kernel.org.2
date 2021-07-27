Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC033D70BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhG0IBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:01:12 -0400
Received: from david.siemens.de ([192.35.17.14]:52299 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbhG0IBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:01:11 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 16R80LnR028664
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 10:00:22 +0200
Received: from md1za8fc.ad001.siemens.net ([167.87.2.134])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 16R80Jbi010200;
        Tue, 27 Jul 2021 10:00:19 +0200
Date:   Tue, 27 Jul 2021 10:00:18 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, xenomai@xenomai.org
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20210727100018.19d61165@md1za8fc.ad001.siemens.net>
In-Reply-To: <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
References: <20190727164450.GA11726@roeck-us.net>
        <20190729093545.GV31381@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
        <20190729101349.GX31381@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
        <20190729104745.GA31398@hirez.programming.kicks-ass.net>
        <20190729205059.GA1127@roeck-us.net>
        <alpine.DEB.2.21.1908161217380.1873@nanos.tec.linutronix.de>
        <20190816193208.GA29478@roeck-us.net>
        <alpine.DEB.2.21.1908172219470.1923@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was this ever resolved and if so can someone please point me to the
patches? I started digging a bit but could not yet find how that
continued.

I am seeing similar or maybe the same problem on 4.19.192 with the
ipipe patch from the xenomai project applied.

regards,
Henning

Am Sat, 17 Aug 2019 22:21:48 +0200
schrieb Thomas Gleixner <tglx@linutronix.de>:

> On Fri, 16 Aug 2019, Guenter Roeck wrote:
> > On Fri, Aug 16, 2019 at 12:22:22PM +0200, Thomas Gleixner wrote:  
> > > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > > index 75fea0d48c0e..625627b1457c 100644
> > > --- a/arch/x86/kernel/process.c
> > > +++ b/arch/x86/kernel/process.c
> > > @@ -601,6 +601,7 @@ void stop_this_cpu(void *dummy)
> > >  	/*
> > >  	 * Remove this CPU:
> > >  	 */
> > > +	set_cpu_active(smp_processor_id(), false);
> > >  	set_cpu_online(smp_processor_id(), false);
> > >  	disable_local_APIC();
> > >  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
> > >   
> > No luck. The problem is still seen with this patch applied on top of
> > the mainline kernel (commit a69e90512d9def6).  
> 
> Yeah, was a bit too naive ....
> 
> We actually need to do the full cpuhotplug dance for a regular
> reboot. In the panic case, there is nothing we can do about. I'll
> have a look tomorrow.
> 
> Thanks,
> 
> 	tglx

