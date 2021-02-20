Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D532044E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 08:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBTHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 02:09:18 -0500
Received: from cynthia.allandria.com ([50.242.82.17]:49778 "EHLO
        cynthia.allandria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhBTHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 02:09:15 -0500
Received: from flar by cynthia.allandria.com with local (Exim 4.84_2)
        (envelope-from <flar@allandria.com>)
        id 1lDMN6-0002Dq-5i; Fri, 19 Feb 2021 23:08:08 -0800
Date:   Fri, 19 Feb 2021 23:08:08 -0800
From:   Brad Boyer <flar@allandria.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
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
Message-ID: <20210220070808.GA7874@allandria.com>
References: <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
 <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
 <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
 <5148eb2aaceb42d78087bc6d8ce15183@hisilicon.com>
 <5fcea94e-6fc9-c340-d7d2-4ae8b69890b8@telegraphics.com.au>
 <0c0ea8eca77c45ea89f2d4432580211c@hisilicon.com>
 <28d4b91d-1774-a8a-df97-7ac9b365c2@telegraphics.com.au>
 <CAK8P3a0VquJPxvS8B=2kLQ5y=h5BftJDR7WJYmj3hgQ8yQY5=Q@mail.gmail.com>
 <264b37c2-527-f0ed-197d-b016a7d16e32@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <264b37c2-527-f0ed-197d-b016a7d16e32@telegraphics.com.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:32:30PM +1100, Finn Thain wrote:
> Nope. Interrupt priority masking is there to place an upper bound 
> interrupt latency. That's why this feature is shipping in contemporary 
> hardware (e.g. ARM GIC). If you care about real time workloads on arm64, 
> that may interest you.

I don't know if it's still true today, but in the past there was a very
noticeable difference in timer stability between the 68k macintosh
models with the timer interrupt at IPL 1 as compared to the models
where the timer interrupt was at IPL 6. The ability to preempt the
other interrupt handlers made the difference between a usable clock
and one that was pretty unreliable.

	Brad Boyer
	flar@allandria.com

