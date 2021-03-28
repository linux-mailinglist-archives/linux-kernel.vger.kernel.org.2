Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828CF34BC83
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 15:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhC1Naf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 09:30:35 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50963 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1Nad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 09:30:33 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12SDUTWw024444;
        Sun, 28 Mar 2021 15:30:29 +0200
Date:   Sun, 28 Mar 2021 15:30:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mateusz Jonczyk <mat.jonczyk@o2.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
Message-ID: <20210328133029.GA24429@1wt.eu>
References: <20210327203218.119372-1-mat.jonczyk@o2.pl>
 <20210327211322.121708-1-mat.jonczyk@o2.pl>
 <20210327232551.GA20783@1wt.eu>
 <87lfa8cchf.ffs@nanos.tec.linutronix.de>
 <059b4775-e130-27c4-26fc-3a0eca07ddae@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <059b4775-e130-27c4-26fc-3a0eca07ddae@o2.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 02:37:55PM +0200, Mateusz Jonczyk wrote:
> W dniu 28.03.2021 o 00:25, Willy Tarreau pisze:
> > FWIW I tested on my ASUS 1025C which runs on an Atom N2600 forced to
> > 32-bit. I had already tried in the past but wanted to give it a try
> > again in case I'd have missed anything. Sadly it didn't work, I'm
> > still getting the "requires an x86-64 CPU" message.
> 
> Thank you. It looks like your bootloader uses the 16-bit kernel boot
> protocol. The 16-bit kernel boot code checks for x86_64 presence with a
> similar message ( inside arch/x86/boot/cpu.c ), which I did not patch out.
> If you would like to test again, use the same patched kernel, but change in
> GRUB: "linux16" to "linux" and "initrd16" to "initrd" to use the 32-bit boot
> protocol. Which distribution and bootloader do you use?

I'm using Lilo on an old Slackware. I can patch the 16-bit code myself,
it's no big deal.

> Of course, force enabling x86_64 would require passing a kernel command line
> parameter with a prominent warning in documentation, just like with
> "forcepae".

Sure, but I mean, I suspect that the risk could be higher with very low
priced laptops were crappy chips are to be expected by definition based
on contracts neither you nor me have seen. 

I'll try again after patching the 16-bit code, thanks for the suggestion.
Willy
