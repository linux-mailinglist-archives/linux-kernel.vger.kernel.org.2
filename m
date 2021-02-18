Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCC31E5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 06:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhBRFj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 00:39:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58856 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhBRFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 00:31:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 07AD82ACC2;
        Thu, 18 Feb 2021 00:30:33 -0500 (EST)
Date:   Thu, 18 Feb 2021 16:30:20 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
cc:     Arnd Bergmann <arnd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
In-Reply-To: <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
Message-ID: <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com> <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com> <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>  <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021, Song Bao Hua (Barry Song) wrote:

> > On Sat, 13 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > 
> > >
> > > So what is really confusing and a pain to me is that: For years 
> > > people like me have been writing device drivers with the idea that 
> > > irq handlers run with interrupts disabled after those commits in 
> > > genirq. So I don't need to care about if some other IRQs on the same 
> > > cpu will jump out to access the data the current IRQ handler is 
> > > accessing.
> > >
> > > but it turns out the assumption is not true on some platform. So 
> > > should I start to program devices driver with the new idea 
> > > interrupts can actually come while irqhandler is running?
> > >
> > > That's the question which really bothers me.
> > >
> > 
> > That scenario seems a little contrived to me (drivers for two or more 
> > devices sharing state through their interrupt handlers). Is it real? I 
> > suppose every platform has its quirks. The irq lock in 
> > sonic_interrupt() is only there because of a platform quirk (the same 
> > device can trigger either of two IRQs). Anyway, no-one expects all 
> > drivers to work on all platforms; I don't know why it bothers you so 
> > much when platforms differ.
> 
> Basically, we wrote drivers with the assumption that this driver will be 
> cross-platform. (Of course there are some drivers which can only work on 
> one platform, for example, if the IP of the device is only used in one 
> platform as an internal component of a specific SoC.)
> 
> So once a device has two or more interrupts, we need to consider one 
> interrupt might preempt another one on m68k on the same cpu if we also 
> want to support this driver on m68k. this usually doesn't matter on 
> other platforms.
> 

When users show up who desire to run your drivers on their platform, you 
can expect them to bring patches and a MAINTAINERS file entry. AFAIK, 
Linux development has always worked that way.

Besides, not all m68k platforms implement priority masking. So there's no 
problem with portability to m68k per se.

> on the other hand, there are more than 400 irqs_disabled() in kernel, I 
> am really not sure if they are running with the knowledge that the true 
> irqs_disabled() actually means some interrupts are off and some others 
> are still open on m68k.

Firstly, use of irqs_disabled() is considered an antipattern by some 
developers. Please see, 
https://lore.kernel.org/linux-scsi/X8pfD5XtLoOygdez@lx-t490/
and
commit e6b6be53ec91 ("Merge branch 'net-in_interrupt-cleanup-and-fixes'")

This means that the differences in semantics between the irqs_disabled() 
implementations on various architectures are moot.

Secondly, the existence of irqs_disabled() call sites does not imply a 
flaw in your drivers nor in the m68k interrupt scheme. The actual semantic 
differences are immaterial at many (all?) of these call sites.

> Or they are running with the assumption that the true irqs_disabled() 
> means IRQ is totally quiet? If the latter is true, those drivers might 
> fail to work on m68k as well.
> 

Yes it's possible, and that was my fear too back in 2017 when I raised the 
same question with the m68k maintainer. But I never found any code making 
that assumption. If you know of such a bug, do tell. So far, your fears 
remain unfounded.

> Thanks
> Barry
> 
