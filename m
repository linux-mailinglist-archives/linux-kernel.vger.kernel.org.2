Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F234BA2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 00:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC0X0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 19:26:24 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:50895 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhC0X0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 19:26:01 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12RNPp7x021074;
        Sun, 28 Mar 2021 00:25:51 +0100
Date:   Sun, 28 Mar 2021 00:25:51 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mateusz Jonczyk <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
Message-ID: <20210327232551.GA20783@1wt.eu>
References: <20210327203218.119372-1-mat.jonczyk@o2.pl>
 <20210327211322.121708-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327211322.121708-1-mat.jonczyk@o2.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 27, 2021 at 10:13:22PM +0100, Mateusz Jonczyk wrote:
> W dniu 27.03.2021 o 21:32, Mateusz Jonczyk pisze:
> > Hello,
> >
> > There are some netbooks with Intel Atom processors that have 64-bit
> > support disabled by BIOS. Theoretically, the processor supports 64-bit
> > operation, but BIOS allows only 32-bit code to run.
> >
> > I wonder whether the 64-bit mode is really disabled in the CPU or only
> > hidden in the CPUID flags. If the latter, the computer could be made to
> > run a 64-bit kernel.
> >
> > Similarly, there are some Pentium M processors that support PAE
> > (Physical Address Extensions), but do not show this in CPUID. They could
> > be made to run distributions that require PAE with the "forcepae" kernel
> > command line parameter.
> >
> > I would like to ask people with such netbooks to try to run a 64-bit kernel
> > with this patch applied.
> >
> > When a patched 64-bit kernel is run in `qemu-system-i386`, the virtual
> > machine restarts instantly. Without this patch in such a case a 64-bit
> > kernel hangs indefinitely (inside .Lno_longmode in head_64.S).
> 
> I have made two mistakes:
> - I left commented out code,
> - I have commented out lines with '#'. The code compiled though.
> 
> Attaching corrected patch, please excuse me.

FWIW I tested on my ASUS 1025C which runs on an Atom N2600 forced to
32-bit. I had already tried in the past but wanted to give it a try
again in case I'd have missed anything. Sadly it didn't work, I'm
still getting the "requires an x86-64 CPU" message.

Given these machines were really cheap, I've always suspected that they
employ cheaper, low-grade CPUs, possibly having been subject to reduced
tests where x86_64-specific parts were not even verified and might be
defective. This may explain why they forcefully disable long mode there,
but that's just speculation.

Cheers,
Willy
