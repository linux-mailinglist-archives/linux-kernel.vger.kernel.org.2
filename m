Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8E320185
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 00:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSXGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 18:06:19 -0500
Received: from cynthia.allandria.com ([50.242.82.17]:49687 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:06:17 -0500
X-Greylist: delayed 2073 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 18:06:17 EST
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1lDEIC-0000OT-RK; Fri, 19 Feb 2021 14:30:32 -0800
Date:   Fri, 19 Feb 2021 14:30:32 -0800
From:   Brad Boyer <flar@allandria.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
Message-ID: <20210219223032.GA1343@allandria.com>
References: <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
 <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com>
 <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
 <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
 <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
 <a8595ec5-88db-072c-9cc3-7a3a301fe191@gmail.com>
 <CAMuHMdWBsupz06wVyVENHfjxP0uQ+1b7cnz6xGEMyqQkJFTeAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWBsupz06wVyVENHfjxP0uQ+1b7cnz6xGEMyqQkJFTeAA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:10:57AM +0100, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Thu, Feb 18, 2021 at 11:11 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > On 19/02/21 12:19 am, Arnd Bergmann wrote:
> > > drivers/net/ethernet/8390/apne.c
> > > drivers/net/ethernet/8390/ax88796.c
> > > drivers/net/ethernet/8390/hydra.c
> > > drivers/net/ethernet/8390/mac8390.c
> > > drivers/net/ethernet/8390/ne.c
> > > drivers/net/ethernet/8390/zorro8390.c
> > [...]
> > > Most of these are normal short-lived interrupts that only transfer
> > > a few bytes or schedule deferred processing of some sort.
> > > Most of the scsi and network drivers process the data in
> > > a softirq, so those are generally fine here, but I do see that 8390
> > > (ne2000) ethernet and the drivers/ide drivers do transfer their
> > > data in hardirq context.
> > >
> > >          Arnd
> >
> > 8390 ethernet drivers are widely used on m68k platforms (Amiga and
> > Atari). At least on Amiga, the corresponding interrupt is a hardirq so
> > I'd advise caution. That said, the 8390 drivers might benefit from some
> > refactoring (the way these drivers are compiled does prevent e.g. the
> > APNE driver from being used with two different variants of PCMCIA
> > interfaces. I had begun some work on making IO primitives runtime
> > selected two years ago but that ended up looking too ugly ...).
> >
> > Can't recall what IPL the 8390 interrupts operate at - Geert?
> 
> #define IRQ_AMIGA_PORTS         IRQ_AUTO_2
> 
> Zorro expansion boards can also use
> 
> #define IRQ_AMIGA_EXTER         IRQ_AUTO_6
> 
> and some boards may have a jumper to select the latter, but all Amiga
> Linux drivers use IRQ_AMIGA_PORTS.

The mac8390 driver will show up wherever NuBus interrupts are routed,
which varies by hardware. It's frequently IRQ_AUTO_2 (due to being
routed through the second VIA chip on most models), but it can be in
other places on systems that don't use a second VIA chip.  On the IIfx,
NuBus interrupts get routed through OSS to IRQ_AUTO_3. I don't see any
cases that use other interrupt levels, but some of the logic is a
little harder to follow.

It's not an 8390, but it looks like macmace actually uses two levels. The
regular interrupt should show up at IRQ_AUTO_3 and the DMA interrupts at
IRQ_AUTO_4. Most Macs only use 4 for serial, but this is an exception.

	Brad Boyer
	flar@allandria.com

