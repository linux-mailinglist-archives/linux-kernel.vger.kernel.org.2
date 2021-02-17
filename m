Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61631E2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 23:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhBQWs5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Feb 2021 17:48:57 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2842 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhBQWm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:42:27 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Dgt6z6thYz13vm8;
        Thu, 18 Feb 2021 06:39:07 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Feb 2021 06:41:33 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 18 Feb 2021 06:41:33 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Thu, 18 Feb 2021 06:41:33 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Finn Thain <fthain@telegraphics.com.au>
CC:     Arnd Bergmann <arnd@kernel.org>,
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
Thread-Topic: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
Thread-Index: AdcA2xDwQTa7W6j6SmS4J3iBnsSynAAcRXSAABFJYBD//354gP//dYEggAGu1ID//yBa4P/+Ln+AAHCiVQD/+aOIoA==
Date:   Wed, 17 Feb 2021 22:41:33 +0000
Message-ID: <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
 <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
 <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
  <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com>
 <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
In-Reply-To: <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.96.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Finn Thain [mailto:fthain@telegraphics.com.au]
> Sent: Sunday, February 14, 2021 6:11 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Arnd Bergmann <arnd@kernel.org>; tglx@linutronix.de;
> gregkh@linuxfoundation.org; arnd@arndb.de; geert@linux-m68k.org;
> funaho@jurai.org; philb@gnu.org; corbet@lwn.net; mingo@redhat.com;
> linux-m68k@lists.linux-m68k.org; linux-kernel@vger.kernel.org
> Subject: RE: [RFC] IRQ handlers run with some high-priority interrupts(not NMI)
> enabled on some platform
> 
> On Sat, 13 Feb 2021, Song Bao Hua (Barry Song) wrote:
> 
> >
> > So what is really confusing and a pain to me is that:
> > For years people like me have been writing device drivers
> > with the idea that irq handlers run with interrupts
> > disabled after those commits in genirq. So I don't need
> > to care about if some other IRQs on the same cpu will
> > jump out to access the data the current IRQ handler
> > is accessing.
> >
> > but it turns out the assumption is not true on some platform.
> > So should I start to program devices driver with the new idea
> > interrupts can actually come while irqhandler is running?
> >
> > That's the question which really bothers me.
> >
> 
> That scenario seems a little contrived to me (drivers for two or more
> devices sharing state through their interrupt handlers). Is it real?
> I suppose every platform has its quirks. The irq lock in sonic_interrupt()
> is only there because of a platform quirk (the same device can trigger
> either of two IRQs). Anyway, no-one expects all drivers to work on all
> platforms; I don't know why it bothers you so much when platforms differ.

Basically, we wrote drivers with the assumption that this driver will
be cross-platform. (Of course there are some drivers which can only work
on one platform, for example, if the IP of the device is only used in
one platform as an internal component of a specific SoC.)

So once a device has two or more interrupts, we need to consider one
interrupt might preempt another one on m68k on the same cpu if we also
want to support this driver on m68k. this usually doesn't matter on
other platforms.

on the other hand, there are more than 400 irqs_disabled() in kernel,
I am really not sure if they are running with the knowledge that
the true irqs_disabled() actually means some interrupts are off
and some others are still open on m68k. Or they are running with
the assumption that the true irqs_disabled() means IRQ is totally
quiet? If the latter is true, those drivers might fail to work on
m68k as well.

Thanks
Barry
