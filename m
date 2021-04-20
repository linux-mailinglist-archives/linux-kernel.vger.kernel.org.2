Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B20F365495
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhDTIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhDTIvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B64E60FEE;
        Tue, 20 Apr 2021 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618908663;
        bh=Ze5OEi3gnNXMeI+Q5SkH0i1aFVUgqD2Gu+bwpAHmcNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/f4Qt/gTMk8hsaDZDyq+0+CqkGBUibJ1ZuG6sxUa2WHcGef6DQRK6E/7ecIJpcYh
         g/9HQNpGALT8ICrhsK5QdJUaSAQk1XE3pQwqtTTAn+WfNBsQXMsoRKtuseYAmvoHQE
         1zCjutxE/+wCkwIjMUhu8NnPKfKoHkoE5dbpQc/A=
Date:   Tue, 20 Apr 2021 10:51:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        tejas.patel@xilinx.com, amit.sunil.dhamne@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com,
        git@xilinx.com
Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
Message-ID: <YH6V9Im3L/gJJ/CP@kroah.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420081153.17020-6-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:41:53PM +0530, Nava kishore Manne wrote:
> This patch adds zynqmp afi config driver.This is useful for
> the configuration of the PS-PL interface on Zynq US+ MPSoC
> platform.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/misc/Kconfig      | 11 ++++++
>  drivers/misc/Makefile     |  1 +
>  drivers/misc/zynqmp-afi.c | 83 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 drivers/misc/zynqmp-afi.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 877b43b3377d..d1ea1eeb3ac1 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -456,6 +456,17 @@ config ZYNQ_AFI
>  	  between PS and PL, the AXI port data path should be configured
>  	  with the proper Bus-width values
>  
> +config ZYNQMP_AFI
> +        tristate "Xilinx ZYNQMP AFI support"
> +        help
> +	  ZynqMP AFI driver support for writing to the AFI registers for
> +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> +	  PS to the programmable logic (PL) through the AXI port. This AXI
> +	  port helps to establish the data path between the PS and PL.
> +	  In-order to establish the proper communication path between
> +	  PS and PL, the AXI port data path should be configured with
> +	  the proper Bus-width values
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e9b03843100f..54bd0edc511e 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>  obj-$(CONFIG_ZYNQ_AFI)		+= zynq-afi.o
> +obj-$(CONFIG_ZYNQMP_AFI)	+= zynqmp-afi.o
> diff --git a/drivers/misc/zynqmp-afi.c b/drivers/misc/zynqmp-afi.c
> new file mode 100644
> index 000000000000..a318652576d2
> --- /dev/null
> +++ b/drivers/misc/zynqmp-afi.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx FPGA AFI bridge.
> + * Copyright (c) 2018-2021 Xilinx Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/**
> + * struct zynqmp_afi_fpga - AFI register description
> + * @value: value to be written to the register
> + * @regid: Register id for the register to be written
> + */
> +struct zynqmp_afi_fpga {
> +	u32 value;
> +	u32 regid;
> +};
> +
> +static int zynqmp_afi_fpga_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_afi_fpga *zynqmp_afi_fpga;
> +	struct device_node *np = pdev->dev.of_node;
> +	int i, entries, ret;
> +	u32 reg, val;
> +
> +	zynqmp_afi_fpga = devm_kzalloc(&pdev->dev,
> +				       sizeof(*zynqmp_afi_fpga), GFP_KERNEL);
> +	if (!zynqmp_afi_fpga)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, zynqmp_afi_fpga);
> +
> +	entries = of_property_count_u32_elems(np, "config-afi");
> +	if (!entries || (entries % 2)) {
> +		dev_err(&pdev->dev, "Invalid number of registers\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < entries / 2; i++) {
> +		ret = of_property_read_u32_index(np, "config-afi", i * 2, &reg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to read register\n");
> +			return -EINVAL;
> +		}
> +		ret = of_property_read_u32_index(np, "config-afi", i * 2 + 1,
> +						 &val);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to read value\n");
> +			return -EINVAL;
> +		}
> +		ret = zynqmp_pm_afi(reg, val);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "AFI register write error %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}

Again, why does this have to be in the kernel?  All it does is make a
single call to the hardware based on some values read from the device
tree.  Can't you do this from userspace?

thanks,

greg k-h
