Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBF36F328
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 02:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhD3AZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 20:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD3AZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 20:25:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF8A861433;
        Fri, 30 Apr 2021 00:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619742299;
        bh=En+FczNIwvLyCaIjOro7KVVQ1zy4lAiRsirNKCBYG2s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nSAS/DXBQ9SUXI9ju8j9Ny2q3Usx+T2UZ5jlssLAkRqw/7NAqKLKT8sry0fuEZSc3
         SB8yFGOjsqqA24JChpSiCGnuS7qYS6jGVQp22bpkzr3TPkK9y04VrEZyAvlqlAWgRo
         gsflzwRBlwV7KwDAlvt9rsnGaxtlkugeIisRJagP/XYfbkqdgVmlprfZL+3h0KwMBq
         DJ53BUiN2oIHJQ33qsvU7mM9GBgqOAxVBQR1b31Tk6vSoDP3fe44brYLP5eswqf3rj
         dCRp0vJ8J2qOf1zVRrv/OAI9N7x5+/6oeNEmQeodNbypc7hf7VMOZhGuAz0zKtjRAa
         nKR6eAAqz8b5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 759335C051D; Thu, 29 Apr 2021 17:24:59 -0700 (PDT)
Date:   Thu, 29 Apr 2021 17:24:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org,
        zhengjun.xing@intel.com, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210430002459.GB975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
 <87a6pimt1f.ffs@nanos.tec.linutronix.de>
 <20210428183118.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <878s517axu.ffs@nanos.tec.linutronix.de>
 <20210429142641.GU975577@paulmck-ThinkPad-P17-Gen-1>
 <87lf91f177.ffs@nanos.tec.linutronix.de>
 <20210429230411.GK4032392@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429230411.GK4032392@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 04:04:11PM -0700, Andi Kleen wrote:
> > > The idea is to leave the watchdog code in kernel/time/clocksource.c,
> > > but to move the fault injection into kernel/time/clocksourcefault.c or
> > > some such.  In this new file, new clocksource structures are created that
> > > use some existing timebase/clocksource under the covers.  These then
> > > inject delays based on module parameters (one senstive to CPU number,
> > > the other unconditional).  They register these clocksources using the
> > > normal interfaces, and verify that they are eventually marked unstable
> > > when the fault-injection parameters warrant it.  This is combined with
> > > the usual checking of the console log.
> > >
> > > Or am I missing your point?
> > 
> > That's what I meant.
> 
> I still think all this stuff should be in the fault injection framework,
> like other fault injections, to have a consistent discoverable interface. 
> 
> I actually checked now and the standard fault injection supports boot arguments,
> so needing it at boot time shouldn't be a barrier.

Per Thomas's feedback, I am in the midst of converting this to a unit
test implemented as a kernel module, at which point the only fault
injection will be in the unit test.

At the moment, the code just registers, reads, unregisters, and verifies
that the bogus unit-test clocksources act normally.  Fault injection is
next on the list for the fine-grained clocksource.  Which, as Thomas
noted, is quite a bit simpler, as I just need to force a delay until
the clocksource gets marked unstable with no need for fancy counting.

							Thanx, Paul
