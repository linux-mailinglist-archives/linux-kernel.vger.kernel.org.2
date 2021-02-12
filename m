Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6DE319C80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhBLKS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBLKST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:18:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9094464E05;
        Fri, 12 Feb 2021 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613125058;
        bh=wdgOSf/3Ef4DA1TlRZ/FTOhlKfsp2S3mPrqUMXeD9TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+kGSf8Hw3mYxqAZCWW78ZQRe9DRSG8l1yBGcm7LCI5Usq4b97WYgbHLBgXuMK5W/
         59zLIdID6vd8iD/kYPbl4VgD3WrmXxIgjMQTOG0XHmNW3RsDQ4UQBM/j9Q0IxmekXk
         R1um1K5J80Tx+Qeg69yZsuB6/h75ruOi1yhTKSbs=
Date:   Fri, 12 Feb 2021 11:17:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH v2 1/3] misc/pvpanic: split-up generic and platform
 dependent code
Message-ID: <YCZVvxxHI8mMEwTC@kroah.com>
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
 <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:17:04AM +0200, Mihai Carabas wrote:
> Split-up generic and platform dependent code in order to be able to re-use
> generic event handling code in pvpanic PCI device driver in the next patch.
> 
> The code from pvpanic.c was split in two new files:
> - pvpanic-common.c: generic code that handles pvpanic events
> - mmio.c: platform/bus dependent code
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/Kconfig                  |   9 +--
>  drivers/misc/Makefile                 |   2 +-
>  drivers/misc/pvpanic.c                | 111 ----------------------------------
>  drivers/misc/pvpanic/Kconfig          |  12 ++++
>  drivers/misc/pvpanic/Makefile         |   2 +
>  drivers/misc/pvpanic/mmio.c           |  83 +++++++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic-common.c |  60 ++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.h        |  10 +++
>  8 files changed, 169 insertions(+), 120 deletions(-)
>  delete mode 100644 drivers/misc/pvpanic.c
>  create mode 100644 drivers/misc/pvpanic/Kconfig
>  create mode 100644 drivers/misc/pvpanic/Makefile
>  create mode 100644 drivers/misc/pvpanic/mmio.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic-common.c
>  create mode 100644 drivers/misc/pvpanic/pvpanic.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0..0273ecb 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -448,14 +448,6 @@ config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
>  
> -config PVPANIC
> -	tristate "pvpanic device support"
> -	depends on HAS_IOMEM && (ACPI || OF)
> -	help
> -	  This driver provides support for the pvpanic device.  pvpanic is
> -	  a paravirtualized device provided by QEMU; it lets a virtual machine
> -	  (guest) communicate panic events to the host.
> -
>  config HISI_HIKEY_USB
>  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
>  	depends on (OF && GPIOLIB) || COMPILE_TEST
> @@ -481,4 +473,5 @@ source "drivers/misc/ocxl/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
> +source "drivers/misc/pvpanic/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index d23231e..9f411b8 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_CXL_BASE)		+= cxl/
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-y				+= cardreader/
> -obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
> +obj-$(CONFIG_PVPANIC)   	+= pvpanic/
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>  obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> deleted file mode 100644
> index 41cab29..00000000
> --- a/drivers/misc/pvpanic.c
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - *  Pvpanic Device Support
> - *
> - *  Copyright (C) 2013 Fujitsu.
> - *  Copyright (C) 2018 ZTE.
> - */
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/kexec.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/types.h>
> -
> -#include <uapi/misc/pvpanic.h>
> -
> -static void __iomem *base;
> -
> -MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
> -MODULE_DESCRIPTION("pvpanic device driver");
> -MODULE_LICENSE("GPL");
> -
> -static void
> -pvpanic_send_event(unsigned int event)
> -{
> -	iowrite8(event, base);
> -}
> -
> -static int
> -pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
> -		     void *unused)
> -{
> -	unsigned int event = PVPANIC_PANICKED;
> -
> -	if (kexec_crash_loaded())
> -		event = PVPANIC_CRASH_LOADED;
> -
> -	pvpanic_send_event(event);
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block pvpanic_panic_nb = {
> -	.notifier_call = pvpanic_panic_notify,
> -	.priority = 1, /* let this called before broken drm_fb_helper */
> -};
> -
> -static int pvpanic_mmio_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct resource *res;
> -
> -	res = platform_get_mem_or_io(pdev, 0);
> -	if (!res)
> -		return -EINVAL;
> -
> -	switch (resource_type(res)) {
> -	case IORESOURCE_IO:
> -		base = devm_ioport_map(dev, res->start, resource_size(res));
> -		if (!base)
> -			return -ENOMEM;
> -		break;
> -	case IORESOURCE_MEM:
> -		base = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(base))
> -			return PTR_ERR(base);
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -				       &pvpanic_panic_nb);
> -
> -	return 0;
> -}
> -
> -static int pvpanic_mmio_remove(struct platform_device *pdev)
> -{
> -
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					 &pvpanic_panic_nb);
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id pvpanic_mmio_match[] = {
> -	{ .compatible = "qemu,pvpanic-mmio", },
> -	{}
> -};
> -
> -static const struct acpi_device_id pvpanic_device_ids[] = {
> -	{ "QEMU0001", 0 },
> -	{ "", 0 }
> -};
> -MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
> -
> -static struct platform_driver pvpanic_mmio_driver = {
> -	.driver = {
> -		.name = "pvpanic-mmio",
> -		.of_match_table = pvpanic_mmio_match,
> -		.acpi_match_table = pvpanic_device_ids,
> -	},
> -	.probe = pvpanic_mmio_probe,
> -	.remove = pvpanic_mmio_remove,
> -};
> -module_platform_driver(pvpanic_mmio_driver);
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> new file mode 100644
> index 00000000..0dce6ef
> --- /dev/null
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -0,0 +1,12 @@
> +config PVPANIC
> +	bool "pvpanic device support"
> +	help
> +	  This option enables pvpanic device driver.

No it doesn't, it allows you to _select_ a specific pvpanic driver, on
its own, it is not a driver, right?

> +
> +config PVPANIC_MMIO
> +	tristate "pvpanic MMIO device support"
> +	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
> +	help
> +	  This driver provides support for the pvpanic device.  pvpanic is
> +	  a paravirtualized device provided by QEMU; it lets a virtual machine
> +	  (guest) communicate panic events to the host.
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> new file mode 100644
> index 00000000..9ea3355
> --- /dev/null
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic-mmio.o
> +pvpanic-mmio-objs := pvpanic-common.o mmio.o

You put the "common" logic in the mmio driver?  How is that going to
work for the PCI driver?

Why is there not a pvpanic.ko that contains the "core" code only?

thanks,

greg k-h
