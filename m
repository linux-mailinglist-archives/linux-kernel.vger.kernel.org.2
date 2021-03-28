Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FD634BB40
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 08:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhC1GTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 02:19:20 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50928 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhC1GS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 02:18:56 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12S6IbCV022735;
        Sun, 28 Mar 2021 08:18:37 +0200
Date:   Sun, 28 Mar 2021 08:18:37 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mateusz Jonczyk <mat.jonczyk@o2.pl>, linux-kernel@vger.kernel.org
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
Message-ID: <20210328061837.GA22710@1wt.eu>
References: <20210327203218.119372-1-mat.jonczyk@o2.pl>
 <20210327211322.121708-1-mat.jonczyk@o2.pl>
 <20210327232551.GA20783@1wt.eu>
 <87lfa8cchf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfa8cchf.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Mar 28, 2021 at 03:07:24AM +0200, Thomas Gleixner wrote:
> On Sun, Mar 28 2021 at 00:25, Willy Tarreau wrote:
> > On Sat, Mar 27, 2021 at 10:13:22PM +0100, Mateusz Jonczyk wrote:
> > FWIW I tested on my ASUS 1025C which runs on an Atom N2600 forced to
> > 32-bit. I had already tried in the past but wanted to give it a try
> > again in case I'd have missed anything. Sadly it didn't work, I'm
> > still getting the "requires an x86-64 CPU" message.
> >
> > Given these machines were really cheap, I've always suspected that they
> > employ cheaper, low-grade CPUs, possibly having been subject to reduced
> > tests where x86_64-specific parts were not even verified and might be
> > defective. This may explain why they forcefully disable long mode there,
> > but that's just speculation.
> 
> There are some of these '32bit only' CPUs out there in the wild which
> actually support long mode. Some of them even do not have the long mode
> CPUID bit fused out.

Yes, I'm aware of this as well. We might even have talked to the same
"victim" :-)

> But whether it works is a different story:
> 
>   - If the CPUID bit is on, then the chance is high, but it runs out of
>     spec (guarantee wise)
> 
>   - If it's off is still might work by some definition of work as they
>     might have fused off more or there are actual defects in some 64bit
>     only area which are irrelevant when in 32bit mode.
> 
> Even if it could work perfectly fine, the BIOS/SMM/ucode can prevent
> switching to long mode.
> 
> It's a lost cause.

I agree. While I bought this netbook to have a 64-bit CPU and was extremely
disappointed, after seeing that it was not just a matter of "oops we forgot
to enable LM", I concluded that it was pointless to try to go further, as I
would never trust it anyway.

Cheers,
Willy
