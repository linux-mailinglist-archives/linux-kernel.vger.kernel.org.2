Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50C2365C32
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhDTP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232915AbhDTP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:29:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1540613AB;
        Tue, 20 Apr 2021 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618932508;
        bh=Alypod0I+kUabfejeO7uWU4e1wf53VKZIKSlCvlTQDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAsz+KUb4fD1wtwgDFKbiojfSeUJ827cHUPpe9aB8j+AZlk/vapL8u1lSpokpdsTv
         4468kvn4Rfn5Hj4jOj5OBM/Qgp+M6Buj0pJD76DHiJrPgy/Bl4QW+maPhwrq7NFO18
         PDhqx/MePHNODaT5g0d0K8Y1JYtMpYQvPrCoVQ78=
Date:   Tue, 20 Apr 2021 17:28:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Dragan Cvetic <draganc@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
Message-ID: <YH7zGf3/NrXmMN8/@kroah.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com>
 <YH6V9Im3L/gJJ/CP@kroah.com>
 <MWHPR02MB26233345F140ACA18E55BC15C2489@MWHPR02MB2623.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR02MB26233345F140ACA18E55BC15C2489@MWHPR02MB2623.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:47:17PM +0000, Nava kishore Manne wrote:
> Hi Greg,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, April 20, 2021 2:21 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Derek Kiernan
> > <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> > arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>; Amit Sunil
> > Dhamne <amitsuni@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > chinnikishore369@gmail.com; git <git@xilinx.com>
> > Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
> > 
> > On Tue, Apr 20, 2021 at 01:41:53PM +0530, Nava kishore Manne wrote:
> > > This patch adds zynqmp afi config driver.This is useful for the
> > > configuration of the PS-PL interface on Zynq US+ MPSoC platform.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/misc/Kconfig      | 11 ++++++
> > >  drivers/misc/Makefile     |  1 +
> > >  drivers/misc/zynqmp-afi.c | 83
> > > +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 95 insertions(+)
> > >  create mode 100644 drivers/misc/zynqmp-afi.c
> > >
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > > 877b43b3377d..d1ea1eeb3ac1 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -456,6 +456,17 @@ config ZYNQ_AFI
> > >  	  between PS and PL, the AXI port data path should be configured
> > >  	  with the proper Bus-width values
> > >
> > > +config ZYNQMP_AFI
> > > +        tristate "Xilinx ZYNQMP AFI support"
> > > +        help
> > > +	  ZynqMP AFI driver support for writing to the AFI registers for
> > > +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> > > +	  PS to the programmable logic (PL) through the AXI port. This AXI
> > > +	  port helps to establish the data path between the PS and PL.
> > > +	  In-order to establish the proper communication path between
> > > +	  PS and PL, the AXI port data path should be configured with
> > > +	  the proper Bus-width values
> > > +
> > >  source "drivers/misc/c2port/Kconfig"
> > >  source "drivers/misc/eeprom/Kconfig"
> > >  source "drivers/misc/cb710/Kconfig"
> > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > > e9b03843100f..54bd0edc511e 100644
> > > --- a/drivers/misc/Makefile
> > > +++ b/drivers/misc/Makefile
> > > @@ -57,3 +57,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
> > >  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> > >  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> > >  obj-$(CONFIG_ZYNQ_AFI)		+= zynq-afi.o
> > > +obj-$(CONFIG_ZYNQMP_AFI)	+= zynqmp-afi.o
> > > diff --git a/drivers/misc/zynqmp-afi.c b/drivers/misc/zynqmp-afi.c new
> > > file mode 100644 index 000000000000..a318652576d2
> > > --- /dev/null
> > > +++ b/drivers/misc/zynqmp-afi.c
> > > @@ -0,0 +1,83 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Xilinx FPGA AFI bridge.
> > > + * Copyright (c) 2018-2021 Xilinx Inc.
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/firmware/xlnx-zynqmp.h> #include <linux/io.h>
> > > +#include <linux/module.h> #include <linux/of.h> #include
> > > +<linux/platform_device.h> #include <linux/slab.h>
> > > +
> > > +/**
> > > + * struct zynqmp_afi_fpga - AFI register description
> > > + * @value: value to be written to the register
> > > + * @regid: Register id for the register to be written
> > > + */
> > > +struct zynqmp_afi_fpga {
> > > +	u32 value;
> > > +	u32 regid;
> > > +};
> > > +
> > > +static int zynqmp_afi_fpga_probe(struct platform_device *pdev)
> > > +{
> > > +	struct zynqmp_afi_fpga *zynqmp_afi_fpga;
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	int i, entries, ret;
> > > +	u32 reg, val;
> > > +
> > > +	zynqmp_afi_fpga = devm_kzalloc(&pdev->dev,
> > > +				       sizeof(*zynqmp_afi_fpga), GFP_KERNEL);
> > > +	if (!zynqmp_afi_fpga)
> > > +		return -ENOMEM;
> > > +	platform_set_drvdata(pdev, zynqmp_afi_fpga);
> > > +
> > > +	entries = of_property_count_u32_elems(np, "config-afi");
> > > +	if (!entries || (entries % 2)) {
> > > +		dev_err(&pdev->dev, "Invalid number of registers\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	for (i = 0; i < entries / 2; i++) {
> > > +		ret = of_property_read_u32_index(np, "config-afi", i * 2,
> > &reg);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "failed to read register\n");
> > > +			return -EINVAL;
> > > +		}
> > > +		ret = of_property_read_u32_index(np, "config-afi", i * 2 + 1,
> > > +						 &val);
> > > +		if (ret) {
> > > +			dev_err(&pdev->dev, "failed to read value\n");
> > > +			return -EINVAL;
> > > +		}
> > > +		ret = zynqmp_pm_afi(reg, val);
> > > +		if (ret < 0) {
> > > +			dev_err(&pdev->dev, "AFI register write error %d\n",
> > > +				ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> > 
> > Again, why does this have to be in the kernel?  All it does is make a
> > single call to the hardware based on some values read from the device
> > tree.  Can't you do this from userspace?
> > 
> For every PL design has its own PS-PL configuration.

What is a "PL design", and what is a "PS-PL configuration"?  :)

> This driver will be used by the overlay framework for configuring the interface after programming the FPGA and before probing the drivers that are present in the PL.

Again, I have no idea what this means at all.

And again, why does this have to be done in the kernel?  All you are
doing is sending some random values read in DT down to a hardware
device.   What requires a kernel driver for this?

thanks,

greg k-h
