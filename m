Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D708836547B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhDTIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDTIr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 233996101D;
        Tue, 20 Apr 2021 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618908415;
        bh=+GoZ6LFlTXqNBpDSWl8fPtmk2irS0pAzQW2Uz6GETHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2S3STF8SuvoVe1E/kGnqk4D5AsfTUoe6P6XCKUbBRp2EwfLQB0wsqc0quLtnCu0X
         0LgNTO+K8JW4sUnVrslk33CKUoUapigAHV95eIr1WALBEZV/WdwTQtWxpusrd7xsTO
         zzm4gwbBmL5Dm1aSyhn94FdwQ/6alQdeMOgyua8o=
Date:   Tue, 20 Apr 2021 10:46:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        tejas.patel@xilinx.com, amit.sunil.dhamne@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com,
        git@xilinx.com
Subject: Re: [PATCH 2/5] misc: zynq: Add afi config driver
Message-ID: <YH6U/L4SEtJajusW@kroah.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420081153.17020-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:41:50PM +0530, Nava kishore Manne wrote:
> This patch adds zynq afi config driver. This is useful for
> the configuration of the PS-PL interface on zynq platform.

What is "PS-PL"?  Can you describe it better please?

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/misc/Kconfig    | 11 ++++++
>  drivers/misc/Makefile   |  1 +
>  drivers/misc/zynq-afi.c | 81 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/misc/zynq-afi.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f532c59bb59b..877b43b3377d 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -445,6 +445,17 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config ZYNQ_AFI
> +	tristate "Xilinx ZYNQ AFI support"
> +	help
> +	  Zynq AFI driver support for writing to the AFI registers
> +	  for configuring PS_PL Bus-width. Xilinx Zynq SoC connect
> +	  the PS to the programmable logic (PL) through the AXI port.
> +	  This AXI port helps to establish the data path between the
> +	  PS and PL.In-order to establish the proper communication path
> +	  between PS and PL, the AXI port data path should be configured
> +	  with the proper Bus-width values
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 99b6f15a3c70..e9b03843100f 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>  obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>  obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
> +obj-$(CONFIG_ZYNQ_AFI)		+= zynq-afi.o
> diff --git a/drivers/misc/zynq-afi.c b/drivers/misc/zynq-afi.c
> new file mode 100644
> index 000000000000..04317d1bdb98
> --- /dev/null
> +++ b/drivers/misc/zynq-afi.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ZYNQ AFI driver.
> + * Copyright (c) 2018-2021 Xilinx Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +/* Registers and special values for doing register-based operations */
> +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> +
> +#define AFI_BUSWIDTH_MASK	0x01
> +
> +/**
> + * struct afi_fpga - AFI register description
> + * @membase:	pointer to register struct
> + * @afi_width:	AFI bus width to be written
> + */
> +struct zynq_afi_fpga {
> +	void __iomem	*membase;
> +	u32		afi_width;
> +};
> +
> +static int zynq_afi_fpga_probe(struct platform_device *pdev)
> +{
> +	struct zynq_afi_fpga *afi_fpga;
> +	struct resource *res;
> +	u32 reg_val;
> +	u32 val;
> +
> +	afi_fpga = devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
> +	if (!afi_fpga)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	afi_fpga->membase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(afi_fpga->membase))
> +		return PTR_ERR(afi_fpga->membase);
> +
> +	val = device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> +				       &afi_fpga->afi_width);
> +	if (val) {
> +		dev_err(&pdev->dev, "failed to get the afi bus width\n");
> +		return -EINVAL;
> +	}
> +
> +	reg_val = readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> +	reg_val &= ~AFI_BUSWIDTH_MASK;
> +	writel(reg_val | afi_fpga->afi_width,
> +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> +	reg_val = readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> +	reg_val &= ~AFI_BUSWIDTH_MASK;
> +	writel(reg_val | afi_fpga->afi_width,
> +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> +
> +	return 0;
> +}

I do not understand, why is this driver needed at all?  Why can't you do
the above from userspace?

All this does is write some values to the hardware at probe time, who
needs this?

thanks,

greg k-h
