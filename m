Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC4314D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhBIKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhBIKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:41:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B97D64E50;
        Tue,  9 Feb 2021 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612867246;
        bh=v+g1YM86idp+0g/8zM59AaEHGhUNJobOxVWmabHE9so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PE5n5Ev8/kePEnnTcd/Ud2/hBWDveV+qPpeqkp34V59nDCpXqlHxKfzVptOpdS3oD
         mDayk89Rbv3TVZlKd6j6Lk8XAAgR1Y9rbBy7Y7mrSoQw4zqIOZE6sbPIy8JXSTuxzR
         vhIewgBfXRyb8LOuHRSShbV8Ju3dr1Xd87KYzdPg=
Date:   Tue, 9 Feb 2021 11:40:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bastien Nocera <hadess@hadess.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: misc: usb5744: Add support for USB hub
 controller
Message-ID: <YCJmq882Sk9ae9PA@kroah.com>
References: <cover.1612864393.git.michal.simek@xilinx.com>
 <e1e1d47982018ccd5a763f199680babc0df848c8.1612864393.git.michal.simek@xilinx.com>
 <YCJd5Xoy1cT6bCIB@kroah.com>
 <fe8f8175-0b5d-3824-e5f7-b8cb826253bf@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8f8175-0b5d-3824-e5f7-b8cb826253bf@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:11:54AM +0100, Michal Simek wrote:
> 
> 
> On 2/9/21 11:03 AM, Greg Kroah-Hartman wrote:
> > On Tue, Feb 09, 2021 at 10:53:20AM +0100, Michal Simek wrote:
> >> From: Piyush Mehta <piyush.mehta@xilinx.com>
> >>
> >> This patch adds a USB GPIO based hub reset for USB5744 hub. This usb5744
> >> driver trigger hub reset signal after soft reset or core Reset. The HUB
> >> needs to be resetted after completion of phy initialization. After the
> >> toggling of gpio, hub configure using i2c usb attached command.
> >>
> >> USB5744 hub can be used without any I2C connection, is handled by a
> >> simple platform device driver.
> >>
> >> As part of the reset, sets the direction of the pin to output before
> >> toggling the pin. Delay of millisecond is added in between low and
> >> high to meet the setup and hold time requirement of the reset.
> >>
> >> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >>  MAINTAINERS                |   1 +
> >>  drivers/usb/misc/Kconfig   |   9 +++
> >>  drivers/usb/misc/Makefile  |   1 +
> >>  drivers/usb/misc/usb5744.c | 115 +++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 126 insertions(+)
> >>  create mode 100644 drivers/usb/misc/usb5744.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 7439471b5d37..56d1fcdd24f6 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2706,6 +2706,7 @@ F:	drivers/edac/synopsys_edac.c
> >>  F:	drivers/i2c/busses/i2c-cadence.c
> >>  F:	drivers/i2c/busses/i2c-xiic.c
> >>  F:	drivers/mmc/host/sdhci-of-arasan.c
> >> +F:	drivers/usb/misc/usb5744.c
> >>  N:	zynq
> >>  N:	xilinx
> >>  
> >> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> >> index 8f1144359012..30335b5c4f88 100644
> >> --- a/drivers/usb/misc/Kconfig
> >> +++ b/drivers/usb/misc/Kconfig
> >> @@ -242,6 +242,15 @@ config USB_HUB_USB251XB
> >>  	  parameters may be set in devicetree or platform data.
> >>  	  Say Y or M here if you need to configure such a device via SMBus.
> >>  
> >> +config USB_USB5744
> >> +	tristate "Microchip USB5744 Hub driver"
> >> +	depends on I2C
> >> +	depends on GPIOLIB
> >> +	help
> >> +	  This option enables support for Microchip USB5744 Hub. This driver
> >> +	  optionally reset the hub using gpio pin and configure hub via i2c if
> >> +	  connected.
> >> +
> >>  config USB_HSIC_USB3503
> >>  	tristate "USB3503 HSIC to USB20 Driver"
> >>  	depends on I2C
> >> diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> >> index 5f4e598573ab..5920146a506a 100644
> >> --- a/drivers/usb/misc/Makefile
> >> +++ b/drivers/usb/misc/Makefile
> >> @@ -25,6 +25,7 @@ obj-$(CONFIG_USB_USS720)		+= uss720.o
> >>  obj-$(CONFIG_USB_SEVSEG)		+= usbsevseg.o
> >>  obj-$(CONFIG_USB_YUREX)			+= yurex.o
> >>  obj-$(CONFIG_USB_HUB_USB251XB)		+= usb251xb.o
> >> +obj-$(CONFIG_USB_USB5744)		+= usb5744.o
> > 
> > Can you follow the convention of the config options we have already, and
> > make this USB_HUB_USB5744 please?
> 
> Sure.
> 
> > 
> >>  obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
> >>  obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
> > 
> > And then put it in sorted order :)
> 
> Do you want me to sort the whole Makefile and Kconfig as separate patch?

No, but at least put your new line in the obvious place, in order :)

> And any other problem with the driver itself?

No idea, I stopped here in reviewing...

thanks,

greg k-h
