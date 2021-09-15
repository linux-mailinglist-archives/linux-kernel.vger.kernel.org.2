Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99140BF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhIOFkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhIOFkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:40:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949B96112D;
        Wed, 15 Sep 2021 05:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631684359;
        bh=GDRQxbnigH40lWnKSgHP52VfeiV/Lkz/WXWQuvdUmEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9c/KOTf6sfbiJaqQ9E/5WkN5LBOjqsb3a7qmU6SxZ2cSGAhG1TlWnF/3jbBRiVdY
         n13rKjmGfVRaLPjc6YbsR67wSnKZylExuf8iMS9Dx90ZS8FaYyjzo33Pg+TEqek9sz
         RftT2LJxPweQRo6XuGplj5IrKJMEcBduJH6pA9ok=
Date:   Wed, 15 Sep 2021 07:38:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <YUGG8iPWMLx5vJ1f@kroah.com>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
 <YUBmIWU6HwIjjeXa@kroah.com>
 <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:43:44PM +0000, Min Li wrote:
> Hi Greg
> 
> Thanks for the review
> 
> > >  drivers/misc/Kconfig      |   9 ++
> > >  drivers/misc/Makefile     |   2 +
> > >  drivers/misc/rsmu_cdev.c  | 239
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/misc/rsmu_cdev.h  |  77 +++++++++++++++
> > >  drivers/misc/rsmu_cm.c    | 164 +++++++++++++++++++++++++++++++
> > >  drivers/misc/rsmu_sabre.c | 133 ++++++++++++++++++++++++++
> > 
> > If you make this all one .c file, the .h file can go away and it will be much
> > simpler in the end.  And will get rid of the global symbols.
> > 
> 
> That is doable. But <linux/mfd/idt8a340_reg.h> and <linux/mfd/idt82p33_reg.h> have naming confliction.
> To make this change one file, I have to include both of them and therefore I have to change them to resolve
> Conflicts. Can I include this 

Yes, that should be fine, do it as patch 1/X in a series.

> > >
> > > +config RSMU
> > > +	tristate "Renesas Synchronization Management Unit (SMU)"
> > > +	help
> > > +	  This option enables support for the IDT ClockMatrix(TM) and
> > 82P33xxx
> > > +	  families of timing and synchronization devices. It will be used by
> > > +	  Renesas PTP Clock Manager for Linux (pcm4l) software to provide
> > support
> > > +	  for GNSS assisted partial timing support (APTS) and other
> > networking
> > > +	  timing functions.
> > 
> > No driver name listed?
> 
> Sorry, what do you mean by driver name in this context?

Most Kconfig help texts say the driver name if it is built as a module.

> > > +
> > > +/**
> > > + * struct rsmu_cdev - Driver data for RSMU character device
> > > + * @name: rsmu device name as rsmu[index]
> > > + * @dev: pointer to device
> > > + * @mfd: pointer to MFD device
> > > + * @miscdev: character device handle
> > > + * @regmap: I2C/SPI regmap handle
> > > + * @lock: mutex to protect operations from being interrupted
> > > + * @type: rsmu device type, passed through platform data
> > > + * @ops: rsmu device methods
> > > + * @index: rsmu device index
> > > + */
> > > +struct rsmu_cdev {
> > > +	char name[16];
> > > +	struct device *dev;
> > 
> > What device is this pointing to?
> 
> It is the platform device from rsmu_probe(struct platform_device *pdev)

Then why not just point to the platform device?

> > 
> > > +	struct device *mfd;
> > 
> > What is this for?
> 
> It is the multi-functional device from driver/mfd/rsmu_core.c
> The mfd driver is responsible for spawn this platform device and spi/i2c
> bus access

Why do you need to mess with that if you have a pointer to the platform
device instead?

> > > +/*
> > > + * RSMU IOCTL List
> > > + */
> > > +#define RSMU_MAGIC '?'
> > 
> > Where did you get this value from?
> > 
> > Where did you reserve it?
> 
> No I didn't reserve it. I checked other code and they all seem to use a random character

That's not the best way to do this.

Why do you need ioctls at all anyway?  What userspace tools will be
accessing this driver?  Do you have a link to where they are located at?

> > > +
> > > +/**
> > > + * @Description
> > 
> > What is this format?  It is not kernel-doc :(
> > 
> > > + * ioctl to set SMU combo mode.Combo mode provides physical layer
> > > + frequency
> > > + * support from the Ethernet Equipment Clock to the PTP clock
> > > + *
> > > + * @Parameters
> > 
> > Same here and elsewhere in this file.
> 
> I was copying the format from xilinx_sdfec.h
> 
> Is there a place that tells me how to properly document ioctl or can you give me an code example?

The kerneldoc format should be described in Documentation/ somewhere...

thanks,

greg k-h
