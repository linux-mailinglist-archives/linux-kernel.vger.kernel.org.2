Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B241A320432
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 07:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBTGdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 01:33:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37326 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhBTGdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 01:33:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D5F0E29A93;
        Sat, 20 Feb 2021 01:32:26 -0500 (EST)
Date:   Sat, 20 Feb 2021 17:32:30 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
In-Reply-To: <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
Message-ID: <264b37c2-527-f0ed-197d-b016a7d16e32@telegraphics.com.au>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com> <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com> <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com> <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au> <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
 <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au> <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021, Arnd Bergmann wrote:

> On Thu, Feb 18, 2021 at 6:30 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Wed, 17 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > > > On Sat, 13 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > > >
> > > > That scenario seems a little contrived to me (drivers for two or 
> > > > more devices sharing state through their interrupt handlers). Is 
> > > > it real? I suppose every platform has its quirks. The irq lock in 
> > > > sonic_interrupt() is only there because of a platform quirk (the 
> > > > same device can trigger either of two IRQs). Anyway, no-one 
> > > > expects all drivers to work on all platforms; I don't know why it 
> > > > bothers you so much when platforms differ.
> > >
> > > Basically, we wrote drivers with the assumption that this driver 
> > > will be cross-platform. (Of course there are some drivers which can 
> > > only work on one platform, for example, if the IP of the device is 
> > > only used in one platform as an internal component of a specific 
> > > SoC.)
> > >
> > > So once a device has two or more interrupts, we need to consider one 
> > > interrupt might preempt another one on m68k on the same cpu if we 
> > > also want to support this driver on m68k. this usually doesn't 
> > > matter on other platforms.
> >
> > When users show up who desire to run your drivers on their platform, 
> > you can expect them to bring patches and a MAINTAINERS file entry. 
> > AFAIK, Linux development has always worked that way.
> 
> This is only part of the picture though. We also also constantly trying 
> to generalize the internal interfaces, to make sure that platforms work 
> the same way and that it's possible to write drivers in a portable way 
> without having to rely on platform maintainers to point out the 
> differences.
> 
> I think it would make a lot of sense to remove the architecture 
> differences here by making m68k work the same way as the others and 
> documenting that as the expected behavior.
> 

If you had some great new feature that was incompatible with priority 
masking, or incompatible with existing drivers portable enough to support 
such features, then I would be more amenable to your plan to remove 
functionality.

But there's no real justification here. You say platform maintainers 
should not have to "point out the differences". But is that not their job?

> You are probably right that there are no specific bugs on m68k machines 
> that rely on the nested hardirqs today, but I think they only get away 
> with it because
> 
> a) there is no SMP support on m68k, so it likely doesn't run into the
>    more subtle cases with lock ordering that you could get when you have 
>    hardirq handlers on multiple CPUs in parallel
> 

And that's relevant because SMP support is now mandatory? Is this the 
logical consequence of your intention to "remove the architecture 
differences"?

> b) there is a very limited number of device drivers that are actually
>    used on m68k, in particular only M54xx has PCI support, but that in 
>    turn has a different interrupt scheme.
> 

Everyone is afraid of some mysterious bug somewhere, yet no one can point 
to it.

Again, I submit that the bug doesn't exist. That's because there is no 
material difference in semantics between the irqs_disabled() 
implementation that says "all interrupts are disabled except for NMI (and 
some others that some ARM platform cares about)" and the implementation 
that says "interrupts are disabled except higher priority ones than you 
may be enabled".

If you can point to code that cares about such semantics, I predict you've 
found either a coding anti-pattern or perhaps some obscure hardware design 
flaw. Either way, there is no justification for your plan.

> Changing the behavior on m68k clearly has its own regression risk, but 
> it could be done as a configuration option that defaults to the 
> traditional behavior on machines that have not been verified to be 
> well-behaved without nested hardirqs, and hidden on machines that do not 
> need it (any more).
> 

This plan will quantifiably increase interrupt latency. It's not some 
vague risk that you can hand-wave away. It's unavoidable.

> As far as I can tell, the only reason you would actually need nested 
> hardirqs is when a low-priority interrupt has to perform expensive I/O 
> processing, but we've had countless other methods to do the same over 
> the years (at least bottom half, softirq, taskqueue, tasklet, keventd, 
> workqueue, kthread, threaded interrupt handlers and probably others).
> 

Nope. Interrupt priority masking is there to place an upper bound 
interrupt latency. That's why this feature is shipping in contemporary 
hardware (e.g. ARM GIC). If you care about real time workloads on arm64, 
that may interest you.

If you don't care about arm hardware or real time workloads, that's fine 
too, but here's the rub. Song Bao Hua's plan involves reworking the 
locking in existing drivers (which may be portable enough to support 
interrerupt priority) without justification.
