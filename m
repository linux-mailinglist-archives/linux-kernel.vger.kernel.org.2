Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939A744AB79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbhKIKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238291AbhKIKa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:30:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B44610FF;
        Tue,  9 Nov 2021 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636453690;
        bh=yFPryjS7QA9HQE/gLxXljo2ASKdVsoOPF1knG7tPAVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usQFigiIcx45VQmTU86xq8+astVPIj2IC45BtUKM13sBnX/ts6PY6WkfSqqDQQYsY
         OCi8t8e/6GWpsuyie7YQucHXondjXP/bv77MDOcGTDKhtXdyVLc7EpSt0JhvjBc0/G
         SUstB3HtbiMN4xvOqwDsBzcuWryKQXaEYTvpfo/8=
Date:   Tue, 9 Nov 2021 11:28:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne, mauro.lima@eclypsium.com,
        hughsient@gmail.com, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YYpNOMtp7Kwf0fho@kroah.com>
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com>
 <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:52:53AM +0100, Hans-Gert Dahmen wrote:
> On 09.11.21 07:16, Greg KH wrote:
> > On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> > > Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> > > on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> > > for pen-testing, security analysis and malware detection on kernels
> > > which restrict module loading and/or access to /dev/mem.
> > 
> > That feels like a big security hole we would be opening up for no good
> > reason.
> > 
> > > It will be used by the open source Converged Security Suite.
> > > https://github.com/9elements/converged-security-suite
> > 
> > What is the reason for this, and what use is this new interface?
> Because it is very hard to access the SPI flash to read the BIOS contents
> for (security) analysis and this works without the more complex and
> unfinished SPI drivers and it does so on a system where we may not access
> the full /dev/mem.

Why not fix the spi drivers to do this properly?  What is preventing you
from doing that instead of adding a new user/kernel api that you will
have to support for the next 20+ years?

> > > +static int __init flash_mmap_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	pdev = platform_device_register_simple("flash_mmap", -1, NULL, 0);
> > > +	if (IS_ERR(pdev))
> > > +		return PTR_ERR(pdev);
> > > +
> > > +	ret = sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);
> > 
> > You just raced with userspace and lost  >
> > Please set the attribute to the platform driver before you create the
> > device.
> >
> 
> Sorry, but I went through tons of code and could not find a single instance
> where I can use a default group for creation without using a probe function
> that does the magic for me. Please help me find the correct way of doing
> this without manually creating and adding kobjects.

The problem here is that you are abusing the platform driver code and
making a "fake" device that is not attached to anything real, and
without a driver.  That should not be done, as you do not know what
hardware this driver is going to be run on.

Bind to the real hardware resource please.

> > Also, you just bound this driver to ANY platform that it was loaded on,
> > with no actual detection of the hardware present, which feels like it
> > could cause big problems on all platforms.  Please, if you really want
> > to do this, restrict it to hardware that actually has the hardware you
> > are wanting to access, not all machines in the world.
> 
> I ave already proven that it works on all x64 Intel platforms here [1]. It
> nearly impossible to prove for AMD b/c of the lack of documentation, but we
> tested it on several old Bulldozer system and so far the memory was always
> mapped. I feel that adding more hardware detection just adds complexity.
> Anyway, what do you suggest? Use CPUID to check if the vendor is AMD or
> Intel?

Again, without some sort of "we only bind to the hardware on these types
of devices", a driver like this is not going to be allowed, because you
are not checking the hardware at all!

Also, drivers are loaded based on the hardware being found on the system
and having the driver loaded automatically.  That isn't happening here
at all, so that's another reason why this isn't going to be acceptable.

You HAVE to have hardware detection, otherwise the code is broken,
sorry.

thanks,

greg k-h
