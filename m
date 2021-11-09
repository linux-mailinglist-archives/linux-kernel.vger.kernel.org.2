Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166544ADAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhKIMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235574AbhKIMpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:45:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC7E561077;
        Tue,  9 Nov 2021 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636461742;
        bh=nkN6DdoFXpKxTb1DjtoFLscdPdRdzApWbvyVc2HKyfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZ93Vp8Mc1WxPhADBr3c6Lr/jqcD0cq6eLQdw0d112VpErapBdgez4PqNd+/zaR49
         eV0Ka+gtvGc9tYCmPPwbsdJ/x6AO/wXXjL/gpbh5Qlt849Cs6BgdnTFAOjZ1MfxR/e
         fxW6cpXLZNLHjEEDLluCzbbtgJJ3O+JAEkY6TaXU=
Date:   Tue, 9 Nov 2021 13:42:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YYpsq/umygfTb8mM@kroah.com>
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com>
 <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com>
 <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 01:32:48PM +0100, Hans-Gert Dahmen wrote:
> On Tue, 9 Nov 2021, 11:28 Greg KH, <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 09:52:53AM +0100, Hans-Gert Dahmen wrote:
> > > On 09.11.21 07:16, Greg KH wrote:
> > > > On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> > > > > Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> > > > > on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> > > > > for pen-testing, security analysis and malware detection on kernels
> > > > > which restrict module loading and/or access to /dev/mem.
> > > >
> > > > That feels like a big security hole we would be opening up for no good
> > > > reason.
> > > >
> > > > > It will be used by the open source Converged Security Suite.
> > > > > https://github.com/9elements/converged-security-suite
> > > >
> > > > What is the reason for this, and what use is this new interface?
> > > Because it is very hard to access the SPI flash to read the BIOS contents
> > > for (security) analysis and this works without the more complex and
> > > unfinished SPI drivers and it does so on a system where we may not access
> > > the full /dev/mem.
> >
> > Why not fix the spi drivers to do this properly?  What is preventing you
> > from doing that instead of adding a new user/kernel api that you will
> > have to support for the next 20+ years?
> >
> 
> Because this interface we want to use is inherently tied to the
> workings of x86_64 CPUs. It is very stable and easy to use. The SPI
> drivers in contrast have a history of being complex, buggy and in
> general not reliable.

Do you have a pointer to these complex and buggy drivers anywhere?

> This module will require very little maintenance
> and will probably work in the future without needing modification for
> newer platforms. It generally is meant as a fallback to the real SPI
> flash drivers so that userspace programs are able to provide essential
> functionality.

If it is a "fallback", how is it going to interact on a system where the
SPI driver is loaded?

> > > > > +static int __init flash_mmap_init(void)
> > > > > +{
> > > > > + int ret;
> > > > > +
> > > > > + pdev = platform_device_register_simple("flash_mmap", -1, NULL, 0);
> > > > > + if (IS_ERR(pdev))
> > > > > +         return PTR_ERR(pdev);
> > > > > +
> > > > > + ret = sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);
> > > >
> > > > You just raced with userspace and lost  >
> > > > Please set the attribute to the platform driver before you create the
> > > > device.
> > > >
> > >
> > > Sorry, but I went through tons of code and could not find a single instance
> > > where I can use a default group for creation without using a probe function
> > > that does the magic for me. Please help me find the correct way of doing
> > > this without manually creating and adding kobjects.
> >
> > The problem here is that you are abusing the platform driver code and
> > making a "fake" device that is not attached to anything real, and
> > without a driver.  That should not be done, as you do not know what
> > hardware this driver is going to be run on.
> >
> > Bind to the real hardware resource please.
> 
> In a previous mail in June you suggested this is some sort of platform
> device, that is why I rewrote it as such.

That's fine, but bind to the real platform device that describes this
hardware!  You are not doing anything like this at all here, you are
just creating a random device in the sysfs tree and instantly allowing
userspace access to raw memory.  You are not actually controlling the
platform device at all.

> The hardware resource here
> is the south bridge for x86_64 CPUs and the module dependencies will
> compile it only for these platforms.

What "module dependencies"?  You do realize that distro kernels enable
all modules to be built. We have an "autoload only the modules that this
hardware needs" infrastructure that you need to tie into here, you are
totally ignoring it (despite it being present for almost 20 years
now...)

> The situation is like, if you
> have that CPU, you have the hardware, so it is implicitly bound or it
> just will not execute on a machine code level.

What do you mean "implicitly bound"?  How does this tie into the driver
model such that it will only be autoloaded, and have the driver bind to
the hardware, that it knows it can control?

That is what needs to be fixed here, you are just claiming that it can
talk to the hardware without having any check at all for this.

> I feel like your
> requirement is somewhat impossible to satisfy and I really don't know
> what to do. Please, can anyone help me by pointing out a proper
> example elsewhere in the kernel?

What resource in the system describes the hardware you wish to bind to?
Write a driver for _that_ resource, and have it be properly autoloaded
when that resource is present in the system.

You have hundreds of examples running on your system today, but as I do
not know where this hardware is described specifically, it's hard to be
able to point you to an example that works like that.

So again, what hardware signature describes the resource you wish to
bind to?

thanks,

greg k-h
