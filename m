Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B133D9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhCPQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236711AbhCPQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:48:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24C01650B1;
        Tue, 16 Mar 2021 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615913319;
        bh=jHrng6y86349pcP73WoHjvzUqM/dcV7seJ6f9K/+R7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cM7yppNdgZ+pr8abM2utPACmY4l3T/qxa0YSJUV0PJqszZNFyD4caSYfFN2a7ziZm
         UjxzP1u6vLLx/VGsMIuSN6XAAunbgQjhri1AJ0afYG2fx9dc63/IuYwE3SG3D5TXvb
         pnoG7GafA/xy/DpplMEXlI54RU3qqrbw3V+1CT28=
Date:   Tue, 16 Mar 2021 17:48:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 3/3] misc/pvpanic: add PCI driver
Message-ID: <YFDhZbRYE5szZ4l/@kroah.com>
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615897229-4055-4-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:20:29PM +0200, Mihai Carabas wrote:
> Add support for pvpanic PCI device added in qemu [1]. At probe time, obtain the
> address where to read/write pvpanic events and pass it to the generic handling
> code. Will follow the same logic as pvpanic MMIO device driver. At remove time,
> unmap base address and disable PCI device.
> 
> [1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/Kconfig       |   6 +++
>  drivers/misc/pvpanic/Makefile      |   1 +
>  drivers/misc/pvpanic/pvpanic-pci.c | 102 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
> 
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 454f1ee..9a081ed 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -17,3 +17,9 @@ config PVPANIC_MMIO
>  	depends on HAS_IOMEM && (ACPI || OF) && PVPANIC
>  	help
>  	  This driver provides support for the MMIO pvpanic device.
> +
> +config PVPANIC_PCI
> +	tristate "pvpanic PCI device support"
> +	depends on PCI && PVPANIC
> +	help
> +	  This driver provides support for the PCI pvpanic device.

Please provide a bit more information here.

> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index e12a2dc..9471df7 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -5,3 +5,4 @@
>  # Copyright (C) 2021 Oracle.
>  #
>  obj-$(CONFIG_PVPANIC_MMIO)	+= pvpanic.o pvpanic-mmio.o
> +obj-$(CONFIG_PVPANIC_PCI)	+= pvpanic.o pvpanic-pci.o
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> new file mode 100644
> index 00000000..27526d3
> --- /dev/null
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Pvpanic PCI Device Support
> + *
> + *  Copyright (C) 2021 Oracle.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include "pvpanic.h"
> +
> +#define PCI_VENDOR_ID_REDHAT             0x1b36
> +#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
> +
> +static void __iomem *base;
> +static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},

Why the ")}"?

Shouldn't it just be "}"?

> +	{}
> +};
> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> +static unsigned int events;
> +
> +static ssize_t capability_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%x\n", capability);

A global capability for all devices?  No, this needs to be a per-device
attttribute as you are showing it to userspace as such.

> +}
> +static DEVICE_ATTR_RO(capability);
> +
> +static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%x\n", events);

Same here, this is not global for the whole module.

> +}
> +
> +static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	unsigned int tmp;
> +	int err;
> +
> +	err = kstrtouint(buf, 16, &tmp);
> +	if (err)
> +		return err;
> +
> +	if ((tmp & capability) != tmp)
> +		return -EINVAL;
> +
> +	events = tmp;
> +
> +	pvpanic_set_events(base, events);
> +
> +	return count;
> +
> +}
> +static DEVICE_ATTR_RW(events);
> +
> +static struct attribute *pvpanic_pci_dev_attrs[] = {
> +	&dev_attr_capability.attr,
> +	&dev_attr_events.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(pvpanici_pci_dev);

You did not document these new sysfs files in Documentation/ABI/ so it's
hard to judge what they do.  Please do so next version.

thanks,

greg k-h
