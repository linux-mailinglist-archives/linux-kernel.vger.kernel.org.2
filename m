Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2218432C0C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579704AbhCCSbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241871AbhCCQpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:45:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C3A8614A7;
        Wed,  3 Mar 2021 16:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614789805;
        bh=Lw05/tYL0RTCnZwEbWPiPAOi1ooTtPKuIysUCncz+l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFcHpnbGMbCdheVIk6h/b8vjSgjFbdic2ZxTtLKmUvwWk3zHgI+ivjHAomB4WBByd
         ZIV/Hkzm4NlCryf09QThPMdIRKOEoZemRPxp2nU0I7GV9m74HwrP8lj416l2gkC9Yo
         FglCmG9a7xb+q/NNeVcceFSb8X80v7qvLKtAz6Ig=
Date:   Wed, 3 Mar 2021 17:43:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YD+8q/hSWNKQS1tE@kroah.com>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com>
 <20210303103839.it7grj3vtrdmngbd@kozik-lap>
 <YD+XkFAfoKpSsea3@kroah.com>
 <cf330a12-82b9-3d6a-eeeb-28630e0a5f2b@roeck-us.net>
 <YD+mkse29UwwYbFB@kroah.com>
 <6e9d6831-f88e-477f-6256-7ab155bfa7ac@kernel.org>
 <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2TAZELiqzy8Xv8hKvZwM6_+rF5OW9_AkP2TBoDRS3skQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:33:46PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 3, 2021 at 4:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 03/03/2021 16:09, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 03, 2021 at 06:56:38AM -0800, Guenter Roeck wrote:
> > >> On 3/3/21 6:05 AM, Greg Kroah-Hartman wrote:
> > >> [ ... ]
> > >>>> Anyway, that's the convention or consensus so far for entire SoC. If we
> > >>>> want to change it - sure, but let's make it for everyone, not for just
> > >>>> this one USB driver.
> > >>>
> > >>> Great, let's change it for everyone, I don't see a need for ARCH_*
> > >>> symbols except for people who want to make it simpler for their one
> > >>> board type.  And for that, use a defconfig.
> > >>>
> > >>
> > >> I don't think that will work in practice. Many ARCH_ symbols for various
> > >> architectures contradict with each other. Almost all watchdog drivers
> > >> only _build_ for specific platforms/architectures.
> > >
> > > Great, that's horrible to hear, so much for a "generic arm64 kernel
> > > binary" which I _thought_ was the goal.
> > >
> > > ugh, you would have thought we would have learned our lesson with
> > > arm32...
> 
> I have no idea what you are talking about here. arm64 kernels have
> always been generic, but you still need drivers for each piece of
> hardware, we unfortunately can't stop SoC vendors from reinventing
> the wheel with each new platform and then having to add yet another
> driver for each subsystems.

That's fine, drivers are easy, but when I see comments like "ARCH_
symbols contradict" that means that we can not make a generic kernel
image.  Otherwise there's no contradiction :)

And "new drivers" are almost always not really "new" as everyone uses
much the same IP blocks.  As proof of this patch where the DWC3 IP block
is being used by multiple SoC vendors.  To handle that, you split out
the SoC-specific portions into sub-drivers, so that you can build a
single image of the driver that works on multiple platforms.  Nothing
new, we've been doing this for years, it's just that out-of-mainline SoC
trees that think they can touch "core IP block code" break this all the
time, which is what I am pushing back on.

Anyway, this is just me as a driver subsystem maintainer being grumpy to
see ARCH_ dependancies on tiny little things like SoC-portions for
generic IP drivers.  Or on individual drivers (i.e. Samsung serial port
driver), where they don't belong at all.

So the overall goal of the original patch here is great, I want to see
that happen, as long as it's done in a way that does not ignore feedback
of arch maintainers...

thanks,

greg k-h
