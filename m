Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3532BEAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574879AbhCCReY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359314AbhCCOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:05:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF49E64E90;
        Wed,  3 Mar 2021 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614780307;
        bh=Eqh28vIRPFMJo7qe41AKhvYlOMF/qtQH6xKEWSHRMZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8KCrY2uk0jVaQI43XIjQP6AgLP0VOAShQRNDqvwBmPcmKCv/uxI0Gc6M1Gz884uo
         BMqCU953ZEQNGz/0X1de2/kBPTijy0RP7aZ68leuL09Bii/tANEL3Ulk57YbW8FoRq
         EgmreE3GnrGAj0NBIRIZT0egHfGef/mRkjEI/UnA=
Date:   Wed, 3 Mar 2021 15:05:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        taehyun cho <taehyun.cho@samsung.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Message-ID: <YD+XkFAfoKpSsea3@kroah.com>
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com>
 <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com>
 <20210303103839.it7grj3vtrdmngbd@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303103839.it7grj3vtrdmngbd@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:38:39AM +0100, Krzysztof Kozlowski wrote:
> On Wed, Mar 03, 2021 at 11:30:38AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 03, 2021 at 11:24:01AM +0100, Krzysztof Kozlowski wrote:
> > > On 03/03/2021 03:26, taehyun cho wrote:
> > > > 'ARCH_EXYNOS' is not suitable for DWC3_EXYNOS config.
> > > > 'USB_DWC3_EXYNOS' is glue layer which can be used with
> > > > Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
> > > > can be used from Exynos5 to Exynos9.
> > > > 
> > > > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> > > 
> > > NACK because you ignored comments from March. Please respond to them instead
> > > of resending the same patch.
> > > 
> > > Anyway, when resending you need to version your patches and explain the
> > > differences. Please also Cc reviewers and other maintainers. I pointed out
> > > this before:
> > > scripts/get_maintainer.pl -f drivers/usb/dwc3/dwc3-exynos.c
> > > 
> > > The driver - in current form - should not be available for other
> > > architectures. It would clutter other platforms and kernel config selection.
> > > If you want to change this, you need to provide rationale (usually by adding
> > > support to new non-Exynos platform).
> > 
> > No, these crazy "ARCH_FOO" things need to go away.  For systems that
> > want to build "universal" kernels, why are they being forced to enable
> > "ARCH_*" just so they can pick specific drivers?  That is not done on
> > other architectures, why is ARM64 so "special" in this regard.
> > 
> > How do you "know" that these cores/devices are tied to specific ARCH_
> > platforms?  We don't, so that dependency should not be there.
> > 
> > Just let any arch pick any driver if it can be built, you never know
> > what it might be run on.  Removing ARCH_ dependencies in Kconfig files
> > is a good thing, please do not discourage that from happening.
> 
> It's getting more generic topic, so let me Cc Arnd and Guenter (I think
> once I discussed this with Guenter around watchdog).
> 
> This is so far component of a SoC, so it cannot be re-used outside of
> SoC. Unless it appears in a new SoC (just like recent re-use of Samsung
> serial driver for Apple M1). Because of the architecture, you cannot
> build universal kernel without ARCH_EXYNOS. You need it. Otherwise the
> kernel won't boot on hardware with DWC Exynos.

So, to create a "generic" arm64 kernel, I need to go enable all of the
ARCH_* variants as well?  I thought we were trying to NOT do the same
mess that arm32 had for this type of thing.

> Since DWC Exynos won't work without ARCH_EXYNOS - the user will not get
> any usable binary - I think all, or almost all, SoC specific drivers are
> limited per ARCH. This limits the amount of choices for distro people
> and other kernel configuring folks, so they won't have to consider
> useless options.

Why do we have ARCH_EXYNOS at all?  x86-64 doesn't have this, why is
arm64 somehow special here?

That's my complaint, it feels wrong that I have to go and enable all
different ARCH_ symbols just to build these drivers.  If people want
'default' configurations, then provide an exynos default config file,
right?

> Anyway, that's the convention or consensus so far for entire SoC. If we
> want to change it - sure, but let's make it for everyone, not for just
> this one USB driver.

Great, let's change it for everyone, I don't see a need for ARCH_*
symbols except for people who want to make it simpler for their one
board type.  And for that, use a defconfig.

I've complained about this before, from a driver subsystem maintainer
point of view, this is crazy, drivers should be building and working on
everything.  Worst case, it's a cpu-type issue, to build or not build a
driver (i.e. s390, i386), best case it's a feature-type issue to depend
on (i.e. USB, TTY, etc.).  But never a "this one sub-architecture of
this one cpu"-type issue.  That feels crazy to me...

thanks,

greg k-h
