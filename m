Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60461319D03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhBLLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhBLLA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:00:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AF0964E6C;
        Fri, 12 Feb 2021 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613127617;
        bh=BWRBsjwiSKYLwWPvGudoNuvoYqx9M15+3k2atM4UMEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkGnK2cKmvjUrYQXiDLnAm+9kD1UIHC6nfB8BmBu+ySVMxWkoEE0CX6W2ahagWtLG
         qXAZtJalwun1n+7HHJM6/nZaV16DZDPRndtjgBkmrY8tyCIul9VLDrk0HgkR69KIx5
         X/IGrykAwycbMZRxzyt5eDIT1fr9WZ2mV5RSLwaM=
Date:   Fri, 12 Feb 2021 12:00:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH v2 1/3] misc/pvpanic: split-up generic and platform
 dependent code
Message-ID: <YCZfvmAhu8lBsQA9@kroah.com>
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
 <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
 <YCZVvxxHI8mMEwTC@kroah.com>
 <a37c9549-14e1-6a80-7163-3a56414ff3f7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a37c9549-14e1-6a80-7163-3a56414ff3f7@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:29:49PM +0200, Mihai Carabas wrote:
> ..snip
> > > -};
> > > -module_platform_driver(pvpanic_mmio_driver);
> > > diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> > > new file mode 100644
> > > index 00000000..0dce6ef
> > > --- /dev/null
> > > +++ b/drivers/misc/pvpanic/Kconfig
> > > @@ -0,0 +1,12 @@
> > > +config PVPANIC
> > > +	bool "pvpanic device support"
> > > +	help
> > > +	  This option enables pvpanic device driver.
> > No it doesn't, it allows you to _select_ a specific pvpanic driver, on
> > its own, it is not a driver, right?
> 
> Yes. I will update the comment.
> 
> 
> > > +
> > > +config PVPANIC_MMIO
> > > +	tristate "pvpanic MMIO device support"
> > > +	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
> > > +	help
> > > +	  This driver provides support for the pvpanic device.  pvpanic is
> > > +	  a paravirtualized device provided by QEMU; it lets a virtual machine
> > > +	  (guest) communicate panic events to the host.
> > > diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> > > new file mode 100644
> > > index 00000000..9ea3355
> > > --- /dev/null
> > > +++ b/drivers/misc/pvpanic/Makefile
> > > @@ -0,0 +1,2 @@
> > > +obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
> > > +pvpanic-mmio-objs := pvpanic-common.o mmio.o
> > You put the "common" logic in the mmio driver?  How is that going to
> > work for the PCI driver?
> > 
> > Why is there not a pvpanic.ko that contains the "core" code only?
> 
> My intention was to put the code in both drivers. There is no generic module
> as it will complicate things: the generic module would have to have its own
> state (e.g. pvpanic_probe would have to create a queue of base addresses).

And when you link both into the kernel image directly, you end up with
duplicate symbols that break the build :(

> Do you want to see a generic module pvpanic.ko with its own state?

As it is, it will just not work so you have to do something...

thanks,

greg k-h
