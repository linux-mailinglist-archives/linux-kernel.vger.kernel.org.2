Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E382F32BFA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579968AbhCCScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239034AbhCCQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:56:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C50D64ECF;
        Wed,  3 Mar 2021 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614790576;
        bh=F6xuDrHfR9Jmp0/snl1bNYDQLnsZiMMqZS6KHJ5mxok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEQXkui2P9iB2CXW8HhgVHm4Ms9NRBze5rF4F7RU6s89K1kzptwp97CPQztfhQBtV
         4AC09+oAKfG4XkagFWtjFPR0pAmH6VuoJkzQQw9jBoDpaVx8nFw1GTFR3BNZ9mfaq7
         A0e+4WUTIoQxqIXPbFbI6LO9P89rBBBh9KLYHIP4=
Date:   Wed, 3 Mar 2021 17:56:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YD+/rdM5xzVDC97F@kroah.com>
References: <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com>
 <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com>
 <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
 <YD+mkse29UwwYbFB@kroah.com>
 <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
 <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com>
 <YD+8q/hSWNKQS1tE@kroah.com>
 <a6ac3887-38d0-48f4-e06f-81b45484a54a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ac3887-38d0-48f4-e06f-81b45484a54a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:49:01PM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2021 17:43, Greg Kroah-Hartman wrote:
> > > > > > I don't think that will work in practice. Many ARCH_ symbols for various
> > > > > > architectures contradict with each other. Almost all watchdog drivers
> > > > > > only _build_ for specific platforms/architectures.
> > > > > 
> > > > > Great, that's horrible to hear, so much for a "generic arm64 kernel
> > > > > binary" which I _thought_ was the goal.
> > > > > 
> > > > > ugh, you would have thought we would have learned our lesson with
> > > > > arm32...
> > > 
> > > I have no idea what you are talking about here. arm64 kernels have
> > > always been generic, but you still need drivers for each piece of
> > > hardware, we unfortunately can't stop SoC vendors from reinventing
> > > the wheel with each new platform and then having to add yet another
> > > driver for each subsystems.
> > 
> > That's fine, drivers are easy, but when I see comments like "ARCH_
> > symbols contradict" that means that we can not make a generic kernel
> > image.  Otherwise there's no contradiction :)
> 
> No, they don't contradict.
> 
> > 
> > And "new drivers" are almost always not really "new" as everyone uses
> > much the same IP blocks.  As proof of this patch where the DWC3 IP block
> > is being used by multiple SoC vendors.  To handle that, you split out
> > the SoC-specific portions into sub-drivers, so that you can build a
> > single image of the driver that works on multiple platforms.  Nothing
> > new, we've been doing this for years, it's just that out-of-mainline SoC
> > trees that think they can touch "core IP block code" break this all the
> > time, which is what I am pushing back on.
> 
> I am perfectly fine with (and like it!) putting dwc3 exynos back into
> base/main dwc3  and getting rid of USB_DWC3_EXYNOS entirely. But this was
> not part of this patch...

I doubt that will happen, and it's not something that I expect.  It's ok
to have platform-specific "sub-drivers" for common IP blocks, we do it
all the time.  But making it separate is good, much like has been done
for xhci as well.

> > Anyway, this is just me as a driver subsystem maintainer being grumpy to
> > see ARCH_ dependancies on tiny little things like SoC-portions for
> > generic IP drivers.  Or on individual drivers (i.e. Samsung serial port
> > driver), where they don't belong at all.
> 
> At least with Samsung serial driver we see adding new SoC - Apple M1.
> 
> Here, the guys in Samsung want to tweak several kernel parts to work with
> their out-of-tree code without contributing this code back. It's not a
> community-friendly approach. The upstream kernel should be tweaked to the
> out-of-tree unknown, hidden and uncontrollable code.

Totally agreed, that's not ok.  But a different issue than what is
happening here.

thanks,

greg k-h
