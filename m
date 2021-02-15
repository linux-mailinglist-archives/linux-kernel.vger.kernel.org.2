Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8B31C3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 23:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBOWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 17:23:02 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45148 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBOWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:22:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E14432A4CB;
        Mon, 15 Feb 2021 17:22:14 -0500 (EST)
Date:   Tue, 16 Feb 2021 09:22:12 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Arnd Bergmann <arnd@kernel.org>,
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
In-Reply-To: <CAHp75VeTKfSAnLUiwJ_SO-r4hUn7aQVTquG0j=k95QO_gk+c1g@mail.gmail.com>
Message-ID: <6bdbd8d8-add1-3c5c-8e3b-8b5ffb715b42@telegraphics.com.au>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com> <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com> <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com> <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <CAHp75VeTKfSAnLUiwJ_SO-r4hUn7aQVTquG0j=k95QO_gk+c1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021, Andy Shevchenko wrote:

> On Sun, Feb 14, 2021 at 7:12 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Sat, 13 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > > So what is really confusing and a pain to me is that:
> > > For years people like me have been writing device drivers
> > > with the idea that irq handlers run with interrupts
> > > disabled after those commits in genirq. So I don't need
> > > to care about if some other IRQs on the same cpu will
> > > jump out to access the data the current IRQ handler
> > > is accessing.
> > >
> > > but it turns out the assumption is not true on some platform.
> > > So should I start to program devices driver with the new idea
> > > interrupts can actually come while irqhandler is running?
> > >
> > > That's the question which really bothers me.
> > >
> >
> > That scenario seems a little contrived to me (drivers for two or more
> > devices sharing state through their interrupt handlers). Is it real?
> > I suppose every platform has its quirks. The irq lock in sonic_interrupt()
> > is only there because of a platform quirk (the same device can trigger
> > either of two IRQs). Anyway, no-one expects all drivers to work on all
> > platforms; I don't know why it bothers you so much when platforms differ.
> 
> Isn't it any IRQ chip driver which may get IRQ on one or more lines 
> simultaneously?
> The question here is can the handler be re-entrant on the same CPU in 
> that case?
> 

An irq_chip handler used only for interrupts having the same priority 
level cannot be re-entered, thanks to the priority mask.

Where the priority levels are different, as in auto_irq_chip in 
arch/m68k/kernel/ints.c, handle_simple_irq() can be re-entered but not 
with the same descriptor (i.e. no shared state).

Documentation/core-api/genericirq.rst says,

   The locking of chip registers is up to the architecture that defines 
   the chip primitives. The per-irq structure is protected via desc->lock, 
   by the generic layer.

Since the synchronization of chip registers is left up to the 
architecture, I think the related code should be portable.

Looking in kernel/irq/*.c, I see that desc->lock is sometimes acquired 
with raw_spin_lock_irq(&desc->lock) and sometimes 
raw_spin_lock(&desc->lock).

I don't know whether there are portability issues lurking here; this code 
is subtle and largely unfamiliar to me.
