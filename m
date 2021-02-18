Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A98C31EA71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhBRN2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBRLqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:46:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6289364E5F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613647200;
        bh=2P/6wagvAfeuuw2UD1M820Zlz7qjiQVM9L923kQfP/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tydGMiI1Expr51rt91j5cn9nTbbsNuRCivMlCeLiiodnKCiRxWxV4+U0jxh1ngOCm
         lFRaJUUig+jz6KSC2Zrv6n8xbsW4Z0T55OAexio40MLanYoNWh1BxH8Ys5E+talbq9
         yjcgnyYVzpUk/d3ybPlXCVX1LoRdf8bB1yCXJPjCmOCBJMx7CxS90i4AJo6HyloIWL
         OODijz47cn2ZXy8X9+tZpX8bR+aT45ZqZOS3qbRUSPByqL6KIrQqj1UQy5Tpqzw2wz
         WSikRw00JnNLk2IASc6jXtcUtZlI/X6rVCeMZtj/xqdNep8L7/sj9LM5lJOTguzA20
         G8YyxeCWLUeAw==
Received: by mail-oi1-f170.google.com with SMTP id l19so1569865oih.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 03:20:00 -0800 (PST)
X-Gm-Message-State: AOAM5317cdCq8pRM95Q12OUwZqCYep1DspHl4t+zYclw6eRCzJ3GeReJ
        WKZvD7Rnn5FTX1rjIeF7P6pzLFp3zTZe7Vl2pPM=
X-Google-Smtp-Source: ABdhPJwybVEo2h7a7H4bquBBVfwM5XcG1Z1tvWIOCv5fwqG1RBftQf2vSeD3J5yCjjNFlc3hEXxl07ytkQ4P/ffos3k=
X-Received: by 2002:aca:2117:: with SMTP id 23mr2403551oiz.4.1613647199535;
 Thu, 18 Feb 2021 03:19:59 -0800 (PST)
MIME-Version: 1.0
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com> <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com> <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com> <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com> <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
In-Reply-To: <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 18 Feb 2021 12:19:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
Message-ID: <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
Subject: Re: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 6:30 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 17 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > > On Sat, 13 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > >
> > > That scenario seems a little contrived to me (drivers for two or more
> > > devices sharing state through their interrupt handlers). Is it real? I
> > > suppose every platform has its quirks. The irq lock in
> > > sonic_interrupt() is only there because of a platform quirk (the same
> > > device can trigger either of two IRQs). Anyway, no-one expects all
> > > drivers to work on all platforms; I don't know why it bothers you so
> > > much when platforms differ.
> >
> > Basically, we wrote drivers with the assumption that this driver will be
> > cross-platform. (Of course there are some drivers which can only work on
> > one platform, for example, if the IP of the device is only used in one
> > platform as an internal component of a specific SoC.)
> >
> > So once a device has two or more interrupts, we need to consider one
> > interrupt might preempt another one on m68k on the same cpu if we also
> > want to support this driver on m68k. this usually doesn't matter on
> > other platforms.
>
> When users show up who desire to run your drivers on their platform, you
> can expect them to bring patches and a MAINTAINERS file entry. AFAIK,
> Linux development has always worked that way.

This is only part of the picture though. We also also constantly trying to
generalize the internal interfaces, to make sure that platforms work the same
way and that it's possible to write drivers in a portable way without having
to rely on platform maintainers to point out the differences.

I think it would make a lot of sense to remove the architecture differences
here by making m68k work the same way as the others and documenting
that as the expected behavior.

You are probably right that there are no specific bugs on m68k machines
that rely on the nested hardirqs today, but I think they only get away with it
because

a) there is no SMP support on m68k, so it likely doesn't run into the more
    subtle cases with lock ordering that you could get when you have
    hardirq handlers on multiple CPUs in parallel

b) there is a very limited number of device drivers that are actually used
    on m68k, in particular only M54xx has PCI support, but that in turn has
    a different interrupt scheme.

Changing the behavior on m68k clearly has its own regression risk, but
it could be done as a configuration option that defaults to the traditional
behavior on machines that have not been verified to be well-behaved
without nested hardirqs, and hidden on machines that do not need it
(any more).

As far as I can tell, the only reason you would actually need nested
hardirqs is when a low-priority interrupt has to perform expensive
I/O processing, but we've had countless other methods to do the
same over the years (at least bottom half, softirq, taskqueue, tasklet,
keventd, workqueue, kthread, threaded interrupt handlers and
probably others).

It would probably not be too hard to go through all drivers that are normally
enabled and see if their interrupt handler should be changed to use
deferred processing (threaded irq handler or workqueue) instead of
doing expensive I/O in hardirq context and relying on priorities.

FWIW, these are the drivers in m68k multi_defconfig that register an
interrupt:

$ find build/tmp/{drivers,sound} -name \*.o | xargs grep request_.*irq
| cut -f 3- -d/ | cut -f 1 -d\  | sed -e "s:o$:c:g"
drivers/block/amiflop.c
drivers/ide/ide-probe.c
drivers/input/joystick/amijoy.c
drivers/input/keyboard/amikbd.c
drivers/input/keyboard/hilkbd.c
drivers/input/mouse/amimouse.c
drivers/input/serio/hp_sdc.c
drivers/input/serio/q40kbd.c
drivers/macintosh/via-cuda.c
drivers/macintosh/via-macii.c
drivers/macintosh/via-pmu.c
drivers/misc/dummy-irq.c
drivers/net/ethernet/8390/apne.c
drivers/net/ethernet/8390/ax88796.c
drivers/net/ethernet/8390/hydra.c
drivers/net/ethernet/8390/mac8390.c
drivers/net/ethernet/8390/ne.c
drivers/net/ethernet/8390/zorro8390.c
drivers/net/ethernet/amd/7990.c
drivers/net/ethernet/amd/a2065.c
drivers/net/ethernet/amd/ariadne.c
drivers/net/ethernet/amd/atarilance.c
drivers/net/ethernet/amd/sun3lance.c
drivers/net/ethernet/apple/macmace.c
drivers/net/ethernet/cirrus/mac89x0.c
drivers/net/ethernet/i825xx/82596.c
drivers/net/ethernet/natsemi/macsonic.c
drivers/net/ethernet/smsc/smc91x.c
drivers/net/phy/phy.c
drivers/parport/parport_amiga.c
drivers/parport/parport_atari.c
drivers/parport/parport_mfc3.c
drivers/parport/parport_pc.c
drivers/scsi/a2091.c
drivers/scsi/a3000.c
drivers/scsi/a4000t.c
drivers/scsi/atari_scsi.c
drivers/scsi/bvme6000_scsi.c
drivers/scsi/gvp11.c
drivers/scsi/mac_esp.c
drivers/scsi/mac_scsi.c
drivers/scsi/mvme147.c
drivers/scsi/mvme16x_scsi.c
drivers/scsi/sun3x_esp.c
drivers/scsi/zorro7xx.c
drivers/scsi/zorro_esp.c
drivers/tty/amiserial.c
drivers/tty/serial/pmac_zilog.c
drivers/video/fbdev/amifb.c
drivers/video/fbdev/atafb.c
sound/oss/dmasound/dmasound_atari.c
sound/oss/dmasound/dmasound_paula.c
sound/oss/dmasound/dmasound_q40.c

Most of these are normal short-lived interrupts that only transfer
a few bytes or schedule deferred processing of some sort.
Most of the scsi and network drivers process the data in
a softirq, so those are generally fine here, but I do see that 8390
(ne2000) ethernet and the drivers/ide drivers do transfer their
data in hardirq context.

        Arnd
